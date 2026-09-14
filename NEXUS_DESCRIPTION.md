# Nexus Mods Page Descriptions (v2.1.0)

## Short Description (Under 255 Characters)

```text
Tired of your Sandy fizzling out or making late-game too easy? Tweak Duration (0.1x–10x) and Cooldown (0.1x–5x) on the fly. Go god-mode or tactical challenge. Works on all Sandevistans. No reloads, no hassle, pure preem speed.
```

*(Character count: 228 / 255 max)*

---

## Full Description (BBCode)

```bbcode
[center]
[size=6][b][color=#2dfcfa]FOREVER SANDY[/color][/b][/size]
[size=3][i][color=#fcee0a]Unlock the factory limiters on your speedware — or handicap it for the ultimate challenge.[/color][/i][/size]

[size=4][b][color=#00ff00]✓ PATCH 2.31 SUPPORTED[/color][/b][/size]
[size=3][b][color=#2dfcfa]⚡ VERSION 2.1.0: HARDCORE & CHALLENGE MODE UPDATE[/color][/b][/size]

[img]https://i.imgur.com/67cfqRp.gif[/img]

[size=4][b][color=#ff003c]WARNING: SYNAPSE ACCELERATOR ENGAGED[/color][/b][/size][/center]

[size=5][b][color=#2dfcfa]/// HEY THERE, EDGERUNNER[/color][/b][/size]
[line]
Let me guess. You dropped a mountain of eddies on a Militech "Apogee" Sandevistan, you slotted it in, and either:
1. 6 seconds later you're standing there like a gonk waiting for the recharge while getting turned into swiss cheese.
[b]OR[/b]
2. By level 50+, you're so insanely overpowered that clicking your Sandy turns Night City into a shooting gallery with zero stakes.

[b][size=4]Both problems solved. One preem daemon.[/size][/b]

Forever Sandy hooks directly into your OS kernel to give you complete bidirectional control over your Sandevistan. Whether you want to go full [b]"Cyberpsychosis God Mode"[/b] with 10x duration and instant recharges, or you want a [b]Tactical Hardcore Challenge[/b] with razor-thin bursts and punishing cooldown delays to keep late-game combat terrifying, I got you covered.


[size=5][b][color=#2dfcfa]/// THE GOODS (FEATURES)[/color][/b][/size]
[line]
[list]
[*][b][color=#fcee0a]>> Synaptic Regulator (Duration Multiplier: 0.1x – 10.0x)[/color][/b]
Fine-tune your slow-motion window on the fly:
• [b]Challenge / Burst Mode (< 1.0x):[/b] Drop it to 0.2x–0.5x for short tactical bursts. Forces split-second decisions and brings tension back to high-level firefights.
• [b]Vanilla Baseline (1.0x):[/b] Standard factory duration.
• [b]Power Fantasy (> 1.0x):[/b] Crank it all the way up to 10.0x. Make that 6-second Apogee run for a full minute. Take a sip of Nicola while the bullet hangs in mid-air.[/*]

[*][b][color=#fcee0a]>> Heat Dissipation (Cooldown Multiplier: 0.1x – 5.0x)[/color][/b]
Dial your recharge cycle to fit your playstyle:
• [b]Rapid Recovery (< 1.0x):[/b] Cut your recharge time down by up to 90% (0.1x). Spam that Sandy like a rogue AI.
• [b]Vanilla Baseline (1.0x):[/b] Unmodified recharge delay.
• [b]Hardcore Punishment (> 1.0x):[/b] Lengthen your recharge up to 500% (5.0x). If you burn your Sandy, you better find cover because you won't be zooming again anytime soon.[/*]

[*][b][color=#fcee0a]>> Clean Scriptable Architecture (Zero Bloat)[/color][/b]
Engineered with a dedicated [i]ScriptableSystem[/i] that only touches its own modifier handles. It [b]never wipes vanilla Reflex scaling[/b], leaves other perks untouched, and produces zero per-frame CPU overhead while playing.[/*]

[*][b][color=#fcee0a]>> Universal Sandevistan Compatibility[/color][/b]
Works on [b]EVERYTHING[/b] that uses standard cyberware pipelines. Apogee? Check. Falcon? Check. Dynalar dumpster special? Check. Custom modded Sandevistans from Cyberware-EX? Absolutely.[/*]

[*][b][color=#fcee0a]>> Persistent Bios[/color][/b]
Set it and forget it. Your preferences are saved to your Kiroshis (disk) and automatically synchronize every time you jack in.[/*]
[/list]


[center][b][color=#00ff00]█▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀█[/color][/b]
[size=4][b][color=#00ff00]NEURAL ARCHITECTURE (v2.1.0)[/color][/b][/size]
[b][color=#00ff00]█▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█[/color][/b][/center]
[quote][b][color=#00ff00]✓ NON-DESTRUCTIVE STAT PIPELINE[/color][/b]
Earlier builds had to wipe session stats to apply multipliers, which messed with native Reflex bonuses.
In [b]v2.1.0[/b], Forever Sandy uses isolated modifier handles. Your [b]Reflexes Attribute bonus (+0.1s/reflex)[/b], cyberware stat affixes, and perk passives remain 100% intact and naturally multiply with your settings. Proper math, proper speed, zero side-effects.[/quote]


[size=5][b][color=#2dfcfa]/// SYSTEM COMPATIBILITY[/color][/b][/size]
[line]
[list]
[*][b][color=#00ff00][✓] COMPATIBLE:[/color][/b] [b]System-EX[/b]. Since this operates cleanly on player stat modifiers, slot extenders work without any hitch.[/*]
[*][b][color=#00ff00][✓] COMPATIBLE:[/color][/b] [b]Cyberware-EX[/b] and all custom/modded Sandevistan items that use standard game stat definitions.[/*]
[*][b][color=#ffff00][!] CAUTION:[/color][/b] [b]Time Dilation Overhaul (TDO)[/b]. TDO completely rewrites the game's internal time dilation engine and state machines. Running both will cause conflicts or ignored values.[/*]
[*][b][color=#ffff00][!] CAUTION:[/color][/b] Other slider mods modifying the exact same duration/cooldown parameters (e.g. [i]Sandevistan Customization[/i]). Pick one daemon, choom.[/*]
[/list]


[size=5][b][color=#2dfcfa]/// REQUIREMENTS[/color][/b][/size]
[line]
[i]You need the right drivers to run this chrome, choom.[/i]

[list=1]
[*][url=https://www.nexusmods.com/cyberpunk2077/mods/1511]Redscript[/url] (v0.5+)[/*]
[*][url=https://github.com/maximegmd/CyberEngineTweaks]Cyber Engine Tweaks[/url] (v1.37+)[/*]
[*][url=https://www.nexusmods.com/cyberpunk2077/mods/3518]Native Settings UI[/url][/*]
[/list]


[size=5][b][color=#2dfcfa]/// INSTALLATION PROTOCOL[/color][/b][/size]
[line]
[list=1]
[*]Download the zip from Files.[/*]
[*]Extract the [b]bin[/b] and [b]r6[/b] folders directly into your Cyberpunk 2077 root directory:
[list]
[*] [i]Steam:[/i]
[code]\SteamLibrary\steamapps\common\Cyberpunk 2077\[/code]
[/*]
[*][i]GOG:[/i]
[code]\GOG Galaxy\Games\Cyberpunk 2077\[/code]
[/*]
[/list]
[/*]
[*]Or install via [b]Vortex[/b] with one click.[/*]
[/list]

[b]File Integrity Check:[/b]
[code]Cyberpunk 2077\r6\scripts\ForeverSandy.reds
Cyberpunk 2077\bin\x64\plugins\cyber_engine_tweaks\mods\ForeverSandy\init.lua[/code]


[size=5][b][color=#2dfcfa]/// UNINSTALLATION[/color][/b][/size]
[line]
Simple delta:
[list]
[*]Delete [code]Cyberpunk 2077\r6\scripts\ForeverSandy.reds[/code][/*]
[*]Delete the folder [code]Cyberpunk 2077\bin\x64\plugins\cyber_engine_tweaks\mods\ForeverSandy\[/code][/*]
[/list]
Modifiers are session-memory only and never saved to your save file. 100% clean uninstallation.


[size=5][b][color=#2dfcfa]/// HOW TO TWEAK IN-GAME[/color][/b][/size]
[line]
1. [b]Jack In:[/b] Boot up the game and load your save.
2. [b]Access Bios:[/b] Open the Pause Menu -> [b]Mods[/b].
3. [b]Locate Daemon:[/b] Select [b]"Forever Sandy"[/b].
4. [b]Tune Speedware:[/b] Adjust Duration and Cooldown Multipliers.
5. [b]Done:[/b] Settings take effect immediately in real-time.


[size=5][b][color=#2dfcfa]/// TROUBLESHOOTING (FAQ)[/color][/b][/size]
[line]
[b]Q: How does the new Challenge / Handicap mode work?[/b]
A: Set Duration Multiplier below 1.0x (e.g. 0.3x) for short tactical bursts, and set Cooldown Multiplier above 1.0x (e.g. 2.0x) for extended recharge penalties. It makes high-tier Sandevistans like the Apogee feel balanced and intense again.

[b]Q: Does this multiply my Reflex Attribute duration bonus?[/b]
A: Yes! As of v2.1.0, the mod multiplies your total duration naturally through the engine's stat pipeline.

[b]Q: Why does Cooldown stop at 0.1x?[/b]
A: 0.1x is a 90% cooldown reduction (near-instant recharge). Dropping to exactly 0.0s can cause weapon swap and animation glitches in the game engine.

[b]Q: Does this affect enemy Sandevistans?[/b]
A: Negatory. This script hooks exclusively into the player puppet. Adam Smasher and enemy Sandevistan users do not get your speed buffs or penalties.

[b]Q: Do I need a new save game?[/b]
A: Never. Drop it into an existing level 60 save or a brand new playthrough without issues.


[size=5][b][color=#2dfcfa]/// CREDITS & SHOUTOUTS[/color][/b][/size]
[line]
Big respect to the legends who paved the way:
[list]
[*][b]Inspired by:[/b] [url=https://www.nexusmods.com/profile/Messaxs]Messaxs[/url] and their nova work on the [url=https://www.nexusmods.com/cyberpunk2077/mods/26637]Double Sandevistan Duration[/url] logic.[/*]
[*][b]Compilers:[/b] [url=https://www.nexusmods.com/cyberpunk2077/mods/1511]Redscript[/url] team.[/*]
[*][b]Core Tech:[/b] [url=https://github.com/maximegmd/CyberEngineTweaks]Cyber Engine Tweaks[/url] team.[/*]
[*][b]UI Framework:[/b] The preem [url=https://www.nexusmods.com/cyberpunk2077/mods/3518]Native Settings UI[/url] team.[/*]
[/list]

[center][img]https://i.imgur.com/DGrkqyr.gif[/img]

[i][color=#fcee0a]Enjoy the speed, V. Try not to burn out your synapses.[/color][/i][/center]
```
