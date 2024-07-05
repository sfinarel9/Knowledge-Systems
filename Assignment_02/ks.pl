:- dynamic rule/2 .
:- include('KB.pl'). % Knowledge base


menu:- 
    write('Main Menu'),nl,                     
	write('Select 1: Run Goals.'),nl,
	write('Select 2: Program Update.'),nl,
	write('Select 3 or other : Exit.'),nl,
    read(Num),nl,
    choice(Num).

choice(1) :- choice1.			%Actions
choice(2) :- choice2.

choice1:- write('Does lab values exists? (yes/no)'),nl , 
        read(Data),
        ((Data=yes , write('Give saturation rate (%) .') ,nl, read(Satur) ,(
            (Satur>=20, rule(Rule,(Data,Satur,Nitrate,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result)) ); %1
            (write('Does nitrate exists? (yes/no)'),nl , read(Nitr) , rule(Rule,(Data,Satur,Nitr,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result)) %2,3
        )));
        (Data = no , write('Does oligochaetes exists? (some/many/no)'),nl , read(Oli) , (
            ((Oli = many ; Oli = some) , rule(Rule,(Data,Saturation,Nitrate,Oli,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result))); %4,5
            (Oli = no ,write('Does Sediments exists? (light/dark/black)'),nl , read(Sedi), (
                (Sedi = light , write('Whats the substrate type? (normal,medium,many)'),nl , read(Substr), (
                    (Substr = normal , write('Does water smells bad? (yes/no)'),nl, read(Smell), 
                        rule(Rule,(Data,Saturation,Nitrate,Oli,Sedi,H2s,CH4,Substr,Smell,Result)) ); %6,7
                    (rule(Rule,(Data,Saturation,Nitrate,Oli,Sedi,H2s,CH4,Substr,Bad_smell,Result))) %8
                ) );
                (write('Does H2S exists? (yes/no)'),nl, read(H) , (
                    (H=no , write('Does CH4 exists? (yes/no)'),nl,read(C) ,
                        rule(Rule,(Data,Saturation,Nitrate,Oli,Sedi,H,C,Substrate_type,Bad_smell,Result))); %9,10
                    (rule(Rule,(Data,Saturation,Nitrate,Oli,Sedi,H,CH4,Substrate_type,Bad_smell,Result)))%11
                ))
            ) )
        ))),write(Result),nl,write(Rule),write(' was used.'),nl,menu.

choice2:-   write('Program Update'),nl,                      
            write('Select a: Delete a clause.'),nl,
            write('Select b: Insert new clause.'),nl,
            write('Select c: Change a clause'),nl,
            write('Select d: Save and go to main menu'),nl,
            read(Ch),nl,
            choice2_1(Ch).

choice2_1(a):-  write('Give rule identity to delete.'),nl,
                read(Ruleid),nl,
                write(Ruleid),
                retractall(rule(Ruleid,(_,_,_,_,_,_,_,_,_,_))),nl,
                write('----------------'),nl,
                choice2.

choice2_1(b):-  write('Give Problem Data like: Data,Saturation,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result'),nl,           
                read(Data),nl,
                write('Give Problem Conditions'),nl,
                read(Conditions),nl,
                assertz((rule(rule12,Data):- Conditions)),nl,
                choice2.

choice2_1(c):-   write('Give rule ID to replace'),nl,
                read(Ruleid),nl,
                write('Give new condition'),nl,
                read(RuleCond),nl,
                atom_concat('' , 'rule(' , Rule),
                write('---------11-------'),nl,
                atom_concat(Rule , Ruleid , Rule1),
                write('---------12-------'),nl,
                atom_concat(Rule1,',(Data,Saturation,Nitrate,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result)):- ' , Head),
                write('---------13-------'),nl,
                atom_concat(Head , RuleCond , Clause),
                write('----------------'),nl,
                retractall(rule(Ruleid,(A,B,C,D,E,F,G,H,I,J))),nl,
                write(Clause),nl,
                assertz((rule(Ruleid,(A,B,C,D,E,F,G,H,I,J)):- RuleCond)),
                write('--------2--------'),nl,
                choice2.

assert_new([H|[H1|T]]) :- asserta(rule(H,H1)).

choice2_1(d):- save , menu.

save:- tell('C:/Users/sfina/OneDrive/Desktop/final_programm_exercise2.pl'),
	retractall(rule),
	listing(rule),
    told.
