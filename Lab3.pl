%4.2
size(Number, 1) :- Number >= 158, Number < 164, !.
size(Number, 2) :- Number >= 164, Number < 170, !.
size(Number, 3) :- Number >= 170, Number < 176, !.
size(Number, 4) :- Number >= 176, Number < 182, !.
size(Number, 5) :- Number >= 182, Number =< 188, !.
size(_, false). % return false for any other input

%4.3
%Программа 3 
a:- write(1).
a:- write(2).
b(X):- a,X='more'.
c:- a.
d:- a,fail.

/*?-b(X). - исполняем a - получаем ответ, возвращаем x = 'more', так как все успешно исполнено - продолжаем исполнять дальше, пока есть что.
?-c. - исполняем 'a'. Так как вызывается 'c', интерпретатор исполнит первую встретившуюся 'a' и закончит исполнение кода.
?-d. - исполняем write(1), получаем false. Пробуем выполнить write(2) - получаем false окончательно*/

%4.4
country('England','London').
country('Russia','Moscow').
country('France','Paris').
country('China','Pekin').
country('Japan','Tokyo').
country('Italy','Rome').

print_countries :- country(Country, City), write(Country), write(' - '), write(City), nl, fail.

%print_countries will print all countries and their cities in the database

%4.5
%?- repeat,a,fail.
%Не исполняй, дурак, рекурсия. Так как repeat всегда делает успешным исполнение предиката, то fail не срабатывает (?). Сама суть этого предиката заключается в том, чтобы искать успешное решение, пока это возможно.

%4.6
%Программа 4
r:- repeat, read(X), write(X), X = stop.
%?- r.
%Возьмем во внимание пояснение к заданию 4.5 и добавим туда условие, что если предикат был успешно согласован без repeat, то repeat больше ничего не вызовет.

%4.7
	
