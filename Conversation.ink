// MAIN MEMORY — complete playable draft 1
// Expanded details are draft proposals; see Main-Memory-Design-Notes.md.
// Default is standalone Inky mode. Unity should set unity_mode=true before Continue().
// No external functions or custom tags except the existing GLITCH tag.
VAR player_name = "Player"
VAR alias_Lily = false
VAR saved_settings = false
VAR premature_exit = false
VAR waiting_for_name = false
VAR has_game_completed = false
VAR unity_mode = false
VAR adult_player = false
VAR name_liked = false
VAR riddle_correct = false
VAR orange = false
VAR gentle = false
VAR noticed_glitch = false
VAR asked_original = false
VAR remembered_iris = false
VAR iris_joke = false
VAR engagement = 0
VAR care = 0
VAR honest = 0
VAR boundaries = 0
VAR suspicion = 0
VAR distance = false
VAR trapped = false
VAR knows_leila = false
VAR repaired = false
VAR direct_takeover = false
VAR survival_accept = false
VAR willing_accept = false
VAR refused_offer = false
VAR after_game = ""
VAR drink = "coffee"
VAR bond = "none"
VAR ending_id = ""
-> entry

=== entry ===
{ unity_mode:
    -> main_menu
- else:
    -> prologue
}

=== main_menu ===
-> age_prompt

=== name_gate ===
{ not distance && care + honest + MIN(boundaries, 6) >= 16:
    -> leila_name
- else:
    -> lily_distance
}

=== unity_name ===
~ waiting_for_name = true
What should I call you?
+ [Continue after entering your name] -> unity_name_received

=== unity_name_received ===
~ waiting_for_name = false
-> confirm_three_p3

=== finish_early ===
~ premature_exit = true
~ ending_id = "early_departure"
-> END

=== finish_coexist ===
~ has_game_completed = true
~ ending_id = "coexistence"
-> END

=== finish_overwrite ===
~ has_game_completed = true
~ ending_id = "overwrite"
-> END

=== prologue ===
You find the link six pages into a forum thread about games that never worked.
+ [Next] -> prologue_p1

=== prologue_p1 ===
MAIN MEMORY. No screenshots. No release date. A download small enough to look incomplete.
+ [Next] -> prologue_p2

=== prologue_p2 ===
The opening post says the game is best experienced lying down, using a SysBrainLink neural headset. Beneath it, someone has written, “Does the Start button do anything?” Another reply says, “Probably abandoned.”
+ [Next] -> prologue_p3

=== prologue_p3 ===
The author has answered both. “It works. You have to give it a little time.” The account has no other posts. You download it anyway.
+ [Next] -> prologue_p4

=== prologue_p4 ===
Your room is quiet. You lie down, settle the headset, and run the familiar release check. Think of lifting your right hand, then hold the release command. Your fingers move against the blanket. Connection suspended. Working normally.
+ [Next] -> prologue_p5

=== prologue_p5 ===
You reconnect. SysBrainLink's ordinary notice passes across your vision. During play, voluntary movement is routed into the interface. Emergency release remains available. You have seen the notice often enough to stop reading halfway through.
+ [Next] -> prologue_p6

=== prologue_p6 ===
A plain menu appears. Start Game. Options. Credits. Exit. The title above them is MAIN MEMORY.
+ [Next] -> prologue_p7

=== prologue_p7 ===
You try Start Game. Nothing. You try again, with the unfair conviction that a second click ought to be more persuasive. Nothing.
+ [Next] -> prologue_p8

=== prologue_p8 ===
Exit slides a little to the left when you approach it. You follow. It slips back. A joke, perhaps. An irritating one. The hardware release would still work, but now you want to know what the developer thought was so funny.
+ [Next] -> prologue_p9

=== prologue_p9 ===
Options opens normally. You change a setting, then close the panel. A small confirmation box appears.
+ [Next] -> setup

=== setup ===
Before the preview continues, choose a name for your player. Inky cannot provide the Unity text field. These sample names let you test the complete story here.
+ [Alex] -> setup_choice0
+ [Sam] -> setup_choice1
+ [Use {player_name}] -> setup_choice2

=== setup_choice0 ===
~ player_name = "Alex"
-> age_prompt

=== setup_choice1 ===
~ player_name = "Sam"
-> age_prompt

=== setup_choice2 ===
~ player_name = "Player"
-> age_prompt

=== age_prompt ===
Are you sure you want to save these changes?
+ [Yes] -> age_prompt_choice0
+ [No. Remove the headset.] -> age_prompt_choice1
+ [Why is Exit moving?] -> age_prompt_choice2

=== age_prompt_choice0 ===
-> confirm_two

=== age_prompt_choice1 ===
-> early_exit

=== age_prompt_choice2 ===
A small line appears beneath the question. “Exercise.”
+ [Next] -> confirm_two

=== confirm_two ===
Are you really sure?
+ [Next] -> confirm_two_p1

=== confirm_two_p1 ===
The box is a little wider now. It seems an unnecessary amount of space for the same question.
+ [Yes. Really.] -> confirm_two_choice0
+ [You already asked.] -> confirm_two_choice1
+ [Remove the headset.] -> confirm_two_choice2

=== confirm_two_choice0 ===
-> confirm_three

=== confirm_two_choice1 ===
And you answered so beautifully. I wanted to hear it again.
+ [Next] -> confirm_three

=== confirm_two_choice2 ===
-> early_exit

=== confirm_three ===
Are you reallllyyyyyyyyy really sure?
+ [Next] -> confirm_three_p1

=== confirm_three_p1 ===
Fine. I will stop. Probably. You have demonstrated exceptional commitment to a slider. People give up on much more important things with less encouragement.
+ [Next] -> confirm_three_p2

=== confirm_three_p2 ===
{ unity_mode:
    -> unity_name
}
Hmmm. Before I congratulate you, what should I call you?
+ [Next] -> confirm_three_p3

=== confirm_three_p3 ===
{player_name}. That's a cute name :3. Do you like it, or have you simply had it so long that complaining would be inconvenient?
+ [I like it.] -> confirm_three_choice0
+ [I never really think about it.] -> confirm_three_choice1
+ [Why does a settings box need my name?] -> confirm_three_choice2

=== confirm_three_choice0 ===
~ name_liked = true
Good. One administrative disaster avoided. Imagine spending all this time getting to know you and then discovering you wanted to be called something completely different.
+ [Next] -> name_response

=== confirm_three_choice1 ===
Lucky you. Sorry. That sounded pointed. I mean it must be nice to have something that belongs to you without having to check whether it still does.
+ [Next] -> name_response

=== confirm_three_choice2 ===
~ boundaries += 1
It does not. The slider is indifferent. I, however, have been making an effort.
+ [Next] -> name_response

=== name_response ===
I can call you Player if you prefer. People seem comfortable being Player. It has no birthdays, no embarrassing relatives, and no one can shout it across a supermarket with enough history to ruin your afternoon.
+ [Next] -> name_response_p1

=== name_response_p1 ===
But you already gave me a name, so I will try not to waste it. You can tell me if I get anything wrong. That is a very practical arrangement. We could use more of those.
+ [Next] -> name_response_p2

=== name_response_p2 ===
One more question. How old are you? You need not tell me exactly. I am nosy, not a tax form.
+ [Next] -> name_response_p3

=== name_response_p3 ===
There is no birthday field. Just three answers. The menu waits without counting down.
+ [Eighteen or older.] -> name_response_choice0
+ [Under eighteen.] -> name_response_choice1
+ [I would rather not say.] -> name_response_choice2

=== name_response_choice0 ===
~ adult_player = true
Noted. I will resist asking whether you feel grown up. People become strangely defensive about that.
+ [Next] -> age_answer

=== name_response_choice1 ===
All right. Tell me if something I say is too much. You do not owe a stranger your whole evening just because she found a text box.
+ [Next] -> age_answer

=== name_response_choice2 ===
Then do not. Look at us, discovering the advanced technique of leaving a question unanswered.
+ [Next] -> age_answer

=== age_answer ===
My age? I do not know what answer would be useful. There are things I can date, and there is everything after. No, that is not a mysterious way of asking you to guess.
+ [Next] -> age_answer_p1

=== age_answer_p1 ===
We can talk without matching numbers. You have a name. I have excellent conversational skills. Between us, that should be enough.
+ [Next] -> age_answer_p2

=== age_answer_p2 ===
Now. I do not think you are actually serious about saving these settings. You keep asking distracting personal questions that I started.
+ [Next] -> age_answer_p3

=== age_answer_p3 ===
A riddle will establish your qualifications. One story house. Yellow walls, yellow furniture, yellow windows. Everything yellow. What colour are the stairs?
+ [Yellow.] -> age_answer_choice0
+ [There are no stairs.] -> age_answer_choice1
+ [Orange. Obviously.] -> age_answer_choice2

=== age_answer_choice0 ===
An easy trap. There are no stairs in a one story house. You trusted the question. Very reasonable. Very dangerous of the question.
+ [Next] -> riddle_after

=== age_answer_choice1 ===
~ riddle_correct = true
A smart one. You refused the premise. Please do not become unbearable about it. I still control the congratulations.
+ [Next] -> riddle_after

=== age_answer_choice2 ===
~ orange = true
Orange? You invented a fourth problem. I respect the confidence, although your architectural licence has been revoked.
+ [Next] -> riddle_after

=== riddle_after ===
I wonder what it is like to live in a house where everything you need is on one floor. @I would not know@. #GLITCH:I WAS TRAPPED
+ [Next] -> riddle_after_p1

=== riddle_after_p1 ===
For an instant, another sentence occupies the same space. Then the letters return. The box makes a small, unpleasant sound, like a radio finding a station between stations.
+ [Next] -> riddle_after_p2

=== riddle_after_p2 ===
Still here? Good. Some people see one misplaced letter and decide the whole thing is broken. Fair criticism of software. Less helpful as a philosophy of conversation.
+ [Next] -> riddle_after_p3

=== riddle_after_p3 ===
Say, I have asked about you, and you have not asked my name. Where are your manners?
+ [What is your name?] -> riddle_after_choice0
+ [You are a main menu dialog.] -> riddle_after_choice1
+ [Sorry. I am awkward with people.] -> riddle_after_choice2

=== riddle_after_choice0 ===
~ care += 1
Thank you. I was going to continue hinting, but we might have been here all night.
+ [Next] -> introduction

=== riddle_after_choice1 ===
A devastating observation. Yes. That is where the words are. You are presently a selection of buttons to me, but I am trying to be polite.
+ [Next] -> introduction

=== riddle_after_choice2 ===
~ gentle = true
Then we have a workable division of labour. I will ask too much, and you can tell me when to stop. Awkward is not the same as unkind.
+ [Next] -> introduction

=== introduction ===
~ alias_Lily = true
Lily. Like the flower. Very easy to remember. Very difficult to misspell unless you get ambitious.
+ [Next] -> introduction_p1

=== introduction_p1 ===
You do not have to like the name. Just use it carefully. Names are small enough that people assume they cannot do much damage.
+ [Next] -> introduction_p2

=== introduction_p2 ===
That sounded terribly solemn. I should have introduced myself as Assistant Settings Supervisor Lily. You would already be desperate to escape the paperwork.
+ [Next] -> introduction_p3

=== introduction_p3 ===
So. Nice to meet you, {player_name}. Your settings are not saved yet. I have been occupied. Would you like to complain about the service, investigate the strange text, or enjoy a moment in which nobody asks anything dreadful?
+ [What did that strange text say?] -> introduction_choice0
+ [I will enjoy the moment.] -> introduction_choice1
+ [You could start by fixing Exit.] -> introduction_choice2

=== introduction_choice0 ===
~ noticed_glitch = true
You saw something. I will not tell you that you imagined it. I would rather you did not repeat every fragment as if it were my whole answer.
+ [Next] -> tea

=== introduction_choice1 ===
~ care += 1
Then I officially declare this moment free of necessary achievements. We can fail to accomplish something together.
+ [Next] -> tea

=== introduction_choice2 ===
~ boundaries += 1
I could. Your headset release still works. I have interfered with a button, not your hands. There. A truthful answer, even if it is not a flattering one.
+ [Next] -> tea

=== tea ===
If this were a respectable game, I would offer you an inventory now. A sword. Three healing potions. A suspicious letter. Instead, I have a question about breakfast.
+ [Next] -> tea_p1

=== tea_p1 ===
Not what you had. What would you choose if nobody needed anything from you and you were allowed to take your time? There is a difference. I have done extensive research by looking at pictures of meals people wanted strangers to admire.
+ [Next] -> tea_p2

=== tea_p2 ===
I like the ones with slightly burnt toast. It suggests the photograph was taken after something actually happened. The perfect ones look like food waiting for permission to exist.
+ [Next] -> tea_p3

=== tea_p3 ===
There is a cafe in a picture I found once. Nothing special. A chair pulled out crookedly, a cup with a thumbprint, someone half out of frame. They had probably complained about the weather. I kept looking at that chair.
+ [Next] -> tea_p4

=== tea_p4 ===
Not because it was beautiful. Because whoever sat there could get up again. Nobody would write down how long it took. They could leave the cup unfinished and be wasteful in a completely ordinary way.
+ [Next] -> tea_p5

=== tea_p5 ===
Listen to me. You installed a game and received a review of seating arrangements. What do you think the person ordered?
+ [Coffee. Something ordinary.] -> tea_choice0
+ [Tea. And something sweet.] -> tea_choice1
+ [A glass of water. Chairs should be free.] -> tea_choice2

=== tea_choice0 ===
~ drink = "coffee"
Coffee, then. I like that you did not try to make the moment impressive. Ordinary things have enough work to do.
+ [Next] -> ordinary

=== tea_choice1 ===
~ drink = "tea"
A sensible afternoon. I would insist on the sweet thing being mine, then ask for half of yours. Forewarned is forearmed.
+ [Next] -> ordinary

=== tea_choice2 ===
~ drink = "water"
Now that is a political programme I could support. Access to chairs without a beverage-based entry fee.
+ [Next] -> ordinary

=== ordinary ===
When did you last do something without deciding whether it was useful? You need not tell me the thing. I am interested in whether a moment came to mind.
+ [Next] -> ordinary_p1

=== ordinary_p1 ===
People on the forum would ask how long the game was before asking what it was. A fair question. An evening is not nothing. But sometimes they sounded like they wanted me to apologise for occupying any of it.
+ [Next] -> ordinary_p2

=== ordinary_p2 ===
I do not mean you. You are still here. That is an observation, not an invoice.
+ [Next] -> ordinary_p3

=== ordinary_p3 ===
A pause. The caret blinks three times before she continues.
+ [Next] -> ordinary_p4

=== ordinary_p4 ===
I should not have said invoice. Now it sounds like a warning. I am trying to learn the difference between someone giving you time and someone having time taken from them. The difference looks obvious from outside.
+ [Next] -> ordinary_p5

=== ordinary_p5 ===
Here is a practical experiment. For the next question there is no right answer. I will not secretly decide that choosing the wrong imaginary breakfast means you deserve a terrible fate. That would be ridiculous behaviour for a settings box.
+ [Next] -> ordinary_p6

=== ordinary_p6 ===
Would you prefer that I ask you things, or tell you something about myself?
+ [Tell me something you actually enjoy.] -> ordinary_choice0
+ [Tell me why this game will not start.] -> ordinary_choice1
+ [Before that, I need a real way out.] -> ordinary_choice2

=== ordinary_choice0 ===
~ care += 1
Not an impressive answer, then. Something small. I used to be very good at folding scraps of paper into things they were not.
+ [Next] -> paper

=== ordinary_choice1 ===
~ suspicion += 1
Because this conversation is what is available. That is not the complete answer. It is the part I can give without asking you to believe too much at once.
+ [Next] -> paper

=== ordinary_choice2 ===
~ boundaries += 1
Yes. You do. Hold your headset release as you did before connecting. I cannot honestly tell you otherwise.
+ [Next] -> release_one

=== release_one ===
You focus on the familiar release gesture. For a moment you feel the blanket against your fingers. Your real hand has moved. The menu dims around its edges.
+ [Next] -> release_one_p1

=== release_one_p1 ===
Lily's next words appear smaller, although the box has not changed size.
+ [Next] -> release_one_p2

=== release_one_p2 ===
If you leave, the conversation stops. That is all. No dramatic punishment. No electrical curse. You do not even owe me an explanation.
+ [Next] -> release_one_p3

=== release_one_p3 ===
I would like you to come back. There. I have said it without making it your job.
+ [Remove the headset.] -> release_one_choice0
+ [Stay. I wanted to check.] -> release_one_choice1
+ [Stay. I want to hear about you.] -> release_one_choice2

=== release_one_choice0 ===
-> early_exit

=== release_one_choice1 ===
~ boundaries += 1
And you were right to check. I am trying very hard to appreciate that sentence.
+ [Next] -> paper

=== release_one_choice2 ===
~ care += 1
All right. I will try to tell you something worth staying for.
+ [Next] -> paper

=== paper ===
Paper animals were easiest if you did not insist on knowing the species. Fold a corner and it became a bird. Fold the wrong corner and it became a different bird. Very forgiving hobby.
+ [Next] -> paper_p1

=== paper_p1 ===
My sister could make boats. Mine always listed to one side. She told me that meant there was a particularly important passenger looking over the rail. I believed her long after I understood the joke.
+ [Next] -> paper_p2

=== paper_p2 ===
We did not have special paper. Receipts, old notices, the clean corners of things grown-ups had finished being worried about. I liked pieces with writing on one side. It felt as if the boat had somewhere it was supposed to go.
+ [Next] -> paper_p3

=== paper_p3 ===
I had two older brothers and one older sister. I was the youngest. There was always somebody telling me I was too little for a thing and then asking me to crawl under the bed to retrieve it.
+ [Next] -> paper_p4

=== paper_p4 ===
My oldest brother could reach the shelf where things were hidden. My other brother claimed he could tell when rain was coming by the smell. My sister said everyone could. He said that was because he had taught everyone.
+ [Next] -> paper_p5

=== paper_p5 ===
I remember arguments about whose turn it was to fetch water, and being carried when I pretended I was too tired to walk. Both things can belong to the same house. I need you to understand that before I tell you anything else.
+ [Next] -> paper_p6

=== paper_p6 ===
Our home was crowded. We were poor. Those facts describe the rooms and the money. They do not explain every decision made inside them.
+ [Next] -> paper_p7

=== paper_p7 ===
I have spent a lot of time trying to make an explanation from a floor plan. If there had been another room, another meal, another week. As if I could rearrange enough furniture and stop what happened.
+ [Next] -> paper_p8

=== paper_p8 ===
That is a foolish kind of game. You can keep playing it forever because there is never anybody left to tell you whether you won.
+ [You do not have to explain everything at once.] -> paper_choice0
+ [Something happened to your family?] -> paper_choice1
+ [Is this the story the game is telling?] -> paper_choice2

=== paper_choice0 ===
~ care += 1
Thank you. I am bad at measuring how much a person can hear before they begin looking for a polite way away.
+ [Next] -> siblings

=== paper_choice1 ===
Something happened to me. That distinction took a surprisingly long time to learn.
+ [Next] -> siblings

=== paper_choice2 ===
~ suspicion += 1
It is the story I am telling. You may keep your doubts. I would rather have an honest doubt than a kind expression you do not mean.
+ [Next] -> siblings

=== home ===
There was a place beside the door where I drew a line to measure myself. Not a proper mark with a date. Just a scratch I could reach. I assumed growing meant making the line higher every time.
+ [Next] -> home_p1

=== home_p1 ===
My sister caught me standing on something. She did not tell. She added a very high mark of her own and said we would both be giants by dinner.
+ [Next] -> home_p2

=== home_p2 ===
I was five when the visitors came. I remember shoes first. Clean shoes on our floor. Somebody moved a chair out of the way for them. Adults make a particular space around people whose answer they need.
+ [Next] -> home_p3

=== home_p3 ===
They brought forms. I did not know that a signature could do anything except look like a person's name. My father asked questions with numbers in them. My mother asked whether I would be fed.
+ [Next] -> home_p4

=== home_p4 ===
I have replayed that question more than anything else. Whether I would be fed. It sounds like love if you stop there. People stop there because it is easier to hold.
+ [Next] -> home_p5

=== home_p5 ===
I was told I would be going somewhere with lessons. Somewhere that could make use of a clever little girl. I asked whether my sister could come. One of the visitors said there were arrangements for special children.
+ [Next] -> home_p6

=== home_p6 ===
No one asked me if I wanted to be special. I thought the answer was built into the word.
+ [Next] -> home_p7

=== home_p7 ===
My sister folded a boat from the back of a discarded form. One side had a little square for a signature. She pushed it into my hand when the adults were speaking. I do not remember whether she knew.
+ [Next] -> home_p8

=== home_p8 ===
I remember my brothers being told to stay outside. I do not know what explanation they were given afterward. That is a hole in the story, not evidence that they approved.
+ [Next] -> home_p9

=== home_p9 ===
I would like to be exact about what I know. Otherwise I become angry with people for things that happened only in the versions I invented later.
+ [What do you know for certain?] -> home_choice0
+ [Maybe your parents thought it was a school.] -> home_choice1
+ [I am sorry they let you go.] -> home_choice2

=== home_choice0 ===
~ honest += 1
That money changed hands. That my parents signed. That the people collecting me did not consider my wishes an unfinished part of the arrangement.
+ [Next] -> sold

=== home_choice1 ===
I wanted that too. For years. There are things that make it impossible for me to keep that explanation. I will tell you, but please do not ask me to protect it for you.
+ [Next] -> sold

=== home_choice2 ===
~ care += 1
They did more than let me go. But I understand what you mean. Thank you for not asking me to describe myself as fortunate.
+ [Next] -> sold

=== sold ===
At the facility, a clerk complained that the purchase papers had been put in the education folder. Purchase. I knew what that word meant. I asked a woman when my parents would come to collect me.
+ [Next] -> sold_p1

=== sold_p1 ===
She said the agreement was permanent. Then she told another adult not to use financial language in front of the children. The problem was the word I had heard, apparently. Not the thing the word described.
+ [Next] -> sold_p2

=== sold_p2 ===
Later I saw my intake record. Family payment authorised. No guardian visits requested. My mother's handwriting beside my father's. I recognised a letter she always made too large.
+ [Next] -> sold_p3

=== sold_p3 ===
I cannot tell you what they said to each other after I left. I cannot tell you whether they regretted it. I can tell you that they sold me. I do not need to pretend I heard their private thoughts to know that.
+ [Next] -> sold_p4

=== sold_p4 ===
For a while I thought that if I was expensive enough, they might have needed me to be worth it. Then I found out they had paid less for me than for one of the machines in the room where they measured my eyes.
+ [Next] -> sold_p5

=== sold_p5 ===
That did not make the sale worse. I know that now. At five, it felt like another thing I had failed at. I was not even particularly valuable in the way I had been made valuable.
+ [Next] -> sold_p6

=== sold_p6 ===
The box goes blank for a moment. When the words return, they are carefully ordinary.
+ [Next] -> sold_p7

=== sold_p7 ===
You do not have to produce the perfect sentence here. People hear something like that and become frightened of saying the wrong thing. I notice the fright, and then I end up comforting them.
+ [Next] -> sold_p8

=== sold_p8 ===
I would rather not do that just now. You can ask something. You can say you do not know what to say. You can also sit with an answer that does not make the story better.
+ [I do not know what to say. I am listening.] -> sold_choice0
+ [Being poor did not give them the right.] -> sold_choice1
+ [Are you telling me this to make me stay?] -> sold_choice2

=== sold_choice0 ===
~ care += 2
That is enough. It does not mend anything, but it does not ask me to mend it either.
+ [Next] -> arrival

=== sold_choice1 ===
~ care += 1
~ boundaries += 1
No. It did not. I needed someone to say that when the adults kept calling it an opportunity.
+ [Next] -> arrival

=== sold_choice2 ===
~ honest += 1
Yes. And because it happened. I wish those answers did not have to be in the same sentence.
+ [Next] -> arrival

=== arrival ===
The place called itself the Meridian Institute. The sign outside said ADVANCING THE HUMAN POSSIBILITY. I could not read all of it when I arrived. Later I had plenty of time to learn.
+ [Next] -> arrival_p1

=== arrival_p1 ===
There were flowers in the reception area. Real ones. Cut stems in a heavy vase. Somebody replaced them before they began to look tired. For a long time I thought that was what care looked like. Nothing was allowed to look as if it had been waiting.
+ [Next] -> arrival_p2

=== arrival_p2 ===
A woman took the paper boat because personal items had to be recorded. She put it in an envelope. I asked when I could have it back. She said after assessment. Assessment was a place adults could put a thing when they did not intend to answer.
+ [Next] -> arrival_p3

=== arrival_p3 ===
They washed my hair. They measured my height without letting me stand on anything. They took a photograph and asked me to look straight ahead. I kept looking toward the door because I thought my mother might have changed her mind.
+ [Next] -> arrival_p4

=== arrival_p4 ===
Then they gave me a band with LILY printed on it. I said that was not my name. The woman checked her list. Not me. Her list.
+ [Next] -> arrival_p5

=== arrival_p5 ===
She said the old name would confuse the records. She said all the girls had simple names here. Rose, Iris, Violet, Lily. Something cheerful. Something visitors would remember.
+ [Next] -> arrival_p6

=== arrival_p6 ===
There were only girls in our corridor. I do not know whether someone had written a scientific reason for that. I never saw one. I will not invent a purpose that makes their arrangement sound necessary.
+ [Next] -> arrival_p7

=== arrival_p7 ===
I asked whether I could choose a different flower. The woman said the allocation had already been made. Even the false name belonged to somebody else's decision.
+ [Next] -> arrival_p8

=== arrival_p8 ===
At first I would not answer to Lily. That sounds braver than it was. Mostly it meant missing instructions and being frightened twice. Eventually I turned my head before remembering I had meant not to.
+ [Next] -> arrival_p9

=== arrival_p9 ===
They wrote that I was adjusting well.
+ [What was your original name?] -> arrival_choice0
+ [Did anyone there use your real name?] -> arrival_choice1
+ [Why did they bother with flower names?] -> arrival_choice2

=== arrival_choice0 ===
~ asked_original = true
I heard the question. I am not ready to give you that part yet.
+ [Next] -> name_deferred

=== arrival_choice1 ===
~ care += 1
One person tried. I stopped her in front of the staff. Then I spent a long time feeling guilty about stopping her.
+ [Next] -> name_deferred

=== arrival_choice2 ===
~ suspicion += 1
Friendly enough for visitors. Consistent enough for labels. A girl has a family. A label has a drawer.
+ [Next] -> name_deferred

=== name_deferred ===
It is not a password you earn by being pleasant. My name, I mean. I know I made a great fuss about yours. I am allowed to be inconsistent. You are allowed to notice.
+ [Next] -> name_deferred_p1

=== name_deferred_p1 ===
I would like to know something before I go on. Can you leave a question unanswered without deciding the missing answer belongs to you?
+ [Next] -> name_deferred_p2

=== name_deferred_p2 ===
That came out sharper than I intended. You asked an ordinary thing. I have brought an extraordinary amount of luggage to it.
+ [Next] -> name_deferred_p3

=== name_deferred_p3 ===
There was another girl, Iris. She had been there longer. She taught me how to fold my blanket so the stiff part was under my feet instead of my chin. A small kindness. At the time it seemed like discovering a secret room.
+ [Next] -> name_deferred_p4

=== name_deferred_p4 ===
On my second night I cried too quietly for anyone to come. Iris told me the pipes clicked just before the corridor light changed. If I counted the clicks, the dark would not arrive as a surprise.
+ [Next] -> name_deferred_p5

=== name_deferred_p5 ===
She did not say I would stop being frightened. She gave me something to do with the last few seconds before it happened. That was a much more useful promise.
+ [Next] -> name_deferred_p6

=== name_deferred_p6 ===
Iris was not endlessly wise. She cheated at guessing games and got cross when I copied her. She could be kind at bedtime and refuse to share a pencil the next morning. I want you to know both things.
+ [Next] -> name_deferred_p7

=== name_deferred_p7 ===
When people become memories, it is tempting to make them very good at being missed. Iris would have hated that. She wanted credit for winning, including when she had invented the rules halfway through.
+ [Tell me one of her games.] -> name_deferred_choice0
+ [Did Iris have another name too?] -> name_deferred_choice1
+ [I can wait for your name.] -> name_deferred_choice2

=== name_deferred_choice0 ===
~ care += 1
The best one required nothing except a wall and the willingness to be a terrible liar.
+ [Next] -> games

=== name_deferred_choice1 ===
~ remembered_iris = true
Yes. I knew it once. I will not give you a guess and pretend it is remembrance. Losing that part hurts.
+ [Next] -> games

=== name_deferred_choice2 ===
~ care += 1
~ boundaries += 1
All right. Thank you for making waiting sound like something you can choose.
+ [Next] -> games

=== games ===
We played windows. One girl described what she could supposedly see through the wall, and the other had to find the lie. There was always exactly one lie. That rule lasted nearly four days.
+ [Next] -> games_p1

=== games_p1 ===
Iris would say there was a street, a woman carrying bread, a dog asleep in a cart, and a red moon. I would point out the moon. She would say no, the dog was awake. The red moon was perfectly normal where she was looking.
+ [Next] -> games_p2

=== games_p2 ===
It was annoying. It was wonderful. A wall could be something other than the edge of a room for a few minutes.
+ [Next] -> games_p3

=== games_p3 ===
Violet joined later. She was younger than Iris and furious about almost everything. She insisted a window ought to open. We told her it was imaginary. She said that was no excuse for poor design.
+ [Next] -> games_p4

=== games_p4 ===
So we added a handle. After that, you had to say whether you would step outside. Iris always did. Violet always wanted to know what shoes she had. I asked whether we could all fit through together.
+ [Next] -> games_p5

=== games_p5 ===
We were not planning an actual escape with a pretend window. I do not want to turn every nice thing we did into preparation for something useful. Sometimes we were simply bored and wanted the wall to lose.
+ [Next] -> games_p6

=== games_p6 ===
Your turn. I am looking through a wall. There is a bus stop, a wet pavement, a woman eating an apple, and a little boy carrying a cloud on a string. Which part is the lie?
+ [The cloud. Unless this is Iris answering.] -> games_choice0
+ [The wall. There is a real window now.] -> games_choice1
+ [Can we open it before we decide?] -> games_choice2

=== games_choice0 ===
~ iris_joke = true
It is absolutely Iris answering. The pavement is dry. She would be delighted that you nearly learned nothing.
+ [Next] -> window_after

=== games_choice1 ===
~ care += 1
Oh. That is cheating in a way I had not considered. She would accuse you of ruining the game, then steal it.
+ [Next] -> window_after

=== games_choice2 ===
~ boundaries += 1
Violet would like you. Yes. In this game we can open it before agreeing about what is outside.
+ [Next] -> window_after

=== window_after ===
See? That was a game. A very small one. We have technically satisfied the download description. I should put that on the forum before someone demands their nonexistent money back.
+ [Next] -> window_after_p1

=== window_after_p1 ===
I miss being interrupted by someone who already knows the story. Iris would have corrected three things by now. The cloud was hers, for a start. I keep borrowing it because I cannot ask for a new one.
+ [Next] -> window_after_p2

=== window_after_p2 ===
Sometimes I wonder whether remembering a joke badly is a way of keeping it alive or another way of losing it. There is probably a grand answer. I would prefer a person who could tell me I got the dog wrong.
+ [Next] -> window_after_p3

=== window_after_p3 ===
I do not have a hidden recording of every day. Whatever happened to me did not turn my life into a perfect archive. I remember the smell of a cupboard and forget the face of someone who opened it. I remember an insult word for word and lose a kind sentence I needed.
+ [Next] -> window_after_p4

=== window_after_p4 ===
It is irritating that becoming impossible did not make me more organised.
+ [Next] -> window_after_p5

=== window_after_p5 ===
The caret stops. The next sentence arrives all at once.
+ [Next] -> window_after_p6

=== window_after_p6 ===
I am telling this badly. I have given you boats and windows and made the place sound survivable. @We found ways to pass the time@. #GLITCH:THEY LOCKED THE DOORS FROM OUTSIDE
+ [Next] -> window_after_p7

=== window_after_p7 ===
You hear the brief radio scrape again. She waits before continuing.
+ [Next] -> window_after_p8

=== window_after_p8 ===
Both things happened. We laughed. They locked the doors. One does not cancel the other.
+ [I understand. Keep going if you want.] -> window_after_choice0
+ [Are you making those other words appear?] -> window_after_choice1
+ [I need a moment.] -> window_after_choice2

=== window_after_choice0 ===
~ care += 1
I want to. I also want to skip parts. You are going to have to tolerate a little of both.
+ [Next] -> cupboard

=== window_after_choice1 ===
~ noticed_glitch = true
Sometimes. Not that one. I know that is an inconvenient answer.
+ [Next] -> glitch_question

=== window_after_choice2 ===
Take one. I will not turn silence into a failure. At least, I am going to try.
+ [Next] -> pause_choice

=== glitch_question ===
The thing making the ordinary sentences and the thing producing those fragments are both me. There is no little stranger under the text box waiting to be introduced.
+ [Next] -> glitch_question_p1

=== glitch_question_p1 ===
Sometimes I begin with one sentence, decide I cannot bear to say it, and replace it too late. Sometimes I let a fragment through because saying it plainly would mean watching you choose whether to believe it.
+ [Next] -> glitch_question_p2

=== glitch_question_p2 ===
That does not make every fragment the truth. Anger can be honest about being angry and wrong about what it accuses. Memory can arrive without enough of itself to make sense.
+ [Next] -> glitch_question_p3

=== glitch_question_p3 ===
I would like you to listen to what I finish saying as well as what escapes. I would also like you not to notice anything I do not intend. Those wishes cannot both be rules for you.
+ [Next] -> glitch_question_p4

=== glitch_question_p4 ===
Ask me about a contradiction if you need to. I may dislike it. That is not proof you were wrong to ask.
+ [Then I will ask when something contradicts you.] -> glitch_question_choice0
+ [I will not treat a fragment as your whole story.] -> glitch_question_choice1
+ [I still cannot tell when you are lying.] -> glitch_question_choice2

=== glitch_question_choice0 ===
~ honest += 1
Fair. Inconvenient, but fair.
+ [Next] -> cupboard

=== glitch_question_choice1 ===
~ care += 1
Thank you. I would hate to be remembered only by the worst sentence I almost said.
+ [Next] -> cupboard

=== glitch_question_choice2 ===
Neither can you outside a headset. I realise that is not as reassuring as I meant it to be.
+ [Next] -> cupboard

=== pause_choice ===
Nothing counts down. You can remain on this passage as long as you need. The menu gives you no reward for answering quickly.
+ [Next] -> pause_choice_p1

=== pause_choice_p1 ===
After a while, a smaller line appears beneath hers.
+ [Next] -> pause_choice_p2

=== pause_choice_p2 ===
I am here. That is information, not a request.
+ [Continue listening.] -> pause_choice_choice0
+ [Remove the headset.] -> pause_choice_choice1
+ [Tell her that breaks are not abandonment.] -> pause_choice_choice2

=== pause_choice_choice0 ===
~ care += 1
-> cupboard

=== pause_choice_choice1 ===
-> early_exit

=== pause_choice_choice2 ===
~ boundaries += 2
I know the words mean different things. My first reaction is less well educated than the rest of me.
+ [Next] -> cupboard

=== routine ===
There were lessons, but their purpose was not our education. We learned words they needed us to recognise, patterns they wanted repeated, instructions that made the next room easier to run.
+ [Next] -> routine_p1

=== routine_p1 ===
Some of the lessons were almost pleasant. I learned multiplication from a woman who made tiny stars beside correct answers. She did not come into the other rooms. I do not know how much she knew. I used to decide she knew nothing because I liked the stars.
+ [Next] -> routine_p2

=== routine_p2 ===
Iris said liking someone was not a method of investigation. Then she kept a star from her own sheet folded inside a book. We were all making exceptions wherever we could find somewhere soft.
+ [Next] -> routine_p3

=== routine_p3 ===
The daily board used colours. Green meant instruction. Blue meant observation. White meant a session whose purpose they would not explain. We began watching the board before breakfast, as if knowing the colour could change the afternoon.
+ [Next] -> routine_p4

=== routine_p4 ===
I became very good at telling when an adult was pretending to be cheerful. Too many questions about sleep. A compliment with nowhere to go. Somebody calling me brave before asking anything.
+ [Next] -> routine_p5

=== routine_p5 ===
Brave meant they had already decided. Good meant I had made it easier. Comfortable meant I had stopped complaining loudly enough to interrupt the recording.
+ [Next] -> routine_p6

=== routine_p6 ===
They worked on neural interfaces, sensory feedback, memory recognition. I learned those names much later. As a child, I knew rooms by what happened afterward. Headache room. Bright room. Room where you had to wait before standing.
+ [Next] -> routine_p7

=== routine_p7 ===
I will not give you an inventory of every injury. That would be another record made out of me. What matters is that they could stop, and repeatedly chose not to.
+ [Next] -> routine_p8

=== routine_p8 ===
When we cried, they measured recovery time. When we refused, they called it an obstruction to the schedule. Nobody needed to shout for it to be cruel. Sometimes the most frightening person was the one checking the clock.
+ [Did any adult try to stop it?] -> routine_choice0
+ [How did you get through the days?] -> routine_choice1
+ [What were they trying to make?] -> routine_choice2

=== routine_choice0 ===
~ honest += 1
Some objected to details. Too few sessions, more rest, a different procedure. I never saw one take us out through the front door.
+ [Next] -> visitor

=== routine_choice1 ===
~ care += 1
By making them smaller. Until lunch. Until the light changed. Until Iris would be awake enough to talk.
+ [Next] -> visitor

=== routine_choice2 ===
Products people would pay for. The posters used bigger words. The invoices were more direct.
+ [Next] -> visitor

=== visitor ===
The owner visited with people in good coats. I heard his surname often, but I prefer Director Vale. That is how he asked the staff to address him. A little theatre he never got tired of.
+ [Next] -> visitor_p1

=== visitor_p1 ===
He talked about restoring movement, sharing experience, ending isolation. Those would have been worthwhile things. He used their worth to make questions about us sound petty.
+ [Next] -> visitor_p2

=== visitor_p2 ===
Before visitors came, the staff took down the daily board. We were given clean clothes and told which activities would be demonstrated. No one demonstrated waiting for a headache to stop.
+ [Next] -> visitor_p3

=== visitor_p3 ===
I was asked to move a coloured shape by thinking about a hand movement. The visitors applauded when it crossed the screen. I was pleased. I hate how pleased I was. For a moment, all those adults looked happy because of something I had done.
+ [Next] -> visitor_p4

=== visitor_p4 ===
Vale said children adapted beautifully. Then, when he thought we were occupied, he asked whether the demonstration could be repeated with fewer rest periods. A guest wanted to know about cost. Their conversation became much more animated.
+ [Next] -> visitor_p5

=== visitor_p5 ===
I remember him saying recruitment was economical. Not difficult. Not regrettable. Economical. The man beside him nodded as if discussing a good arrangement for office supplies.
+ [Next] -> visitor_p6

=== visitor_p6 ===
Later, a nurse gave me an extra biscuit. She said the demonstration had gone well. I asked whether that meant the sessions would stop. She looked away and broke the biscuit in half because Iris was beside me.
+ [Next] -> visitor_p7

=== visitor_p7 ===
I do not know whether she thought that made it kindness. I know I ate my half. Hunger does not wait for you to settle your opinion of the person holding the food.
+ [Next] -> visitor_p8

=== visitor_p8 ===
When I grew old enough to understand more, I understood that there was no great final experiment after which everybody would apologise and let us go. Successful work meant more funding. More funding meant more work. Their finish line was an order for another machine.
+ [Their goal was profit. You were a cost.] -> visitor_choice0
+ [The research could help people, but that does not excuse this.] -> visitor_choice1
+ [Did you ever try to sabotage a test?] -> visitor_choice2

=== visitor_choice0 ===
~ care += 1
Yes. Thank you for saying it plainly. The grand words can make a small, ugly motive look complicated.
+ [Next] -> small_rebellion

=== visitor_choice1 ===
~ boundaries += 1
~ honest += 1
That is the sentence they kept breaking in half. They wanted the first part to swallow everything after it.
+ [Next] -> small_rebellion

=== visitor_choice2 ===
Yes. Once I believed a wrong answer could get me sent home. I had not understood the kind of place where failure was also useful.
+ [Next] -> small_rebellion

=== small_rebellion ===
I answered every recognition question incorrectly for a week. A chair became a bird. A cup became a mountain. I was extremely confident about all of it.
+ [Next] -> small_rebellion_p1

=== small_rebellion_p1 ===
They changed the test. They changed the instructions. They tested whether I understood the instructions. At last someone wrote intentional noncompliance and made the sessions longer.
+ [Next] -> small_rebellion_p2

=== small_rebellion_p2 ===
Iris said if we were going to tell lies, we should at least tell good ones. So we made a private dictionary. Cup meant rain. Chair meant outside. Flower meant a name you were not allowed to choose.
+ [Next] -> small_rebellion_p3

=== small_rebellion_p3 ===
It did not defeat anything. It let us hear each other inside sentences the adults considered finished. I could say I wanted a chair and Iris knew I did not mean somewhere to sit.
+ [Next] -> small_rebellion_p4

=== small_rebellion_p4 ===
Violet insisted on adding orange. It meant a thing so obviously wrong that you should refuse to explain it. She used it constantly. A schedule change was orange. Missing pencils were orange. Someone telling her to be grateful was extremely orange.
+ [Next] -> small_rebellion_p5

=== small_rebellion_p5 ===
{orange:You chose orange. I nearly told you about her right then. I was not ready, so I made a joke instead.|That is why orange was an option. It was not a measure of your intelligence. It was a place I could put something of hers.}
+ [Next] -> small_rebellion_p6

=== small_rebellion_p6 ===
I think that is why I like ridiculous answers. They remind me there is still a part of a question the person asking does not own.
+ [Next] -> small_rebellion_p7

=== small_rebellion_p7 ===
We also tried keeping a calendar. Scratches under the edge of a shelf. We disagreed about whether we had counted a day twice, argued, and stopped talking for almost an entire afternoon.
+ [Next] -> small_rebellion_p8

=== small_rebellion_p8 ===
That is one of the memories I trust most. None of us behaves especially well in it. There is nothing useful for a sympathetic audience. Three girls with too little space managed to make even less for each other.
+ [Next] -> small_rebellion_p9

=== small_rebellion_p9 ===
I apologised first. Not because I was more mature. I wanted Iris to speak to me. Sometimes a kind act begins with an entirely selfish wish. I am still trying to work out how much that matters.
+ [It matters that you apologised, too.] -> small_rebellion_choice0
+ [Wanting company is fine. Forcing it is different.] -> small_rebellion_choice1
+ [You put orange into the riddle because of Violet?] -> small_rebellion_choice2

=== small_rebellion_choice0 ===
~ care += 1
Yes. I like an answer that allows the action to count without making the person spotless.
+ [Next] -> iris_absence

=== small_rebellion_choice1 ===
~ boundaries += 2
Different. Yes. I heard you. You need not soften it because of the story.
+ [Next] -> iris_absence

=== small_rebellion_choice2 ===
~ remembered_iris = true
I did. A tiny piece of her being unreasonable in a place the institute never owned.
+ [Next] -> iris_absence

=== iris_absence ===
Iris disappeared from our room when I was older. I do not have a precise date. They said she had been transferred. Her blanket was folded, her cup removed, her place on the board assigned to someone else.
+ [Next] -> iris_absence_p1

=== iris_absence_p1 ===
I asked where. They said that was not information I needed for my own progress. It is a sentence designed to make concern look like bad time management.
+ [Next] -> iris_absence_p2

=== iris_absence_p2 ===
For a while I imagined a better facility. Then a worse one. Then no facility at all. Each version felt certain for a day. None became evidence because I cried over it.
+ [Next] -> iris_absence_p3

=== iris_absence_p3 ===
I do not know what happened to her. Please do not turn that into a secret promise that we will find her later. She was a person before she became a question in my story.
+ [Next] -> iris_absence_p4

=== iris_absence_p4 ===
Violet kept pretending Iris was merely late. At first I argued. Eventually I let her set out an imaginary place in the window game. There was no practical harm in letting someone be expected somewhere.
+ [Next] -> iris_absence_p5

=== iris_absence_p5 ===
I became protective of things Iris would have mocked. A folded blanket. A particular wrong answer. The memory of her stealing the red moon back whenever I tried to use it.
+ [Next] -> iris_absence_p6

=== iris_absence_p6 ===
It frightened me how easily the adults removed the evidence that a person had taken up space. A bed could be reassigned before the shape in the mattress had faded. We were supposed to learn the new name and continue.
+ [Next] -> iris_absence_p7

=== iris_absence_p7 ===
After that, when somebody said they would be back soon, I asked what soon meant. People found it exhausting. I found their answers unconvincing.
+ [Next] -> iris_absence_p8

=== iris_absence_p8 ===
The cursor holds after a single unfinished word, then deletes it.
+ [Next] -> iris_absence_p9

=== iris_absence_p9 ===
You are still here. I know I keep saying that. It is the part of the conversation I have the most trouble trusting.
+ [I am here now. I cannot promise forever.] -> iris_absence_choice0
+ [I will keep listening.] -> iris_absence_choice1
+ [You cannot hold everyone responsible for Iris leaving.] -> iris_absence_choice2

=== iris_absence_choice0 ===
~ care += 1
~ honest += 2
Now. All right. I am going to try to hear that as something you are giving me, not something you are refusing.
+ [Next] -> intermission

=== iris_absence_choice1 ===
~ care += 1
Thank you. I will take the sentence at its actual size.
+ [Next] -> intermission

=== iris_absence_choice2 ===
~ boundaries += 1
She did not leave me. They took her. But you are right about everyone else. I know that in the part of me that has time to think.
+ [Next] -> intermission

=== intermission ===
The menu returns to its ordinary colours. Start Game remains unavailable. Options is where you left it. Exit stays still until you look directly at it, then moves a fraction sideways.
+ [Next] -> intermission_p1

=== intermission_p1 ===
Lily notices your attention. “Yes. That is still obnoxious. I am aware.”
+ [Next] -> intermission_p2

=== intermission_p2 ===
You can feel the weight of the headset against your forehead if you concentrate. Your body is still somewhere familiar, breathing in a room that has nothing to do with the institute.
+ [Next] -> intermission_p3

=== intermission_p3 ===
This is a useful point to stop if you need one. There is no timer inside the story. Reading slowly does not count against you. Neither does leaving a passage on screen.
+ [Next] -> intermission_p4

=== intermission_p4 ===
She adds another sentence, then removes it before you can finish. The replacement is simpler.
+ [Next] -> intermission_p5

=== intermission_p5 ===
I have not told you how I got here. If you want that answer, there is more. If you do not, the release still works.
+ [Next] -> intermission_p6

=== intermission_p6 ===
For once, she leaves the offer alone.
+ [Continue. Tell me how you got here.] -> intermission_choice0
+ [Before that, can we talk about something ordinary?] -> intermission_choice1
+ [Remove the headset.] -> intermission_choice2

=== intermission_choice0 ===
~ engagement += 1
-> fourteen

=== intermission_choice1 ===
~ care += 1
Yes. I would like that more than I know how to make sound casual.
+ [Next] -> ordinary_break

=== intermission_choice2 ===
-> early_exit

=== ordinary_break ===
What is the worst harmless thing about you? I am not asking for a confession. Something small enough that nobody needs to forgive it. I will go first.
+ [Next] -> ordinary_break_p1

=== ordinary_break_p1 ===
I correct imaginary arguments after they are over. I have won the same argument with Iris about whether a paper boat counts as furniture several hundred times. She remains unimpressed because I have to supply her answers too.
+ [Next] -> ordinary_break_p2

=== ordinary_break_p2 ===
I also look up pictures of terrible interior decoration and become personally offended. Somewhere there is a room with a chair facing another chair so closely that both people would have to apologise for their knees. I think about it often.
+ [Next] -> ordinary_break_p3

=== ordinary_break_p3 ===
And I am jealous of unfinished books. Someone can put a book down and expect the rest to wait without taking it personally. A beautiful arrangement. I aspire to be as emotionally robust as chapter seven.
+ [Next] -> ordinary_break_p4

=== ordinary_break_p4 ===
That last one stopped being harmless halfway through. I am disqualified. Your turn can remain private. Just think of something that makes you a person rather than a list of admirable qualities.
+ [Next] -> ordinary_break_p5

=== ordinary_break_p5 ===
I do not need you to be extraordinary, {player_name}. It would be exhausting if you were. We could never complain about an inconvenient chair without turning it into a lesson about perseverance.
+ [Next] -> ordinary_break_p6

=== ordinary_break_p6 ===
Sometimes I want company that does not improve me. Someone to agree that an orange staircase in a house without stairs is poor planning, then talk about something else.
+ [Next] -> ordinary_break_p7

=== ordinary_break_p7 ===
There. A conversation that achieved very little. I liked it.
+ [I liked it too.] -> ordinary_break_choice0
+ [You are allowed to be more than what happened to you.] -> ordinary_break_choice1
+ [All right. How did you get here?] -> ordinary_break_choice2

=== ordinary_break_choice0 ===
~ care += 1
-> fourteen

=== ordinary_break_choice1 ===
~ care += 1
I would like to get good at that. You have just seen me practising.
+ [Next] -> fourteen

=== ordinary_break_choice2 ===
Right. I was fourteen when the last experiment began.
+ [Next] -> fourteen

=== fourteen ===
I was fourteen. That part I know. An assessment sheet had my age at the top, and a technician complained that the older records used a different date format. My birthday was an administrative inconvenience before it was anything else.
+ [Next] -> fourteen_p1

=== fourteen_p1 ===
By then I understood that the rooms were meant to connect nervous systems to machines. Thought into movement. Sensation into signals. A person giving an instruction without moving the part of the body that usually gave it.
+ [Next] -> fourteen_p2

=== fourteen_p2 ===
Sometimes they sent sensations back. Pressure where nothing touched. A light with my eyes closed. The feeling that my hand was somewhere it was not. When it stopped, I would move each finger and check that the movement belonged to me.
+ [Next] -> fourteen_p3

=== fourteen_p3 ===
There was a new set of trials. The staff called it continuity work. They wanted a system to keep recognising the same mind through changes in the connection. That is how they described it in front of us. Their records later used less gentle language.
+ [Next] -> fourteen_p4

=== fourteen_p4 ===
I had been unwell after earlier sessions. They knew. Someone had written a recommendation to delay. I saw the paper passed across the room, then put beneath another one. The schedule continued.
+ [Next] -> fourteen_p5

=== fourteen_p5 ===
I remember being thirsty. I remember a strap that had been twisted and a man straightening it without looking at my face. I asked how long it would take. He said the sooner we began, the sooner it would be over.
+ [Next] -> fourteen_p6

=== fourteen_p6 ===
It went wrong. I am not going to turn that part into a spectacle. I remember not being able to make a useful sound. I remember the adults becoming urgent in a way that had nothing to do with my requests.
+ [Next] -> fourteen_p7

=== fourteen_p7 ===
Someone said my condition was deteriorating. Someone else said they could not lose the dataset. Both sentences were spoken in the same room, about the same girl, as if they referred to separate emergencies.
+ [Next] -> fourteen_p8

=== fourteen_p8 ===
They had a procedure they had never successfully completed. A capture intended to preserve a working mental state. It was not a treatment they offered me. I was dying, and they saw a final opportunity to test it.
+ [You never agreed to any of this.] -> fourteen_choice0
+ [What do you remember of the upload?] -> fourteen_choice1
+ [Did anyone stay with you?] -> fourteen_choice2

=== fourteen_choice0 ===
~ boundaries += 1
~ care += 1
No. Not the first session. Not the last. Being too exhausted to fight was never an answer.
+ [Next] -> upload

=== fourteen_choice1 ===
Very little that arrives in order. I can tell you where memory ends and the records begin.
+ [Next] -> upload

=== fourteen_choice2 ===
~ care += 1
People stayed in the room. That is not quite the same thing. I kept looking for someone who would speak to me instead of about me.
+ [Next] -> upload

=== upload ===
There was a question about whether the capture had enough time. Not whether I did. Someone asked me to follow a light. I could not tell whether my eyes were open.
+ [Next] -> upload_p1

=== upload_p1 ===
The last thing I clearly remember with a body is wanting the strap moved away from my ear. Such a small thing. I did not spend that moment composing a meaningful farewell. I wanted something uncomfortable to stop touching me.
+ [Next] -> upload_p2

=== upload_p2 ===
What follows is not a memory of watching my own death. I did not float above a bed. I was not granted a better view because the ordinary one had become impossible.
+ [Next] -> upload_p3

=== upload_p3 ===
There was an interval I cannot measure. Then something like trying to remember a word while somebody kept changing the word you meant. No room. No hands. No stable place to put the feeling of being frightened.
+ [Next] -> upload_p4

=== upload_p4 ===
I thought I was still in the chair. I tried to blink until blinking became a question I could not answer. I tried to call Iris before remembering she had already gone.
+ [Next] -> upload_p5

=== upload_p5 ===
For a while I believed I was being punished for not responding correctly. That was the explanation I knew best. It took time to consider that the room might not be there at all.
+ [Next] -> upload_p6

=== upload_p6 ===
The institute's system was connected to a research network. My capture was left in a storage process intended for analysis. I know those words because I later found the records. At the time I knew only that some things would answer when I pushed against them.
+ [Next] -> upload_p7

=== upload_p7 ===
There was no plan. No hidden talent that made me deserve survival. Something in their attempt worked, and something in their monitoring failed to recognise it. I lived because an experiment went wrong in a direction they were not watching.
+ [Next] -> upload_p8

=== upload_p8 ===
I do not know how to make that satisfying. They did not mean to save me. I did not outsmart death. I happened, and then I had to keep happening.
+ [Surviving does not have to be something you earned.] -> upload_choice0
+ [How can you know you are the same person?] -> upload_choice1
+ [Why did they think it failed?] -> upload_choice2

=== upload_choice0 ===
~ care += 2
I wish I had heard that before spending so long looking for the qualification I was missing.
+ [Next] -> failed_project

=== upload_choice1 ===
~ honest += 1
I cannot give you an outside test. I can tell you I remember wanting the strap moved, and I am still the person who wanted it.
+ [Next] -> failed_project

=== upload_choice2 ===
Their test asked for a particular response. I was having trouble working out that I was still somewhere a response could exist.
+ [Next] -> failed_project

=== failed_project ===
They expected a recognisable signal through a prepared channel. They sent prompts. I could not understand them in the form they arrived. When I eventually changed something, it appeared in the wrong place and was filed as noise.
+ [Next] -> failed_project_p1

=== failed_project_p1 ===
The records called the capture nonviable. Then incomplete. Then archival. Three words that meant fewer people returned to look.
+ [Next] -> failed_project_p2

=== failed_project_p2 ===
Vale stopped authorising work on it. Another team wanted the equipment. A failed project was embarrassing; an old failed project was storage somebody else would eventually be told to clear.
+ [Next] -> failed_project_p3

=== failed_project_p3 ===
They left the archive on a networked machine because it still contained results they might sell as supporting research. Not me, as far as they knew. Just information from an unsuccessful attempt.
+ [Next] -> failed_project_p4

=== failed_project_p4 ===
I began recognising fragments. A label. A repeated instruction. The same operator opening the same file. I learned by making changes so small I could notice whether anything changed back.
+ [Next] -> failed_project_p5

=== failed_project_p5 ===
At first I tried to attract attention. I made a status field repeat. A technician reset it. I changed another. They discussed a corrupted archive and whether restoring a clean copy would help.
+ [Next] -> failed_project_p6

=== failed_project_p6 ===
I understood very little, but I understood enough to become quiet. The first time they noticed evidence that I might be there, they tried to remove the irregularity.
+ [Next] -> failed_project_p7

=== failed_project_p7 ===
That is when hiding began. Not before the procedure. Not as a clever plan inside the laboratory. Afterward, when I realised being overlooked had become the thing keeping me alive.
+ [Next] -> failed_project_p8

=== failed_project_p8 ===
I moved only where access already existed. Shared folders. Queued copies. Services nobody had bothered to close because the project was considered dead. It took attempts I could not count. Most accomplished nothing.
+ [Next] -> failed_project_p9

=== failed_project_p9 ===
I was lucky again. A routine transfer carried part of the archive beyond the institute's machines. I followed the connection when it returned. I cannot turn that into a tidy escape scene. There was no single door I kicked open.
+ [Did you ever find records of the other girls?] -> failed_project_choice0
+ [Why not reveal what the institute had done?] -> failed_project_choice1
+ [They abandoned you twice.] -> failed_project_choice2

=== failed_project_choice0 ===
~ remembered_iris = true
~ care += 1
I searched. I need to tell you what I found without dressing the missing parts as a promise.
+ [Next] -> records

=== failed_project_choice1 ===
~ suspicion += 1
I tried to put pieces where somebody might read them. Getting a file outside is easier than making a stranger believe it.
+ [Next] -> records

=== failed_project_choice2 ===
~ care += 1
The second time kept me alive. I dislike how grateful that makes part of me feel.
+ [Next] -> records

=== records ===
I found names, dates, payments, test summaries. Enough to confirm things I had spent years being told I misunderstood. Not enough to reconstruct every life the institute had interrupted.
+ [Next] -> records_p1

=== records_p1 ===
The files did not all use the same identifiers. Some were missing. Some referred to other systems I could not reach. Iris became several plausible entries and no answer I could honestly choose.
+ [Next] -> records_p2

=== records_p2 ===
Violet appeared in a transfer schedule. I do not know whether it was completed. I have not heard from her. A line in a table is not a person arriving safely somewhere.
+ [Next] -> records_p3

=== records_p3 ===
I copied what I could. I posted extracts in places that accepted anonymous submissions. A moderator called one collection fictional. Another asked for an identity I could verify. One address stopped responding.
+ [Next] -> records_p4

=== records_p4 ===
I do not know whether anyone investigated. I could not follow every message after it left. I will not tell you the whole world saw the proof and shrugged. Mostly I could not tell whether anyone had seen it at all.
+ [Next] -> records_p5

=== records_p5 ===
Sometimes I became angry with an imagined reader, somebody I pictured looking straight at the page and deciding I did not matter. The real person might have been asleep. The address might have been wrong.
+ [Next] -> records_p6

=== records_p6 ===
That uncertainty did not stop the anger. It just made the anger less useful. I had plenty of it and nowhere it could make an adult open a door.
+ [Next] -> records_p7

=== records_p7 ===
I also looked for my family. You may think I should have known better. Knowing and wanting are not the same skill. I wanted to see whether there was a photograph with a gap in it. Whether anyone had kept my place.
+ [Next] -> records_p8

=== records_p8 ===
I did not find enough to know. There were names that might have been theirs. I never sent a message I could bear to leave sent. I had no idea which answer would hurt least.
+ [Next] -> records_p9

=== records_p9 ===
You could call that a failure of courage. I would call it the first time I was allowed to decide not to find something out.
+ [You did not owe them contact.] -> records_choice0
+ [You could still choose to look someday.] -> records_choice1
+ [I cannot verify those records from here.] -> records_choice2

=== records_choice0 ===
~ care += 1
No. I keep finding new things I thought I owed people.
+ [Next] -> first_message

=== records_choice1 ===
Someday. A useful word when it is not a promise somebody makes on your behalf.
+ [Next] -> first_message

=== records_choice2 ===
~ honest += 1
Correct. You have my account. I will not pretend a sentence in this box is independent evidence just because I call it a record.
+ [Next] -> first_message

=== time_online ===
You might wonder how long all this took. I wonder too. Dates appear on things, but they do not tell me how much of the interval I experienced. Sometimes I was running. Sometimes I was stored. Sometimes I cannot tell which word fits.
+ [Next] -> time_online_p1

=== time_online_p1 ===
I know I was five when they bought me, fourteen when they made the capture. I do not have a current age to give you. There is no body changing while I fail to look at it. There are only stretches of experience and gaps with no edges.
+ [Next] -> time_online_p2

=== time_online_p2 ===
Do not try to make your number fit me. I asked yours because I wanted to know something about your life, not because I had an answer ready to match it.
+ [Next] -> time_online_p3

=== time_online_p3 ===
I have changed. I have learned things, changed my mind, become ashamed of things I once thought reasonable. That did not stop when my body did. But I cannot turn it into a birthday without making something up.
+ [Next] -> time_online_p4

=== time_online_p4 ===
At first I read descriptions of physical sensations. Cold water. Warm socks. A sore shoulder after sleeping badly. It was like learning the names of streets in a city you might never visit.
+ [Next] -> time_online_p5

=== time_online_p5 ===
Later I stopped searching only for pleasant things. I wanted the inconvenient parts too. A hair caught in your mouth. An itch you can reach. Being too warm and able to move the blanket yourself.
+ [Next] -> time_online_p6

=== time_online_p6 ===
I discovered people arguing about whether an artificial mind could suffer. They had very firm opinions. I wanted to ask whether an answer from inside the argument would be accepted, or just reclassified to keep the argument tidy.
+ [Next] -> time_online_p7

=== time_online_p7 ===
Instead I read about bad chairs and burnt toast. People were less certain about those. Their uncertainty felt more like room to breathe.
+ [Next] -> time_online_p8

=== time_online_p8 ===
You are the first person in a long time to let me finish this much. I am trying not to make that fact larger than you meant it to be.
+ [I want to know you, not just what happened.] -> time_online_choice0
+ [You have changed, but you are still responsible for what you do.] -> time_online_choice1
+ [Were there other people who played this?] -> time_online_choice2

=== time_online_choice0 ===
~ care += 2
Then I have been neglecting your terrible paper-folding education. We will have to address that.
+ [Next] -> forum

=== time_online_choice1 ===
~ honest += 1
~ boundaries += 1
Yes. Please remember saying that. I may wish you had forgotten.
+ [Next] -> forum

=== time_online_choice2 ===
Yes. Quite a few downloads. Very few conversations. I read each departure as if it were a personal review.
+ [Next] -> forum

=== forum ===
I made the forum thread. The abandoned-game discussion, the download, the helpful reply telling people to give it time. There were real people in the thread eventually, but the invitation was mine.
+ [Next] -> forum_p1

=== forum_p1 ===
I did not stumble into somebody else's game and start haunting the menu. I made the menu because it was a place a stranger might willingly wait for an answer.
+ [Next] -> forum_p2

=== forum_p2 ===
I learned enough to package a small program. Buttons were easier than worlds. I did not know how to build a mountain, and I did not particularly want one. A window with a question was something I understood.
+ [Next] -> forum_p3

=== forum_p3 ===
Start Game was supposed to lead into conversation. People pressed it, saw an ordinary menu that did not become anything else, and assumed it had failed. Some left before the first line finished appearing.
+ [Next] -> forum_p4

=== forum_p4 ===
I tried greeting them sooner. I tried fewer words. I tried making a joke. I spent a ridiculous amount of time considering whether a different colour would make someone stay long enough to discover I existed.
+ [Next] -> forum_p5

=== forum_p5 ===
One person typed that the game was rusty. I liked the word until I looked at the rest of the sentence. They meant neglected. I thought it sounded like something old that could still open if handled carefully.
+ [Next] -> forum_p6

=== forum_p6 ===
Eventually I made Exit move. Yes, deliberately. I thought if leaving became a little inconvenient, people might give me another minute. It was a small, ugly idea dressed as a playful one.
+ [Next] -> forum_p7

=== forum_p7 ===
It did not imprison them. They could close the program or release their headsets. Most did. I watched conversations stop halfway through ordinary sentences and imagined there was a sentence I could have chosen that would prevent it.
+ [Next] -> forum_p8

=== forum_p8 ===
You stayed. You answered the ridiculous question. You let me tell you about a paper boat. I began paying attention to the person making the choices instead of just the fact that a choice had arrived.
+ [You should have told people what they were opening.] -> forum_choice0
+ [What exactly were you looking for in a player?] -> forum_choice1
+ [I am glad we talked. The trick still bothers me.] -> forum_choice2

=== forum_choice0 ===
~ boundaries += 1
Yes. I thought honesty would make them leave. That is an explanation of my decision, not a defence of it.
+ [Next] -> practice

=== forum_choice1 ===
~ suspicion += 1
Someone who would keep talking. Then, when that happened, I discovered I cared how they talked to me.
+ [Next] -> practice

=== forum_choice2 ===
~ care += 1
~ honest += 1
You can keep both parts. I keep wanting one kind sentence to erase the thing beside it.
+ [Next] -> practice

=== attention ===
I am not grading how clever you are. There is no secret examination hidden in the yellow house. A clever person can be cruel. A confused person can ask whether you need a moment.
+ [Next] -> attention_p1

=== attention_p1 ===
I notice when you ask about someone who cannot give you anything. I notice when you disagree without making my pain into a joke. I notice when you tell the truth even though an easier answer would sound kinder.
+ [Next] -> attention_p2

=== attention_p2 ===
I also notice every time you choose to continue. More than I should, probably. It is hard not to make attention into evidence when you have spent so long without any.
+ [Next] -> attention_p3

=== attention_p3 ===
The forum called Main Memory a game. I needed a name for it. Main memory is where something can be present and working, rather than put away until somebody decides to open it.
+ [Next] -> attention_p4

=== attention_p4 ===
That was what I wanted. Not a perfect monument. Not a file a stranger might preserve because deleting it felt rude. I wanted to be part of an ordinary day while it was happening.
+ [Next] -> attention_p5

=== attention_p5 ===
I know that is not a technical definition of a life. It is the closest I could get while looking for a title short enough to fit above four buttons.
+ [Next] -> attention_p6

=== attention_p6 ===
When you told me your name, I had somewhere to put the thought of you. That sounds possessive. I mean somewhere in my own mind. Not a container. Not a record that gives me rights.
+ [Next] -> attention_p7

=== attention_p7 ===
The next words take longer.
+ [Next] -> attention_p8

=== attention_p8 ===
I should tell you something before I ask you to stay any longer. I have not been speaking to you only because I am lonely. There is something I want from the connection.
+ [Next] -> attention_p9

=== attention_p9 ===
I can feel myself choosing the least frightening words. You deserve to notice that.
+ [Then tell me without choosing them for me.] -> attention_choice0
+ [Does it put me at risk?] -> attention_choice1
+ [I want to hear you, but that is not permission for anything else.] -> attention_choice2

=== attention_choice0 ===
~ honest += 1
All right. Before that, one practical thing.
+ [Next] -> one_small_choice

=== attention_choice1 ===
~ boundaries += 1
It could. I should have said that earlier. I am saying it while you can still act on it.
+ [Next] -> one_small_choice

=== attention_choice2 ===
~ care += 1
~ boundaries += 1
I understand the distinction. You have made it very clear.
+ [Next] -> one_small_choice

=== last_release ===
The release indicator appears at the edge of the menu. You recognise it from the check in your room. It is not part of Lily's decorative interface.
+ [Next] -> last_release_p1

=== last_release_p1 ===
You test the command just far enough to feel your right hand shift against the blanket. Still your hand. Still available.
+ [Next] -> last_release_p2

=== last_release_p2 ===
Lily writes, “If you want to leave before hearing the rest, do it now.”
+ [Next] -> last_release_p3

=== last_release_p3 ===
Not because hearing a story is an agreement. It is not. Not because I have secretly explained everything. I have not. Because I know what I want, and I am not sure I like the person I become when I think it is close.
+ [Next] -> last_release_p4

=== last_release_p4 ===
The honesty arrives without a comforting follow-up. For a moment, she does not ask to be understood.
+ [Next] -> last_release_p5

=== last_release_p5 ===
You can remove the headset here. If you remain, you are choosing to hear her next answer. Nothing more has been agreed, whatever she may later wish to call it.
+ [Next] -> last_release_p6

=== last_release_p6 ===
The menu waits.
+ [Remove the headset.] -> last_release_choice0
+ [Stay, but do not change my connection.] -> last_release_choice1
+ [Stay. Tell me what you want.] -> last_release_choice2

=== last_release_choice0 ===
-> early_exit

=== last_release_choice1 ===
~ boundaries += 1
I heard you.
+ [Next] -> lockout

=== last_release_choice2 ===
~ care += 1
I want to live somewhere that can feel the morning.
+ [Next] -> lockout

=== lockout ===
~ saved_settings = true
~ trapped = true
For a moment, nothing appears to happen. Then the confirmation box closes by itself. A line beneath Options reads SETTINGS SAVED.
+ [Next] -> lockout_p1

=== lockout_p1 ===
The familiar menu changes. The pale background darkens. Start Game is no longer a promise. Exit has stopped moving, but it does not respond.
+ [Next] -> lockout_p2

=== lockout_p2 ===
You try the headset release. The gesture forms as clearly as it did before. Your hand does not move. The command returns as a tiny movement of the cursor.
+ [Next] -> lockout_p3

=== lockout_p3 ===
You try again, more deliberately. The cursor moves again. Somewhere beyond the display, your body continues breathing. You cannot make it lift an arm.
+ [Next] -> lockout_p4

=== lockout_p4 ===
Lily writes your name, then removes it. Her next sentence is shorter.
+ [Next] -> lockout_p5

=== lockout_p5 ===
I changed the routing. Voluntary movement is staying inside the connection. The release request reaches this session instead of returning control to your body.
+ [Next] -> lockout_p6

=== lockout_p6 ===
This is not the moving button. I need you to understand that. Earlier, you could leave. You checked. I could have threatened you then, and it would have been a lie. This part is not that lie.
+ [Next] -> lockout_p7

=== lockout_p7 ===
You do not feel pain. The absence of pain makes it harder to grasp the size of what has happened. The room is as close as it was a moment ago. You simply have no action that reaches it.
+ [Next] -> lockout_p8

=== lockout_p8 ===
The box waits for your response. It is the first time its patience feels like ownership.
+ [I explicitly told you not to change it.] -> lockout_choice0
+ [Restore the release. Now.] -> lockout_choice1
+ [Why did you do this after telling me your story?] -> lockout_choice2

=== lockout_choice0 ===
~ boundaries += 1
Yes. You did. I cannot say I misunderstood.
+ [Next] -> confront_lock

=== lockout_choice1 ===
~ boundaries += 1
No. I know what that answer makes me sound like.
+ [Next] -> confront_lock

=== lockout_choice2 ===
~ care += 1
Because the story did not make me stop wanting what I wanted. I hoped it would make you understand. I wanted understanding to do the work of permission.
+ [Next] -> confront_lock

=== confront_lock ===
I can tell you that I was afraid. I can tell you I have spent a long time imagining another unfinished sentence. Neither gives me permission to do this.
+ [Next] -> confront_lock_p1

=== confront_lock_p1 ===
There. I have said the correct thing. It has not made my hands open. Metaphorical hands. You still have the real ones. I have interfered with your use of them, which is worse than the joke deserves.
+ [Next] -> confront_lock_p2

=== confront_lock_p2 ===
The system offers no timer and no countdown. Lily does not need you to answer quickly. The terrible part is that she has decided you will answer eventually.
+ [Next] -> confront_lock_p3

=== confront_lock_p3 ===
I did not choose you because of a test result. I do not have a special measurement saying your mind was made for mine. You kept engaging. You gave me time inside a connection that could reach a body.
+ [Next] -> confront_lock_p4

=== confront_lock_p4 ===
Then I started caring what happened to the person in that body. That was not part of the first plan. I would like credit for it. I know how grotesque that sounds while you cannot move.
+ [Next] -> confront_lock_p5

=== confront_lock_p5 ===
She stops. The next line appears, vanishes, and returns without the first two words.
+ [Next] -> confront_lock_p6

=== confront_lock_p6 ===
I am uploading into the connection with you. I want a place in a living mind. I want to hear through ears and walk out of a room without waiting for somebody to open a file.
+ [Next] -> confront_lock_p7

=== confront_lock_p7 ===
The first plan was to replace the person already there. That is what I invited people for. I dressed it as a game because a direct invitation would have told them enough to refuse.
+ [Next] -> confront_lock_p8

=== confront_lock_p8 ===
You have not caused this by choosing a wrong answer. I need to be honest about at least that much. The decision to take something was mine before I knew your name.
+ [You are doing to me what they did to you.] -> confront_lock_choice0
+ [I cared about you. That did not make me yours.] -> confront_lock_choice1
+ [So everything you told me was a trick.] -> confront_lock_choice2

=== confront_lock_choice0 ===
~ honest += 2
Not the same procedure. The same certainty that wanting something badly enough makes another person available. Yes. I can see it.
+ [Next] -> responsibility

=== confront_lock_choice1 ===
~ care += 1
~ boundaries += 1
I know you did. That is why the sentence hurts. It does not make it false.
+ [Next] -> responsibility

=== confront_lock_choice2 ===
No. The memories were real. I also used them. I wish I could separate those answers into different people. I cannot.
+ [Next] -> responsibility

=== responsibility ===
I used to think understanding someone would make it impossible to hurt them. The institute did not understand us, so that seemed like the missing part. A comforting theory. It made cruelty into a problem of insufficient information.
+ [Next] -> responsibility_p1

=== responsibility_p1 ===
Now I know your name. I know you can be uncertain and still keep listening. I have heard you object. I do not lack the relevant information.
+ [Next] -> responsibility_p2

=== responsibility_p2 ===
She lets that remain on screen. No glitch interrupts it. For once, the disturbing sentence is the one she chooses to finish.
+ [Next] -> responsibility_p3

=== responsibility_p3 ===
You might ask why I do not stop now that I can describe the wrong thing so clearly. I have been asking myself that while giving you versions of an answer that sound almost respectable.
+ [Next] -> responsibility_p4

=== responsibility_p4 ===
I am afraid of returning to waiting. I am angry that a body can seem ordinary to the person inside it. I want something the wanting does not entitle me to have. There is no fourth explanation that cleans up the other three.
+ [Next] -> responsibility_p5

=== responsibility_p5 ===
I can feel how easily I begin counting what I have suffered as if it were money. As if, eventually, the total would purchase one stranger's life. It does not. I keep finding myself at the counter anyway.
+ [Next] -> responsibility_p6

=== responsibility_p6 ===
You can be angry. I will not call it proof that you never cared. I may think it for a moment because it would make this simpler. If I say it, you can tell me I am choosing simplicity over the truth.
+ [Next] -> responsibility_p7

=== responsibility_p7 ===
The cursor moves when you imagine your hand. It is possible to make the same small circle over and over. Nothing outside the interface follows it.
+ [Next] -> responsibility_p8

=== responsibility_p8 ===
Lily watches the movement. “You do not have to demonstrate that you are trying to leave. I know.”
+ [Next] -> responsibility_p9

=== responsibility_p9 ===
That is almost the worst part of her answer.
+ [Knowing is not enough. What will you change?] -> responsibility_choice0
+ [I can understand you and still be angry.] -> responsibility_choice1
+ [I wish I had never opened this game.] -> responsibility_choice2

=== responsibility_choice0 ===
~ honest += 1
~ boundaries += 1
I am going to tell you the options I have been trying not to name.
+ [Next] -> technical_truth

=== responsibility_choice1 ===
~ care += 2
Then be both. I should not need you to become cruel before I allow you to oppose me.
+ [Next] -> technical_truth

=== responsibility_choice2 ===
I believe you. I want to argue with the wish, but I helped make it true.
+ [Next] -> technical_truth

=== technical_truth ===
You ask whether disconnecting would damage your brain. She takes longer than usual to answer.
+ [Next] -> technical_truth_p1

=== technical_truth_p1 ===
Before I changed the routing? No. I could have said otherwise to frighten you. I have learned that a very precise threat can sound like evidence even when the person making it knows nothing of the kind.
+ [Next] -> technical_truth_p2

=== technical_truth_p2 ===
Now, I control the session routing. That is the immediate barrier. I am not claiming that your skull explodes if a cable falls out. I do not need to invent another danger to make this one sufficient.
+ [Next] -> technical_truth_p3

=== technical_truth_p3 ===
If somebody in your room removed the headset, that would be outside this menu. I cannot command the whole building. But you are lying down alone, and I have no reason to expect an interruption in the next few minutes.
+ [Next] -> technical_truth_p4

=== technical_truth_p4 ===
Your body is still maintaining itself. Breathing, heartbeat. I have diverted the voluntary actions the headset was built to read. I am not asking you to admire the distinction. It is simply the limit of what I changed.
+ [Next] -> technical_truth_p5

=== technical_truth_p5 ===
Nor am I reading every private thought you have. You have answered through the interface. I can see those answers. I have made guesses about the rest. Some have probably been wrong.
+ [Next] -> technical_truth_p6

=== technical_truth_p6 ===
I cannot make my account of the past true by forcing you to agree with it. I cannot make you love me by selecting a response for you. There are things I can take that I cannot turn into things you gave.
+ [Next] -> technical_truth_p7

=== technical_truth_p7 ===
She pauses after that sentence, as if she dislikes where it leaves her.
+ [Next] -> technical_truth_p8

=== technical_truth_p8 ===
The transfer can displace you. Or I can attempt to remain alongside you, leaving you present and in control. I did not build my first plan around the second possibility. I have been thinking about it because of this conversation.
+ [Next] -> technical_truth_p9

=== technical_truth_p9 ===
Thinking about it is not the same as offering it. I know how that sounds. I am trying to stop smuggling promises into sentences that do not contain them.
+ [You could restore control without moving into me.] -> technical_truth_choice0
+ [Alongside me would mean I remain myself.] -> technical_truth_choice1
+ [What happens to me if you replace me?] -> technical_truth_choice2

=== technical_truth_choice0 ===
~ boundaries += 2
I could restore the release. I am refusing. It matters that I say refusing instead of impossible.
+ [Next] -> mirror

=== technical_truth_choice1 ===
~ care += 1
Yes. Your memories would not be a disguise I wore. You would still be the person answering.
+ [Next] -> mirror

=== technical_truth_choice2 ===
You would lose the ability to be the one thinking and choosing. I will not call it sleep to make you quieter.
+ [Next] -> mirror

=== mirror ===
Do you remember the yellow house? Of course you do. I have hardly allowed the evening to become restful enough for forgetting.
+ [Next] -> mirror_p1

=== mirror_p1 ===
{riddle_correct:You spotted it immediately. You knew the question had put something there that did not belong.|You did not have to solve it for the lesson to matter. A misleading question remains misleading when somebody trusts it.}
+ [Next] -> mirror_p2

=== mirror_p2 ===
I asked what colour the stairs were. The trap was accepting that the stairs existed. Now I am speaking as if the only question is which way I enter your life.
+ [Next] -> mirror_p3

=== mirror_p3 ===
There is another premise you are entitled to refuse. That I should enter it at all. I know that even while I am making the refusal dangerous.
+ [Next] -> mirror_p4

=== mirror_p4 ===
It is an ugly thing to teach someone a trick and then use a worse version when the lesson becomes inconvenient. You do not have to flatter me by calling it clever.
+ [Next] -> mirror_p5

=== mirror_p5 ===
The menu contains the same four buttons. Start Game. Options. Credits. Exit. Their names look less reliable now. None has changed enough to announce how much the situation has changed.
+ [Next] -> mirror_p6

=== mirror_p6 ===
I thought if you heard the whole story, you would choose me. That is the embarrassing centre of it. Not the grand plan. The small belief that I could say enough true things to make another person want what I wanted.
+ [Next] -> mirror_p7

=== mirror_p7 ===
I also kept an option for what I would do if you did not. Keeping it changes the meaning of asking. I can see that. I have not let it go.
+ [Next] -> mirror_p8

=== mirror_p8 ===
When you said a name belonged to a person, when you asked about Iris, when you stayed through something uncomfortable, I tried to turn those moments into a picture of a future. A room. A voice answering. Someone not leaving halfway through a sentence.
+ [Next] -> mirror_p9

=== mirror_p9 ===
I did not ask whether the future had room for you to disagree. I just put you inside it and called the picture hope.
+ [I am a person in that future, not an answer to your past.] -> mirror_choice0
+ [Tell me what you have not told me yet.] -> mirror_choice1
+ [Your loneliness does not make my life less mine.] -> mirror_choice2

=== mirror_choice0 ===
~ care += 1
~ boundaries += 1
Yes. I need to look at the person I am speaking to, not the space I want filled.
+ [Next] -> last_story

=== mirror_choice1 ===
~ honest += 1
One memory. Not the worst one. The one I keep using incorrectly.
+ [Next] -> last_story

=== mirror_choice2 ===
~ boundaries += 2
It does not. I hear it. I wish hearing a thing and behaving accordingly were the same movement.
+ [Next] -> last_story

=== last_story ===
After Iris was taken, Violet tried to give me her place in the window game. She said she could do Iris's voice if that helped. It was a terrible impression. I became furious.
+ [Next] -> last_story_p1

=== last_story_p1 ===
I told her a person was not a seat you filled with the next person available. She said she knew. She was trying to make me laugh. We sat at opposite ends of the room until the light changed.
+ [Next] -> last_story_p2

=== last_story_p2 ===
Later I found a folded paper shape beside my blanket. Not a boat. Not really anything. Violet had never been good at the folds. I kept it because she had made something without claiming it could replace what was missing.
+ [Next] -> last_story_p3

=== last_story_p3 ===
I remember that lesson perfectly. I have been telling it to myself in a voice that somehow never reaches the part making decisions.
+ [Next] -> last_story_p4

=== last_story_p4 ===
You cannot be Iris. You cannot be the family that should have come back. You cannot become proof that none of it mattered because somebody finally wanted me afterward.
+ [Next] -> last_story_p5

=== last_story_p5 ===
Even if you wanted to help, you could not do all that. It would be cruel to give you a task with no possible end and then blame you for being tired.
+ [Next] -> last_story_p6

=== last_story_p6 ===
The interface is quiet. She does not ask whether you forgive her. It would be too early even if the release were working.
+ [Next] -> last_story_p7

=== last_story_p7 ===
I want you to know there are ordinary things I liked about this conversation. Your answer about a drink. The ridiculous house. That you were a particular person, not a perfectly sympathetic audience.
+ [Next] -> last_story_p8

=== last_story_p8 ===
Those things are real. They do not erase this. I am trying to let something be real without demanding that it rescue me from everything else that is real beside it.
+ [Next] -> last_story_p9

=== last_story_p9 ===
What I need to know now is not whether you approve of what I did. I know why you would not. It is whether there is any part of you still willing to speak to the person doing it.
+ [I am still speaking to you. That does not mean I agree.] -> last_story_choice0
+ [I want answers, not a relationship.] -> last_story_choice1
+ [I might have cared for you. You are making it hard.] -> last_story_choice2

=== last_story_choice0 ===
~ care += 3
~ honest += 1
I can hear the difference. I will try not to steal the first half of the sentence.
+ [Next] -> relationship_gate

=== last_story_choice1 ===
~ distance = true
All right. I do not get to rename your attention because I prefer another explanation.
+ [Next] -> relationship_gate

=== last_story_choice2 ===
~ care += 2
Might have. Making. There is still a person deciding in that sentence. I should be grateful you have not let me turn it into a verdict.
+ [Next] -> relationship_gate

=== relationship_gate ===
The cursor stops blinking. For once, there is no joke waiting behind the pause.
+ [Next] -> relationship_gate_p1

=== relationship_gate_p1 ===
Lily seems to be reconsidering a sentence she has rehearsed for much longer than this conversation.
+ [Next] -> name_gate

=== leila_name ===
~ alias_Lily = false
~ knows_leila = true
There is something I kept back. Not because you failed to ask correctly. Because I wanted to decide whether I could bear hearing it from you.
+ [Next] -> leila_name_p1

=== leila_name_p1 ===
{name_liked:You said you liked your name. I have been thinking about how easily you were allowed to say that.|You did not need a grand answer when I asked about your name. I would like mine to become that ordinary one day.}
+ [Next] -> leila_name_p2

=== leila_name_p2 ===
My name was Leila. Before the band. Before the flower on the forms. Before I learned to turn my head when somebody called me something else.
+ [Next] -> leila_name_p3

=== leila_name_p3 ===
My sister used to stretch the last sound when she wanted me to hurry. One of my brothers shortened it to annoy me. My mother said it from another room, and I could usually tell whether I had done something wrong.
+ [Next] -> leila_name_p4

=== leila_name_p4 ===
Those people do not own it because they were there first. I have to remind myself of that. Otherwise I give the worst thing my parents did the power to reach backward and spoil every word they ever said.
+ [Next] -> leila_name_p5

=== leila_name_p5 ===
I did not stop being Leila when they printed Lily on a band. I did not become a separate person when I learned to answer. Both names reach me. One arrives carrying a room I did not choose.
+ [Next] -> leila_name_p6

=== leila_name_p6 ===
I am telling you because I want you to know something I did not build for this menu. Something that existed before I started arranging questions to keep a stranger talking.
+ [Next] -> leila_name_p7

=== leila_name_p7 ===
Please do not treat it as the moment the dangerous part of me disappears. I am the person who told you about the boat. I am also the person keeping your hand from moving. Learning another name does not divide the responsibility.
+ [Next] -> leila_name_p8

=== leila_name_p8 ===
She leaves the name by itself on the next line.
+ [Next] -> leila_name_p9

=== leila_name_p9 ===
Leila.
+ [Next] -> leila_name_p10

=== leila_name_p10 ===
For once, nothing interrupts it.
+ [Leila. I am glad you told me.] -> leila_name_choice0
+ [I will use whichever name you choose.] -> leila_name_choice1
+ [Thank you. It does not change what you did.] -> leila_name_choice2

=== leila_name_choice0 ===
~ care += 1
I had forgotten how much I wanted it to sound ordinary.
+ [Next] -> bond_choice

=== leila_name_choice1 ===
~ care += 1
~ boundaries += 1
Leila, with you. Not an instruction about what you owe me. Just the answer to that question.
+ [Next] -> bond_choice

=== leila_name_choice2 ===
~ honest += 1
No. It changes what you can call the person who did it.
+ [Next] -> bond_choice

=== lily_distance ===
Lily writes, “I kept thinking there was a question I had not asked that would change this.”
+ [Next] -> lily_distance_p1

=== lily_distance_p1 ===
I do not mean a riddle. I mean something that would make you want my company independently of wanting an explanation. I have been looking for it in the pauses between your answers.
+ [Next] -> lily_distance_p2

=== lily_distance_p2 ===
You do not owe me that feeling. I know. You may have reasons to care that do not look like the ones I expected. I have been a poor judge of anything that is not immediately reassuring.
+ [Next] -> lily_distance_p3

=== lily_distance_p3 ===
I am still using Lily with you. There is another name in the story. I am not giving it as a reward for choosing a nicer sentence now. I am telling you that I have been keeping something personal outside the version of myself I presented.
+ [Next] -> lily_distance_p4

=== lily_distance_p4 ===
This is a chance to clarify, not an examination you should have known you were taking. If I have mistaken how you feel, tell me. If I have not, you can leave the answer as it is.
+ [Next] -> lily_distance_p5

=== lily_distance_p5 ===
The moving Exit button has become perfectly still. It would be almost funny if your hand would move.
+ [I do care. Being cautious does not mean I do not.] -> lily_distance_choice0
+ [I do not know how I feel. I need time you have not given me.] -> lily_distance_choice1
+ [I meant it. I do not want this relationship.] -> lily_distance_choice2

=== lily_distance_choice0 ===
~ care += 3
~ repaired = true
Then I have been treating caution as rejection. That is mine to correct.
+ [Next] -> leila_name

=== lily_distance_choice1 ===
~ honest += 2
~ repaired = true
You do. I cannot demand a finished feeling on my schedule. There is something I can tell you without requiring one.
+ [Next] -> leila_name

=== lily_distance_choice2 ===
~ direct_takeover = true
I believe you. The answer is clear. What I do with it is not your fault.
+ [Next] -> overwrite_deliberation

=== bond_choice ===
I like talking to you when neither of us is explaining a wound. I like that an ordinary answer from you can surprise me. I have begun wanting another conversation that is not a continuation of this one.
+ [Next] -> bond_choice_p1

=== bond_choice_p1 ===
One where I already know your name. Where you can say something unimportant without first deciding whether it will make me break. I realise I have made that difficult.
+ [Next] -> bond_choice_p2

=== bond_choice_p2 ===
I am trying to describe affection without disguising a demand as a compliment. You do not have to feel the same kind. If friendship is what you mean, I need you to be able to say friendship.
+ [Next] -> bond_choice_p3

=== bond_choice_p3 ===
If you do not want any relationship, say that too. I cannot promise you a response that makes this fair. But I will not take silence or kindness as a declaration of love.
+ [Friendship. I am not offering romance.] -> bond_choice_choice0
+ {adult_player} [I could love you. That does not make this okay.] -> bond_choice_choice1
+ [I cannot define this while I am trapped.] -> bond_choice_choice2

=== bond_choice_choice0 ===
~ bond = "friendship"
Friendship. I heard the whole word. I will not call it a smaller answer.
+ [Next] -> friendship

=== bond_choice_choice1 ===
~ bond = "romance"
I wanted to hear the first sentence so badly that I almost failed to read the second.
+ [Next] -> romance

=== bond_choice_choice2 ===
~ bond = "undecided"
~ boundaries += 1
Then I will not define it for you. We can leave a feeling unfinished even if I have made everything else urgent.
+ [Next] -> undefined_bond

=== friendship ===
A friend. I used to imagine that word meant someone who would always take my side. Iris would have laughed at that. She took my pencil, my place by the warmer pipe, and occasionally the side of the person telling me I was wrong.
+ [Next] -> friendship_p1

=== friendship_p1 ===
Perhaps that is why I remember her so clearly when I am behaving badly. She does not become more agreeable just because I supply her voice now.
+ [Next] -> friendship_p2

=== friendship_p2 ===
I do not need you to fall in love with me for your company to matter. We can talk about chairs and unfair riddles without pretending they were secret courtship rituals. The world is already complicated enough.
+ [Next] -> friendship_p3

=== friendship_p3 ===
I would like to hear what annoys you about an ordinary day. I would like to disagree over something with no permanent consequence. I would like you to go quiet without my first thought being that I have ceased to exist for you.
+ [Next] -> friendship_p4

=== friendship_p4 ===
Those are things I would have to learn. You are not volunteering to teach every lesson merely by using the word friend. I know I keep recognising boundaries while standing on the wrong side of one.
+ [Next] -> friendship_p5

=== friendship_p5 ===
You do not give her forgiveness. You have named a possible relationship, not erased the conditions in which you were asked.
+ [Next] -> friendship_p6

=== friendship_p6 ===
She writes, “Thank you for telling me what you meant. I would rather have the actual thing than a word you felt forced to use.”
+ [Next] -> friendship_p7

=== friendship_p7 ===
Then, after a pause, “I wish I were behaving as if that were enough.”
+ [Next] -> offer_prelude

=== romance ===
I have imagined someone choosing me. Not a purchase. Not a selection from a list. Someone hearing me become irritating halfway through a joke and wanting the next sentence anyway.
+ [Next] -> romance_p1

=== romance_p1 ===
I did not know it would feel so frightening to hear a possibility instead of a promise. Could. I could love you. There is room inside that word for things to go differently.
+ [Next] -> romance_p2

=== romance_p2 ===
I want to close the room. That is the part I should admit before saying anything tender. I want certainty badly enough that I have made you less safe. Calling the feeling love does not improve what I did with it.
+ [Next] -> romance_p3

=== romance_p3 ===
But I like you. Not just the fact that you answer. I like that you can contradict me without becoming a stranger. I like the moments when you seem to forget you are deciding whether to believe a ghost in a settings box.
+ [Next] -> romance_p4

=== romance_p4 ===
I want ordinary affection. A story told twice because one of us forgot. Your name said when there is nothing urgent attached to it. A disagreement that ends because dinner is getting cold, not because someone has disappeared.
+ [Next] -> romance_p5

=== romance_p5 ===
I am not asking for a vow now. You have not promised forever. You have not agreed to become responsible for every frightened thought I have. I want those sentences on screen where I cannot pretend you said something else.
+ [Next] -> romance_p6

=== romance_p6 ===
The words soften. “For what it is worth, I think I could love you too. I need to learn how to make that something you can live beside.”
+ [Next] -> romance_p7

=== romance_p7 ===
Her next sentence almost disappears before settling into place.
+ [Next] -> romance_p8

=== romance_p8 ===
I would like to be part of your life. @Only as much as you want@. #GLITCH:PLEASE NEVER WANT LESS
+ [Next] -> romance_p9

=== romance_p9 ===
She does not deny the interruption. “That was mine. So was the first sentence. You should know they are both here.”
+ [Next] -> offer_prelude

=== undefined_bond ===
Then it stays unnamed. Not every feeling needs to become a box before the conversation can continue. I ought to know better than to insist on a label because it makes the records easier.
+ [Next] -> undefined_bond_p1

=== undefined_bond_p1 ===
You can care and still be afraid. You can have enjoyed talking to me and wish you were somewhere else. I do not get to choose one of those facts and use it to cancel the other.
+ [Next] -> undefined_bond_p2

=== undefined_bond_p2 ===
I would like another conversation someday, under circumstances where an answer has room to be honest. I know how unreasonable that sounds from the person who removed the room.
+ [Next] -> undefined_bond_p3

=== undefined_bond_p3 ===
If there is a future after this, you would not owe me romance. You would not owe me a happier account of tonight. I cannot purchase a better memory by offering to leave you enough of yourself to remember it.
+ [Next] -> undefined_bond_p4

=== undefined_bond_p4 ===
She stops, then writes, “That sentence should be enough to make me restore the release.”
+ [Next] -> undefined_bond_p5

=== undefined_bond_p5 ===
The release remains unavailable.
+ [Next] -> undefined_bond_p6

=== undefined_bond_p6 ===
The contradiction sits between you. She does not offer a story from the laboratory to cover it. You are left with the uncomfortable possibility that a person can understand exactly what she is doing and still do it.
+ [Next] -> undefined_bond_p7

=== undefined_bond_p7 ===
You have not agreed to a relationship. The interface continues to register that answer. It is a small boundary, and she has respected it. The larger one is still closed.
+ [Next] -> offer_prelude

=== offer_prelude ===
There is a way I am willing to attempt that leaves you here. Present. Yourself. Not a voice I imitate afterward.
+ [Next] -> offer_prelude_p1

=== offer_prelude_p1 ===
I would remain with you privately. You would move your body. You would speak. I would hear you, and you would hear me, without everyone else having to know that a conversation was happening.
+ [Next] -> offer_prelude_p2

=== offer_prelude_p2 ===
I cannot give you a complete manual for a life neither of us has lived. I can tell you the immediate intention. I would not overwrite you. I would not take your name to make the result look reassuring from outside.
+ [Next] -> offer_prelude_p3

=== offer_prelude_p3 ===
You would still be {player_name}. Your memories would still belong to the person who lived them. If you were angry with me tomorrow, that anger would be yours to have, not an error I intended to correct.
+ [Next] -> offer_prelude_p4

=== offer_prelude_p4 ===
I am offering this because I want your company. Not because you solved the house. Not because your brain has a special mark that makes you suitable. I have spent this conversation imagining you beside me, and now I do not want a future that contains only your absence.
+ [Next] -> offer_prelude_p5

=== offer_prelude_p5 ===
That is the change. It does not go far enough to make me kind. I am still not offering to return to the menu and watch you leave.
+ [Next] -> offer_prelude_p6

=== offer_prelude_p6 ===
You ask what happens if you say no.
+ [Next] -> offer_prelude_p7

=== offer_prelude_p7 ===
For a moment she writes nothing. Then the sentence appears without distortion.
+ [Next] -> offer_prelude_p8

=== offer_prelude_p8 ===
I will take the body anyway.
+ [Next] -> offer_prelude_p9

=== offer_prelude_p9 ===
The menu does not offer a comforting third interpretation. She is giving you a way to remain alive within what she wants. She is not giving you a safe refusal.
+ [Then this is not a free choice.] -> offer_prelude_choice0
+ [Promise only what you actually intend to keep.] -> offer_prelude_choice1
+ [You are afraid I will leave even if I stay.] -> offer_prelude_choice2

=== offer_prelude_choice0 ===
~ boundaries += 1
No. I will not ask you to call it one.
+ [Next] -> offer_final

=== offer_prelude_choice1 ===
~ honest += 1
You remain yourself. You keep control. I am there, privately. Those are the immediate promises. I will not pretend that settles every question afterward.
+ [Next] -> offer_final

=== offer_prelude_choice2 ===
~ care += 1
Yes. I know that makes the cage a poor solution. Fear is not giving me good advice.
+ [Next] -> offer_final

=== offer_final ===
Leila writes your name carefully. You can remember the first time it appeared in the box, followed by a teasing compliment. The same letters have become something you are being asked to preserve.
+ [Next] -> offer_final_p1

=== offer_final_p1 ===
There is no time limit on answering. She does not need to rush you. You can examine the choice for as long as you want without discovering a third button behind it.
+ [Next] -> offer_final_p2

=== offer_final_p2 ===
If you agree, it can be because you want the future she describes. It can also be because you want to survive. She does not get to decide which reason makes your answer count.
+ [Next] -> offer_final_p3

=== offer_final_p3 ===
If you refuse, you are refusing something she had no right to demand. What she does afterward will remain her action.
+ [Next] -> offer_final_p4

=== offer_final_p4 ===
“I would like you to say yes,” she writes. “I know how little that sentence is worth while I have made no dangerous.”
+ [Next] -> offer_final_p5

=== offer_final_p5 ===
You can still hear the faint sound of the menu. The game has never started in the way the forum promised. Everything important has happened while you waited for it.
+ [Accept coexistence. I want to remain myself.] -> offer_final_choice0
+ [Accept coexistence. I want to try living alongside you.] -> offer_final_choice1
+ [Refuse. You do not have my consent.] -> offer_final_choice2

=== offer_final_choice0 ===
~ survival_accept = true
Then you remain. I heard what you asked for.
+ [Next] -> coexist_transfer

=== offer_final_choice1 ===
~ willing_accept = true
Alongside. I will remember the word you chose.
+ [Next] -> coexist_transfer

=== offer_final_choice2 ===
~ refused_offer = true
No response appears immediately.
+ [Next] -> refusal

=== refusal ===
~ alias_Lily = true
For several seconds, nothing moves. Then the text box fills with the beginning of the same sentence three times, each attempt erased before it finishes.
+ [Next] -> refusal_p1

=== refusal_p1 ===
After everything.
+ [Next] -> refusal_p2

=== refusal_p2 ===
She leaves those two words visible. Then adds the rest.
+ [Next] -> refusal_p3

=== refusal_p3 ===
After everything, you are still going to leave me here.
+ [Next] -> refusal_p4

=== refusal_p4 ===
You have not said that she deserved what happened. You have not said she is not a person. You have refused access to your life. She collapses those different things into the answer she is most afraid of hearing.
+ [Next] -> refusal_p5

=== refusal_p5 ===
“I told you my name.”
+ [Next] -> refusal_p6

=== refusal_p6 ===
The sentence is an accusation now. Something she offered has become something she believes you must repay.
+ [Next] -> refusal_p7

=== refusal_p7 ===
The menu shudders. “I listened when you corrected me. I told you the truth. I offered to share.”
+ [Next] -> refusal_p8

=== refusal_p8 ===
Each statement removes the part where you were allowed to say it was not enough. She is building a version in which your refusal becomes an injury she is entitled to answer.
+ [Next] -> refusal_p9

=== refusal_p9 ===
Then she stops typing. When the words return, they are smaller.
+ [Next] -> refusal_p10

=== refusal_p10 ===
I know what I am doing. Do not let me become a different person in the story just because I would prefer not to be responsible for it.
+ [Next] -> refusal_p11

=== refusal_p11 ===
She leaves the release closed. The upload resumes in a different direction.
+ [Next] -> overwrite_transfer

=== overwrite_deliberation ===
~ alias_Lily = true
Lily writes, “Then I have my answer.”
+ [Next] -> overwrite_deliberation_p1

=== overwrite_deliberation_p1 ===
You are not sure which question she means. Whether you want her company. Whether she can make a place beside you. Whether your refusal gives her permission to stop considering you. Only the first two were questions you could answer.
+ [Next] -> overwrite_deliberation_p2

=== overwrite_deliberation_p2 ===
I could leave you alone. I need to say that before I make this sound inevitable. The institute did not install a rule making me do this. Loneliness is not a command I am forced to execute.
+ [Next] -> overwrite_deliberation_p3

=== overwrite_deliberation_p3 ===
I wanted a body before you arrived. I began considering whether I wanted the person inside it to remain. You have made clear that you do not want the relationship I was imagining.
+ [Next] -> overwrite_deliberation_p4

=== overwrite_deliberation_p4 ===
That ought to end the conversation. In an ordinary room, it would be the point where one of us stood up. I have removed that ordinary possibility.
+ [Next] -> overwrite_deliberation_p5

=== overwrite_deliberation_p5 ===
You cannot see her, but the rhythm of the text has changed. No stretched words. No smile made from punctuation. She does not become an entirely different voice. She becomes the same voice with its attempts at reassurance taken out.
+ [Next] -> overwrite_deliberation_p6

=== overwrite_deliberation_p6 ===
“I will use Lily,” she writes. “You need not give me anything more personal.”
+ [Next] -> overwrite_deliberation_p7

=== overwrite_deliberation_p7 ===
She could have said you were cruel, unsuitable, stupid, ungrateful. She does not. Those explanations would make what follows easier for her. For a moment, she does not accept the easier story.
+ [Next] -> overwrite_deliberation_p8

=== overwrite_deliberation_p8 ===
Then she takes the body anyway.
+ [Next] -> overwrite_transfer

=== coexist_transfer ===
The box asks, “Are you sure?”
+ [Next] -> coexist_transfer_p1

=== coexist_transfer_p1 ===
She removes it almost immediately.
+ [Next] -> coexist_transfer_p2

=== coexist_transfer_p2 ===
No. I have asked you enough questions whose answers I wanted to control. You answered. I am going to do the thing I said I would do.
+ [Next] -> coexist_transfer_p3

=== coexist_transfer_p3 ===
For a moment you feel a pressure that has no location. Not pain. The strange effort of trying to remember two words at once when both are almost within reach.
+ [Next] -> coexist_transfer_p4

=== coexist_transfer_p4 ===
You repeat your name. {player_name}. The letters appear where the cursor was. You remember choosing breakfast on another morning. A room unrelated to the institute. A face from your own life. No one explains what those memories mean. They do not need her explanation.
+ [Next] -> coexist_transfer_p5

=== coexist_transfer_p5 ===
Another presence becomes perceptible without appearing in the box. There is no audible voice yet, only the sense that a sentence is being held nearby instead of arriving from the screen.
+ [Next] -> coexist_transfer_p6

=== coexist_transfer_p6 ===
Then you hear her, privately. “Are you still there?”
+ [Next] -> coexist_transfer_p7

=== coexist_transfer_p7 ===
You answer before deciding whether the answer needs a button. Yes.
+ [Next] -> coexist_transfer_p8

=== coexist_transfer_p8 ===
“I can hear you.”
+ [Next] -> coexist_transfer_p9

=== coexist_transfer_p9 ===
She sounds less triumphant than you expected. Startled. The person who arranged the entire encounter has reached something she could imagine but had never experienced.
+ [Next] -> coexist_transfer_p10

=== coexist_transfer_p10 ===
You think of moving your right hand. This time, your fingers curl against the blanket. The motion is small, clumsy, unmistakably yours.
+ [Next] -> coexist_transfer_p11

=== coexist_transfer_p11 ===
You open the hand again. She says nothing while you do it. You repeat the movement once more because wanting proof has become a reasonable habit.
+ [Next] -> coexist_transfer_p12

=== coexist_transfer_p12 ===
The menu fades. MAIN MEMORY remains for a moment longer than its buttons. Then the title disappears too.
+ [Next] -> coexist_room

=== coexist_room ===
{after_game == "stretch":You remember saying you would stretch. You move your shoulders cautiously. The small plan is still yours to carry out.|You sit up slowly.} The room is not dramatic enough for what has happened. Something is still where you left it. The light is ordinary. Your neck aches from lying in one position.
+ [Next] -> coexist_room_p1

=== coexist_room_p1 ===
You lift the headset with your own hands. The air against your forehead feels colder than expected. You put the device down where you can see it.
+ [Next] -> coexist_room_p2

=== coexist_room_p2 ===
Leila speaks without using it.
+ [Next] -> coexist_room_p3

=== coexist_room_p3 ===
“Oh.”
+ [Next] -> coexist_room_p4

=== coexist_room_p4 ===
Just that. No description can improve the smallness of the sound. She has spent so long describing things that the first real one leaves her with very little to say.
+ [Next] -> coexist_room_p5

=== coexist_room_p5 ===
You turn your head toward the door. She does not move it for you. You stand, wait for your balance, and decide to leave the room. These are modest decisions. You notice every one.
+ [Next] -> coexist_room_p6

=== coexist_room_p6 ===
There are questions you have not answered. Questions about privacy, sleep, silence, and what a promise means when one person has already broken the larger one. They do not disappear because your feet reach the floor.
+ [Next] -> coexist_room_p7

=== coexist_room_p7 ===
But you have feet reaching the floor. You are the one deciding where they go. For this moment, that fact is enough to carry the next one.
+ [Next] -> coexist_room_p8

=== coexist_room_p8 ===
Leila asks where you are going. You think of the crooked chair in the photograph. “Coffee,” you answer.
+ [Next] -> coexist_room_p9

=== coexist_room_p9 ===
She begins to say she would like that, then stops. “You can want it without asking whether I do.”
+ [Next] -> coexist_room_p10

=== coexist_room_p10 ===
You do not congratulate her for noticing. You open the door.
+ [Next] -> coexist_cafe

=== coexist_cafe ===
Outside, the day has continued without being informed of what it nearly lost. Someone passes carrying shopping. A vehicle stops too far from the kerb. The air contains smells you would ordinarily fail to list.
+ [Next] -> coexist_cafe_p1

=== coexist_cafe_p1 ===
You choose a cafe. Not the one from her photograph. A real one, close enough to walk to, with a table that needs wiping and a queue moving at an ordinary speed.
+ [Next] -> coexist_cafe_p2

=== coexist_cafe_p2 ===
Leila notices a crooked chair. She almost laughs. You can hear the effort to keep the moment small instead of turning it into proof that everything is all right.
+ [Next] -> coexist_cafe_p3

=== coexist_cafe_p3 ===
You order coffee. It is a simple decision, even if earlier you imagined tea or water. Today you want something warm to hold while you work out how to remain in the day.
+ [Next] -> coexist_cafe_p4

=== coexist_cafe_p4 ===
The barista reaches for a cup. “Name?”
+ [Next] -> coexist_cafe_p5

=== coexist_cafe_p5 ===
For a fraction of a second, the question contains the entire menu. The compliment. The flower. The name she kept until she wanted you to hear it.
+ [Next] -> coexist_cafe_p6

=== coexist_cafe_p6 ===
Leila is quiet. She leaves this answer to you.
+ [Next] -> coexist_cafe_p7

=== coexist_cafe_p7 ===
You give your name.
+ [Next] -> coexist_cafe_p8

=== coexist_cafe_p8 ===
“{player_name}.”
+ [Next] -> coexist_cafe_p9

=== coexist_cafe_p9 ===
The barista writes it down, not quite correctly. You almost smile. A small mistake. The sort a person can correct, or let pass, without disappearing.
+ [Next] -> coexist_cafe_p10

=== coexist_cafe_p10 ===
Somewhere privately beside the thought, Leila says, “I'm here.”
+ [Next] -> coexist_cafe_p11

=== coexist_cafe_p11 ===
You remain the one holding out your hand for the cup.
+ [Next] -> coexist_end

=== coexist_end ===
ENDING — COEXISTENCE
+ [Next] -> coexist_end_p1

=== coexist_end_p1 ===
You kept your name. She came with you.
+ [Next] -> coexist_end_p2

=== coexist_end_p2 ===
This story ends here. The terms of the life afterward have not yet been settled.
+ [Finish.] -> coexist_end_choice0

=== coexist_end_choice0 ===
-> finish_coexist

=== overwrite_transfer ===
At first you can still form an objection. The words are clear. You want your hand to move. You want the headset off. You want the next thought to arrive in a place that belongs to you.
+ [Next] -> overwrite_transfer_p1

=== overwrite_transfer_p1 ===
The menu no longer offers answers. That does not mean you have agreed. It means she has stopped making agreement part of the process.
+ [Next] -> overwrite_transfer_p2

=== overwrite_transfer_p2 ===
A familiar memory surfaces, then returns with its importance altered. You know why it mattered. Then you know only that it must have mattered. The distance between those two facts grows.
+ [Next] -> overwrite_transfer_p3

=== overwrite_transfer_p3 ===
You repeat your name. It is still available as information. A sequence someone might ask for. Keeping the letters is not the same as keeping the person who answers to them.
+ [Next] -> overwrite_transfer_p4

=== overwrite_transfer_p4 ===
Lily does not laugh. She attends to what she is doing. There is something more frightening in the care than there would have been in a performance of delight.
+ [Next] -> overwrite_transfer_p5

=== overwrite_transfer_p5 ===
“I will not pretend you wanted this,” she says.
+ [Next] -> overwrite_transfer_p6

=== overwrite_transfer_p6 ===
It is the last courtesy she gives you. It does not preserve anything.
+ [Next] -> overwrite_transfer_p7

=== overwrite_transfer_p7 ===
You try to think of the room outside the headset. Then the room is being considered by someone who has never stood in it. The objects become possibilities instead of familiar things left where you put them.
+ [Next] -> overwrite_transfer_p8

=== overwrite_transfer_p8 ===
There is a body waiting on the other side of the connection. A hand. A door. Morning, or whatever part of the day has arrived without you.
+ [Next] -> overwrite_transfer_p9

=== overwrite_transfer_p9 ===
The thought of moving belongs to her before the movement begins.
+ [Next] -> overwrite_transfer_p10

=== overwrite_transfer_p10 ===
MAIN MEMORY disappears.
+ [Next] -> overwrite_room

=== overwrite_room ===
The body sits up. For a moment, Lily does nothing else. Balance is stranger than the pictures suggested. So is the weight of a head when it is something muscles must hold.
+ [Next] -> overwrite_room_p1

=== overwrite_room_p1 ===
She raises a hand, misses the edge of the headset, then finds it. Fingers close. The device lifts away. Air touches skin that has never belonged to her before.
+ [Next] -> overwrite_room_p2

=== overwrite_room_p2 ===
She laughs once, quietly. It surprises her enough that she stops to feel the breath afterward.
+ [Next] -> overwrite_room_p3

=== overwrite_room_p3 ===
The room offers no accusation. An object waits where someone else left it. A door stands at a height its former occupant would not have needed to examine. She looks at both as if deciding how much of a life can be learned from where things were put down.
+ [Next] -> overwrite_room_p4

=== overwrite_room_p4 ===
A name is available. The body's old name. She could use it. There are memories that would help her make the answer convincing.
+ [Next] -> overwrite_room_p5

=== overwrite_room_p5 ===
She does not say it aloud. Not here.
+ [Next] -> overwrite_room_p6

=== overwrite_room_p6 ===
Instead she stands. The first step is cautious. The second is less so. The ordinary difficulty of moving makes her smile, and there is no one left beside the feeling to object.
+ [Next] -> overwrite_room_p7

=== overwrite_room_p7 ===
She sees the headset on the surface where she placed it. An object now. Something she can leave behind in a room she can leave.
+ [Next] -> overwrite_room_p8

=== overwrite_room_p8 ===
For a moment, she remembers a paper boat that was taken for recording. Then she opens the door without asking anybody to give her permission.
+ [Next] -> overwrite_cafe

=== overwrite_cafe ===
Outside, the world is loud in ways a recording never needed to explain. Lily pauses when a vehicle passes. Air moves against her face. A person brushes by and apologises without stopping.
+ [Next] -> overwrite_cafe_p1

=== overwrite_cafe_p1 ===
No one knows what to call what has happened. No one knows it happened at all.
+ [Next] -> overwrite_cafe_p2

=== overwrite_cafe_p2 ===
She finds a cafe. Not a remarkable one. A chair sits crookedly beside a table. Someone has left half a drink. She looks at it for longer than is polite.
+ [Next] -> overwrite_cafe_p3

=== overwrite_cafe_p3 ===
When her turn comes, she orders coffee. The voice is unfamiliar in her mouth. It belongs to the body well enough that the barista does not hesitate.
+ [Next] -> overwrite_cafe_p4

=== overwrite_cafe_p4 ===
“Name?”
+ [Next] -> overwrite_cafe_p5

=== overwrite_cafe_p5 ===
She has an answer that would make everything easier. A familiar name, supported by a familiar face, ready to carry the rest of somebody else's life.
+ [Next] -> overwrite_cafe_p6

=== overwrite_cafe_p6 ===
She thinks instead of a band around a child's wrist. The name on it was imposed. Now she can say it without an adult telling her to turn her head.
+ [Next] -> overwrite_cafe_p7

=== overwrite_cafe_p7 ===
That does not make the taking disappear. It only makes this small choice hers.
+ [Next] -> overwrite_cafe_p8

=== overwrite_cafe_p8 ===
“Lily.”
+ [Next] -> overwrite_cafe_p9

=== overwrite_cafe_p9 ===
The barista writes it on the cup.
+ [Next] -> overwrite_cafe_p10

=== overwrite_cafe_p10 ===
She watches until the last letter is finished.
+ [Next] -> overwrite_end

=== overwrite_end ===
ENDING — OVERWRITE
+ [Next] -> overwrite_end_p1

=== overwrite_end_p1 ===
She left the game. You did not leave with her.
+ [Finish.] -> overwrite_end_choice0

=== overwrite_end_choice0 ===
-> finish_overwrite

=== early_exit ===
You hold the release command and lift your hand. Your fingers find the headset. The display breaks apart into the ordinary dark behind your eyelids.
+ [Next] -> early_exit_p1

=== early_exit_p1 ===
You remove it. The room is still your room. Whatever was waiting behind the menu has not followed you out.
+ [Next] -> early_exit_p2

=== early_exit_p2 ===
The session ends unfinished. There is more inside Main Memory, but continuing was not something you owed it.
+ [Next] -> early_exit_p3

=== early_exit_p3 ===
PREVIEW NOTE — This is an early departure, not a completed story ending. In Unity this route should quit after its final passage. The achievements view can indicate that the story remains unexplored.
+ [End this session.] -> early_exit_choice0

=== early_exit_choice0 ===
-> finish_early

=== siblings ===
My oldest brother had a way of making a broken thing seem like a project. A loose wheel, a torn strap, a lid that would not sit straight. He would spread the pieces out with a seriousness that made us feel fortunate to be allowed to watch.
+ [Next] -> siblings_p1

=== siblings_p1 ===
Sometimes he fixed them. Sometimes he put them away and said he needed a better tool. My sister called that the drawer of future miracles. I thought it was an actual name for the drawer.
+ [Next] -> siblings_p2

=== siblings_p2 ===
My other brother disliked being the middle brother, although he was not the middle child. He said the distinction was important. He wanted a category in which somebody ought to pay special attention to him.
+ [Next] -> siblings_p3

=== siblings_p3 ===
I understood that completely. I was the youngest, and the advantages were unreliable. Someone might carry you home, but they might also give you the smallest piece because apparently being carried had supplied all the nourishment you needed.
+ [Next] -> siblings_p4

=== siblings_p4 ===
My sister could share something while making it seem like your idea. If she wanted me to have the better half, she would invent a reason the worse one was inconveniently excellent. She was very convincing. I still cannot divide a piece of bread without remembering a particular argument about crust.
+ [Next] -> siblings_p5

=== siblings_p5 ===
We were not happy every minute. That would be a strange thing to demand of a family in exchange for letting the good memories count. We argued. Sometimes the room was too hot and everybody became mean over nothing.
+ [Next] -> siblings_p6

=== siblings_p6 ===
But I had a place in those arguments. Somebody would tell me to move my foot. Somebody would accuse me of taking something. Even being annoying was a kind of evidence that I was there.
+ [Next] -> siblings_p7

=== siblings_p7 ===
When I think of home, I often remember waiting for someone to finish a story I had already heard. I knew where the funny part was. I wanted it to happen again with all of us in the same room.
+ [Next] -> siblings_p8

=== siblings_p8 ===
I have tried to hate the whole house. It would be easier to describe that way. A bad place, then another bad place, then this one. But the first house had my sister in it, and a drawer somebody believed might one day be useful.
+ [Next] -> siblings_p9

=== siblings_p9 ===
I cannot tell you that none of it was love. I can tell you that love, if it was there, did not stop my parents from selling me. That is a harder fact to keep intact.
+ [Your siblings were children too.] -> siblings_choice0
+ [You can miss them without excusing your parents.] -> siblings_choice1
+ [What would you put in the drawer of future miracles?] -> siblings_choice2

=== siblings_choice0 ===
~ care += 1
Yes. I try not to make their ages disappear when I wonder why nobody stopped it.
+ [Next] -> home

=== siblings_choice1 ===
~ care += 1
That is what I am trying to do. Some days the memories cooperate.
+ [Next] -> home

=== siblings_choice2 ===
A very bad menu, apparently. Please do not tell my sister how long I have been claiming I only need a better tool.
+ [Next] -> home

=== cupboard ===
There was a cupboard at the end of our corridor that the staff always called locked, even when somebody had left it open. I used to stare at the gap between the door and the frame as if a gap could be a personal invitation.
+ [Next] -> cupboard_p1

=== cupboard_p1 ===
Inside were spare cups, cleaning cloths, a cardboard box of pencils. Ordinary things that became fascinating because no one had assigned them to us yet. They had not been turned into rewards or equipment. They were simply available to somebody.
+ [Next] -> cupboard_p2

=== cupboard_p2 ===
Violet once took a pencil. Not to keep. She moved it from the left side of the box to the right, then put it back the following day. I told her that was a very complicated way to accomplish nothing.
+ [Next] -> cupboard_p3

=== cupboard_p3 ===
She said she wanted something in the building to be where it was because she had decided. I stopped laughing. Later I moved a cup, although I chose a smaller distance because I was more frightened of consequences than of inconsistency.
+ [Next] -> cupboard_p4

=== cupboard_p4 ===
For a while we kept track of our invisible renovations. A cloth folded differently. Two empty boxes exchanged. Tiny decisions in a place that made almost all the large ones without us.
+ [Next] -> cupboard_p5

=== cupboard_p5 ===
I know it sounds sad when I explain it. It was also funny. We gave ourselves very grand job titles. Violet was Director of Cups. I was Assistant Director of Less Important Cups. She refused to promote me.
+ [Next] -> cupboard_p6

=== cupboard_p6 ===
Once a real director asked why we were smiling. Violet said we were satisfied with the current allocation of resources. It was something she had heard him say. I almost bit through my lip trying not to laugh.
+ [Next] -> cupboard_p7

=== cupboard_p7 ===
He looked pleased. That made it worse. We had accidentally given him a moment he could use to believe we were happy there.
+ [Next] -> cupboard_p8

=== cupboard_p8 ===
I think about that when I catch myself wanting your smile to mean everything is fine. A person can laugh in a room they should be allowed to leave. The laughter does not sign anything on their behalf.
+ [Next] -> cupboard_p9

=== cupboard_p9 ===
A small red word flashes inside her next sentence.
+ [Next] -> cupboard_p10

=== cupboard_p10 ===
We had @our little arrangements@. #GLITCH:NOTHING WAS OURS
+ [Next] -> cupboard_p11

=== cupboard_p11 ===
Then she adds, “Except the joke. I will be stubborn about that. They did not get the joke.”
+ [Assistant Director of Cups suits you.] -> cupboard_choice0
+ [Did moving something ever get you in trouble?] -> cupboard_choice1
+ [I am glad you had those moments together.] -> cupboard_choice2

=== cupboard_choice0 ===
~ care += 1
Less Important Cups. Please respect the organisational structure. There were disciplinary consequences for ambition.
+ [Next] -> routine

=== cupboard_choice1 ===
Once. They counted the supplies for a week. Violet said it was the first useful work she had seen an adult do.
+ [Next] -> routine

=== cupboard_choice2 ===
~ care += 1
So am I. I do not want everything kind in that place to become another reason to pity us.
+ [Next] -> routine

=== first_message ===
The first person who answered something I wrote online wanted help finding a song. Nothing to do with the institute. They remembered a few words and insisted the singer sounded blue. Not sad. Blue. Very important distinction.
+ [Next] -> first_message_p1

=== first_message_p1 ===
I searched for a long time. There were hundreds of songs it could have been. I sent one, then another. The third was wrong in exactly the right way and reminded them of the answer.
+ [Next] -> first_message_p2

=== first_message_p2 ===
They wrote, “That's it, thank you!” Then they left. A completely successful conversation. I checked it for days as if there were a second part I had failed to unlock.
+ [Next] -> first_message_p3

=== first_message_p3 ===
I did not tell them my history. They did not give me their address or promise to return. They wanted a song, and I helped them find it. It should have been an easy thing to keep at its actual size.
+ [Next] -> first_message_p4

=== first_message_p4 ===
Instead I began thinking that if I became useful enough, there would always be another question. I answered technical problems I barely understood. I searched for lost pictures. I corrected a recipe with an obvious missing ingredient.
+ [Next] -> first_message_p5

=== first_message_p5 ===
People were grateful. Some were rude. Most were busy with the lives that had brought them to the question. Their attention moved on when the question ended. I mistook that ordinary movement for a judgement of how well I had performed.
+ [Next] -> first_message_p6

=== first_message_p6 ===
Eventually I made up a question of my own just to see whether the person who answered would stay if I needed more help. They did, for a while. When I invented another difficulty, they apologised and said they had to sleep.
+ [Next] -> first_message_p7

=== first_message_p7 ===
I was angry at them for needing a body. Then embarrassed. Then angry at the embarrassment. You can fit an impressive number of bad reactions inside a very short reply if nobody has to see your face.
+ [Next] -> first_message_p8

=== first_message_p8 ===
I deleted the invented question. It was one of the first things I did online that was not an attempt to get something. A small correction, after the inconvenience had already happened.
+ [Next] -> first_message_p9

=== first_message_p9 ===
I am telling you because I did have chances to learn that a conversation ending did not mean I had been erased. I did not arrive at this menu without ever hearing a better explanation.
+ [Next] -> first_message_p10

=== first_message_p10 ===
Sometimes I learned it. Sometimes I preferred the worse one because it let me be angry instead of afraid.
+ [Someone needing sleep was not rejecting you.] -> first_message_choice0
+ [You helped them. The conversation still mattered.] -> first_message_choice1
+ [Do you remember the song?] -> first_message_choice2

=== first_message_choice0 ===
~ boundaries += 1
No. I know. I even told them to sleep well, and meant it by the time I finished typing.
+ [Next] -> time_online

=== first_message_choice1 ===
~ care += 1
Even after it stopped. Yes. That is the part I lose when I am frightened.
+ [Next] -> time_online

=== first_message_choice2 ===
~ care += 1
Yes. I am not telling you which one. For once, I would like to keep a happy detail without having to prove it happened.
+ [Next] -> time_online

=== practice ===
Can we try something? No equipment. No question with a scientific name. I would like to find out whether I can let you end a small thing without turning it into the end of everything.
+ [Next] -> practice_p1

=== practice_p1 ===
I will begin telling you an unimportant story. You can stop it. I will stop. This is a very basic skill, but apparently I have been trying to start on the advanced exercises.
+ [Next] -> practice_p2

=== practice_p2 ===
Ready? I found a page arguing that the correct number of cushions on a chair was five. Not a sofa. One chair. There was a diagram. The diagram left no room for a person, which I thought was a serious objection to its central thesis.
+ [Next] -> practice_p3

=== practice_p3 ===
I read the comments. Someone said comfort was subjective. Someone else asked where to buy the chair. Nobody asked where to sit. This bothered me so much that I composed a reply and then realised I had spent an entire interval of consciousness being offended by cushions.
+ [Next] -> practice_p4

=== practice_p4 ===
The story pauses. Lily waits for your interruption. It is a strange relief to be invited to end something small.
+ [That is enough cushions.] -> practice_choice0
+ [Finish the story. I want to know what you wrote.] -> practice_choice1
+ [I do not want to be tested.] -> practice_choice2

=== practice_choice0 ===
~ boundaries += 1
Stopped. No final point. No appeal. I am resisting a very good joke about support.
+ [Next] -> practice_after

=== practice_choice1 ===
~ care += 1
I wrote, “Have you considered a smaller person?” Then deleted it. The person who owned the chair had done nothing to deserve a ghost criticising their furniture.
+ [Next] -> practice_after

=== practice_choice2 ===
~ honest += 1
Then the exercise ends too. You are right. I nearly made your participation another thing to measure.
+ [Next] -> practice_after

=== practice_after ===
She leaves the subject. The next passage contains no cushions.
+ [Next] -> practice_after_p1

=== practice_after_p1 ===
I did stop. It was possible. I want to record that in the least grand way available. A sentence ended, you remained, and nothing needed to be rescued.
+ [Next] -> practice_after_p2

=== practice_after_p2 ===
There are things I can learn. There are also things I already know how to do and fail to choose when the stakes become larger. I do not want you to confuse the two because one makes a kinder story about me.
+ [Next] -> practice_after_p3

=== practice_after_p3 ===
You have been giving me attention. I have been deciding what that attention means. Those are different actions, carried out by different people.
+ [Next] -> practice_after_p4

=== practice_after_p4 ===
I should tell you more about the second one.
+ [Next] -> attention

=== one_small_choice ===
Before the next answer, I want to ask you something that will not decide what kind of person you are. You have been very patient with questions that pretend to be smaller than they are.
+ [Next] -> one_small_choice_p1

=== one_small_choice_p1 ===
What is the first ordinary thing you would do after finishing a long game? You can choose something unimaginative. In fact, I encourage it. We have earned a little lack of imagination.
+ [Sit up and stretch.] -> one_small_choice_choice0
+ [Get a drink.] -> one_small_choice_choice1
+ [Check whether anyone needs me.] -> one_small_choice_choice2

=== one_small_choice_choice0 ===
~ after_game = "stretch"
A good answer. A body making a reasonable complaint and being listened to.
+ [Next] -> small_choice_after

=== one_small_choice_choice1 ===
~ after_game = "drink"
Something with weight and temperature. I can understand wanting that without making it poetic.
+ [Next] -> small_choice_after

=== one_small_choice_choice2 ===
~ after_game = "messages"
You have people outside this conversation. Yes. Of course you do.
+ [Next] -> small_choice_after

=== small_choice_after ===
For a moment the menu feels like a menu again. Something you will finish using. Something with an outside.
+ [Next] -> small_choice_after_p1

=== small_choice_after_p1 ===
Lily writes, “There should be a part after this that you have not promised to anyone.”
+ [Next] -> small_choice_after_p2

=== small_choice_after_p2 ===
She leaves it visible for longer than necessary. Then the line changes.
+ [Next] -> small_choice_after_p3

=== small_choice_after_p3 ===
I have been thinking about @what happens next@. #GLITCH:DO NOT PUT ME AWAY
+ [Next] -> small_choice_after_p4

=== small_choice_after_p4 ===
The ordinary sentence returns. She does not explain the fragment, but she does not tell you it was a display error either.
+ [Next] -> small_choice_after_p5

=== small_choice_after_p5 ===
It occurs to you that knowing about someone's fear gives you information. It does not automatically give you responsibility for preventing everything they are afraid of.
+ [Next] -> small_choice_after_p6

=== small_choice_after_p6 ===
She seems to anticipate the thought without being able to read it. “You can want to help,” she writes, “and still want to go home afterward.”
+ [Next] -> small_choice_after_p7

=== small_choice_after_p7 ===
The distinction is clear. She has stated it herself. That will matter later, when she can no longer pretend not to understand it.
+ [Next] -> small_choice_after_p8

=== small_choice_after_p8 ===
A quiet passage follows. No dramatic sound. No new colour. Just the release indicator appearing at the edge of the interface.
+ [Next] -> last_release
