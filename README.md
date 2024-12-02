# commands for run program


## 1)gedit programe1.l
cc lex.yy.c -ll <br>
./a.out input.text<br>

## 2) gedit programe2.l
cc lex.yy.c -ll<br>
./a.out input.text<br>

## 3) lex calculator.l
yacc -d calculator.y<br>
cc lex.yy.c y.tab.c -ll -ly<br>
./a.out<br>

===> 3+5
          Result = 8

## 4) lex cfg.l
yaac -d cfg.y<br>
cc lex.yy.c y.tab.c -ll -ly<br>
./a.out <br>

===> Enter string ( a and b)
          aabb<br>

## 5) lex target.l
yacc -d target.y <br>
cc lex.yy.c y.tab.c -ll -ly <br>
./a.out input.text <br>

===> check in folder there is output file generated <br>

## 6) lex dfa.l 
yacc -d dfa.y <br>
cc lex.yy.c y.tab.c -ll -ly <br>
./a.out <br>

===> Enter Decimal number..... <br>
          36
