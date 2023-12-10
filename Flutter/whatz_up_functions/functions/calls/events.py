from firebase_functions import https_fn

from firebase_admin import firestore, storage
import google.cloud.firestore as gcfirestore

from models import Event


EVENT_COLLECTION = "events"


@https_fn.on_call()
def create_event(req: https_fn.CallableRequest) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(EVENT_COLLECTION)

    event = Event.parse(req)

    data_ref = db.document()
    event_data = event.to_dict()
    data_ref.set(event_data)

    return {'id': data_ref.id, **event_data}


@https_fn.on_call()
def get_event(req: https_fn.CallableRequest) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(EVENT_COLLECTION)

    event_id = req.data.get('id')
    data_ref = db.document(event_id)

    return {'id': event_id, **data_ref.get().to_dict()}


@https_fn.on_call()
def get_events(req: https_fn.CallableRequest) -> https_fn.Response:
    client: gcfirestore.Client = firestore.client()
    db = client.collection(EVENT_COLLECTION)
    return [{'id': doc.id, **doc.to_dict()} for doc in db.stream()]