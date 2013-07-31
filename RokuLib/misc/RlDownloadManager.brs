'Manages files downloaded via http
function RlDownloadManager() as Object
    this = {
        requests: {}
        
        'Private variables
        start: 0
        duration: 0
        urlArray: []
        
        Download: RlDownloadManager_Download
        DownloadBatch: RlDownloadManager_DownloadBatch
        Update: RlDownloadManager_Update
        Clear: RlDownloadManager_Clear
    }
    
    return this
end function

'Starts a download of the url
function RlDownloadManager_Download(url as String) as void
    name = GetNameFromUrl(url)
    if not m.requests.DoesExist(name)
        request = CreateObject("roUrlTransfer")
        request.SetUrl(url)
        path = GetPathFromUrl(url)
        request.AsyncGetToFile(path)
        m.requests[name] = request
    end if
end function

'Sets this download manaer to request each url given in urlArray. To simulate nonblocking behavior, a maximum duration to try to create a download request
'can be specified (in case there are too many downloads)
'@param urlArray a roArray of url strings
'@param duration the approximate maximum duration update should run, in milliseconds
function RlDownloadManager_DownloadBatch(urlArray as Object, duration = 1 as Integer) as Void
    m.urlArray = ArrayCopy(urlArray)
    m.start = 0
    m.count = m.urlArray.Count()
    m.duration = duration
end function

function RlDownloadManager_Clear() as Void
    m.requests.Clear()
    'fs = CreateObject("roFilesystem")
    'fs.Delete("tmp:/")
end function

function RlDownloadManager_Update() as Boolean
    'Start requests not already started
    updated = false
    timer = CreateObject("roTimespan")
    if m.count <> 0 'Check if there is something to download
        for i = m.start to m.count - 1 'Start at wherever we left off in a previous update
            if (i - m.start >= 1) and m.duration > 0 and timer.TotalMilliseconds() > m.duration 'If running too long, return, but only if at least one was downlaoded
                m.start = i
                return updated
            end if
            item = m.urlArray[i]
            if item <> invalid then m.Download(item)
            updated = true 'If one pass finished, updated is set to true
        end for
        
        'Finished, reinitialize urlArray
        m.urlArray = []
        m.start = 0
        m.count = 0
    end if
    
    fs = CreateObject("roFileSystem")
    doneOnce = false
    for each name in m.requests
        if doneOnce and m.duration > 0 and timer.TotalMilliseconds() > m.duration 'If running too long, return
            return updated
        end if
        url = m.requests[name].GetUrl()
        path = GetPathFromUrl(url)
        if fs.Exists(path) 'If the file exists, delete the request
           m.requests.Delete(name)
        end if
        doneOnce = true
    end for
    
    
    return updated
end function