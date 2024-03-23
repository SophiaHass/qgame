
inventory::(`r;`s)!("Rusty Sword";"Smoke Bomb")

itemslist::([sym:(`o;`h;`k;`b;`d;`a;`g;`p;`m;`c)]item:("Oaken Shield";"Holy Amulet of Protection";"Key";"Boots of Alacrity";"Dungeon Map";"Apple";"Golden Apple";"Potion";"Flaming Sword of Archangel Michael";"Suit of Crystal Armor"))
aaa: update loc: (count itemslist)?(1+til 25) from itemslist
itemslist:: aaa / yes, I have no idea why this is necessary to do this extra step but it is. Forgive me for I have
/wavered in my faith, but I keep thinking that the global variable functionality of q is super awkward and buggy

a:update loc:13 from itemslist where sym in (`h`k`g) /delete later
itemslist:: a / delete later
room::13 /delete this later!!!!!!

itemsdef:: ("Holy Amulet of Protection";"Boots of Alacrity";"Flaming Sword of Archangel Michael") / items that take the definite article
an:: ("Oaken Shield";"Apple") / singular items that start with a vowel
items: {        /shows the items in current room in nice text, e.g. "There is an Oaken Shield here."
 /if[room in select loc from itemslist; 

 /item lists:
 roomitems: exec item from itemslist where loc=room; /lists the items in the current room. exec makes a list, this gives a diff result to selecting one column! I wasted like two hours because I didn't realise this.
 middleroomitems: `$ roomitems; middleroomitems: middleroomitems except first middleroomitems; middleroomitems: middleroomitems except last middleroomitems; middleroomitems: string middleroomitems; / gets us the room items except the first and last. in order to get "except" to work, we cast to symbol and later turn it back to strings

 /snippets (what I call pieces of the text):
 snippet1: $[(first roomitems) in itemsdef;"the";"a"] , $[(first roomitems) in an; "n "; " "] , first roomitems; /text about first item 
 middlesnippets: {[itemz] ", " , $[itemz in itemsdef;"the";"a"] , $[itemz in an; "n "; " "] , itemz , ","}; /text about middle items
 lastsnippet: " and " , $[(last roomitems) in itemsdef;"the";"a"] , $[(last roomitems) in an; "n "; " "] , (last roomitems) , " "; / text about last item
 
 show middlesnippets/[middleroomitems]

 /putting it all together:
 show "There " , $[roomitems[0]~"Boots of Alacrity";"are ";"is "] , snippet1 , $[(count roomitems) > 2; middlesnippets[roomitems[1]]; "" ] , $[(count roomitems) > 1; lastsnippet; " "] , "here." /puts it all together and shows it on the terminal. phew
 
 /]
 }

items[]