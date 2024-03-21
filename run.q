
// basic multiple choice function. Reads a file, known as a "room" (though this may be something other than an 
// actual room in the game) containing flavour text and up to ten prompts.
// Takes input from user in terminal in the form of a number from 1 to 10, which corresponds to the prompts. 
// The prompt may lead to changing variables or performing other actions; it always selects a room, potentially the same room, for 
// the next round of the game.



// some test rooms to get started. 


.rooms.a: {

 flav:: "You're in a room. It's square and boring.";
 p1:: "West";
 p2:: "East"

 }


.rooms.b: {

 flav:: "You're in another room. It's also square and boring.";
 p1:: "West";
 p2:: "East"

 }


flavour: {[roomID]

 if[roomID~18; :"Cobwebs line every last corner of this room."];
 if[roomID~22; :"A fountain gives this room a refreshing sound."];
 if[roomID~23; :"You are in that accursed room in which you were unceremoniously dumped. There is a trapdoor in the ceiling which would take a key if you had one."];
 if[roomID~24; :"This room is dark and grey."];

 
 }




prompter: {

 show flav;
 show "1: " , p1;
 show "2: " , p2;
 input: read0 0;
 if[input~enlist "1"; .rooms.b[]]; /our input comes in as a single item list.
 prompter[]
 
 }

// starting up the game

\l map.q
\l items.q
.rooms.a[]
prompter[]
