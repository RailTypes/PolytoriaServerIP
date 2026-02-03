--[[

    #########################
    ## Polytoria Server IP ##
    #########################

    Fetches the IP info of Polytoria servers.

    Author: @RailTypes
    Created: 2025-02-02 UTC
    Updated: 2025-02-03 UTC
    Version: 1.0.0+2
    License: ISC License
        SPDX Identifier: ISC
    GitHub: https://github.com/RailTypes/PolytoriaServerIP
    Codeberg: N/A

]]

-- Services
local scriptService = game["ScriptService"]

-- Constants
local URL = "https://ipinfo.io/json"
local SEND_OPTIONS = {"ip", "hostname", "city", "region", "country", "loc", "org", "postal", "timezone",} -- any key returned by ipinfo.io/json

local START_DELAY = 1
local RETRY_DELAY = 5

local DISABLE_IN_CREATOR = true

-- Variables
local success = false

-- Networking
local networkEvent = Instance.New("NetworkEvent")
networkEvent.Name = "ServerIP"
networkEvent.Parent = scriptService

local netMessage = NetMessage.New()
netMessage:AddBool("loaded", true)

local netMessageLoading = NetMessage.New()
netMessageLoading:AddBool("loaded", false)

-- Return the IP info to the client if available.
networkEvent.InvokedServer:Connect(function(player, message)
    if success then
        networkEvent.InvokeClient(netMessage, player)
    else
        networkEvent.InvokeClient(netMessageLoading, player)
    end
end)

-- Disable IP checking, so only a "loading" message is returned
if DISABLE_IN_CREATOR and game.GameID == 0 then return end

-- Start delay
wait(START_DELAY)

-- Callback for the GET request.
local function httpCallback(data, didError, errMsg)
    if didError then
        warn("Could not get IP info: " .. errMsg)
    else
        local info = json.parse(data)
        for index, option in pairs(SEND_OPTIONS) do
            netMessage:AddString(option, info[option])
        end
        success = true
    end
end

-- Begin attempting to get the IP info.
repeat
    Http:Get(URL, httpCallback, {})
    wait(RETRY_DELAY)
until success
