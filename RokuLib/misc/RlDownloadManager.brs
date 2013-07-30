'Manages downloads via http
function RlDownloadManager() as Object
    this = {
        downloads: {}
        
        Download: RlDownloadManager_download()
    }
end function