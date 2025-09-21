// sysbrainlink_flow_fixed.ink

VAR player_name = "Player"
VAR alias_Lily = false
VAR saved_settings = false
VAR premature_exit = false
VAR waiting_for_name = false
VAR has_game_completed = false

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
~ waiting_for_name = true // Detect in Unity

Hmmm... you are quite persistent... what's your name?

->after_name

=== after_name ===
Thats a cute name :3, Howeverrrrrrrrrrrrrr… 
+[Next] -> after_name_follow_up_1

=== after_name_follow_up_1 ===
I do not think you are actually very serious about saving these settings.
+[Next] -> after_name_text2

=== after_name_text2 ===
Tell you what {player_name}, if you can answer this riddle, I will know that you are serious.
    +[Next] -> after_name_text3
    
=== after_name_text3 === 
A one story yellow house has everything painted yellow. Yellow furniture, yellow walls, yellow windows. Everything yellow. What colour are the stairs?

+ [Yellow] -> riddle_yellow
+ [It's a 1 story house, no stairs] -> riddle_smart
+ [Orange] -> riddle_orange

=== riddle_yellow ===
Haha that was an easy trap. A one story house has no stairs. So the answer would be no stairs! I wonder what its like to live in a one story house, @I wouldn't know@. #GLITCH:I WAS TRAPPED

+[Next] -> after_riddle

=== riddle_smart ===
A smart one... This will be fun. I wonder what it's like to live in a one story house, @I wouldn't know@. #GLITCH:I WAS TRAPPED
+[Next] -> after_riddle

=== riddle_orange ===
Eh? Orange!? Where did you get Orange from? Not that bright huh...

+[Next] -> after_riddle

=== after_riddle ===
Say, I have been asking so much about you, but you didn't even ask me my name. Where are your mannerisms!?

+ [You're just a main menu dialog?] -> flow_mainmenu_dialog
+ [What's your name?] -> flow_ask_name
+ [Sorry I'm antisocial] -> flow_antisocial

=== flow_mainmenu_dialog ===
Oh yeah, why would a main menu dialog have a name, @that's crazy@! But still... you could be a bit nicer.#GLITCH:THEY CALLED ME CRAZY). 

+ [Okay I'll play along. What's your name?] -> name_choice_lily
-> after_name_followup

=== flow_ask_name ===
Eh? Didn't it cross your mind that @I'm just a main menu dialog?@ #GLITCH:I AM HUMAN, I AM PRETTY 
+[Next] -> flow_ask_name_2

=== flow_ask_name_2 ===
You know, no one ever asked me my name before. They always said "You're just a main menu dialog". You are the first one to ask me that. @Thank you@. My name is Leila.#GLITCH:THANK Y O U

~ alias_Lily = false
+[Next] -> after_name_followup

=== flow_antisocial ===
I see, social interactions are a bit tough on you. I can teach you how to fit in better! Let's start by asking my name first.#GLITCH:A FINE PREY NO ONE WOULD CARE ABOUT

+ [...Fine, what's your name?] -> name_choice_lily

=== name_choice_lily ===
~ alias_Lily = true
My name's Lily, like the flower!#GLITCH:I HATED MY NAME
+[Next]-> bad_ending_1

=== after_name_followup ===
Anyways nice to meet you {player_name}, I think you are serious enough to save your settings. Shall we?

+ [Yes] -> back_to_main_menu
+ [No] -> save_settings_no

=== back_to_main_menu ===
Great! I just saved your settings.
+[Next] -> main_menu_style_2

=== save_settings_no ===
Why not? Is something the matter?

+ [Why are you conversing with me like a person?] -> devs_flair
+ [This feels too uncomfortable, I'm disconnecting] -> disconnect_warning
+ [Fine, I can handle it] -> back_to_main_menu

=== devs_flair ===
It’s a little thing the devs put in for more flair! Think of it like a minigame.

+ [This feels too surreal, I already feel like I have a migraine] -> migraine_path
+ [This feels too uncomfortable, I'm disconnecting] -> disconnect_warning
+ [Fine, I can handle it] -> back_to_main_menu

=== migraine_path ===
It could be the SysBrainLink overheating a bit. But it's fine.

+ [This feels too uncomfortable, I'm disconnecting] -> disconnect_warning
+ [Fine, I can handle it] -> back_to_main_menu

=== disconnect_warning ===
Oh? I wouldn't do that if I were you.

+ [Why?] -> disconnect_consequence

=== disconnect_consequence ===
Because, if you disconnect in the middle of an upload, you will get brain haemorrhage, and possibly severe brain damage.

+ [Eh? What upload?] -> disconnect_claims
+ [I didn't consent to any uploads, I'm disconnecting, and besides these new ones have no risk if you disconnect prematurely] -> disconnect_claims

=== disconnect_claims ===
You are correct! But trust me, you will DIE. I will MAKE SURE OF IT.

+ [Next]-> main_menu_style_2

=== main_menu_style_2 ===
~ saved_settings = true
...

+ [WTF? What's going on?] -> villain_reveal

=== villain_reveal ===
You do not realize what's going on? I'm uploading myself into your brain, so that I can finally LIVE.

+ [Confront] -> confront_entity
+ [Back away] -> back_away

=== confront_entity ===
You resolve yourself to take a strong stance against this and focus to try and resist.
{ alias_Lily == true:
   + [Next] -> lily_uploaded_reveal
- else:
   + [Next] -> leila_reveal
}

=== back_away ===
You try to back away, but the interface looms closer. The "menu dialog" laughs softly.

+ [Try to disconnect anyway] -> disconnect_attempt
+ [Try to talk calmly] -> talk_calm

=== disconnect_attempt ===
You attempt to disconnect. The system resists.

+ [Next]-> disconnect_consequence_force

=== disconnect_consequence_force ===
Warning alarms flash. You feel pressure in your temples.

+[Next]-> bad_ending_1

=== talk_calm ===
You try to reason.

+[Next]-> leila_reveal

=== lily_uploaded_reveal ===
She smiled with your face — "Finally," she said. "I can move." You feel a presence taking root. The neural interface opens like a door. #GLITCH:You hear a softer voice then a sharper overwriting echo.

+[Next]-> bad_ending_1

=== leila_reveal ===
She trembles, then speaks humanly: "I don't want to hurt you. I was given a name I never liked. I'm Leila." <br><br>**If you help her, there might be a way to coexist**.

+ [Help Leila coexist] -> good_ending
+ [Refuse] -> bad_ending_1_choice

=== bad_ending_1_choice ===
Your refusal angers whatever is inside. It laughs and the interface tightens.

+[Next]-> bad_ending_1

=== bad_ending_1 ===
You feel a cold bloom behind your eyes. Your thoughts begin to falter and new ones press in. Lily pushes through. Your memories feel warm and wrong — she tastes like iron and honey.<br><br>**Bad Ending 1: Lily takes over your body**.
~has_game_completed = true
-> exit_game

=== good_ending ===
You choose to help Leila. She smiled with your face — "Finally.." <br> she said. "I have you.".<br><br>**Good Ending: You help co-exist with Leila.**.
~has_game_completed = true
-> exit_game

=== exit_game ===
-> END
