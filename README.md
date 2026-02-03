# PolytoriaServerIP
Fetches the IP info of Polytoria servers.

The script should be placed within `ScriptService` and on server startup will automatically create a [`NetworkEvent`](https://docs.polytoria.com/objects/scripting/NetworkEvent/) there. An example script can be found in the [`demo`](https://github.com/RailTypes/PolytoriaServerIP/blob/main/demo/ui.client.lua) folder.

## Config
Configuration can be found by opening the script and changing the constants.
Name (Type) | Description
-|-
**`URL`** (`string`) | The URL to send the HTTP request to (must return JSON). Uses [IPinfo](https://ipinfo.io/)'s JSONP API by default.
**`SEND_OPTIONS`** (`{string}`) | The information that should be sent to the client. The array can contain any key returned by `URL`.
**`START_DELAY`** (`number`) | The duration to wait before attempting to send HTTP requests.
**`RETRY_DELAY`** (`number`) | The duration to wait before retrying a failed HTTP request.
**`DISABLE_IN_CREATOR`** (`number`) | Whether or not this script will run during local playtesting. Enabled by default for privacy reasons.
