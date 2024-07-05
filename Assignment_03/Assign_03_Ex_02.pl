:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_client)).

:- http_handler('/', web_form, []).
:- http_handler('/trionymo', trionym, []).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).



web_form(_Request) :-
  reply_html_page(
          title('Trionym'),   % Το “title” δημιουργεί τον τίτλο της ιστοσελίδας
    [
      
      form([action='/trionymo', method='POST'], 
      [ p([], [
        label([for=a],'Number 1: '),
        input([name=a, type=textarea])
        ]),
        p([], [
        label([for=b],'Number 2: '),
        input([name=b, type=textarea])
            ]),
      p([], [
        label([for=c],'Number 3: '),
        input([name=c, type=textarea])
            ]),
      p([], input([name=submit, type=submit, value='Submit'], [])) ])]).



trionym(Request) :-
    reply_html_page(
        title('TRIONUMO'),
        []), 
        member(method(post), Request), !, 
        http_read_data(Request, Data, []),
	    format('<p><h3>', []),
    checkTrionym(Data.a,Data.b,Data.c).


checkTrionym(A1,B1,C1):- 											 % Trionym equations
  atom_number(A1,A),												 
  atom_number(B1,B),
  atom_number(C1,C),
  (
    (
      (A=0, B=0, C=0, write('Identity.'),nl,                             % 1a ) Case A = 0 , B = 0 , C = 0
      write('Degenerate trionymal'),nl) ; 	

      (A=0, B=0, C\=0, write('Impossible equation.'),nl,                 % 1b ) Case A = 0 , B = 0 , C != 0
      write('Degenerate trionymal'),nl)
    );

    (A=0, B\=0,                                                          % 2) Case A = 0 , B != 0 
    Result is (- C/B), 
    write('There is one root of equation : x = '), 
    write(Result),nl);

    (A\=0, C=0,                                                           % 3) Case A != 0 , C = 0 
    Result is (- B/A), 
    write('There are two roots of equation:'),nl,
    write('X1 = '), 
    write(Result),nl,
    write(', X2 = 0'),nl);

    (                                                                   
      ( 
        (A\=0, B\=0, C\=0,                                                %4i )  Case A,B,C != 0 
        Dis is ((B*B) -(4*A*C)),
        Dis>=0,                                                          %4i)  Case Dis>=0 (Dis = discriminant = diakrinousa)
        Diakrinousa is sqrt(Dis), 
        Result1 is ((-B + Diakrinousa) / (2*A)), 
        Result2 is ((-B - Diakrinousa) / (2*A)), 

        write('There are 2 real roots . '),nl,
        write('X1 = '), 
        write(Result1),nl,
        write(', X2 = '), 
        write(Result2),nl);

        (A\=0, B\=0, C\=0,       % Migadikes rizes
        Dis is ((B*B) -(4*A*C)), 
        Dis<0,                                                          % Case Dis <  0
        write('There are 2 complex roots'),nl)
      );
      (
        (A\=0, C\=0,                                                 %4ii )  Case A,C != 0
        Dis is ((B*B) -(4*A*C)),
        Dis>=0,                                                         % Case Dis >= 0
        Diakrinousa is sqrt(Dis),
        Result1 is ((-B + Diakrinousa) / (2*A)),
        Result2 is ((-B - Diakrinousa) / (2*A)),

        write('There are 2 real roots . '),nl,
        write('X1 = '), 
        write(Result1),nl,
        write(', X2 = '),  
        write(Result2),nl);

        (A\=0, C\=0, 
        Dis is ((B*B) -(4*A*C)), 
        Dis<0,                                                           % Case Dis <  0
        write('There are 2 complex roots'),nl)
      )
    )
  ).