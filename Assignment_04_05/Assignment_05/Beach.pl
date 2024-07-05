:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_error)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_client)).
:- include('knowledge_base.pl').


:- http_handler('/', menu, []).
:- http_handler('/prediction', prediction, []).
:- http_handler('/answer', answer, []).


server(Port) :-
        http_server(http_dispatch, [port(Port)]).
		
menu(_Request) :- format('Content-type: text/html~n~n'),
	print_html(['
	<html>
		<head>
			<title>Beach</title>
		</head>
   	<main>
    	<body>	
				<p>Welcome to the beach Explorer!!</p>
				<p><a href="/prediction">Let\'s find the ideal place to swim, on a sunny Sunday</a></p>
      </body>        
    </main>
  </html>
']).


prediction(_Request) :- reply_html_page(title('Beach'), [
	form([action='/answer', method='POST'],
	[
		p([], [label([for=condition], 'Who do you want to visit the beach with?'),
		select([id=condition, name=condition], [option(friends), option(kids)])]),
		p([], [label([for=ground], 'What would you like the beach soil to consist of?'),
		select([id=ground, name=ground], [option(sand),option(pebbles)])]),
		p([], [label([for=place], 'Where would you like the beach to be?'),
		select([id=place, name=place], [option(apokoronas),option(chania),option(kissamos),option(sfakia),option(selino)])]),
		p([], input([name=submit, type=submit, value='Find the best Beach!!'], []))
	])
]).
			
answer(Request) :- member(method(post), Request), !,
				http_read_data(Request, Data, []),
				(beach(_,Data.condition, Data.ground,Data.place,Name,Description,URL);Name = "Sorry!", Description = "We couldn't find a beach that suits your choices!" , URL = "https://www.elizabethestateagency.com/gr/paralies/"),
				reply_html_page( 
                    [ title('Beach') ],
                    [ \page_content(Name,Description,URL) ]).

page_content(Name,Description,URL) -->
    html([
        p([style='text-align: ' + 'center ;'+ 'font-size: ' + '15pt'],h1(Name)), 
        p([style='text-align: ' + 'center'],h3(i(Description))),
        p(a([href=URL], 'Visit the Beach')),
        p(a([href="/prediction"], 'Return'))]
    ).


