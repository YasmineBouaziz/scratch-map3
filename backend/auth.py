from flask import request, jsonify, current_app as app
import jwt
from functools import wraps
import datetime


def encode_data(user_id: str) -> str:
    payload = {
        "exp": datetime.datetime.utcnow()
        + datetime.timedelta(days=0, minutes=5, seconds=5),
        "iat": datetime.datetime.utcnow(),
        "user_id": user_id,
    }
    return jwt.encode(
        payload=payload, key=app.config.get("SECRET_KEY"), algorithm="HS256"
    )


def decode_auth_token(encoded_data: str) -> str:
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
