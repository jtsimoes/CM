from firebase_functions import https_fn

from firebase_admin import firestore, storage
import google.cloud.firestore as gcfirestore

from models import User


USER_COLLECTION = "users"


@https_fn.on_call()
def create_user(req: https_fn.CallableRequest) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(USER_COLLECTION)

    user = User.parse(req)

    data_ref = db.document(user.phone_number)

    user_data = user.to_dict()
    del user_data['phone_number']

    data_ref.set(user_data)
    return user.to_dict()


@https_fn.on_call()
def get_user(req: https_fn.CallableRequest) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(USER_COLLECTION)

    phone_number = req.data.get('phone_number')
    data_ref = db.document(phone_number)

    return data_ref.get().to_dict()