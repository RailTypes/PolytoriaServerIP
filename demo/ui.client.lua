--[[

    ###################################
    ## Polytoria Server IP - UI Demo ##
    ###################################

    A simple client-sided script that displays the server IP in a text label.

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
local DISPLAY_OPTIONS = {"ip", "hostname", "city", "region", "country", "loc", "org", "postal", "timezone",}
local RETRY_DELAY = 5

-- Instances
local networkEvent = scriptService["ServerIP"]
local label = script.Parent

-- Networking
local netMessageEmpty = NetMessage.New()

-- Variables
local loaded = false

-- Begin attempting to fetch the IP info.
networkEvent.InvokedClient:Connect(function(_, message)
    loaded = message:GetBool("loaded")
    if loaded then
        label.Text = ""
        for index, option in pairs(DISPLAY_OPTIONS) do
            if index ~= 1 then
                label.Text = label.Text .. "\n"
            end
            label.Text = label.Text .. option .. ": " .. message:GetString(option)
        end
    else
        wait(RETRY_DELAY)
        networkEvent.InvokeServer(netMessageEmpty)
    end
end)

networkEvent.InvokeServer(netMessageEmpty)
