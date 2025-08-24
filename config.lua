RAKI = {}

RAKI.Permissions = {
    ["ab6ae79788f00264d116f586b3b1d349b4d6b63c"] = true,
}

RAKI.PedAllowed = {
    ["ab6ae79788f00264d116f586b3b1d349b4d6b63c"] = true,
}

function CLNotify(type, title, msg)
    TriggerEvent("lrp_notify", type, title, msg)
end