from firebase_functions import https_fn


class Event:
  def __init__(self, name: str, description: str, price: float, latitude, longitude: float) -> None:
    self.name = name
    self.description = description
    self.price = price
    self.latitude = latitude
    self.longitude = longitude

  def __repr__(self) -> dict:
    return { 'name': self.name, 'description': self.description, 'price': self.price, 'latitude': self.latitude, 'longitude': self.longitude }
  
  @staticmethod
  def parse(req: https_fn.Request):
    data: dict = req.json

    fields = ['name', 'description', 'price', 'latitude', 'longitude']
    values = {field: data.get(field) for field in fields}

    if any(value is None or type(value) != str for value in values):
      raise ValueError(f"Missing field in {fields}.")

    return Event(**values)