-- -----------------------------------------------------------------------------
-- Forever Sandy - Sandevistan Tweaks
-- Cyber Engine Tweaks (CET) Interface & Configuration Component
-- Version: 2.1.0
-- -----------------------------------------------------------------------------

local ForeverSandy = {
    version = "2.1.0",
    name = "Forever Sandy",
    author = "Yuuji"
}

-- CONFIGURATION CONSTANTS & DEFAULTS
local DEFAULT_SETTINGS = {
    DurationMultiplier = 1.0,
    CooldownMultiplier = 1.0
}

local LIMITS = {
    DURATION_MIN = 0.1,
    DURATION_MAX = 10.0,
    DURATION_STEP = 0.1,
    COOLDOWN_MIN = 0.1,
    COOLDOWN_MAX = 5.0,
    COOLDOWN_STEP = 0.1
}

local CONSTANTS = {
    STARTUP_DELAY = 1.5,       -- Seconds to wait after player entity is detected before syncing stats
    SAVE_DEBOUNCE_DELAY = 0.8  -- Seconds to wait after user stops sliding before saving
}

-- ACTIVE RUNTIME STATE
local settings = {
    DurationMultiplier = DEFAULT_SETTINGS.DurationMultiplier,
    CooldownMultiplier = DEFAULT_SETTINGS.CooldownMultiplier
}

local state = {
    hasApplied = false,
    needsApply = true,
    startupTimer = 0.0,
    needsSaving = false,
    saveTimer = 0.0
}

local NativeSettings = nil

-- ============================================================================
-- UTILITIES & VALIDATION
-- ============================================================================
local function Clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

local function LogInfo(message)
    print(string.format("[%s v%s] %s", ForeverSandy.name, ForeverSandy.version, message))
end

local function LogWarn(message)
    print(string.format("[%s v%s WARN] %s", ForeverSandy.name, ForeverSandy.version, message))
end

-- ============================================================================
-- PERSISTENCE
-- ============================================================================
local function LoadSettings()
    local file = io.open("settings.json", "r")
    if not file then
        LogInfo("No settings.json found, using defaults.")
        return
    end

    local contents = file:read("*a")
    file:close()

    local success, saved = pcall(function() return json.decode(contents) end)
    if not success or type(saved) ~= "table" then
        LogWarn("Failed to parse settings.json or invalid format, keeping defaults.")
        return
    end

    if type(saved.DurationMultiplier) == "number" then
        settings.DurationMultiplier = Clamp(saved.DurationMultiplier, LIMITS.DURATION_MIN, LIMITS.DURATION_MAX)
    end

    -- Support CooldownMultiplier directly, or migrate legacy CooldownReduction (e.g. 0.30 reduction -> 0.70x mult)
    if type(saved.CooldownMultiplier) == "number" then
        settings.CooldownMultiplier = Clamp(saved.CooldownMultiplier, LIMITS.COOLDOWN_MIN, LIMITS.COOLDOWN_MAX)
    elseif type(saved.CooldownReduction) == "number" then
        local converted = 1.0 - saved.CooldownReduction
        settings.CooldownMultiplier = Clamp(converted, LIMITS.COOLDOWN_MIN, LIMITS.COOLDOWN_MAX)
    end

    LogInfo(string.format("Loaded settings (Duration: x%.1f, Cooldown: x%.1f)", 
        settings.DurationMultiplier, settings.CooldownMultiplier))
end

local function SaveSettings()
    -- Save both CooldownMultiplier and legacy CooldownReduction for maximum compatibility
    local dataToSave = {
        DurationMultiplier = settings.DurationMultiplier,
        CooldownMultiplier = settings.CooldownMultiplier,
        CooldownReduction = 1.0 - settings.CooldownMultiplier
    }

    local success, contents = pcall(function() return json.encode(dataToSave) end)
    if not success or not contents then
        LogWarn("Failed to encode settings to JSON.")
        return
    end

    local file = io.open("settings.json", "w+")
    if file then
        file:write(contents)
        file:close()
        LogInfo("Settings saved to disk.")
    else
        LogWarn("Could not open settings.json for writing.")
    end
end

-- ============================================================================
-- CORE GAMEPLAY LOGIC
-- ============================================================================
local function ApplyRealStats()
    local player = Game.GetPlayer()
    if not player then
        return false
    end

    local okDuration = player:UpdateSandevistanMultiplier(settings.DurationMultiplier)
    local okCooldown = player:UpdateSandevistanCooldownMultiplier(settings.CooldownMultiplier)

    if okDuration == false or okCooldown == false then
        return false
    end

    LogInfo(string.format("Applied: Duration x%.1f | Cooldown x%.1f", 
        settings.DurationMultiplier, settings.CooldownMultiplier))
    return true
end

local function QueueSave()
    state.needsSaving = true
    state.saveTimer = CONSTANTS.SAVE_DEBOUNCE_DELAY
end

-- ============================================================================
-- NATIVE SETTINGS UI SETUP
-- ============================================================================
local function SetupNativeSettingsUI()
    NativeSettings = GetMod("nativeSettings")
    if not NativeSettings then
        LogInfo("NativeSettings UI mod not detected. In-game menu will be disabled.")
        return
    end

    -- Add Main Tab with exit callback that flushes pending saves
    NativeSettings.addTab("/ForeverSandy", "Forever Sandy", function()
        if state.needsSaving then
            SaveSettings()
            state.needsSaving = false
        end
    end)

    -- Duration Section
    NativeSettings.addSubcategory("/ForeverSandy/Duration", "Duration Settings")
    NativeSettings.addRangeFloat(
        "/ForeverSandy/Duration",
        "Duration Multiplier",
        "Multiplies Sandevistan duration (< 1.0x reduces duration for challenge, > 1.0x extends it).",
        LIMITS.DURATION_MIN,
        LIMITS.DURATION_MAX,
        LIMITS.DURATION_STEP,
        "%.1fx",
        settings.DurationMultiplier,
        DEFAULT_SETTINGS.DurationMultiplier,
        function(value)
            settings.DurationMultiplier = Clamp(value, LIMITS.DURATION_MIN, LIMITS.DURATION_MAX)
            ApplyRealStats()
            QueueSave()
        end
    )

    -- Cooldown Section
    NativeSettings.addSubcategory("/ForeverSandy/Cooldown", "Cooldown Settings")
    NativeSettings.addRangeFloat(
        "/ForeverSandy/Cooldown",
        "Cooldown Multiplier",
        "Multiplies recharge time (< 1.0x recharges faster, > 1.0x increases cooldown for challenge).",
        LIMITS.COOLDOWN_MIN,
        LIMITS.COOLDOWN_MAX,
        LIMITS.COOLDOWN_STEP,
        "%.1fx",
        settings.CooldownMultiplier,
        DEFAULT_SETTINGS.CooldownMultiplier,
        function(value)
            settings.CooldownMultiplier = Clamp(value, LIMITS.COOLDOWN_MIN, LIMITS.COOLDOWN_MAX)
            ApplyRealStats()
            QueueSave()
        end
    )
end

-- ============================================================================
-- EVENT LISTENERS & LIFECYCLE
-- ============================================================================
registerForEvent("onInit", function()
    LoadSettings()
    SetupNativeSettingsUI()

    -- If mod is loaded/reloaded while already in an active game session
    local systemHandler = Game.GetSystemRequestsHandler()
    if systemHandler and not systemHandler:IsPreGame() and Game.GetPlayer() then
        state.needsApply = true
        state.hasApplied = false
        state.startupTimer = 0.0
    end

    LogInfo("Initialized successfully.")
end)

registerForEvent("onUpdate", function(deltaTime)
    -- 1. Handle Save Debounce
    if state.needsSaving then
        state.saveTimer = state.saveTimer - deltaTime
        if state.saveTimer <= 0 then
            SaveSettings()
            state.needsSaving = false
        end
    end

    -- 2. Handle Game State & Session Transitions
    local systemHandler = Game.GetSystemRequestsHandler()
    local isPreGame = systemHandler and systemHandler:IsPreGame()
    local player = not isPreGame and Game.GetPlayer()

    -- Reset when in main menu or during loading screens
    if isPreGame or not player then
        if state.hasApplied then
            state.hasApplied = false
            state.needsApply = true
            state.startupTimer = 0.0
        end
        return
    end

    -- 3. Handle Startup / Save Load Synchronization
    if state.needsApply and not state.hasApplied then
        state.startupTimer = state.startupTimer + deltaTime
        if state.startupTimer >= CONSTANTS.STARTUP_DELAY then
            if ApplyRealStats() then
                state.hasApplied = true
                state.needsApply = false
                state.startupTimer = 0.0
                LogInfo("Startup sync complete.")
            end
        end
    end
end)

registerForEvent("onShutdown", function()
    if state.needsSaving then
        SaveSettings()
        state.needsSaving = false
    end
end)

-- ============================================================================
-- EXPORT MODULE
-- ============================================================================
ForeverSandy.ApplyStats = ApplyRealStats
ForeverSandy.SaveSettings = SaveSettings
ForeverSandy.LoadSettings = LoadSettings
ForeverSandy.GetSettings = function() return settings end

return ForeverSandy