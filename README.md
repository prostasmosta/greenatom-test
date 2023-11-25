# README

### To run app in docker container:
```sh
docker-compose up -d
docker-compose exec greenatom rails db:migrate
```

### To run tests:
```sh
bash testing-locally.sh
```

### To send POST request:
```
curl -X POST 'http://localhost:3000/users' -H 'Content-Type: application/json' \
-d '{
  "user": {
    "name": "John",
    "email": "john@example.com",
    "password": "password",
    "password_confirmation": "password",
    "passport_data": {
      "number": "12345",
      "issued_by": "Moscow",
      "issued_at": "2023-01-01"
    }
  }
}'
```

### To send GET request for index:
```
curl 'http://localhost:3000/users?page=1&per_page=2' -H 'Authorization: Bearer AUTH_TOKEN_FROM_POST_RESPONSE_Authorization_HEADER'
```

### To send GET request for show:
```
curl 'http://localhost:3000/users/USER_ID' -H 'Authorization: Bearer AUTH_TOKEN_FROM_POST_RESPONSE_Authorization_HEADER'
```