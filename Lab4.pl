menu :- 
	repeat,
		nl, nl,
		write('---------------------------------------------MENU------------------------------------------------'),
		nl,
		write('1 - Find an author whose books have been reprinted the most times'), 
		nl,
		write('2 - Find all books whose have been published more then one time'),
		nl,
		write('3 - Find all books whose have been published by desired publisher in desired year'),
		nl,
		write('4 - Find all books written by desired author'),
		nl,
		write('5 - Find all books whose price is more than desired number'),
		nl,
		write('6 - Add book'),
		nl,
		write('7 - Delete book'),
		nl,
		write('8 - Change book availability'),
		nl,
		write('9 - Show book info'),
		nl,
		write('0 - Exit'),
		nl, nl,
		read(Choice),
		processAction(Choice).
	

processAction(0) :-
	!.

processAction(Choice) :- 
	action(Choice),
	fail.
	
action(_) :-
	write('Action not found'),
	nl, 
	!.

action(1) :-
	write('kek').
	
%action(2) :-


%action(3) :-


%action(4) :-


%action(5) :-


action(6) :-
	dynamic(book/3),
	write('Enter book title'),
	read(Title),
	%write('fill ')

%action(7) :-


%action(8) :-


%action(9) :-



%author(FirstName, SecondName, BirthYear, Salary).
%edition(Publisher, Number, YearPublished, Pages, Price, author(_, _, _, Salary)).
%book(Title, author, edition).
