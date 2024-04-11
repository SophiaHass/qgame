
inventory::([sym:(`r`s)]item:("Rusty Sword";"Smoke Bomb"); useable:(`no`yes)) / this table is the player's inventory. We start with these items. 

/preparing the items table
itemslist::([sym:(`o;`h;`k;`b;`d;`a;`g;`p;`m;`c)]item:("Oaken Shield";"Holy Amulet of Protection";"Key";"Boots of Alacrity";"Dungeon Map";"Apple";"Golden Apple";"Potion";"Flaming Sword of Archangel Michael";"Suit of Crystal Armor")) / create itemlist with individual keys
aaa: update loc: (count itemslist)?(1+til 25) from itemslist / adds randomised room numbers to each item. you can have multiple items in a room.
aaa: update useable: (`no`no`no`no`no`yes`yes`yes`no`no) from aaa 
/aaa: update loc:23 from aaa where sym in (`k) / testing code, gives you items in starter room. comment out later.
itemslist:: aaa / yes, I have no idea why this is necessary to do this extra step but it is. Forgive me for I have wavered in my faith, but I keep thinking that the global variable functionality of q is super awkward and buggy

/language stuff
itemsdef:: ("Holy Amulet of Protection";"Boots of Alacrity";"Flaming Sword of Archangel Michael") / items that take the definite article
an:: ("Oaken Shield";"Apple") / singular items that start with a vowel

/a big juicy function: items shows the items in current room in nice text, e.g. "There is an Oaken Shield here."
itemreader: {        
    if[room in exec loc from itemslist; 

        /item lists:
        roomitems: exec item from itemslist where loc=room; /lists the items in the current room. exec makes a list, this gives a diff result to selecting one column! I wasted like two hours because I didn't realise this.
        middleroomitems: `$ roomitems; middleroomitems: middleroomitems except first middleroomitems; middleroomitems: middleroomitems except last middleroomitems; middleroomitems: string middleroomitems; / gets us the room items except the first and last. in order to get "except" to work, we cast to symbol and later turn it back to strings

        /snippets (what I call pieces of the text):
        snippet1: $[(first roomitems) in itemsdef;"the";"a"] , $[(first roomitems) in an; "n "; " "] , first roomitems; /text about first item 
        middlesnipper: {[itemz] ", " , $[itemz in itemsdef;"the";"a"] , $[itemz in an; "n "; " "] , itemz }; /produces text about individual middle items
        /here comes some brute force code. don't judge me. (text about all middle items) / Note: copy and paste a few more of these if I make more items
        if[(count roomitems) >2; 
            middlesnippets: middlesnipper[middleroomitems[0]] , $[(count middleroomitems) > 1; middlesnipper[middleroomitems[1]]; ""] , $[(count middleroomitems) > 2; middlesnipper[middleroomitems[2]]; ""] , $[(count middleroomitems) > 3; middlesnipper[middleroomitems[3]]; ""] , $[(count middleroomitems) > 4; middlesnipper[middleroomitems[4]]; ""] , $[(count middleroomitems) > 5; middlesnipper[middleroomitems[5]]; ""] , $[(count middleroomitems) > 6; middlesnipper[middleroomitems[6]]; ""] , $[(count middleroomitems) > 7; middlesnipper[middleroomitems[7]]; ""] , $[(count middleroomitems) > 8; middlesnipper[middleroomitems[8]]; ""]]; 
        lastsnippet: " and " , $[(last roomitems) in itemsdef;"the";"a"] , $[(last roomitems) in an; "n "; " "] , (last roomitems) , " "; / text about last item

        /putting it all together:
        show "There " , $[roomitems[0]~"Boots of Alacrity";"are ";"is "] , snippet1 , $[(count roomitems) > 2; middlesnippets; "" ] , $[(count roomitems) > 1; lastsnippet; " "] , "here." /puts it all together and shows it on the terminal. phew
        
    ]
 }


/ what happens when you pick items up (you can only pick up all items in the room)
pickup: {

        items: exec item from itemslist where loc=room; / a list of items in the current room
        
        /function to show the text that appears when you pick up a given item
        pickuptext:{if[x in ("Dungeon Map";"Apple";"Golden Apple";"Potion";"Key"); show "You pick up the " , x , "."];
            if[x in ("Holy Amulet of Protection";"Boots of Alacrity";"Suit of Crystal Armor"); show "You don the " , x , "."];
            if[x ~ "Oaken Shield"; show "You take up the " , x , "."];
            if[x ~ "Flaming Sword of Archangel Michael"; show "You toss your rusty sword aside and take up the " , x , ". You are overcome with a sensation of holy might."]; 
        };

        / if picking up sword of michael, delete rusty sword
        if["Flaming Sword of Archangel Michael" in items; aaa: delete from inventory where item in ("Rusty Sword";"I don't know why this has to be here but the code doesn't work otherwise"); inventory:: aaa];

        / if boots of alacrity, slow down grue relative to you

        if["Boots of Alacrity" in items; gruespeed::3];

        / adding items to inventory and then deleting from itemslist
        pickuptext each items;
        aaa: select sym, item, useable from itemslist where item in items; / making a list of items to add
        aaa: `sym xkey aaa; /needs to be keyed to match (that took me like half a fucking hour to realise!)
        bbb: inventory, aaa; / appending items to inventory
        inventory:: bbb;
        ccc:delete from itemslist where item in items; / delete items from itemslist
        itemslist:: ccc

 }


/individual items, as they are used

apple: {
 
 show "You eat the apple. You feel a little stronger with something in your belly.";
 health:: health+1;
 maxhealth:: maxhealth+1
 
 }

golden: {

 show "You eat the golden apple. You feel warm and hale from head to toe.";
 health:: health+3;
 maxhealth:: maxhealth+3
 
 }

potion: {
 
 show "You drink the potion. You feel a warm glow spread through your body." , $[health <= maxhealth%3; " You feel much better.";health <= 2*maxhealth%3; " You feel better.";""];
 health:: maxhealth

 }

smokebomb: {

    show "You smash the Smoke Bomb on the ground! A thick cloud of smoke provides cover.";
    flee[`smokebomb]
 
 }

