'A simple LRU cache by bytes, rather than objects. For use especially with bitmaps. Based on code by Monsur Hossain. Ported by Daniel Phang.
'
'MIT LICENSE
'Copyright (c) 2007 Monsur Hossain (http://www.monsur.com)
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

function RlByteCache(capacity as Integer, sizeFunction as Object) as Object
    this = {
        sizeFunction: sizeFunction
        items: {}
        stats: {hits: 0, misses: 0}
        count: 0
        
        capacity: capacity
        
        Get: RlByteCache_Get
        Set: RlByteCache_Set
    }
    
    return this
end function

function RlByteCache_Get(key as String) as Dynamic
    item = m.items[key]
    
    if item <> invalid
        if m._isExpired(item)
            item.lastAccessed = 
        else
            m._removeItem(key)
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

function RlByteCache_Set(key as String, value as Dynamic, options)
    CacheItem = function(k as String, v as Dynamic, o as Object) as Object
        item = {}
        if k = invalid or k = ""
            print "Key cannot be null or empty"
            return invalid
        end if
        
        item.key = k
        item.value = v
        
        if o = invalid
            o = {}
        end if
        
        if o.expirationAbsolute <> invalid
            o.expirationAbsolute = o.expirationAbsolute.getTime()
        end if
        
        if o.priority = invalid
            o.priority = 2
        end if
        
        m.options = o
        m.lastAccessed =
    end function

    if m.items[key] <> invalid
        m._removeItem(key)
    end if
    m._addItem(CacheItem(key, value, options))
    
    if m.capacity > 0 and m.count > this.maxSize
        m._purge()
    end if
end function

function RlByteCache_Purge() as Void
    tmpArray = []
    
    for each key in m.items
        item = m.items[key]
        if m._isExpires(item)
            m._removeItem(key)
        else
            tmparray.Push(item)
        end if
    end for
    
    if tmpArray.Count() > m.purgeSize
        sortFunction = function (a as Object, b as Object) as Integer
            if a.options.priority <> b.options.priority
                return b.options.priority - a.options.priority
            else
                return b.lastAccessed - a.lastAccessed;
            end if
        end function
        Sort(tmpArray, sortFunction
    end if
end function