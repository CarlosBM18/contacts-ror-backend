# Contacts Backend with Ruby on Rails

This is the backend for a contacts app where each user can have its own list of contacts. The app handles user authentication and stores the data to be persistent in a database.

## Overview 📋

- [Ruby on Rails](https://rubyonrails.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [JWT](https://jwt.io/) for user authentication
- [RSpec](https://rspec.info/) for testing

## Live demo 🚀

[https://contacts-ror-app.herokuapp.com/api/v1](https://contacts-ror-app.herokuapp.com/api/v1)

## Install and set up 🔧

First, clone the project and install the project dependencies, to do so run:

```sh
bundle install
```

Create a `.env` file and add a `POSTGRESQL_DATABASE_USERNAME` and `POSTGRESQL_DATABASE_PASSWORD` variable with the username and password of the PostreSQL database. Should be something like:

```sh
POSTGRESQL_DATABASE_USERNAME=YOUR_PASSWORD
POSTGRESQL_DATABASE_PASSWORD=YOUR_USERNAME
```

Finally, start the server with:

```sh
rails s
```

## Tests ⚙️

To run the tests:

```sh
bundle exec rspec
```

## Routes 🚏

### POST `/users`

- Body

```json
{
  "email": "carlos@test.es",
  "password": "test123"
}
```

- Success Response

```json
{
  "id": 1,
  "email": "carlos@test.es",
  "created_at": "2021-10-03T16:20:53.280Z",
  "updated_at": "2021-10-03T16:20:53.280Z"
}
```

- Error Response
  - `400 BAD REQUEST`

### POST `/login?email={email_string}&password={password_string}`

- Parameters
  `email` and `password`

- Success Response

```json
{
  "user": {
    "id": 1,
    "email": "carlos@test.es",
    "created_at": "2021-10-03T15:57:38.242Z",
    "updated_at": "2021-10-03T15:57:38.242Z"
  },
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMH0.UX8SaCzkRQsZfJutKKujynJ5YCev8taMrIxGKjg0wQ0"
}
```

- Error Response
  - `400 BAD REQUEST`

### GET `/contacts`

- Success Response

```json
[
  {
    "id": 1,
    "first_name": "Carlos",
    "last_name": "Bertomeu",
    "email": "carlos@test.es",
    "phone_number": 666777888,
    "user_id": 1,
    "created_at": "2021-10-03T19:39:40.372Z",
    "updated_at": "2021-10-03T19:39:40.372Z"
  }
]
```

- Error Response
  - `401 UNAUTHORIZED`

### POST `/contacts`

- Body

```json
{
  "first_name": "Carlos",
  "last_name": "Bertomeu",
  "email": "carlos@test.es",
  "phone_number": 666777888
}
```

- Success Response

```json
{
  "id": 1,
  "first_name": "Carlos",
  "last_name": "Bertomeu",
  "email": "test@test.es",
  "phone_number": 666777888,
  "user_id": 1,
  "created_at": "2021-10-03T19:52:04.632Z",
  "updated_at": "2021-10-03T19:52:04.632Z"
}
```

- Error Response
  - `400 BAD REQUEST`
  - `401 UNAUTHORIZED`
  - `403 FORBIDDEN`

### GET `/contacts/{id}`

- Success Response

```json
{
    "id": {id},
    "first_name": "Carlos",
    "last_name": "Bertomeu",
    "email": "carlos@test.es",
    "phone_number": 666777888,
    "user_id": 1,
    "created_at": "2021-10-03T19:39:40.372Z",
    "updated_at": "2021-10-03T19:47:18.672Z"
}
```

- Error Response
  - `404 NOT FOUND`
  - `401 UNAUTHORIZED`
  - `403 FORBIDDEN`

### PATCH/PUT `/contacts/{id}`

- Body

```json
{
  "first_name": "Carlos",
  "last_name": "Bertomeu",
  "email": "carlos@test.es",
  "phone_number": 666777111
}
```

- Success Response

```json
{
  "id": {id},
  "first_name": "Carlos",
  "last_name": "Bertomeu",
  "email": "carlos@test.es",
  "phone_number": 666777111,
  "user_id": 1,
  "created_at": "2021-10-03T19:39:40.372Z",
  "updated_at": "2021-10-03T19:47:18.672Z"
}
```

- Error Response
  - `400 BAD REQUEST`
  - `401 UNAUTHORIZED`
  - `403 FORBIDDEN`

### DELETE `/contacts/{id}`

- Success Response

  - `200 OK`

- Error Response
  - `404 NOT FOUND`
  - `401 UNAUTHORIZED`
  - `403 FORBIDDEN`

### GET `/contact_histories/{id}`

- Success Response

```json
[
  {
    "id": 1,
    "first_name": "Carlos",
    "last_name": "Bertomeu",
    "email": "carlos@test.com",
    "phone_number": 666777222,
    "contact_id": {id},
    "created_at": "2021-10-03T19:39:40.408Z",
    "updated_at": "2021-10-03T19:39:40.408Z",
    "state": "created",
    "user_id": 1
  }
]
```

- Error Response
  - `404 NOT FOUND`
  - `401 UNAUTHORIZED`
  - `403 FORBIDDEN`
