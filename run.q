/
issues: 
not sure if skeleton disappears after i kill it, if it is always in the room if I flee and return; a couple of times after picking up items a skeleton fight was triggered?
... implement having a prompt as to whether you want to use the key. if you say no, it doesn't bother you next turn even though you're still in the room.
... implement fleeing from an encounter just by using a direction 
... perhaps make fleeing less likely to be successful (perhaps even making the boots of alacrity imperfect?)
\

\l map.q
\l items.q
\l flavtbl.q
\l system.q
\l fight.q

system"S ",string"j"$.z.t / makes a new seed for the random number generator based on the current time.
system "c 200 500"  / makes the terminal show longer lines 

room:: 23
health:: 3
maxhealth:: 3
grue:: 1b / whether the grue is still at large
end:: 0b / whether the game is over or not
turncounter:: 0 / keeps track of game turns, mostly for the sake of the grue
gruespeed:: 2 / every x turns, the grue moves towards you. Boots of alacrity slow the grue down, or rather, speed you up.

prompter: {

 turncounter:: turncounter + 1;
 if[((turncounter mod gruespeed)~0)and(grue); gruefinder[]]; /moves the grue towards the player every two turns. should I make it every three instead?
 /show "Grue Location:"; / testing code
 /show gruelocation; /testing code

 /stuff that gets shown before input
 if[end~1b;:"THE END"]; / if something in the previous round ended the game, we find out here.
 if[room in skeletonlocations; fight[`skeleton]];
 if[room~gruelocation; gruesighted:: room; fight[`grue]];
 if[room~23; if[`k in key inventory; :win[]]];
 if[end~1b;:"THE END"]; / ends the game if the fight kicks your ass
 show gameflavtbl[room];
 itemreader[];
 show doors[room];
 $[health <= maxhealth%3; show "You are badly wounded."; health <= 2*maxhealth%3; show "You are wounded."];
 
 /prompt for input
 input: read0 0;
 input: lower input[0];

 /process input
 if[input in ("n";"e";"s";"w"); if[room~move[room; input]; show "There's just a bare wall in that direction!"];room:: move[room; input]];
 if[input~"i"; show (exec sym from inventory)!(exec item from inventory)]; 
 if[input~"m"; map[]];
 if[input~"q"; quitprompt[]];
 prompter[]
 
 }

// starting up the game

prompter[]
