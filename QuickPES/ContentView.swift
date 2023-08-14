import SwiftUI
import UniformTypeIdentifiers  // Import for UTType

struct ContentView: View {
    @State private var selectedFiles: [URL] = []
    @State private var selectedUSB: URL?
    @State private var outputMessage: String = ""
    @State private var subfolderName: String = "PES_Files"  // Default name
    
    var body: some View {
        VStack(spacing: 20) {
            Text("A utility tool to simplify the organization and transfer of .pes files for Brother embroidery systems.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            HStack {
                VStack {
                    Text("Drag & Drop your files or folders here:")
                        .onDrop(of: [UTType.fileURL.identifier], isTargeted: nil) { providers in
                            _ = providers.first?.loadObject(ofClass: URL.self) { url, error in
                                if let actualURL = url {
                                    DispatchQueue.main.async {
                                        self.selectedFiles = fetchPESFilesRecursively(from: actualURL)
                                    }
                                }
                            }
                            return true
                        }
                        .frame(width: 300, height: 150)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8.0)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.blue, lineWidth: 2))
                    
                    // Displaying the paths of the selected files
                    if !selectedFiles.isEmpty {
                        Text("Selected files:")
                            .padding(.top, 10)
                        
                        ScrollView {
                            ForEach(selectedFiles.indices, id: \.self) { index in
                                Text(selectedFiles[index].path)
                            }
                        }
                        .frame(height: 100)
                    }
                }
                
                Spacer()
                
                VStack {
                    Spacer()
                    Button("Or Browse Files Manually") {
                        showFilePicker()
                    }
                    Spacer()
                }
            }
            
            VStack(spacing: 20) {
                HStack {
                     Text("Subfolder Name:")
                         .frame(width: 120, alignment: .trailing)
                     TextField("Enter Subfolder Name", text: $subfolderName)
                         .frame(width: 100) // Set the desired width here
                         .padding(10)
                         .overlay(
                             RoundedRectangle(cornerRadius: 5)
                                 .stroke(Color.gray, lineWidth: 1)
                         )
                         .onChange(of: subfolderName) { newName in
                             if newName.count > 20 {
                                 subfolderName = String(newName.prefix(20))
                             }
                         }
                 }
                HStack {
                    Button("Select Target USB Directory") {
                        showDirectoryPicker()
                    }
                    Spacer()
                    Text("Selected USB:")
                        .frame(width: 120, alignment: .trailing)
                    if let usbURL = selectedUSB {
                        Text(usbURL.path)
                            .lineLimit(1)
                            .truncationMode(.middle)
                    }
                }
            }
            .padding()

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
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.begin { result in
            if result == .OK {
                let selectedURLs = panel.urls
                self.selectedFiles.append(contentsOf: selectedURLs)
            }
        }
    }

    private func fetchPESFilesRecursively(from directory: URL) -> [URL] {
        var pesFiles: [URL] = []

        if let enumerator = FileManager.default.enumerator(at: directory, includingPropertiesForKeys: [.isDirectoryKey], options: []) {
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
