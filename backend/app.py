from flask import Flask, request, jsonify, Response
from db import get_db_accessor
from auth import encode_data, authenticated_route

app = Flask(__name__)
app.config["SECRET_KEY"] = "your-secret-key-here"


# Add token refresh method (OPTIONAL, do this way later)


def error_to_dict(error: Exception) -> dict[str, str]:
    return {"message": str(error)}


@app.errorhandler(ValueError)
def handle_invalid_usage(error: Exception) -> Response:
    response = jsonify(error_to_dict(error))
    return response


# Login API Route
@app.route("/login", methods=["POST"])
async def login() -> tuple[Response, int]:
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
async def sign_up() -> tuple[Response, int]:
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


@app.route("/get-visited-countries-for-user", methods=["GET", "POST"])
@authenticated_route
async def get_visited_countries_for_user(user_id: str) -> Response:
    async with get_db_accessor() as db_accessor:
        user_countries = await db_accessor.get_country_data_by_user(user_id)
    return jsonify(user_countries)


# Add visited country
@app.route("/visit-country", methods=["POST"])
@authenticated_route
async def visit_country_for_user(user_id: str) -> Response:
    country = request.json["country"]
    async with get_db_accessor() as db_accessor:
        new_country = await db_accessor.visit_country_for_user(user_id, country)
    return jsonify({"country": new_country})


# Add visited country
@app.route("/unvisit-country", methods=["POST"])
@authenticated_route
async def unvisit_country_for_user(user_id: str) -> Response:
    country = request.json["country"]
    async with get_db_accessor() as db_accessor:
        await db_accessor.unvisit_country_for_user(user_id, country)
    return jsonify({"success": True}), 200


@app.after_request
def add_cors_headers(response: Response) -> Response:
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
