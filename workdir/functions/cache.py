import queue

#store most recent 100 items in cache
#use a queue to store the items
#look into cache hitting and missing (this will likely use a diferent data structure)

#reduce load on the server by caching the most recent 100 items
class Cache:
    def __init__(self):
        self.thisCache = queue.Queue(maxsize=100)
        
    def cache(self,item):
        if self.thisCache.full():
            #remove the oldest item from the cache
            self.thisCache.get()
            #add the new item to the cache
        self.thisCache.put(item)
        
    def contains(self, item):
        return item in self.cache

