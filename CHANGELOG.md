## [0.1.2] - 2024-07-15

- Fixed spelling error for `success` attribute on `Response`

## [0.1.1] - 2024-07-11

- Fixed bug where snake-cased keys were being converetd to camel-cased keys for API request params
- JustCall's API actually expects snake-cased keys

## [0.1.0] - 2024-07-10

The initial release. Provides all basic Ruby wrapper functionality for JustCall's V2 API.

The V2 API currently includes the following endpoints:
- Calls
  - [List all calls](https://developer.justcall.io/reference/call_list)
  - [Get a call](https://developer.justcall.io/reference/call_get)
  - [Update a call](https://developer.justcall.io/reference/call_update)
  - [Download a recording](https://developer.justcall.io/reference/call_recording_download)
- SMS
  - [List all texts](https://developer.justcall.io/reference/texts_list)
  - [Get a text](https://developer.justcall.io/reference/texts_get)
  - [Check reply](https://developer.justcall.io/reference/texts_checkreply)
  - [Send SMS/MMS](https://developer.justcall.io/reference/texts_new)
