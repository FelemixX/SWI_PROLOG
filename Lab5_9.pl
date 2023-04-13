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
  write('Семья: '), write(FamilyID), nl,
  % Перебрать все member в цикле
  member(MemberID, FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец),
  % Вывести информацию о member в строку
  write(MemberID), write('. '), write(Тип), write('\t: '), write(Фамилия), write(' '), write(Имя), write(' '), write(Отчество), nl,
  write('    '), write('год: '), write(Год), write('; пол: '), write(Пол), write('; доход: '), write(Доход), nl,
  % Если является близнецом, то сказать об этом
  (Близнец \= нет -> write('    '), write('близнец: '), write(Близнец), nl; true),
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
  write('Семья добавлена: '), write(NewID), nl.

% Добавить нового члена семьи
m_add(FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец) :-
  % Найти максимальный id
  getMaxIDMember(Max),
  % Увеличить на 1
  NewID is Max + 1,
  % Добавить нового члена семьи
  assert(member(NewID, FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец)),
  write('Член семьи добавлен: '), write(NewID), nl.

% Обновить одно поле с id family у member по id
m_updateFamily(MemberID, FamilyID) :- 
  % Найти member по id
  member(MemberID, _, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец),
  % Удалить member
  retract(member(MemberID, _, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец)),
  % Добавить member с новым family id
  assert(member(MemberID, FamilyID, Тип, Фамилия, Имя, Отчество, Год, Пол, Доход, Близнец)),
  write('Семья у человека обновлена: '), write(MemberID), nl.

% Обновить поле муж в family по id
f_updateHusband(FamilyID, HusbandID) :- 
  % Найти family по id
  family(FamilyID, _, WifeID, Children),
  % Удалить family
  retract(family(FamilyID, _, WifeID, Children)),
  % Добавить family с новым мужем
  assert(family(FamilyID, HusbandID, WifeID, Children)),
  write('Муж у семьи '), write(FamilyID), write(' обновлен'), nl.

% Обновить поле жена в family по id
f_updateWife(FamilyID, WifeID) :- 
  % Найти family по id
  family(FamilyID, HusbandID, _, Children),
  % Удалить family
  retract(family(FamilyID, HusbandID, _, Children)),
  % Добавить family с новой женой
  assert(family(FamilyID, HusbandID, WifeID, Children)),
  write('Жена у семьи '), write(FamilyID), write(' обновлена'), nl.

% Обновить поле дети в family по id
f_updateChildren(FamilyID, Children) :- 
  % Найти family по id
  family(FamilyID, HusbandID, WifeID, _),
  % Удалить family
  retract(family(FamilyID, HusbandID, WifeID, _)),
  % Добавить family с новыми детьми
  assert(family(FamilyID, HusbandID, WifeID, Children)),
  write('Дети у семьи '), write(FamilyID), write(' обновлены'), nl.

% Удалить семью по id
f_delete(FamilyID) :- 
  % Найти family по id
  family(FamilyID, _, _, _),
  % Удалить family
  retract(family(FamilyID, _, _, _)),
  write('Семья удалена: '), write(FamilyID), nl.

% Удалить члена семьи по FamilyID и MemberID
m_delete(FamilyID, MemberID) :- 
  % Найти member по id
  member(MemberID, FamilyID, _, _, _, _, _, _, _, _),
  % Удалить member
  retract(member(MemberID, FamilyID, _, _, _, _, _, _, _, _)),
  write('Член семьи удален: '), write(MemberID), nl,
  % заменить его в семье на 0
  m_updateFamily(MemberID, 0).

% Удалить семью по id и все ее члены
f_deleteAll(FamilyID) :- 
  % Найти family по id
  family(FamilyID, _, _, _),
  % Удалить family
  retract(family(FamilyID, _, _, _)),
  write('Семья удалена: '), write(FamilyID), nl,
  % Найти всех member
  member(ID, FamilyID, _, _, _, _, _, _, _, _),
  % Удалить member
  retract(member(ID, FamilyID, _, _, _, _, _, _, _, _)),
  write('Член семьи удален: '), write(ID), nl.

% 1. Найти всех близнецов;
filter1 :-
  % Найти всех member
  member(ID, _, _, Фамилия, Имя, _, _, _, _, Близнец),
  % Если является близнецом, то вывести
  (Близнец \= нет -> write('Близнец: '), write(ID), write(' '), write(Фамилия), write(' '), write(Имя), nl; true),
  fail.

% 2. Найти всех детей, родившихся в заданном году; 
filter2(Year) :-
  % Найти всех member
  member(ID, _, Тип, Фамилия, Имя, _, Год, _, _, _),
  % Если тип - ребенок и год рождения совпадает с заданным, то вывести
  (Тип = реб, Год = Year -> write('Ребенок: '), write(ID), write(' '), write(Фамилия), write(' '), write(Имя), nl; true),
  fail.

% 3. Найти всех работающих жен, чей доход больше заданной суммы; 
filter3(Sum) :-
  % Найти всех member
  member(ID, _, Тип, Фамилия, Имя, _, _, Пол, Доход, _),
  % Если тип - жена, пол - женский и доход больше заданной суммы, то вывести
  (Тип = жена, Пол = жен, Доход > Sum -> write('Жена: '), write(ID), write(' '), write(Фамилия), write(' '), write(Имя), nl; true),
  fail.

% 4. Найти фамилии людей, у которых есть заданное число детей.
filter4(Count) :-
  % Найти все family
  family(FamilyID, _, _, Children),
  % Если количество детей совпадает с заданным, то вывести первого member из family
  (length(Children, Count) -> member(_, FamilyID, муж, Фамилия, _, _, _, _, _, _), write('Семья: '), write(Фамилия), nl; true),
  fail.

% 5. Найти всех людей, у которых есть только один ребенок.
filter5 :-
  % Найти все family
  family(FamilyID, _, _, Children),
  % Если количество детей равно 1, то вывести первого member из family
  (length(Children, 1) -> member(_, FamilyID, муж, Фамилия, _, _, _, _, _, _), write('Семья: '), write(Фамилия), nl; true),
  fail.

% Сделать меню
