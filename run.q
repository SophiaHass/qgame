
// basic multiple choice function. Reads a file, known as a "room" (though this may be something other than an 
// actual room in the game) containing flavour text and up to ten prompts.
// Takes input from user in terminal in the form of a number from 1 to 10, which corresponds to the prompts. 
// The prompt may lead to changing variables or performing other actions; it always selects a room, potentially the same room, for 
// the next round of the game.



flavtbl: (18 22)!("Cobwebs line every last corner of this room.";"A fountain gives this room a refreshing sound.")
flavtbl[23]: ("You are in that accursed room in which you were unceremoniously dumped.";"There is a trapdoor in the ceiling which would take a key if you had one.")
flavtbl[24]: "This room is dark and grey."


room:: 23
health:: 3
maxhealth:: 3

prompter: {

 show flavtbl[room];
 items[]
 show doors[room];
 input: read0 0;
 input: input[0]; / our input comes in as a single item list. This turns it into an atom. Is there a more direct way to do this?
 if[input in ("N"; "E"; "S"; "W"); room:: map[room; input]];
 if[input~"I"; show inventory];
 prompter[]
 
 }

// starting up the game

\l map.q
\l items.q
prompter[]
