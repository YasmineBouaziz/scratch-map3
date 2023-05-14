from __future__ import annotations
import asyncpg
from asyncpg import Connection
from dataclasses import dataclass
from typing import Optional
from contextlib import asynccontextmanager
from collections.abc import Generator


@dataclass
class CountryMetadata:
    name: str
    date_of_visit: str
    description: Optional[str]
    rating: Optional[int]
    continent: Optional[str]
    hasVisited: bool = True


@asynccontextmanager
async def get_db_accessor() -> Generator[ScratchMapAccessor, None, None]:
    async with DatabaseConnection(
        port="5432",
        host="localhost",
        user="postgres",
        password="postgres",
        database="postgres",
    ) as conn:
        yield ScratchMapAccessor(conn)


class DatabaseConnection:
    # TODO: Make connection pool object and use this instead for all requests
    def __init__(self, host: str, port: str, database: str, user: str, password: str):
        self.connection = None
        self.host = host
        self.port = port
        self.database = database
        self.user = user
        self.password = password

    async def __aenter__(self) -> asyncpg.Connection:
        self.connection = await asyncpg.connect(
            host=self.host,
            port=self.port,
            database=self.database,
            user=self.user,
            password=self.password,
        )
        return self.connection

    async def __aexit__(self, exc_type, exc_val, exc_tb):
        await self.connection.close()


class DBAccessor:
    def __init__(self, connection: Connection):
        self.connection = connection


class ScratchMapAccessor(DBAccessor):
    async def get_user_id(self, email: str, password: str) -> str:
        query = """SELECT id FROM user_ WHERE email = $1 and password = crypt($2, password)"""
        user_id = await self.connection.fetch(query, email, password)
        if not user_id:
            raise ValueError("Incorrect username or password")
        return str(user_id[0]["id"])

    async def signup_user(self, email: str, password: str) -> str:
        query = """
                INSERT INTO user_ (email, password) VALUES (
                    $1,
                    crypt($2, gen_salt('bf'))
                )
                RETURNING id
                """
        try:
            user_id = await self.connection.fetch(query, email, password)
        except asyncpg.exceptions.UniqueViolationError as e:
            raise ValueError("Email already exists.")

        return str(user_id[0]["id"])

    async def unvisit_country_for_user(self, user_id: str, country: str) -> str:
        delete_sql = """
                    DELETE FROM user_country 
                    WHERE country = $1 AND user_id = $2
                    """
        await self.connection.fetch(delete_sql, country, user_id)

    async def get_country_data_by_user(self, user_id: str):
        # Get all visited countries at startup and then store on frontend for user
        # Don't need many other queries tbh
        visited_countries = await self.connection.fetch(
            """
            SELECT uc.date_of_visit, uc.rating, uc.description, uc.country as name, c.continent
            FROM user_country as uc
            INNER JOIN country as c
            ON uc.country = c.name
            WHERE uc.user_id = $1
            """,
            user_id,
        )
        return {
            country["name"]: CountryMetadata(**country) for country in visited_countries
        }

    async def visit_country_for_user(
        self,
        user_id: str,
        country: str,
        rating: Optional[int] = None,
        description: Optional[str] = None,
    ) -> CountryMetadata:
        insert_sql = """
                INSERT INTO user_country (user_id, country, date_of_visit, rating, description)
                VALUES ($1, $2, CURRENT_DATE, $3, $4)
                RETURNING country, date_of_visit
              """
        visited_countries = await self.connection.fetch(
            insert_sql,
            user_id,
            country,
            rating,
            description,
        )
        if visited_countries is None:
            raise ValueError("Failed to add new user country relationship")

        get_continent_sql = "SELECT continent FROM country WHERE name = $1"
        continent = (
            await self.connection.fetch(
                get_continent_sql,
                country,
            )
        )[
            0
        ]["continent"]

        return CountryMetadata(
            visited_countries[0]["country"],
            visited_countries[0]["date_of_visit"],
            description,
            rating,
            continent,
        )
