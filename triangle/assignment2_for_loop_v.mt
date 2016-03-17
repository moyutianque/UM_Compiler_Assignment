! java -classpath "c:\triangle" Triangle.Compiler assignment1.mt
! java -classpath "c:\triangle" TAM.Interpreter

let var DirectionFlag: Integer; !globel var
    var minimum: Integer
in
  begin
  DirectionFlag:=0;
  
let
  type Matrix1 ~ 
            record
               score: Integer, direction: Integer
            end;
            
  type Matrix ~
            record
               Y: array 10 of Matrix1
            end;
            
  var ScoreMatrix: array 10 of Matrix;
 
  type Line ~ 
            record
               length: Integer,
               content: array 10 of Char
            end;
            
  ! get the string from user          
  proc getline (var l: Line) ~
            let var c: Char in
            begin
            l.length := 0;
            get(var c);
            
            ! using ascii to control loop
            while (ord(c) \= 10)/\(ord(c) \= 13) do 
                begin
                l.content[l.length]:=c;
                ! putint(l.length);put(l.content[l.length]);
                get(var c);
                l.length := l.length + 1
                end;
            geteol()
            end;
            
  ! output the string inversed
  proc putreversedline (l: Line) ~
            let var i : Integer
            in
                begin
                i := l.length;
                while i > 0 do
                    begin
                    i := i-1;
                    put(l.content[i]);
                    put(' ')
                    end;
                puteol()
                end;
                                  

  func Sub (xi: Char, yj: Char) : Integer ~
            if(xi = yj) then 0
            else 2;
            
            
  proc min (var x: Integer,var y: Integer,var z: Integer) ~
            begin
                minimum := x;
                DirectionFlag := 1;
                if y<minimum then
                    begin minimum := y; DirectionFlag := 2 end else;
                if z<minimum then
                    begin minimum := z; DirectionFlag := 3 end else
                end;
                
    var lengthOfSolution: Integer;
    var print1st: array 10 of Char;
    var print2nd: array 10 of Char;
    var print3rd: array 10 of Char;
    var tmp: Integer;
    var min1: Integer; var min2: Integer; var min3: Integer;
    var m: Integer; var n:Integer;                     
    var line1: Line; !input string 1(row of the matrix)
    var line2: Line; !input string 2(column of  the matrix)
    var i: Integer;  !row variable
    var j: Integer   !column variable
    
in
    begin
        
        
        put('>'); !ask to input the first line
        getline(var line2);
        put('>'); !ask to input the second line
        getline(var line1);
        ! putreversedline (line2) ! test correct for output
        
        ! DYNAMIC PROGRAMMING
        i:=1; j:=1;
        ScoreMatrix[0].Y[0].score := 0;
        for j from 1 to line2.length do
                begin
                    ScoreMatrix[0].Y[j].score := ScoreMatrix[0].Y[j-1].score + 1
                end;
        for i from 1 to line1.length do        
                begin
                ScoreMatrix[i].Y[0].score := ScoreMatrix[i-1].Y[0].score + 1;
                for j from 1 to line2.length do
                    begin
                    min1 := ScoreMatrix[i-1].Y[j-1].score + Sub(line1.content[i-1],line2.content[j-1]);
                    min2 := ScoreMatrix[i-1].Y[j].score+1;
                    min3 := ScoreMatrix[i].Y[j-1].score+1;
                    min(var min1,var min2,var min3);
                    ScoreMatrix[i].Y[j].score := minimum;
                    ScoreMatrix[i].Y[j].direction := DirectionFlag;
                    DirectionFlag := 0;
                    end
                end;
                
                
        ! Output the cost        
        put('T');put('h');put('e');put(' ');
        put('c');put('o');put('s');put('t');put(' ');
        put('i');put('s');put(':');put(' ');
        putint(ScoreMatrix[i-1].Y[j-1].score);
        puteol();
        
        ! Print matrix
        !n:=line2.length;m:= 0;
        !while n>=0 do
            !begin
            !while (m<=line1.length) do
               ! begin
               ! putint(ScoreMatrix[m].Y[n].score);
               ! put(' ');
               ! m := m+1
               ! end;
               ! m:=0;
               ! puteol();
               ! n:=n-1
           ! end
           
       !print direction
       !n:=line2.length;m:= 1;
       ! while n>0 do
           ! begin
            !while (m<=line1.length) do
              !  begin
              !  putint(ScoreMatrix[m].Y[n].direction);
              !  put(' ');
               ! m := m+1
               ! end;
              !  m:=1;
              !  puteol();
              !  n:=n-1
           ! end
           
      i:=i-1;j:=j-1; 
      lengthOfSolution := 0;
      while (i\=0) \/ (j\=0) do
            begin
            if (ScoreMatrix[i].Y[j].direction = 1) then
                begin
                    print1st[lengthOfSolution] := line2.content[j-1];
                    print2nd[lengthOfSolution] := '|';
                    print3rd[lengthOfSolution] := line1.content[i-1];
                    lengthOfSolution:=lengthOfSolution+1;
                    i:=i-1;j:=j-1
                end
            else if (ScoreMatrix[i].Y[j].direction = 2) \/ ((j=0)/\(i\=0)) then
                begin
                    print1st[lengthOfSolution] := '-';
                    print2nd[lengthOfSolution] := '|';
                    print3rd[lengthOfSolution] := line1.content[i-1];
                    lengthOfSolution:=lengthOfSolution+1;
                    i:=i-1
                end
            else if (ScoreMatrix[i].Y[j].direction = 3) \/ ((i=0)/\(j\=0)) then
                begin
                    print1st[lengthOfSolution] := line2.content[j-1];
                    print2nd[lengthOfSolution] := '|';
                    print3rd[lengthOfSolution] := '-';
                    lengthOfSolution:=lengthOfSolution+1;
                    j:=j-1
                end
            else 
                begin
                put('W'); put('W'); put('W'); put('W'); put('W'); put('W'); put('W');puteol()
                end
            end;
            
            
       !Output
       puteol();
       put('A');put('n');put(' ');
       put('p');put('o');put('s');put('s');put('i');put('b');put('l');put('e');put(' ');
       put('a');put('l');put('i');put('g');put('n');put('m');put('e');put('n');put('t');put(' '); 
       put('i');put('s');put(' '); put(':');puteol();       
       tmp:=lengthOfSolution-1;
       while tmp>=0 do
            begin
            put(print1st[tmp]);put(' ');
            tmp:=tmp-1
            end;
       puteol();
       tmp:=lengthOfSolution-1;
       while tmp>=0 do
            begin
            put(print2nd[tmp]);put(' ');
            tmp:=tmp-1
            end;
       puteol();
       tmp:=lengthOfSolution-1;
       while tmp>=0 do
            begin
            put(print3rd[tmp]);put(' ');
            tmp:=tmp-1
            end;
       puteol();
       
       puteol();
       put('T');put('r');put('i');put('a');put('n');put('g');put('l');put('e');put(' ');
       put('p');put('r');put('o');put('g');put('r');put('a');put('m');put(' ');
       put('t');put('e');put('r');put('m');put('i');put('n');put('a');put('t');put('e');put('d');put('!');puteol();puteol();
       
       put('F');put('u');put('u');put('u');put('u');put('u');put('u');put('u');put('c');put('k');
       put('n');put('n');put('n');put('n');put('n');put('n');put('n');put('g');put(' ');
       put('T');put('r');put('i');put('a');put('n');put('g');put('l');put('e');put('!');put('!');put('!');put('!');put('!');put('!');put('!');put('!');put('!');put('!');put('!');put(' ');puteol()
    end
  end