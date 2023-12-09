import re

from firebase_functions import https_fn


class User:
    def __init__(self, phone_number: str, name: str, biography: str, avatar: str):
        self.phone_number = phone_number
        self.name = name
        self.biography = biography
        self.avatar = avatar

    def __repr__(self) -> str:
        return { 'phone_number': self.phone_number, 'name': self.name, 'biography': self.biography, 'avatar': self.avatar }

    @staticmethod
    def parse(req: https_fn.Request):
        data: dict = req.json

        fields = ['phone_number', 'name', 'biography', 'avatar']
        values = {field: data.get(field) for field in fields}

        if any(value is None or type(value) != str for value in values):
            raise ValueError(f"Missing field in {fields}.")
        
        values['phone_number'] = re.sub(r'[^\d+]', '', values['phone_number'])
        
        return User(**values)
    