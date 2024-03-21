/ M: sword of Archangel Michael
/ C: suit of crystal armor
/ O: oaken shield
/ A: amulet of protection
/ K: key
/ B: boots of alacrity (you can always flee)
/ M: map
/ G: golden apple (doubles health)
/ S: smoke bomb (you start with one)
/ P: potion
/ R: rusty sword

inventory::(`r;`s)!("Rusty Sword";"Smoke Bomb")

itemslist::(`m;`c)!("Flaming Sword of Archangel Michael";"Suit of Crystal Armor")
itemsloc:: (value itemslist)!((count value itemslist) ? 1+til 25) / location of items by room number

items: {
 if[room in value itemsloc; show "item here"]

 
 }