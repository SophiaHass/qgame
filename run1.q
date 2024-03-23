

\l map.q
\l items.q
\l flavtbl.q
\l system.q
system"S ",string"j"$.z.t / makes a new seed for the random number generator based on the current time.

room:: 23
health:: 3
maxhealth:: 3
end:: 0 / a boolean determining if the game is over or not

prompter: {

 if[end~1;:"THE END"];
 show gameflavtbl[room];
 items[]
 show doors[room];
 $[health < 2*maxhealth%3; show "You are wounded."; health < maxhealth%3; show "You are badly wounded."];
 input: read0 0;
 input: input[0]; / our input comes in as a single item list
 if[input in ("N";"E";"S";"W"); room:: map[room; input]];
 if[input~"I"; show inventory];
 if[input~"Q"; quitprompt[]];
 prompter[]
 
 }

// starting up the game

prompter[]
