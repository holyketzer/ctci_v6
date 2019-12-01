import heapq

def topk(lists, k):
    lists = list(l for l in lists if len(l) > 0)

    if len(lists) == 0:
        return []

    # With pairs (-count, key)
    top_heap = []
    heapq.heapify(top_heap)

    offsets = [0] * len(lists)

    # With pairs (key, list_index)
    min_heap = []
    for li in range(0, len(lists)):
        min_heap.append((lists[li][0], li))
        offsets[li] = 1

    heapq.heapify(min_heap)
    min_pair = heapq.heappop(min_heap)
    heapq.heappush(min_heap, min_pair)

    last_min = min_pair[0]
    offsets[min_pair[1]] += 1
    count = 1
    print(min_heap)

    while len(min_heap) > 0:
        next_min, li = heapq.heappop(min_heap)

        if offsets[li] < len(lists[li]):
            heapq.heappush(min_heap, (lists[li][offsets[li]], li))
            print(min_heap)
            offsets[li] += 1

        if next_min != last_min:
            heapq.heappush(top_heap, (count, last_min))
            count = 1
            last_min = next_min

            if len(top_heap) > k:
                heapq.heappop(top_heap)
        else:
            count += 1

    heapq.heappush(top_heap, (count, next_min))
    if len(top_heap) > k:
        heapq.heappop(top_heap)

    res = []
    while len(top_heap) > 0:
        c, k = heapq.heappop(top_heap)
        res.append(k)

    res.reverse()
    return res

lists = [
    [1, 2, 3],
    [3, 4, 8],
    [1, 8],
    [2, 8]
]

print topk(lists, 3)
