// -----------------------------------------------------------------------------
// Forever Sandy - Sandevistan Tweaks
// Redscript System Component
// Version: 2.1.0
// -----------------------------------------------------------------------------

public class ForeverSandySystem extends ScriptableSystem {
    private let m_durationModifier: ref<gameStatModifierData>;
    private let m_cooldownModifier: ref<gameStatModifierData>;

    public static func GetInstance(gameInstance: GameInstance) -> ref<ForeverSandySystem> {
        return GameInstance.GetScriptableSystemsContainer(gameInstance).Get(n"ForeverSandySystem") as ForeverSandySystem;
    }

    public func UpdateDurationMultiplier(player: ref<PlayerPuppet>, multiplier: Float) -> Bool {
        if !IsDefined(player) { return false; }
        let statsSystem = GameInstance.GetStatsSystem(player.GetGame());
        let ownerID = Cast<StatsObjectID>(player.GetEntityID());
        if !IsDefined(statsSystem) { return false; }

        // Remove only our previously tracked duration modifier (preserves vanilla & other mod stats)
        if IsDefined(this.m_durationModifier) {
            statsSystem.RemoveModifier(ownerID, this.m_durationModifier);
            this.m_durationModifier = null;
        }

        // Clamp to valid range [0.10, 10.0] (< 1.0 reduces duration, > 1.0 extends it)
        if multiplier < 0.10 { multiplier = 0.10; }
        if multiplier > 10.0 { multiplier = 10.0; }

        // Only apply modifier if different from vanilla baseline (1.0x)
        let diff: Float = multiplier - 1.0;
        if diff < 0.0 { diff = -diff; }

        if diff > 0.01 {
            this.m_durationModifier = RPGManager.CreateStatModifier(
                gamedataStatType.TimeDilationSandevistanDuration,
                gameStatModifierType.Multiplier,
                multiplier
            );
            statsSystem.AddModifier(ownerID, this.m_durationModifier);
        }
        return true;
    }

    public func UpdateCooldownMultiplier(player: ref<PlayerPuppet>, multiplier: Float) -> Bool {
        if !IsDefined(player) { return false; }
        let statsSystem = GameInstance.GetStatsSystem(player.GetGame());
        let ownerID = Cast<StatsObjectID>(player.GetEntityID());
        if !IsDefined(statsSystem) { return false; }

        // Remove only our previously tracked cooldown modifier
        if IsDefined(this.m_cooldownModifier) {
            statsSystem.RemoveModifier(ownerID, this.m_cooldownModifier);
            this.m_cooldownModifier = null;
        }

        // Clamp to valid range [0.10, 5.0] (< 1.0 accelerates recharge, > 1.0 increases delay for challenge)
        if multiplier < 0.10 { multiplier = 0.10; }
        if multiplier > 5.0 { multiplier = 5.0; }

        // Only apply modifier if different from vanilla baseline (1.0x)
        let diff: Float = multiplier - 1.0;
        if diff < 0.0 { diff = -diff; }

        if diff > 0.01 {
            this.m_cooldownModifier = RPGManager.CreateStatModifier(
                gamedataStatType.TimeDilationSandevistanRechargeDuration,
                gameStatModifierType.Multiplier,
                multiplier
            );
            statsSystem.AddModifier(ownerID, this.m_cooldownModifier);
        }
        return true;
    }

    public func UpdateCooldownReduction(player: ref<PlayerPuppet>, reductionPercent: Float) -> Bool {
        // Backwards compatibility delegate for legacy calls
        return this.UpdateCooldownMultiplier(player, 1.0 - reductionPercent);
    }

    public func ClearModifiers(player: ref<PlayerPuppet>) -> Void {
        if !IsDefined(player) { return; }
        let statsSystem = GameInstance.GetStatsSystem(player.GetGame());
        let ownerID = Cast<StatsObjectID>(player.GetEntityID());
        if !IsDefined(statsSystem) { return; }

        if IsDefined(this.m_durationModifier) {
            statsSystem.RemoveModifier(ownerID, this.m_durationModifier);
            this.m_durationModifier = null;
        }
        if IsDefined(this.m_cooldownModifier) {
            statsSystem.RemoveModifier(ownerID, this.m_cooldownModifier);
            this.m_cooldownModifier = null;
        }
    }

    private func OnDetach() -> Void {
        // Reset handles on game session detach
        this.m_durationModifier = null;
        this.m_cooldownModifier = null;
    }
}

// -----------------------------------------------------------------------------
// PlayerPuppet extensions (called by CET init.lua and external scripts)
// -----------------------------------------------------------------------------
@addMethod(PlayerPuppet)
public func UpdateSandevistanMultiplier(multiplier: Float) -> Bool {
    let system = ForeverSandySystem.GetInstance(this.GetGame());
    if IsDefined(system) {
        return system.UpdateDurationMultiplier(this, multiplier);
    }
    return false;
}

@addMethod(PlayerPuppet)
public func UpdateSandevistanCooldownMultiplier(multiplier: Float) -> Bool {
    let system = ForeverSandySystem.GetInstance(this.GetGame());
    if IsDefined(system) {
        return system.UpdateCooldownMultiplier(this, multiplier);
    }
    return false;
}

@addMethod(PlayerPuppet)
public func UpdateSandevistanCooldown(reductionPercent: Float) -> Bool {
    let system = ForeverSandySystem.GetInstance(this.GetGame());
    if IsDefined(system) {
        return system.UpdateCooldownReduction(this, reductionPercent);
    }
    return false;
}