import math
import sys
from collections import defaultdict

sys.setrecursionlimit(10000) # looks like it hadn't any effect

class Graph:
    def __init__(self):
        self.graph = defaultdict(list)
        self.uniq_vertices = set()

    # function to add an edge to graph
    def add_edge(self, u, v):
        self.graph[u].append(v)
        self.uniq_vertices.add(v)
        self.uniq_vertices.add(u)

    def topological_sort(self):

        # Create a vector to store indegrees of all
        # vertices. Initialize all indegrees as 0.
        in_degree = defaultdict(int)

        # Traverse adjacency lists to fill indegrees of vertices.  This step takes O(V + E) time
        for i in self.graph:
            for j in self.graph[i]:
                in_degree[j] += 1

        # Create an queue and enqueue all vertices with
        # indegree 0
        queue = []
        for i in self.uniq_vertices:
            if in_degree[i] == 0:
                queue.append(i)

        # Initialize count of visited vertices
        cnt = 0

        # Create a vector to store result (A topological
        # ordering of the vertices)
        top_order = []

        # One by one dequeue vertices from queue and enqueue
        # adjacents if indegree of adjacent becomes 0
        while queue:
            # Extract front of queue (or perform dequeue)
            # and add it to topological order
            u = queue.pop(0)
            top_order.append(u)

            # Iterate through all neighbouring nodes
            # of dequeued node u and decrease their in-degree
            # by 1
            for i in self.graph[u]:
                in_degree[i] -= 1
                # If in-degree becomes zero, add it to queue
                if in_degree[i] == 0:
                    queue.append(i)

            cnt += 1

        # Check if there was a cycle
        if cnt != len(self.uniq_vertices):
            raise Exception("There exists a cycle in the graph")
        else :
            # Print topological order
            return top_order

def merge(res, res2):
    for key in res2.keys():
        res[key] += res2[key]

    return res

def mult(res, count):
    for item in res.keys():
            res[item] *= count

    return res

def count_for(dish, reciepts, cache):
    if dish in cache:
        return cache[dish].copy()

    res = defaultdict(int)
    if dish in reciepts:
        reciept = reciepts[dish]

        for item in reciept.keys():
            if item in reciepts:
                res = merge(res, mult(count_for(item, reciepts, cache), reciept[item]))
            else:
                res[item] += reciept[item]

        cache[dish] = res.copy()
        return res
    else:
        return { dish: 1 }

x = int(sys.stdin.readline().strip())

for i in range(x):
    n, k, f = [int(i) for i in sys.stdin.readline().strip().split(' ')]

    cache = {}
    dishes = {}
    graph = Graph()

    for ii in range(n):
        dish, count = sys.stdin.readline().strip().split(' ')
        dishes[dish] = int(count)

    reciepts = {}

    for ii in range(k):
        dish, r = sys.stdin.readline().strip().split(' ')
        r = int(r)
        reciept = {}

        for ri in range(r):
            ingidient, amount = sys.stdin.readline().strip().split(' ')
            reciept[ingidient] = int(amount)
            graph.add_edge(ingidient, dish)

        reciepts[dish] = reciept

    fridge = {}

    for ii in range(f):
        ingidient, amount = sys.stdin.readline().strip().split(' ')
        fridge[ingidient] = int(amount)

    order = defaultdict(int)

    ordered_dish_list = graph.topological_sort()

    for dish in ordered_dish_list:
        if dish in dishes:
            sub_res = count_for(dish, reciepts, cache)

            mult(sub_res, dishes[dish])

            order = merge(order, sub_res)
        else:
            count_for(dish, reciepts, cache)

    for item in order.keys():
        if item in fridge:
            order[item] = order[item] - fridge[item]

    items = list(order.keys())
    items.sort()

    for item in items:
        if order[item] > 0:
            print(item, order[item])
