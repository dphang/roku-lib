'Manages files downloaded via http
function RlDownloadManager() as Object
    this = {
        requests: {}
        
        Download: RlDownloadManager_Download
        DownloadBatch: RlDownloadManager_DownloadBatch
        CheckRequests: RlDownloadManager_CheckRequests
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

function RlDownloadManager_DownloadBatch(urlArray as Object) as void
    max = urlArray.Count() - 1
    for i = 0 to max
        url = urlArray[i]
        m.download(url)
    end for
end function

'Check whether requests have been downloaded
function RlDownloadManager_CheckRequests() as Void
    fs = CreateObject("roFileSystem")
    for each request in m.requests
        url = request.GetUrl()
        path = GetPathFromUrl(url)
        name = GetNameFromUrl(url)
        if fs.Exists(path) 'If the file exists, delete the request
           m.request.Delete(name)
        end if
    end for
end function

function RlDownloadManager_Clear() as Void
    m.requests.Clear()
    'fs = CreateObject("roFilesystem")
    'fs.Delete("tmp:/")
end function