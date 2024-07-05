%RULES
%1
rule(rule1,(yes,Saturation,Nitrate,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,'No anoxia problem.')) :- Saturation >= 20 .

%2
rule(rule2,(yes,Saturation,yes,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,'Serious anoxia problem.')) :- Saturation < 20 .

%3
rule(rule3,(yes,Saturation,no,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,'Very serious anoxia problem.')) :- Saturation < 20 .

%4
rule(rule4,(no,Saturation,Nitrate,many,Sediments,H2s,CH4,Substrate_type,Bad_smell,'Medium level of anoxia')).

%5
rule(rule5,(no,Saturation,Nitrate,some,Sediments,H2s,CH4,Substrate_type,Bad_smell,'Very serious anoxia problem.')).

%6
rule(rule6,(no,Saturation,Nitrate,no,light,H2s,CH4,normal,no,'No anoxia problem.')).

%7
rule(rule7,(no,Saturation,Nitrate,no,light,H2s,CH4,normal,yes,'Medium level of anoxia.')).

%8
rule(rule8,(no,Saturation,Nitrate,no,light,H2s,CH4,_,Bad_smell,'No anoxia problem.')).

%9
rule(rule9,(no,Saturation,Nitrate,no,_,no,no,Substrate_type,Bad_smell,'Serious anoxia problem.')) .

%10
rule(rule10,(no,Saturation,Nitrate,no,_,no,yes,Substrate_type,Bad_smell,'Very serious anoxia problem.')).

%11
rule(rule11,(no,Saturation,Nitrate,no,_,yes,CH4,Substrate_type,Bad_smell,'Very serious anoxia problem.')).