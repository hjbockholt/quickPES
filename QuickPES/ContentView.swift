import SwiftUI

struct ContentView: View {
    @State private var selectedFiles: [URL] = []
    @State private var selectedUSB: URL?
    @State private var outputMessage: String = ""
    @State private var subfolderName: String = "PES_Files"  // Default name

    var body: some View {
        VStack(spacing: 20) {
            Text("Drag & Drop your files or folders here:")

            TextField("Subfolder Name", text: $subfolderName)
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )

            Button("Select .PES Files") {
                showFilePicker()
            }

            if let usbURL = selectedUSB {
                Text("Selected USB: \(usbURL.path)")
            }

            Button("Select Target USB Directory") {
                showDirectoryPicker()
            }

            Button("Copy .PES Files") {
                if let usbURL = selectedUSB {
                    outputMessage = FileUtility.copyFiles(from: selectedFiles, to: usbURL, with: subfolderName)
                } else {
                    outputMessage = "Please select a valid USB directory first."
                }
            }

            Text(outputMessage)
                .foregroundColor(.red)
        }
        .padding()
    }

    private func showFilePicker() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = true
        panel.canChooseDirectories = true // Allow directory selection to fetch .pes files recursively
        panel.canChooseFiles = true
        panel.begin { result in
            if result == .OK {
                let selectedURLs = panel.urls
                self.selectedFiles = selectedURLs.flatMap { fetchPESFilesRecursively(from: $0) }
            }
        }
    }

    private func fetchPESFilesRecursively(from directory: URL) -> [URL] {
        var pesFiles: [URL] = []

        if let enumerator = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [URLResourceKey.isDirectoryKey], options: []) {
            for case let fileURL as URL in enumerator {
                do {
                    let resourceValues = try fileURL.resourceValues(forKeys: [.isDirectoryKey])
                    if let isDirectory = resourceValues.isDirectory, !isDirectory {
                        if fileURL.pathExtension == "pes" {
                            pesFiles.append(fileURL)
                        }
                    }
                } catch {
                    print("Error fetching files: \(error)")
                }
            }
        }

        return pesFiles
    }
    
    private func showDirectoryPicker() {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = false
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        panel.begin { result in
            if result == .OK, let url = panel.urls.first {
                self.selectedUSB = url
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
