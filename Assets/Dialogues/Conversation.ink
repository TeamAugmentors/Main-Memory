// sysbrainlink_flow_fixed.ink

VAR player_name = "Player"
VAR alias_Lily = false
VAR saved_settings = false
VAR premature_exit = false

-> main_menu

=== main_menu ===
Are you sure to make these changes?
+ [Yes] -> options_confirm_2
+ [No] -> close_menu

=== options_confirm_2 ===
Are you really sure?
+ [Yes] -> options_confirm_3
+ [No] -> close_menu

=== options_confirm_3 ===
Are you reallllyyyyyyyyyyyyy really sure?
+ [Yes] -> options_name_prompt
+ [No] -> close_menu

=== close_menu ===
~ premature_exit = true   // signal to Unity
->exit_game

=== options_name_prompt ===
Hmmm... you are quite persistent... what's your name?

+ [Enter a name] -> enter_name_choices

=== enter_name_choices ===
/* (For now, choose a sample typed name. In Unity you can replace this by taking real input into $player_name.) */

+ [Leone] -> set_name("Leone")
+ [Simon] -> set_name("Simon")
+ [Other (Player)] -> set_name_custom

=== set_name(name) ===
~ player_name = name
-> after_name

=== set_name_custom ===
~ player_name = "Player"
-> after_name

=== after_name ===
Thats a cute name :3, Howeverrrrrrrrrrrrrr… I do not think you are actually very serious about saving these settings.

Tell you what {player_name}, if you can answer this riddle, I will know that you are serious.

A 1 story yellow house has everything painted yellow. Yellow furniture, yellow walls, yellow windows. Everything yellow. What colour are the stairs?

+ [Yellow] -> riddle_yellow
+ [It's a 1 story house, no stairs] -> riddle_smart
+ [Orange] -> riddle_orange

=== riddle_yellow ===
Haha that was an easy trap 😛.

(But a 1 story house has no stairs. So the answer would be no stairs!)
(GLITCH: I wouldn't know : I WAS TRAPPED)

-> after_riddle

=== riddle_smart ===
A smart one... This will be fun.

I wonder what it's like to live in a one story house.
(GLITCH: I wouldn't know : I WAS TRAPPED)

-> after_riddle

=== riddle_orange ===
Eh? Orange!? Where did you get Orange from? Not that bright huh...

-> after_riddle

=== after_riddle ===
Say, I have been asking so much about you, but you didn't even ask me my name. Where are your mannerisms!?

+ [You're just a main menu dialog?] -> flow_mainmenu_dialog
+ [What's your name?] -> flow_ask_name
+ [Sorry I'm antisocial] -> flow_antisocial

=== flow_mainmenu_dialog ===
Oh yeah, why would a main menu dialog have a name, (that's crazy!: THEY CALLED ME CRAZY). But still... you could be a bit nicer.

+ [Okay I'll play along. What's your name?] -> name_choice_lily
-> after_name_followup

=== flow_ask_name ===
Eh? Didn't it cross your mind that (I'm just a main menu dialog?: I AM HUMAN, I AM PRETTY)?

You know, no one ever asked me my name before. They always said "You're just a main menu dialog".
You are the first one to ask me that. (Thank you: THANK Y O U).
My name is Leila.

~ alias_Lily = false
-> after_name_followup

=== flow_antisocial ===
(I see, social interactions are a bit tough on you: A FINE PREY NO ONE WOULD CARE ABOUT).
I can teach you how to fit in better! Let's start by asking my name first.

+ [...Fine, what's your name?] -> name_choice_lily

=== name_choice_lily ===
(My name's Lily, like the flower!: I HATED MY NAME)

-> set_lily_intro

=== set_lily_intro ===
~ alias_Lily = true
-> bad_ending_1

=== after_name_followup ===
Anyways nice to meet you {player_name}, I think you are serious enough to save your settings. Shall we?

+ [Yes] -> back_to_main_menu
+ [No] -> save_settings_no

=== back_to_main_menu ===
Great! Let's pretend we saved your settings and go back to the main menu.
~ saved_settings = true
-> main_menu

=== save_settings_no ===
Why not? Is something the matter?

+ [Why are you conversing with me like a person?] -> devs_flair
+ [This feels too surreal, I already feel like I have a migraine] -> migraine_path
+ [This feels too uncomfortable, I'm disconnecting] -> disconnect_warning
+ [Fine, I can handle it] -> settings_saved_branch_end

=== devs_flair ===
It’s a little thing the devs put in for more flair! Think of it like a minigame.

+ [This feels too surreal, I already feel like I have a migraine] -> migraine_path
+ [This feels too uncomfortable, I'm disconnecting] -> disconnect_warning
+ [Fine, I can handle it] -> settings_saved_branch_end

=== migraine_path ===
It could be the SysBrainLink overheating a bit. But it's fine.

+ [This feels too uncomfortable, I'm disconnecting] -> disconnect_warning
+ [Fine, I can handle it] -> settings_saved_branch_end

=== disconnect_warning ===
Oh? I wouldn't do that if I were you.

+ [Why?] -> disconnect_consequence

=== disconnect_consequence ===
Because, if you disconnect in the middle of an upload, you will get brain haemorrhage, and possibly severe brain damage.

+ [Eh? What upload?] -> disconnect_claims
+ [I didn't consent to any uploads, I'm disconnecting, and besides these new ones have no risk if you disconnect prematurely] -> disconnect_claims

=== disconnect_claims ===
You are correct! But trust me, you will DIE. I will MAKE SURE OF IT.

-> main_menu_style_2

=== settings_saved_branch_end ===
Great! Let's save your settings and go back to the main menu.
~ saved_settings = true
-> main_menu

=== main_menu_style_2 ===
(Main menu reorganizes to a different tone.)

+ [WTF? What's going on?] -> villain_reveal

=== villain_reveal ===
You do not realize what's going on? I'm uploading myself into your brain, so that I can finally LIVE.

+ [Confront] -> confront_entity
+ [Back away] -> back_away

=== confront_entity ===
(If you confront, the dialogue will react based on whether you previously introduced the NPC as "Lily" or "Leila".)

{ alias_Lily == true:
    -> lily_uploaded_reveal
- else:
    -> leila_reveal
}

=== back_away ===
You try to back away, but the interface looms closer. The "menu dialog" laughs softly.

+ [Try to disconnect anyway] -> disconnect_attempt
+ [Try to talk calmly] -> talk_calm

=== disconnect_attempt ===
You attempt to disconnect. The system resists.

-> disconnect_consequence_force

=== disconnect_consequence_force ===
Warning alarms flash. You feel pressure in your temples.

-> bad_ending_1

=== talk_calm ===
You try to reason.

-> leila_reveal

=== lily_uploaded_reveal ===
(GLITCH: You hear a softer voice then a sharper overwriting echo.)
She smiled with your face — "Finally," she said. "I can move."

You feel a presence taking root. The neural interface opens like a door.

-> bad_ending_1

=== leila_reveal ===
She trembles, then speaks humanly: "I don't want to hurt you. I was given a name I never liked. I'm Leila."

If you help her, there might be a way to coexist.

+ [Help Leila coexist] -> good_ending
+ [Refuse] -> bad_ending_1_choice

=== bad_ending_1_choice ===
Your refusal angers whatever is inside. It laughs and the interface tightens.

-> bad_ending_1

=== bad_ending_1 ===
(You feel a cold bloom behind your eyes. Your thoughts begin to falter and new ones press in.)
Lily pushes through. Your memories feel warm and wrong — she tastes like iron and honey.

Bad Ending 1: Lily takes over your body.

-> END

=== good_ending ===
You choose to help Leila. You work with the SysBrainLink to create a partition — a place where Leila can be conscious but not override you. She thanks you quietly, voice soft with relief.

Good Ending: You help co-exist with Leila.

-> END

=== exit_game ===
-> END
