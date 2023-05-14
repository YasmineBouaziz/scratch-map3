from flask import Flask, request
from db import get_db_accessor

from flask import jsonify

import jwt
import datetime
from functools import wraps

app = Flask(__name__)
app.config["SECRET_KEY"] = "your-secret-key-here"


# Add token refresh method (OPTIONAL, do this way later)


def error_to_dict(error):
    rv = {}
    rv["message"] = str(error)
    return rv


@app.errorhandler(ValueError)
def handle_invalid_usage(error):
    response = jsonify(error_to_dict(error))
    # response.status_code = error.status_code
    return response


def decode_auth_token(encoded_data):
    """
    Decodes the auth token
    :param auth_token:
    :return: integer|string
    """

    try:
        decoded_data = jwt.decode(
            jwt=encoded_data, key=app.config.get("SECRET_KEY"), algorithms=["HS256"]
        )
        return decoded_data["user_id"]
    except jwt.ExpiredSignatureError:
        raise jwt.ExpiredSignatureError("Signature expired. Please log in again.")
    except jwt.InvalidTokenError:
        raise jwt.InvalidTokenError("Invalid token. Please log in again.")


def encode_data(user_id: str):
    payload = {
        "exp": datetime.datetime.utcnow()
        + datetime.timedelta(days=0, minutes=5, seconds=5),
        "iat": datetime.datetime.utcnow(),
        "user_id": user_id,
    }
    return jwt.encode(
        payload=payload, key=app.config.get("SECRET_KEY"), algorithm="HS256"
    )


# Login API Route
@app.route("/login", methods=["POST"])
async def login():
    email = request.json["email"]
    password = request.json["password"]
    async with get_db_accessor() as db_accessor:
        user_id = await db_accessor.get_user_id(email, password)
    if user_id is not None:
        # create a JWT token with a payload containing the user ID and expiration time
        encoded_data = encode_data(user_id)
        response = jsonify({"success": True, "token": encoded_data}), 200
        # return the JWT token in the response
        return response
    else:
        return (
            jsonify({"success": False, "error": "Invalid email or password"}),
            401,
        )


# Sign up API Route
@app.route("/signup", methods=["POST"])
async def sign_up():
    email = request.json["email"]
    password = request.json["password"]
    async with get_db_accessor() as db_accessor:
        user_id = await db_accessor.signup_user(email, password)
    if user_id is not None:
        encoded_data = encode_data(user_id)
        response = jsonify({"success": True, "token": encoded_data}), 200
        return response
    else:
        return (
            jsonify({"success": False, "error": "Failed to create user because blah"}),
            401,
        )


def authenticated_route(f):
    @wraps(f)
    async def wrapper(*args, **kwargs):
        try:
            user_id = decode_auth_token(request.headers.get("Authorization"))
            return await f(user_id=user_id)
        except Exception as e:
            return (
                jsonify({"success": False, "error": str(e)}),
                401,
            )

    return wrapper


@app.route("/get-visited-countries-for-user", methods=["GET", "POST"])
@authenticated_route
async def get_visited_countries_for_user(user_id: str):
    async with get_db_accessor() as db_accessor:
        user_countries = await db_accessor.get_country_data_by_user(user_id)
    return jsonify(user_countries)


# Add visited country
@app.route("/visit-country", methods=["POST"])
@authenticated_route
async def visit_country_for_user(user_id: str):
    country = request.json["country"]
    async with get_db_accessor() as db_accessor:
        new_country = await db_accessor.visit_country_for_user(user_id, country)
    return jsonify({"country": new_country})


# Add visited country
@app.route("/unvisit-country", methods=["POST"])
@authenticated_route
async def unvisit_country_for_user(user_id: str):
    country = request.json["country"]
    async with get_db_accessor() as db_accessor:
        await db_accessor.unvisit_country_for_user(user_id, country)
    return jsonify({"success": True}), 200


@app.route("/login", methods=["OPTIONS"])
def handle_options():
    return (
        "",
        200,
        {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "Content-Type",
            "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
            "Access-Control-Allow-Credentials": "true",
        },
    )


@app.after_request
def add_cors_headers(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers[
        "Access-Control-Allow-Headers"
    ] = "Content-Type, Authorization, withCredentials"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, PUT, DELETE, OPTIONS"
    response.headers["Access-Control-Allow-Credentials"] = "true"
    response.headers.add("Access-Control-Allow-Credentials", "true")

    return response


if __name__ == "__main__":
    app.run(debug=True)
