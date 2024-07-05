# Ερώτημα 2ο 
rule(rule,Data,Saturation,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result).

rule(rule1,exists,Saturation,Oligochaetes,Sediments,H2s,CH4,Substrate_type,Bad_smell,Result) :- Saturation >= 20 , Result = "No anoxia problem.".