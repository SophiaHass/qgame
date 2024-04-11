quitprompt: {

    show "Do you really want to quit? (Y/N)";
    prompt: read0 0;
    if[(lower prompt[0]) ~ "y"; end::1b]
 
 }

win: {

    a: key inventory;
    b: exec sym from a;
    c: b except `s`r`k;
    $[(count c)~0; :show "You scramble to fit the key into the keyhole. With a sigh of relief, you see that it turns. You escape with your life."; :show "You scramble to fit the key into the keyhole. With a sigh of relief, you see that it turns. You escape with your life, as well as a trinket or two for your time."]   
 
 }

/what happens when you press "U". First picks up item, then if no item is there, prompts for item choice and gives a particular effect when a given item is used
/these two functions work together.

usefunction:{ [fightornot]

    if[fightornot~`fight; if[(count select sym from inventory where useable = `yes)~0; :show "You don't have any items that you can actively use."]] 
    if[fightornot~`notfight; if[(count((exec sym from inventory where useable = `yes) except `s))~0; :show "You don't have any items that you can actively use here."]]
    show "Use which item?:";

    inventlist: select sym from inventory where useable = `yes;
    if[fightornot~`notfight; inventlist: delete from inventlist where sym = `s];
    show value each inventlist;

    prompt: read0 0;
    prompt: lower prompt[0];
    $[(` $ prompt) in inventlist; inventory:: delete from inventory where sym = ` $ prompt; :show "You don't have that item!"];
    if[prompt~"a"; apple[]];
    if[prompt~"g"; golden[]];
    if[prompt~"p"; potion[]];
    if[prompt~"s"; if[fightornot~`fight; smokebomb[]]];

 }

use: {

        $[room in exec loc from itemslist; pickup[]; usefunction[`notfight]] / runs pickup function if items are available; else, usefunction

 }

map: {

    mapinv: { 
        show "DUNGEON MAP";
        show "Despite its irregularities, the dungeon appears to form a rough grid. The mapmaker has taken advantage of this by numbering it in a logical progression from 1 to 25.";
        show "...";
        show 5 5 # 1+til 25;
        show "...";
        show "You are in room " , (string room) , ".";
        if[not gruesighted = 0; show "The grue was last sighted in room " , (string gruesighted) , "."];
        show "The exit is in room 23.";
        show "..."};

    $[`d in key inventory; mapinv[]; show "You don't have a map."];

 }