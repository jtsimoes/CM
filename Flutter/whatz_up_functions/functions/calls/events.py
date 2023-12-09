from firebase_functions import https_fn

from firebase_admin import firestore, storage
import google.cloud.firestore as gcfirestore

from models import Event


EVENT_COLLECTION = "events"


@https_fn.on_request()
def create_event(req: https_fn.Request) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(EVENT_COLLECTION)

    event = Event.parse(req)

    data_ref = db.document()
    event_data = repr(event)
    data_ref.set(event_data)

    return https_fn.Response({'id': data_ref.id, **event_data})


@https_fn.on_request()
def get_event(req: https_fn.Request) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(EVENT_COLLECTION)

    event_id = req.json.get('id')
    data_ref = db.document(event_id)

    return https_fn.Response(data_ref.get().to_dict())


@https_fn.on_request()
def get_events(req: https_fn.Request) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(EVENT_COLLECTION)
    return https_fn.Response(db.get())