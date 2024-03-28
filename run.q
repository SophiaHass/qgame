
\l map.q
\l items.q
\l flavtbl.q
\l system.q

system"S ",string"j"$.z.t / makes a new seed for the random number generator based on the current time.
system "c 200 500"  / makes the terminal show longer lines 

room:: 23
health:: 3
maxhealth:: 3
end:: 0 / a boolean determining if the game is over or not

prompter: {

 if[end~1;:"THE END"];
 show gameflavtbl[room];
 itemreader[];
 show doors[room];
 $[health <= maxhealth%3; show "You are badly wounded."; health <= 2*maxhealth%3; show "You are wounded."];
 input: (read0 0)[0]; /prompt for input
 if[input in ("N";"E";"S";"W"); room:: map[room; input]];
 if[input~"I"; show inventory];
 if[input~"U"; pickup[]];
 if[input~"M"; if["Dungeon Map" in inventory; mapper[]];]
 if[input~"Q"; quitprompt[]];
 prompter[]
 
 }

// starting up the game

prompter[]
