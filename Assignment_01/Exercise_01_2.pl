% Ερώτημα 2ο 
% template :  rule(rule,Data,Saturation,Nitrate,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result).

%main program

start:- write('Does lab values exists? (yes/no)'),nl , 
        read(Data),
        ((Data=yes , write('Give saturation rate (%) .') ,nl, read(Satur) ,(
            (Satur>=20, rule(Rule,Data,Satur,Nitrate,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) ); %1
            (write('Does nitrate exists? (yes/no)'),nl , read(Nitr) , rule(Rule,Data,Satur,Nitr,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) %2,3
        )));
        (Data = no , write('Does oligochaetes exists? (some/many/no)'),nl , read(Oli) , (
            ((Oli = many ; Oli = some) , rule(Rule,Data,Saturation,Nitrate,Oli,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result)); %4,5
            (Oli = no ,write('Does Sediments exists? (light/dark/black)'),nl , read(Sedi), (
                (Sedi = light , write('Whats the substrate type? (normal,medium,many)'),nl , read(Substr), (
                    (Substr = normal , write('Does water smells bad? (yes/no)'),nl, read(Smell), 
                        rule(Rule,Data,Saturation,Nitrate,Oli,Sedi,H2s,CH4,Substr,Smell,Result) ); %6,7
                    (rule(Rule,Data,Saturation,Nitrate,Oli,Sedi,H2s,CH4,Substr,Bad_smell,Result)) %8
                ) );
                (write('Does H2S exists? (yes/no)'),nl, read(H) , (
                    (H=no , write('Does CH4 exists? (yes/no)'),nl,read(C) ,
                        rule(Rule,Data,Saturation,Nitrate,Oli,Sedi,H,C,Substrate_type,Bad_smell,Result)); %9,10
                    (rule(Rule,Data,Saturation,Nitrate,Oli,Sedi,H,CH4,Substrate_type,Bad_smell,Result))%11
                ))
            ) )
        ))),write(Result),nl,write(Rule).



%RULES
%1
rule(rule1,yes,Saturation,Nitrate,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) :- Saturation >= 20 , Result = 'No anoxia problem.'.

%2
rule(rule2,yes,Saturation,yes,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) :- Saturation < 20 , Result = 'Serious anoxia problem.'.

%3
rule(rule3,yes,Saturation,no,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) :- Saturation < 20 , Result = 'Very serious anoxia problem.'.

%4
rule(rule4,no,Saturation,Nitrate,many,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) :- Result = 'Medium level of anoxia'.

%5
rule(rule5,no,Saturation,Nitrate,some,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) :- Result = 'Very serious anoxia problem.'.

%6
rule(rule6,no,Saturation,Nitrate,no,light,H2s,CH4,normal,no,Result) :- Result = 'No anoxia problem.'.

%7
rule(rule7,no,Saturation,Nitrate,no,light,H2s,CH4,normal,yes,Result) :- Result = 'Medium level of anoxia.'.

%8
rule(rule8,no,Saturation,Nitrate,no,light,H2s,CH4,_,Bad_smell,Result) :- Result = 'No anoxia problem.'.

%9
rule(rule9,no,Saturation,Nitrate,no,_,no,no,Substrate_type,Bad_smell,Result) :- Result = 'Serious anoxia problem.'.

%10
rule(rule10,no,Saturation,Nitrate,no,_,no,yes,Substrate_type,Bad_smell,Result) :- Result = 'Very serious anoxia problem.'.

%11
rule(rule11,no,Saturation,Nitrate,no,_,yes,CH4,Substrate_type,Bad_smell,Result) :- Result = 'Very serious anoxia problem.'.