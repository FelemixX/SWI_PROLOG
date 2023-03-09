%Программа 1

loves("Eric", reading).
loves("Ellen", tennis).
loves("John", football).
loves("Tom", baseball).
loves("Eric", swimming).
loves("Mark", tennis).

loves("Bill", What) :- loves("Tom", What).

loves("Ellen", reading).
loves("Mark", computers).
loves("John", badminton).

%Задание 1.2

sports(tennis).
sports(football).
sports(baseball).
sports(badminton).

sportsman(Who) :- loves(Who, What), sports(What).

%Задание 1.3 trace, (sportsman(Who)).

%Задание 1.5

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
