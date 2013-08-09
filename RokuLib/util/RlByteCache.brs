'A simple LRU byte cache. Can also be used as a normal item cache (simply set size function to return a constant such as 1)
'Adapted by Daniel Phang based on code by Monsur Hossain.
'
'MIT LICENSE
'Copyright (c) 2007 Monsur Hossain (http://www.monsur.com) and Daniel Phang
'
'Permission is hereby granted, free of charge, to any person
'obtaining a copy of this software and associated documentation
'files (the "Software"), to deal in the Software without
'restriction, including without limitation the rights to use,
'copy, modify, merge, publish, distribute, sublicense, and/or sell
'copies of the Software, and to permit persons to whom the
'Software is furnished to do so, subject to the following
'conditions:
'
'The above copyright notice and this permission notice shall be
'included in all copies or substantial portions of the Software.
'
'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
'EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
'OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
'NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
'HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
'WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
'FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
'OTHER DEALINGS IN THE SOFTWARE.

function RlByteCache(maxSize as Integer, sizeFunction as Dynamic) as Object
    this = {
        maxSize: maxSize
        sizeFunction: sizeFunction
        items: {}
        timer: CreateObject("roTimespan")
        size: 0
        fillFactor: 0.75
        
        stats: {hits: 0, misses: 0}
        
        Get: RlByteCache_Get
        Set: RlByteCache_Set
        
        'Private methods
        RemoveItem: RlByteCache_RemoveItem
        IsExpired: RlByteCache_IsExpired
        Purge: RlByteCache_Purge
        AddItem: RlByteCache_AddItem
        PrintAll: RlByteCache_PrintAll
        Clear: RlByteCache_Clear
        CacheItem: RlByteCacheItem
        Exists: RlByteCache_Exists
        
        PRIORITY_LOW: 1
        PRIORITY_NORMAL: 2
        PRIORITY_HIGH: 4
    }
    
    this.purgeSize = this.fillFactor * this.maxSize
    
    return this
end function

function RlByteCache_Get(key as String) as Dynamic
    item = m.items[key]
    
    if item <> invalid
        if not m.IsExpired(item)
            item.lastAccessed = m.timer.TotalMilliseconds()
        else
            m.RemoveItem(key)
            item = invalid
        end if
    end if
    
    returnVal = invalid
    
    if item <> invalid
        returnVal = item.value
        m.stats.hits = m.stats.hits + 1
    else
        m.stats.misses = m.stats.misses + 1
    end if
    
    return returnVal
end function

function RlByteCache_Set(key as String, value as Dynamic, options = invalid as Dynamic) as Void
    if m.items[key] <> invalid
        m.RemoveItem(key)
    end if
    m.AddItem(m.CacheItem(key, value, options))

    while m.size > m.maxSize and m.maxSize > 0 'Need a while loop since we want to purge bitmaps until there are enough free bytes
        m.Purge()
    end while
    
end function

function RlByteCache_Clear() as Void
    m.items = {}
    m.size = 0
end function

function RlByteCache_Purge() as Void
	print "Purging..."
    tmpArray = []
    
    for each key in m.items
        item = m.items[key]
        if m.IsExpired(item)
            m.RemoveItem(key)
        else
            tmparray.Push(item)
        end if
    end for

    'Compute total size of all elements in the cache
    totalSize = 0
    max = tmpArray.Count() - 1
    for i = 0 to max
        item = tmpArray[i]
        totalSize = totalSize + m.sizeFunction(item.value)
    end for
    
    'Purge if total size is greater than purge size
    if totalSize > m.purgeSize
        RlQuickSort(tmpArray, RlByteCache_Comparator)
        
        for i = 0 to tmpArray.Count() - 1
            item = tmpArray[i]
        end for
        
        while totalSize > m.purgeSize
            ritem = tmpArray.Shift()
            m.RemoveItem(ritem.key)
            totalSize = totalSize - m.sizeFunction(ritem.value)
        end while
    end if
end function

function RlByteCache_AddItem(item as Object) as Void
    m.items[item.key] = item
    m.size = m.size + m.sizeFunction(item.value)
end function

function RlByteCache_RemoveItem(key as String) as Void
    item = m.items[key]
    m.items.Delete(key)
    m.size = m.size - m.sizeFunction(item.value)
end function

function RlByteCache_IsExpired(item as Object) as Boolean
    now = m.timer.TotalMilliseconds()
    expired = false
    
    if item.options.expirationAbsolute <> invalid and item.options.expirationAbsolute < now
        expired = true
    end if
    
    if not expired and item.options.expirationSliding <> invalid
        lastAccess = item.lastAccessed + item.options.expirationSliding * 1000
        if lastAccess < now
            expired = true
        end if
    end if 
    
    return expired
end function

'Prints the contents of this RlByteCache
function RlByteCache_PrintAll() as Void
    for each key in m.items
        print tostr(m.items[key].value)
    end for
end function

function RlByteCacheItem(k as String, v as Dynamic, o as Object) as Object
    this = {}
    
    if k = invalid or k = ""
        print "Key cannot be null or empty"
        return invalid
    end if
    
    this.key = k
    this.value = v
    
    if o = invalid
        o = {}
    end if
    
    if o.expirationAbsolute <> invalid
        o.expirationAbsolute = o.expirationAbsolute.GetTime()
    end if
    
    if o.priority = invalid
        o.priority = m.PRIORITY_NORMAL
    end if
    
    this.options = o
    this.lastAccessed = m.timer.TotalMilliseconds()
    
    return this
end function

function RlByteCache_Comparator(a as Object, b as Object) as Integer 'Sort by priority, then by access time
    if a.options.priority <> b.options.priority
        return a.options.priority - b.options.priority
    else
        return a.lastAccessed - b.lastAccessed
    end if
end function

function RlByteCache_Exists(key as String) as Boolean
    return m.items.DoesExist(key)
end function