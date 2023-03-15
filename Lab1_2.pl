%2.2
auto('audi', 10000, black, 1).
auto('toyota', 15000, red, 10).
auto('yoba', 5000, orange, 0).
auto('junk', 1000, rust, 100500).
auto('UAZ', 8000, green, 25).
auto('UAZ', 12000, cyan, 15).
auto('ford', 9000, blue, 2).
auto('mazda', 25000, black, 10).
auto('Volga', 123123, cherry, 50).


/* b. car(Brand, Cost, Color, Age), Cost < 5000.
	c. buy(Brand, Cost, Color, Age) :-	auto(Brand, Cost, blue, Age), Age < 3 ; auto(Brand, Cost, green, Age), Age < 3. 
			buy(Brand, Cost, Color, Age).
	d.  auto(Brand, 10000, Color, Age).
*/
buy(Brand, Cost, Color, Age) :-	auto(Brand, NewCost, Color, Age), NewCost < Cost, Age < 30, (Color = blue; Color = green). 

/*%2.4
has('Oleg', book('Pushkin', 'Captains Daughter')).
has('Lena', book('Monten', 'Expirements')).
has('Ira', handkerchief(blue)).
has('Lena', handkerchief(red)).
/* 
has(Who, book('Monten', Book)).
has(Who, book(Name)). 
has(Who, What).
has('Lena', handkerchief(red)). %false
*/

%2.5

lives('Zebra', ground).
lives('Dog', ground).
lives('Carp', water).
lives('Whale', water).
lives('Cat', Where) :- lives('Dog', Where).
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

/* 
b.lives(Creature, Env),lives(Creature,Env2), dif(Env,Env2).
a. lives(Creature,Env), aggregate_all(count, lives(Creature,  _), Count), Count = 1.
*/

%2.6
%c
price('Cherry Volga', rubles(32000)).
price(television, rubles(8400)).
price(freezer, rubles(4200)).
price('Cassete player', rubles(35000)).
price(video, rubles(12000)).
price(reciever, rubles(1300)).
price(clock, rubles(500)).

%a
has('Ivan', rubles(10000)).
has('Ivan', television).
has('Ivan', auto('Cherry Volga',123123,cherry,50)).
has('Ivan', 'Cassete player').
has('Pyotr', rubles(5000)).
has('Pyotr', television).
has('Pyotr', freezer).
has('Nick', rubles(20000)).
has('Nick', television).

/*
%b
1.has('Pyotr', What).
2.has(Who, rubles(10000)).
3.has(Who, What).
4.has('Ivan', Item), not('Nick', Item).
%d
has('Pyotr', rubles(Money)), price(video, rubles(Cost)), Money >= Cost.
has(Rich, rubles(TheMost)), has(Who, rubles(Sum)), has(Who2, rubles(Sum2)), has(Who3, rubles(Sum3)), TheMost>Sum,Sum>Sum2,Sum2>Sum3,rich\=Who2,Rich\=Who3,Who2\=Who3. %???
%e
can_buy(Who, Item) :- has(Who, rubles(Х)), price(Item, З), Х>=З, not(has(Who, Item)), Item\=rub(_). 
%f 
has('Nick', rubles(Money)), price(Item, rubles(Cost)), Money >= Cost.
has('Nick', Item), has('Ivan', Item), Item \= rubles(Money).
%g
married('Ann', 'Kolya').
married('Mary', 'Ivan').
married('Olga', 'Pyotr').
/*has(married(Wife, Husband), Item) :- has(Husband, Item).
*/
%h
has(Who, Item) := has(Who, Item), married(Who, Husband). 

/* 
%i
has('Mary', auto(Brand, Cost, Color, Age).
has('Ann', Item), not(has('Mary', Item2)). */
*/
