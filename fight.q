/
\l run.q

inventory::([sym:(`r`s)]item:("Rusty Sword";"Smoke Bomb"); useable:(`no`yes)) / this table is the player's inventory. We start with these items. 
aaa:([sym:(`o;`h;`k;`b;`d;`a;`g;`p;`m;`c)]item:("Oaken Shield";"Holy Amulet of Protection";"Key";"Boots of Alacrity";"Dungeon Map";"Apple";"Golden Apple";"Potion";"Flaming Sword of Archangel Michael";"Suit of Crystal Armor")) / create itemlist with individual keys
aaa: update useable: (`no`no`no`no`yes`yes`yes`yes`no`no) from aaa 
itemslist:: aaa


aaa: select from itemslist where sym in `o`a`p
bbb: inventory
ccc: bbb , aaa
inventory::ccc


wincounter::0
losecounter::0

health::3
maxhealth::3
grue::1b
system"S ",string"j"$.z.t / makes a new seed for the random number generator based on the current time.

/delete above items when testing is done
\

foes::([monster: `grue`skeleton] hp:(20;4); damage:(9;4); encountermessage:("IT'S THE GRUE!!";"A skeleton warrior blocks your path!"); attackmessage: ("The grue slashes into you with its claws!";"The skeleton warrior hits!"); losemessage: ("The grue tears you apart into bloody confetti with its monstrous teeth.";"The skeleton warrior's sword lodged in your gut, you bleed out and die."); winmessage: ("The grue falls to its knees and lets out an earth-shaking growl before expiring.";"You smash the skeleton warrior into bits!"))
gruelocation:: first 1?((1+til 25) except 23) / sets grue's initial location randomly, anywhere except starting room
skeletonlocations:: -3?(((1+til 25) except 23) except gruelocation) / sets random location for three skeletons, anywhere except starting room or grue's location
gruesighted:: 0 / initial value, later will show where grue encounters happened



prepared::0b

fight: { [foe]

        preparefight: { [foe]
        /preparing variables
        losemessage:: exec losemessage from foes where monster=foe; /gets losemessage from foe table
        winmessage:: exec winmessage from foes where monster=foe; /gets winmessage from foe table
        foeattackmessage:: exec attackmessage from foes where monster=foe; /gets attackmessage from foe tabl
        foehp:: first exec hp from foes where monster=foe; /gets hp from foe table
        foedmg:: first exec damage from foes where monster=foe; /gets dmg from foe table
        hitmsg:: $[`m in key inventory; "You smite the " , (string foe) , "!"; "You hit the " , (string foe) , "!"]; /gets hit message. If you have michael's sword it's fancier.
        fleesuccess::0b; /if flee[] sets this to 1, you escape
        prepared::1b; /tells us these variables have been prepared

        /health::3 /for testing, delete later

        show exec encountermessage from foes where monster=foe


       };

    if[prepared~0b; preparefight[foe]];
    
    $[health <= maxhealth%3; show "You are badly wounded."; health <= 2*maxhealth%3; show "You are wounded."];
    /show health; / delete after testing
    show "What will you do? (a) attack, (u) use item, or (f) flee?";
    prompt: read0 0; /gets user input
    prompt: lower prompt[0];
    /prompt: "u"; /test code, delete later; uncomment the above after testing

    if[prompt~"a"; attack[]];
    if[prompt~"u"; usefunction[`fight]];
    if[prompt~"f"; prepared::0b; flee[]];

    if[fleesuccess~1b; if[`b in key inventory; :show "You flee like the wind." ]; :show "You manage to escape."];

    /win
    if[foehp<=0; if[foe~`grue; grue::0b; gruelocation::0]; prepared::0b; skeletonlocations:: skeletonlocations except room; :show (first winmessage)]; /if your enemy runs out of health
   
    /lose
    foeattack[foe];
    if[ health<=0; end::1b; prepared::0b; :show (first losemessage)]; 

    fight[foe]

 }

attack: {

    show hitmsg;
    foehp:: first foehp - $[`m in key inventory; 5 + 1 ? 10; 1  +1 ? 3]


 }

foeattack: { [foe]

    defend: 1+1?4; /number on 4-sided die determines if attack is blocked by given item of armor
    if[(first defend)~1; if[`h in key inventory; :show "A mystical glow from the holy amulet of protection deflects the " , (string foe) , "'s attack!"]];
    if[(first defend)~2; if[`o in key inventory; :show "You block the " , (string foe) , "'s attack with your shield!"]];
    if[(first defend)~3; if[`h in key inventory; :show "The " , (string foe) , "'s attack glances off your crystal armour!"]];
    show foeattackmessage;
    health:: first health - 1 + 1 ? foedmg; 
 }

flee: { [smokebombornot]

    show "Flee in which direction?";
    show doors[room];
    currentroom: room;
    input: read0 0;
    input: lower first input;

    fleecheck: 1+1?4;
    if[smokebombornot~`smokebomb; fleecheck: 4];
    if[`b in key inventory; fleecheck: 4];
    if[(first fleecheck)~1; :show "You're blocked from escaping!"];

    if[input in ("n";"e";"s";"w"); room:: move[room; input]];
    if[not room~currentroom; fleesuccess::1b]

 }

/
/delete following after testing
fight[`skeleton] 
/do[1000;fight[`skeleton]]
show wincounter 
show losecounter
