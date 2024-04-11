
/

map:

1  2  3  4  5 
6  7  8  9  10
11 12 13 14 15
16 17 18 19 20
21 22 23 24 25

\

gridx:: 5 5 # 1+til 25 / when we index into this grid, we get rows by default, e.g. the x axis
gridy:: (gridx[;0];gridx[;1];gridx[;2];gridx[;3];gridx[;4]) / this gives us the columns, e.g. the y axis


gruefinder: {

    if[not (gruelocation~room);


        $[gruelocation in gridx[0]; gruex::gridx[0]; gruelocation in gridx[1]; gruex::gridx[1]; gruelocation in gridx[2]; gruex::gridx[2]; gruelocation in gridx[3]; gruex::gridx[3]; gruelocation in gridx[4]; gruex::gridx[4];]; / I brute forced it. Sue me. / This gets the row of the grid where the grue is.
        $[room in gridx[0]; youx::gridx[0]; room in gridx[1]; youx::gridx[1]; room in gridx[2]; youx::gridx[2]; room in gridx[3]; youx::gridx[3]; room in gridx[4]; youx::gridx[4];]; / This gets the row of the grid where the player is.

        $[gruelocation in gridy[0]; gruey::gridy[0]; gruelocation in gridy[1]; gruey::gridy[1]; gruelocation in gridy[2]; gruey::gridy[2]; gruelocation in gridy[3]; gruey::gridy[3]; gruelocation in gridy[4]; gruey::gridy[4];]; / This gets the column of the grid where the grue is.
        $[room in gridy[0]; youy::gridy[0]; room in gridy[1]; youy::gridy[1]; room in gridy[2]; youy::gridy[2]; room in gridy[3]; youy::gridy[3]; room in gridy[4]; youy::gridy[4];]; / This gets the column of the grid where the player is.


        gruedistancex: (gruex?gruelocation) - youx?room; /finds distance between grue and player in x direction
        gruedistancey: (gruey?gruelocation) - youy?room; /finds distance between grue and player in y direction
        $[(abs gruedistancex) >= (abs gruedistancey); $[gruedistancex < 0; gruelocation:: gruelocation+1; gruelocation:: gruelocation-1]; $[gruedistancey < 0; gruelocation:: gruey[((gruey?gruelocation)+1)]; gruelocation:: gruey[((gruey?gruelocation)-1)]] ];

    ]

 }

/ takes current room as a number, input as "E", "W", "N" or "S", and returns the number of the new room. If you would hit a wall, returns the current room.

move: { [currentr; input]

 / regular movement:
 / I could refactor this using the same gridx and gridy system as the gruefinder uses

 if[input~"n"; output: currentr-5];
 if[input~"s"; output: currentr+5];
 if[input~"e"; output: currentr+1]; 
 if[input~"w"; output: currentr-1];

 / if you hit a wall, just return the current room
 if[input~"w"; if[currentr in (1 6 11 16 21); :currentr]]; 
 if[input~"e"; if[currentr in (5 10 15 20 25); :currentr]];
 if[input~"n"; if[currentr in (1 2 3 4 5); :currentr]];
 if[input~"s"; if[currentr in (21 22 23 24 25); :currentr]];

 output

 }

/ takes current room as a number and returns which directions are valid to move in from there.
finddirect: { [currentr]

    directions: ("North";"East";"South";"West");
    directions: ` $ directions; / don't know how to keep them as separate items and not glue together in one string if I don't do this
    attempts: (move[currentr; "n"]; move[currentr; "e"]; move[currentr; "s"]; move[currentr; "w"]); / the function imagines going in each direction.
    newdirec: ();
    if[not attempts[0]~currentr; newdirec,: directions[0]]; / current room means the move function disallows movement that way. so if the attempt is not the current room, newdirec gets the direction
    if[not attempts[1]~currentr; newdirec,: directions[1]];
    if[not attempts[2]~currentr; newdirec,: directions[2]];
    if[not attempts[3]~currentr; newdirec,: directions[3]];
    string newdirec
 
 }

/ returns text saying there is a door to the north, east, west, etc.

doors: { [currentr]

 directions: finddirect[currentr];
 if[(count directions) ~ 4; :"There are doors to the North, East, South, and West."];
 if[(count directions) ~ 3; text: directions[0] , ", " , directions[1] , " and " , directions[2]];
 if[(count directions) ~ 2; text: directions[0] , " and " , directions[1]];

 "There are doors to the " , text , "."

 }

