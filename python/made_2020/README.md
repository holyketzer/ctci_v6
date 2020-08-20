# A. N-битовое разреженное число

N-битовое разреженное число — это число, в бинарной записи которого присутствует ровно N единиц - все остальные нули. Например число 137 — 3-битовое разреженное, потому что в двоичной системе записи выглядит как 10001001.

Рассмотрим все 2-битовые разреженные числа, упорядоченные по возрастанию. Необходимо найти k-тое по порядку число в этой последовательности.

Ответ необходимо дать по модулю числа 35184372089371 (остаток от деления на это число).

```
Тесты с оценкой в 50: 1 <= k <= 10^3
Тесты с оценкой в 100: 1 <= k <=10^6
```

# B. Беспилотные автобусы на Манхеттене

Правительство Нью-Йорка решило запустить в городе беспилотные автобусы. Было решено начать с Манхеттена и поручить Добрыне разработать маршрутную карту.

Посмотрев на узкие улочки Манхеттена, Добрыня пришел к выводу, что не на каждом перекрестке автобусу хватит места, чтобы совершить поворот, поэтому первым делом Добрыня нашел все удобные для поворота перекрестки и обозначил их на карте.

Также Добрыня решил, что для сокращения рисков нужно минимизировать количество поворотов на маршруте каждого автобуса. Учитывая, что улицы на Манхеттене образуют сетку, и места для разворота на 180º на перекрестках нет, остался единственный вариант формы маршрута --- прямоугольной.

Придя к такому умозаключению, Добрыня задумался, а сколько вообще прямоугольных маршрутов через удобные перекрестки можно построить

Помогите Добрыне ответить на этот вопрос.

```
Количество перекрестков в одном наборе данных не превышает 2*10^3

Все координаты перекрестков целочисленные, в отрезке [-2147483648,2147483647].

Любой отрезок любого маршрута должен быть параллелен одной координатной оси.
```

# C. Казино Гальтона

Рулетка Гальтона представляет собой треугольную пирамиду с ячейками (см картинку ниже). На каждой ячейке написано число - стоимость этой ячейки. Сверху в самую первую ячейку кидают шарик. Шарик из текущей ячейки может равновероятно скатиться в одну из двух соседних ячеек уровнем ниже. Когда шарик скатывается на самый нижний уровень, подсчитывается сумма стоимостей всех ячеек, в которых побывал шарик. Эта сумма - выигрыш игрока в казино. 

Чтобы казино не разорилось, необходимо контролировать, чтобы средний выигрыш игрока не был слишком большим. Ваша задача - для данной рулетки Гальтона вычислить средний выигрыш игроке в ней (математическое ожидание). Ответ необходимо дать в виде несократимой дроби.

Если средний выигрыш равен нулю, то ответом считается дробь 0/1.

```
Высота (количество уровней) рулетки h: 1 <= h <= 63. Значение в одной ячейке - целое число c: -100 <= c <= 100. 
```

# D. Немножко сломанный HTML

Было замечено, что у разработчиков веб-сайтов очень частая ошибка - это случайное добавление одного лишнего тега в html документ, который делает его некорректным. В рамках кампании по улучшению качества разрабатываемого программного обеспечения, было принято решение о разработке программы для автоматического исправления подобного рода ошибок. 

HTML-документ - это последовательность открывающих и закрывающих тегов. Открывающий тег - это последовательность английских букв, обособленных треугольными скобками с двух сторон. Пример - <html> . Закрывающий тег - это тоже самое, что и открывающих тег, но с дополнительным символом слеша после левой треугольной скобки. Пример - </html>. 

Тег </X> является закрывающим тегом к <Y>, если X = Y (<Y> тогда - это открывающих тег для </X>). Все теги регистронезависимые - это означает, что <HTML> и <html> - это один и тот же тег.

Каждый тег определяет элемент на странице. Элемент может быть пустой - это означает, что после открывающего тега элемента, сразу стоит закрывающий. Элементы могут быть вложенными друг в друга. Это означает, что между открывающим и закрывающим тегом находятся еще какое-то количество элементов. 

При этом для корректного документа должны выполняться следующие свойства:

Для одного открывающего тега может быть ровно один закрывающий тег.
Для одного закрывающего тега может быть ровно один открывающий тег.
Элементы могут быть только строго вложенными друг в друга - перехлест элементов запрещен (например <x><y></x></y>).
HTML-документ считается сломанным, если какое-то из этих свойств нарушается. Например, для данного тега не нашлось открывающего\закрывающего тега или существует перехлест в тегах.

Для заданного HTML документа необходимо выяснить, является ли он сломанным или нет. Если документ является сломанным, то нужно узнать, не был ли он сломан случайно разработчиком (разработчик мог случайно добавить один лишний тег). То есть, если документ сломан, нужно проверить, можно ли его починить, удалив ровно один тег.

```
Количество строк в документе h: 1 <= h <= 10^6.

Количество букв внутри тега k: 1 <= k <= 100.
```

# E. Обиженные пассажиры

В одной компании, предоставляющей услуги такси, решили раздать бонусы для повышения лояльности N пользователей с самыми большими суммарными опозданиями по вине компании за последний месяц. Для решения этой задачи необходимо проанализировать логи событий, связанных с заказами такси.

Каждое событие в логах описывается одной строкой, содержащей несколько слов, разделенных пробельными символами (слово является непустой последовательностью строчных латинских букв, цифр, нижних подчеркиваний и дефисов). Первое слово в строке всегда определяет тип события.

Всего есть 4 типа событий:

1. ordered —событие заказа такси. Описывается словами 
1.1. order_id (идентификатор заказа, строка), 
1.2. user_id (идентификатор пользователя, строка), 
1.3. ordered_at (время заказа в Unix time*, целое число), 
1.4. X (ожидаемое время подачи машины в минутах, целое число), 
1.5. Y (ожидаемая длительность поездки в минутах, целое число)
2. arrived — машина подана пользователю. Описывается словами
2.1. order_id (идентификатор заказа, строка), 
2.2. arrived_at (время подачи машины, в Unix time, целое число)
3. started — пользователь сел в машине и началась поездка. Описывается словами order_id и started_at аналогично событию arrived.
4. finished — поездка завершилась. Описывается словами order_id и finished_at аналогично событию started.
* момент времени в Unix time —это целое число секунд, прошедших с полуночи 1 января 1970 года.

Считается, что пользователь опоздал, если поездка закончилась позже, чем ориентировочное время окончание поездки, рассчитанное исходя из предполагаемого времени подачи машины X, бесплатного времени ожидания K (измеряется в минутах) и предполагаемой длительности поездки Y.

При этом важно учитывать только опоздания, произошедшие по вине компании: если пользователь не садился в машину дольше K минут после подачи, мы считаем его виноватым в своем опоздании, даже если сама поездка тоже оказалась дольше, чем прогнозировалось.

Обратите внимание, что логи пишутся на разных компьютерах и сливаются в единое хранилище несинхронно, поэтому события никак не упорядочены.

```
Все числа неотрицательные и не превышают 2147483647. Каждая строка входных данных по длине не превышает 1000 символов.

Суммарное количество строк во наборах входных данных не превышает 10^7.

Гарантируется, что ordered_at <= arrived_at <= started_at <= finished_at.
```

# F. Продукты для застолья

Маруся организует застолье, и ей необходимо приготовить блюда для гостей, поэтому она составила меню: какие блюда и в каком количестве она собирается приготовить. 

Теперь ей необходимо обзавестись продуктами для готовки, поэтому Маруся составляет заказ в онлайн-магазине продуктов. К сожалению, в составленном ею меню слишком много блюд с замысловатыми рецептами, к тому же часть продуктов Маруся уже купила и сложила в холодильник, так что она совершенно запуталась.

Вам необходимо помочь Марусе составить заказ. Маруся передала вам всю необходимую для этого информацию:

Меню, в котором написан перечень из N блюд и их количеств.
Кулинарная книга, в которой содержится K рецептов. i-й рецепт содержит R_i ингредиентов и в каком количестве они нужны. Обратите внимание, что одно блюдо может выступать как ингредиент для другого. Например, рецепты лазаньи и пасты болоньезе включают в себя соус болоньезе, для которого в книге содержится отдельный рецепт. 
Опись холодильника, содержащую перечень из F продуктов и их количества.
Вам необходимо проанализировать эту информацию и составить заказ в магазине — список продуктов и их количество. Обратите внимание, что Маруся ненавидит полуфабрикаты, поэтому если для какого-то ингредиента есть рецепт в книге, то она его приготовит сама, и его не нужно покупать в магазине. Также можно быть уверенным, что в холодильнике Маруси нет таких полуфабрикатов.

```
1 <= N, K, F, R_i <= 5000

Все числа (количества продуктов во вводе и корректном выводе) положительные и не превышают 2^63-1.

Гарантируется, что для всех блюд из меню в книге присутствуют рецепты.
```