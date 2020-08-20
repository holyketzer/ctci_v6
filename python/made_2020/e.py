import math
import sys
from collections import defaultdict

# 1.   ordered — событие заказа такси. Описывается словами
# 1.1. order_id (идентификатор заказа, строка),
# 1.2. user_id (идентификатор пользователя, строка),
# 1.3. ordered_at (время заказа в Unix time*, целое число),
# 1.4. X (ожидаемое время подачи машины в минутах, целое число),
# 1.5. Y (ожидаемая длительность поездки в минутах, целое число)

# 2.   arrived — машина подана пользователю. Описывается словами
# 2.1. order_id (идентификатор заказа, строка),
# 2.2. arrived_at (время подачи машины, в Unix time, целое число)

# 3.   started — пользователь сел в машине и началась поездка. Описывается словами order_id и started_at аналогично событию arrived.

# 4.   finished — поездка завершилась. Описывается словами order_id и finished_at аналогично событию started.

class Order:
    def __init__(self, order_id):
        self.order_id = order_id
        self.user_id = None
        self.ordered_at = None
        self.x = None # X (ожидаемое время подачи машины в минутах, целое число),
        self.y = None # Y (ожидаемая длительность поездки в минутах, целое число)
        self.arrived_at = None
        self.started_at = None
        self.finished_at = None

    def full(self):
        return not(not(self.finished_at != None and self.started_at != None and self.arrived_at != None and self.ordered_at != None))

    def late(self, k):
        if self.started_at > self.arrived_at + (60 * k):
            return 0
        else:
            return max(0, self.finished_at - (self.ordered_at + (60 * (self.x + self.y + k))))

    def __repr__(self):
        return self.__str__()

    def __str__(self):
        return str({
            'order_id': self.order_id,
            'user_id': self.user_id,
            'ordered_at': self.ordered_at,
            'x': self.x,
            'y': self.y,
            'arrived_at': self.arrived_at,
            'started_at': self.started_at,
            'finished_at': self.finished_at,
        })

def find_or_add_order(orders, order_id):
    if order_id in orders:
        return orders[order_id]
    else:
        order = Order(order_id)
        orders[order_id] = order
        return order

x = int(sys.stdin.readline().strip())

for j in range(x):
    e, n, k = [int(i) for i in sys.stdin.readline().strip().split(' ')]

    # e - количество событий
    # n - кол-во пользователей с самыми большими суммарными опозданиями по вине компании за последний месяц
    # k - бесплатного времени ожидания K (измеряется в минутах)

    orders = {}

    for jj in range(e):
        event, *params = sys.stdin.readline().strip().split(' ')

        if event == 'ordered':
            order_id, user_id, ordered_at, x, y = params
            order = find_or_add_order(orders, order_id)
            order.user_id = user_id
            order.ordered_at = int(ordered_at)
            order.x = int(x)
            order.y = int(y)
        elif event == 'arrived':
            order_id, arrived_at = params
            order = find_or_add_order(orders, order_id)
            order.arrived_at = int(arrived_at)
        elif event == 'started':
            order_id, started_at = params
            order = find_or_add_order(orders, order_id)
            order.started_at = int(started_at)
        elif event == 'finished':
            order_id, finished_at = params
            order = find_or_add_order(orders, order_id)
            order.finished_at = int(finished_at)
        else:
            raise Exception("unexpected event type " + event)

    users = defaultdict(list)

    for order_id in orders.keys():
        order = orders[order_id]
        if order.full():
            users[order.user_id].append(order)

    lates = []

    for user_id in users.keys():
        total_late = 0
        user_orders = users[user_id]

        for order in user_orders:
            total_late += order.late(k)

        if total_late > 0:
            lates.append((total_late, user_id))

    lates = sorted(lates, key=lambda x: (-x[0], x[1]))

    if len(lates) > 0:
        print(' '.join(map(lambda pair: pair[1], lates[0:n])))
    else:
        print('-')
