%Задание 3.1

%Программа 1
%Не запускай ее глупец
song:- write('running,'),song.

%?- write('Я '),song.
%Программа 2
song(X):-(X>1),write('running,'),(Y is X - 1),song(Y).
song(1).

%?-write('Me '),song(3),write('running on a cinder track').	

%Задание 3.2
%Программа 3
%factorial(1,1).  %Условие выхода из рекурсии 1!=1 

/*factorial(N,F) :-
N > 1,
N1 is N-1,
factorial(N1, F1,
F is N*F1.  */

/* ?-factorial(3,X).
?-factorial(1,X).
?-factorial(0,X). */

%Программа 4 
/*factorial(N,FactN):- fact(N,FactN,1,1).
fact(N,FactN,I,P):- /* накопитель I - аналог счетчика */
I < N, /* накопитель P – промежуточное значение факториала*/
I1 is I+1, /*
FactN - значение факториала */
P1 is P*I1,
fact(N,FactN,I1,P1).
fact(N,FactN,N,FactN). */

%Программа 5
factorial(N,FactN):- fact(N,FactN,1).
fact(N,FactN,P):-
N > 0,
P1 is P*N,
N1 is N-1,
fact(N1,FactN,P1).
fact(0,FactN,FactN).

%Программа 6
kurs(1, gruppa('Shakespeare', gruppa('Moliere', gruppa('Chekhov', empty)))).
kurs(2, gruppa('Gilbert', gruppa('Эйлер', gruppa('Leibniz',  gruppa('Kantor',empty))))).
/* ?-kurs(1,X).
?-kurs(N,gruppa(X,Y)).
?-kurs(N1,gruppa(X, gruppa(Y,Z))) */

%3.6
%Without accumulators
fib(0,0).
fib(1,1).
fib(F,N) :-
	N>1,
	N1 is N-1,
	N2 is N-2,
	fib(F1,N1),
	fib(F2,N2),
	F is F1+F2,
	format('~w, ',[F]).

%fib(F, 10).

%with accumulators

fibAcc(N, F) :-
  fib_helper(N, 0, 1, F).

fib_helper(0, A, _, A).
fib_helper(N, A, B, F) :-
  N > 1,
  N1 is N - 1,
  Sum is A + B,
  fib_helper(N1, B, Sum, F).
  
%fibAcc(10, F).

%3.7
sum_odd_fibonacci(0, 0).
sum_odd_fibonacci(N, Sum):-
    N > 0,
    N1 is N - 1,
    sum_odd_fibonacci(N1, Sum1),
    fib(N, F),
    (F mod 2 =:= 1 -> Sum is Sum1 + F ; Sum is Sum1).


sum_even_fibonacci(0, 0).
sum_even_fibonacci(N, Sum):-
    N > 0,
    N1 is N - 1,
    sum_even_fibonacci(N1, Sum1),
    fib(N, F),
    (F mod 2 =:= 0 -> Sum is Sum1 + F ; Sum is Sum1).


%3.8
sum_odd(Sum, N):-sum_odd1(N, Sum, 0, 0).
sum_odd1(N, X, Sum, I):-
    Sum =< X,
    I1 is I+1,
    sum_odd_fibonacci(I1, Sum1),
    (Sum1 =:= X -> Sum2 is X+1 ; Sum2 is Sum1),
    sum_odd1(N, X, Sum2, I1).
sum_odd1(Sum, _, _, Sum).


sum_even(Sum, N):-sum_even1(N, Sum, 0, 0).
sum_even1(N, X, Sum, I):-
    Sum =< X,
    I1 is I+1,
    sum_even_fibonacci(I1, Sum1),
    (Sum1 =:= X -> Sum2 is X+1 ; Sum2 is Sum1),
    sum_even1(N, X, Sum2, I1).
sum_even1(Sum, _, _, Sum).
  
%3.9
% Ackermann function for non-negative integers
ackermann(0, N, R) :-
  R is N + 1.
ackermann(M, 0, R) :-
  M > 0,
  M1 is M - 1,
  ackermann(M1, 1, R).
ackermann(M, N, R) :-
  M > 0,
  N > 0,
  M1 is M - 1,
  N1 is N - 1,
  ackermann(M, N1, R1),
  ackermann(M1, R1, R).

%ackermann(1, 2, R).
