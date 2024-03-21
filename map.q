
/


5 5 # 1+til 25 gives us our grid:

1  2  3  4  5 
6  7  8  9  10
11 12 13 14 15
16 17 18 19 20
21 22 23 24 25



\

// takes current room as a number, input as "E", "W", "N" or "S", and returns the number of the new room. If you would hit a wall, returns the current room.


testmap: {

    input: read0 0;
    engine.map [25; input[0]] / read0 0 gives us a single item list, so I'm taking the first item

 
 }

engine.map: { [currentr; input]

 /if number is on edge of grid, trying to go beyond the grid just returns the current room; e.g. you can't:

 if[(input~"N") and currentr in (1 2 3 4 5); :currentr];
 if[(input~"S") and currentr in (21 22 23 24 25); :currentr];
 if[(input~"E") and currentr in (1 6 11 16 21); :currentr];
 if[(input~"W") and currentr in (5 10 15 20 25); :currentr];

 / regular movement:

 if[input~"N"; output: currentr-5];
 if[input~"S"; output: currentr+5];
 if[input~"E"; output: currentr-1]; 
 if[input~"W"; output: currentr+1];

 output


 }