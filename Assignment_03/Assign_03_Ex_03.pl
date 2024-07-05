:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_client)).

:- http_handler('/', web_form, []).
:- http_handler('/check_parenthesis', parenthesis, []).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).



web_form(_Request) :-
  reply_html_page(
          title('Parenthesis'),   % Το “title” δημιουργεί τον τίτλο της ιστοσελίδας
    [
      
      form([action='/check_parenthesis', method='POST'], 
      [ p([], [
        label([for=a],'Please give parenthesis: '),
        input([name=a, type=textarea])
        ]),
      p([], input([name=submit, type=submit, value='Submit'], [])) ])]).



empty_stack([]).           

parenthesis(Request) :-
    reply_html_page(
        title('Parenthesis'),
        []), 
        member(method(post), Request), !, 
        http_read_data(Request, Data, []),
	    format('<p><h3>', []),
    parenthesis_LR_same(Data.a).

parenthesis_LR_same(S):-           
    name(S,St),                   % Μετατροπη λίστας που έδωσε ο χρήστης σε αριθμούς
    empty_stack(Y),
    check(St,Y).

check([],S):-                       % Check σε περίπτωση που αδειάσει η λίστα σου έδωσε ο χρήστης , ώστε να εμφανίσει αποτέλεσμα
    (empty_stack(S),
    write('Number of left and right parentheses are same.')) ; 
    ( write('Number of left and right parentheses are different.')).   

check([H|T],S):-                    % Εισαγωγή στοιχείου στην κενή στοίβα
    empty_stack(S),  
    push(S,H,R),  
    check(T,R).       

check([H|T],S):-                    % Εισαγωγή ή εξαγωγή στοιχείου απο τη λίστα ανάλογα με το αν ταιριάζει με το 1ο στοιχείο που έδωσε ο χρήστης.
    top(S,Top),
   ((Top =:= H,push(S,H,NewS));
    (Top =\= H,pop(S,NewS))),
    check(T,NewS).



push(Q,S,[S|Q]).            

pop([H|T],T).  

top([H], H).																		                 													
top([H|T], Last) :- top(T, Last).