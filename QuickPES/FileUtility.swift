import Foundation

struct FileUtility {
    static func ensurePermission(for directory: URL) -> Bool {
         let testFileURL = directory.appendingPathComponent("testPermission.txt")
         
         do {
             try "test".write(to: testFileURL, atomically: true, encoding: .utf8)
             try FileManager.default.removeItem(at: testFileURL)
             return true
         } catch {
             // If the write fails, it's likely due to permissions.
             return false
         }
     }
    
    static func checkPermissions(sourceURLs: [URL], targetDirectoryURL: URL) -> Bool {
        let fileManager = FileManager.default
        
        for sourceURL in sourceURLs {
            guard fileManager.isReadableFile(atPath: sourceURL.path) else {
                return false
            }
        }
        
        // Check if the target directory is writable
        return fileManager.isWritableFile(atPath: targetDirectoryURL.path)
    }

    static func copyFiles(from urls: [URL], to targetDirectory: URL, with folderName: String) -> String {
        let fileManager = FileManager.default
        let destinationFolderURL = targetDirectory.appendingPathComponent(folderName)
        
        do {
            if !fileManager.fileExists(atPath: destinationFolderURL.path) {
                try fileManager.createDirectory(at: destinationFolderURL, withIntermediateDirectories: true, attributes: nil)
            }
            
            for url in urls where url.pathExtension == "pes" {
                let destinationURL = destinationFolderURL.appendingPathComponent(url.lastPathComponent)
                if fileManager.fileExists(atPath: destinationURL.path) {
                    return "Error: File \(url.lastPathComponent) already exists. Please choose a different name or folder."
                } else {
                    try fileManager.copyItem(at: url, to: destinationURL)
                }
            }
            
            return "Files copied successfully!"
        } catch {
            return "Error occurred: \(error.localizedDescription)"
        }
    }
    
    static func detectUSBDrives() -> [URL] {
        let fileManager = FileManager.default
        let keys: [URLResourceKey] = [.volumeNameKey, .volumeIsLocalKey]
        guard let urls = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: keys, options: []) else {
            return []
        }
        
        let usbURLs = urls.filter { url in
            guard let isLocal = try? url.resourceValues(forKeys: Set(keys)).volumeIsLocal else {
                return false
            }
            return isLocal == true
        }
        
        return usbURLs
    }

    static func unmountUSB(at path: String) -> Bool {
        let task = Process()
        task.launchPath = "/usr/sbin/diskutil"
        task.arguments = ["unmount", path]
        task.launch()
        task.waitUntilExit()
        return task.terminationStatus == 0
    }
}
