# API Documentation
* [Elixir.Spell.MessageController](#Elixir.Spell.MessageController)
  * [index](#Elixir.Spell.MessageControllerindex)

## Elixir.Spell.MessageController
### index
* __Method:__ GET
* __Path:__ /api/messages?user_id=2
* __Status__: 200
* __Response body:__
```json
[
  {
    "sender_id": 1,
    "recipient_id": 2,
    "read": false,
    "id": 70,
    "body": "Hi"
  },
  {
    "sender_id": 2,
    "recipient_id": 1,
    "read": false,
    "id": 71,
    "body": "Hi"
  }
]
```
* __Method:__ GET
* __Path:__ /api/messages
* __Status__: 401
* __Response body:__
```json
{
  "error": "unauthorized"
}
```
* __Method:__ GET
* __Path:__ /api/messages
* __Status__: 401
* __Response body:__
```json
{
  "error": "unauthorized"
}
```
* __Method:__ GET
* __Path:__ /api/messages
* __Status__: 200
* __Response body:__
```json
[]
```
