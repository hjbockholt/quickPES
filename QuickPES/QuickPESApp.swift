import SwiftUI

@main
struct QuickPESApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandMenu("Help") {
                Button("QuickPES User Guide") {
                    // Open the User Guide view
                    openUserGuide()
                }
                .keyboardShortcut("?", modifiers: [.command])
            }
        }
    }
    
    func openUserGuide() {
        // Logic to open a new window with the UserGuideView
        let userGuideWindow = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 400, height: 300),
            styleMask: [.titled, .closable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        userGuideWindow.center()
        userGuideWindow.setFrameAutosaveName("User Guide Window")
        userGuideWindow.contentView = NSHostingView(rootView: UserGuideView())
        userGuideWindow.makeKeyAndOrderFront(nil)
    }
}

struct UserGuideView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("QuickPES User Guide")
                .font(.title)
                .padding(.top)

            Text("1. Drag and drop a folder containing your .pes files into the QuickPES app.")
            Text("2. Choose the USB drive to which you'd like to copy your files.")
            Text("3. Enter a subfolder name for the .pes files on the USB drive.")
            Text("4. Wait for the files to be copied. A progress indicator will show the copying progress.")
            Text("5. Once copying is complete, you will receive a notification.")
            Text("6. If desired, you can unmount the USB drive directly from the app.")
            Text("For support or inquiries, contact: H Jeremy Bockholt at hjbockholt@gmail.com.")
        }
        .padding()
    }
}
