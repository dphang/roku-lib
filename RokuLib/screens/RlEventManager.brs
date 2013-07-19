'Custom event manager
function RlEventManager() as Object
    this = {
        events: []
        
        NewEvent: RlEventManager_NewEvent
    }
    
    return this
end function

function RlEventManager_NewEvent(name as String) as Void
    m.events.Push(name)
end function

function RlEventManager_GetLastEvent() as Object
    return m.events.Pop()
end function