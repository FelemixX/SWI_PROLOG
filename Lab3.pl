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
animal(Animal, Lives) :- lives(X, Y), Animal = X, Lives = Y.

lives('Zebra', ground).
lives('Dog', ground).
lives('Carp', water).
lives('Whale', water).
lives('Cat', Where) :- lives('Dog', Where), !.
lives('Croco' , water).
lives('Croco', ground).
lives('Frog', water).
lives('Frog', ground).
lives('Duck', water).
lives('Duck', ground).
lives('Duck', air).
lives('Eagle', ground).
lives('Eagle', air).
lives('Thunderbird', water).
lives('Thunderbird', air).
lives('Troubles', ass).

%а чо делать то еще

%5.1 
write_list([]).
write_list([H|T]):- 
write(H), nl,
write_list(T).

% write_list([1, 2, a, 3]). 
/* returns 
1
2
a
3
true.
*/

%5.2.1
my_list([], 0).
my_list([_|Tail], N) :- my_list(Tail, N1), N is N1 + 1.

%my_list([1,2,3,4], Sth).
%list.length === tail + 1; return false;
%list.length === 0; return true;

%5.2.2
belongsToList(Element, [Element|_]).
belongsToList(Element, [_|Tail]) :-
    belongsToList(Element, Tail).

%belongsToList(2, [22,1,3]).

%5.2.5
inverseList([], []).
inverseList([X|Xs], Ys) :-
    inverseList(Xs, Zs),
    append(Zs, [X], Ys).

%inverseList([1,2,3,4,5], List).

%5.2.3
sum_list([], 0).
sum_list([H|T], Sum) :-
   sum_list(T, Rest),
   Sum is H + Rest.
   
%sum_list([1,0,10,2], Any).
	
%5.2.4
minMaxList([X|Xs], Min, Max) :-
    minMaxList(Xs, X, X, Min, Max).

minMaxList([], Min, Max, Min, Max).
minMaxList([X|Xs], CurrMin, CurrMax, Min, Max) :-
    NewCurrMin is min(CurrMin, X),
    NewCurrMax is max(CurrMax, X),
    minMaxList(Xs, NewCurrMin, NewCurrMax, Min, Max).

%minMaxList([1,0,9,2,0], Min, Max).
