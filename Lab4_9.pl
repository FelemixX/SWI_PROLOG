% Вариант 9
% Предметная область – семья. 
% Каждая семья может быть описана структурой из трех компонент: мужа, жены и детей.
% Каждый член семьи может быть описан структурой: имя, отчество, фамилия, год рождения, пол, ежемесячный доход.
% Для детей добавить поле «близнец». 

% Здесь member содержит:
% 1. Идентификатор члена семьи
% 2. Идентификатор семьи
% 3. Тип члена семьи (муж, жена, ребенок)
% 4. Информация о члене семьи (имя, отчество, фамилия, год рождения, пол, ежемесячный доход)
% 5. Близнецы помечаются одинаковым номером, с каждым новым близнецом увеличивается номер
:- dynamic member/10.
:- discontiguous member/10.
member(1, 1, муж, 'Иванов', 'Иван', 'Иванович', 1980, 'муж', 10000, нет).
member(2, 1, жена, 'Иванова', 'Ирина', 'Ивановна', 1976, 'жен', 200, нет).
member(3, 1, реб, 'Иванов', 'Александр', 'Иванович', 2000, 'муж', 0, 3).
member(4, 1, реб, 'Иванов', 'Алексей', 'Иванович', 2000, 'муж', 0, 4).
% ещё семья
member(5, 2, муж, 'Петров', 'Петр', 'Петрович', 1913, 'муж', 300000, нет).
member(6, 0, жена, 'Петрова', 'Ирина', 'Петровна', 1926, 'жен', 20, нет).
% Нет семьи
member(7, 0, реб, 'Петров', 'Александр', 'Петрович', 2007, 'муж', 0, нет).

% Здесь family содержит:
% 1. Идентификатор семьи
% 2. Идентификаторы членов семьи (муж, жена, массив детей)
:- dynamic family/4.
family(1, 1, 2, [3, 4]).
family(2, 5, 0, []).

% Выввести список всех family и member в них.
f_list :-
  % Перебрать все family в цикле
  family(FamilyID, _, _, _),
  % Вывести информацию о family
  write('Family: '), write(FamilyID), nl,
  % Перебрать все member в цикле
  member(MemberID, FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец),
  % Вывести информацию о member в строку
  write(MemberID), write('. '), write(Тип), write('\t: '), write(Фамилия), write(' '), write(Имя), write(' '), write(Отчество), nl,
  write('    '), write('год: '), write(Год), write('; пол: '), write(Пол), write('; salary: '), write(Доход), nl,
  % Если является близнецом, то сказать об этом
  (Близнец \= нет -> write('    '), write('twin: '), write(Близнец), nl; true),
  fail.

% Вернет максимальный id списка family
getMaxIDFamily(Max) :-
  findall(ID, family(ID, _, _, _), IDs),
  max_list(IDs, Max).

% Вернет максимальный id списка member
getMaxIDMember(Max) :-
  findall(ID, member(ID, _, _, _, _, _, _, _, _, _), IDs),
  max_list(IDs, Max).

% Добавить новую семью с пустыми полями
f_add :- 
  % Найти максимальный id
  getMaxIDFamily(Max),
  % Увеличить на 1
  NewID is Max + 1,
  % Добавить новую семью
  assert(family(NewID, 0, 0, [])),
  write('Family added: '), write(NewID), nl.

% Добавить нового члена семьи
m_add(FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец) :-
  % Найти максимальный id
  getMaxIDMember(Max),
  % Увеличить на 1
  NewID is Max + 1,
  % Добавить нового члена семьи
  assert(member(NewID, FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец)),
  write('Family member added: '), write(NewID), nl.

% Обновить одно поле с id family у member по id
m_updateFamily(MemberID, FamilyID) :- 
  % Найти member по id
  member(MemberID, _, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец),
  % Удалить member
  retract(member(MemberID, _, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец)),
  % Добавить member с новым family id
  assert(member(MemberID, FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец)),
  write('Family updated: '), write(MemberID), nl.

% Обновить поле муж в family по id
f_updateHusband(FamilyID, HusbandID) :- 
  % Найти family по id
  family(FamilyID, _, WifeID, Children),
  % Удалить family
  retract(family(FamilyID, _, WifeID, Children)),
  % Добавить family с новым мужем
  assert(family(FamilyID, HusbandID, WifeID, Children)),
  write('Husband '), write(FamilyID), write(' updated'), nl.

% Обновить поле жена в family по id
f_updateWife(FamilyID, WifeID) :- 
  % Найти family по id
  family(FamilyID, HusbandID, _, Children),
  % Удалить family
  retract(family(FamilyID, HusbandID, _, Children)),
  % Добавить family с новой женой
  assert(family(FamilyID, HusbandID, WifeID, Children)),
  write('Wife '), write(FamilyID), write(' updated'), nl.

% Обновить поле дети в family по id
f_updateChildren(FamilyID, Children) :- 
  % Найти family по id
  family(FamilyID, HusbandID, WifeID, _),
  % Удалить family
  retract(family(FamilyID, HusbandID, WifeID, _)),
  % Добавить family с новыми детьми
  assert(family(FamilyID, HusbandID, WifeID, Children)),
  write('Children '), write(FamilyID), write(' updated'), nl.

% Удалить семью по id
f_delete(FamilyID) :- 
  % Найти family по id
  family(FamilyID, _, _, _),
  % Удалить family
  retract(family(FamilyID, _, _, _)),
  write('Family removed '), write(FamilyID), nl.

% Удалить члена семьи по FamilyID и MemberID
m_delete(FamilyID, MemberID) :- 
  % Найти member по id
  member(MemberID, FamilyID, _, _, _, _, _, _, _, _),
  % Удалить member
  retract(member(MemberID, FamilyID, _, _, _, _, _, _, _, _)),
  write('Family member removed: '), write(MemberID), nl,
  % заменить его в семье на 0
  m_updateFamily(MemberID, 0).

% Удалить семью по id и все ее члены
f_deleteAll(FamilyID) :- 
  % Найти family по id
  family(FamilyID, _, _, _),
  % Удалить family
  retract(family(FamilyID, _, _, _)),
  write('Family removed: '), write(FamilyID), nl,
  % Найти всех member
  member(ID, FamilyID, _, _, _, _, _, _, _, _),
  % Удалить member
  retract(member(ID, FamilyID, _, _, _, _, _, _, _, _)),
  write('Family member removed: '), write(ID), nl.

% 1. Найти всех близнецов;
filter1 :-
  % Найти всех member
  member(ID, _, _, Фамилия, Имя, _, _, _, _, Близнец),
  % Если является близнецом, то вывести
  (Близнец \= нет -> write('Twin: '), write(ID), write(' '), write(Фамилия), write(' '), write(Имя), nl; true),
  fail.

% 2. Найти всех детей, родившихся в заданном году; 
filter2(Year) :-
  % Найти всех member
  member(ID, _, Тип, Фамилия, Имя, _, Год, _, _, _),
  % Если тип - ребенок и год рождения совпадает с заданным, то вывести
  (Тип = реб, Год = Year -> write('Child: '), write(ID), write(' '), write(Фамилия), write(' '), write(Имя), nl; true),
  fail.

% 3. Найти всех работающих жен, чей доход больше заданной суммы; 
filter3(Sum) :-
  % Найти всех member
  member(ID, _, Тип, Фамилия, Имя, _, _, Пол, Доход, _),
  % Если тип - жена, пол - женский и доход больше заданной суммы, то вывести
  (Тип = жена, Пол = жен, Доход > Sum -> write('Wife: '), write(ID), write(' '), write(Фамилия), write(' '), write(Имя), nl; true),
  fail.

% 4. Найти фамилии людей, у которых есть заданное число детей.
filter4(Count) :-
  % Найти все family
  family(FamilyID, _, _, Children),
  % Если количество детей совпадает с заданным, то вывести первого member из family
  (length(Children, Count) -> member(_, FamilyID, муж, Фамилия, _, _, _, _, _, _), write('Wife: '), write(Фамилия), nl; true),
  fail.

% 5. Найти всех людей, у которых есть только один ребенок.
filter5 :-
  % Найти все family
  family(FamilyID, _, _, Children),
  % Если количество детей равно 1, то вывести первого member из family
  (length(Children, 1) -> member(_, FamilyID, муж, Фамилия, _, _, _, _, _, _), write('Family: '), write(Фамилия), nl; true),
  fail.


menu :- 
	repeat, nl, nl, 
	write('1. Find all twins'), nl,
	write('2. Find all child born in exact year'), nl,
	write('3. Find all whives who work whos salary is more than defined salary'), nl,
	write('4. Find all surnames of people that have defined number of children'), nl,
	write('5. Find all people that have single child'), nl,
	write('6. Add new empty family'), nl,
	write('7. Add new member to family'), nl,
	write('8. Print all families and families members'), nl,
	write('9. Get max id value of families'), nl,
	write('10. Get max id value of members'), nl,
	write('11. Update family by family id and member id'), nl,
	write('12. Update husband in family'), nl,
	write('13. Update wife in family'), nl,
	write('14. Update child in family'), nl,
	write('15. Delete family by id'), nl,
	write('16. Delete family member by id'), nl,
	write('0. Exit'), nl,
	read(X), 
	do(X).

do(1) :-
	write('Twins found: '), nl,
	filter1.
	
do(2) :- 
	write('Input year of birth: '), nl,
		read(Year),
	filter2(Year).
	
do(3) :- 
	write('Input salary: '), nl,
		read(Sum),
	filter3(Sum).
	
do(4) :- 
	write('Input count of children: '), nl,
		read(Count),
	filter4(Count).
	
do(5) :- 
	write('Found families with single child: '), nl, 
	filter5.

do(6) :-
	f_add,
	write('Successfully added new empty family').
	
do(7) :-
	write('Input FamilyID: '), nl,
		read(FamilyID),
	write('Input Type: '), nl,
		read(Тип),
	write('Input Surname: '), nl,
		read(Фамилия),
	write('Input Name: '), nl,
		read(Имя),
	write('Input Third Name: '), nl,
		read(Отчество),
	write('Input Year of Birth: '), nl,
		read(Год),
	write('Input Gender: '), nl,
		read(Пол),
	write('Input Salary: '), nl,
		read(Доход),
	write('Input Twin: '), nl,
		read(Близнец),
	m_add(FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец).
	
do(0) :- 
	write('Exit').
do(_) :-
	write('Wrong input'), nl,
	fail.

% Запуск программы
:- initialization(menu).
