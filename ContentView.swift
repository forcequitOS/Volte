// I definitely did not copy the outline for this from Stasis.
import SwiftUI

struct ContentView: View {
    // Revolutionary variables
    @State private var showingAlert = false
    @State private var message = ""
    @State private var pendingAction: (() -> Void)? // This idea was bestowed upon me by Claude. Thanks Claude!
    @AppStorage("enableAlerts") private var enableAlerts = true
    // 2 columns
    private var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]

    var appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown Version"
    var tvVersion = ProcessInfo.processInfo.operatingSystemVersionString
    
    var body: some View {
        TabView {
            if #available(tvOS 16.0, *) {
                NavigationStack {
                    MainView
                }
                .tabItem {
                    Label("Volte", systemImage: "bolt.fill")
                }
                
                NavigationStack {
                    SettingsView
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            } else {
                NavigationView {
                    MainView
                }
                .tabItem {
                    Label("Volte", systemImage: "bolt.fill")
                }
                
                NavigationView {
                    SettingsView
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
    }
    
    // Settings (More of an About page really.)
    private var SettingsView: some View {
        VStack {
            // Show Confirmation Alerts toggle
            Toggle(isOn: $enableAlerts) {
                Text("Show Confirmation Alerts")
            }
            // App Version
            Button(action: {}) {
                HStack {
                    Text("Volte Version")
                    Spacer()
                    Text(appVersion)
                        .foregroundColor(.gray)
                }
            }
            // tvOS Version
            Button(action: {}) {
                HStack {
                    Text("tvOS Version")
                    Spacer()
                    Text(tvVersion)
                        .foregroundColor(.gray)
                }
            }
            // Made By
            Button(action: {}) {
                HStack {
                    Text("Made By")
                    Spacer()
                    Text("Taj C (forcequit)")
                        .foregroundColor(.gray)
                }
            }
            // Inspired By
            Button(action: {}) {
                HStack {
                    Text("Inspired By")
                    Spacer()
                    Text("PowerApp by Dave1482")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .navigationTitle("Settings")
        .padding()
        .frame(maxWidth: 1000)
    }
    
    private var MainView: some View {
        VStack {
            Spacer()
            LazyVGrid(
                columns: columns,
                alignment: .center
            ) {
                // With Liquid Glass, the buttons look really nice and vibrant, without it, the colors look like pastels... oh well. The wonders of SwiftUI on tvOS.
                
                // Power Off | Restart
                Group {
                    Button {
                        pendingAction = { shutdown() }
                        message = "Shutting down will completely power off your Apple TV, this is functionally identical to a restart, as it will power back on momentarily. You will lose your jailbreak. Are you sure you'd like to continue?"
                        if enableAlerts {
                            showingAlert = true
                        } else {
                            pendingAction?()
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "power")
                                .font(.system(size: 60))
                            Text("Power Off")
                                .font(.headline)
                        }
                        .frame(width: 750, height: 175)
                    }
                    Button {
                        pendingAction = { reboot() }
                        message = "Restarting will completely power off your Apple TV and power it back on, thus losing your jailbreak. This can be convenient if you want to enter DFU on an Apple TV 4K. Are you sure you'd like to continue?"
                        if enableAlerts {
                            showingAlert = true
                        } else {
                            pendingAction?()
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "restart")
                                .font(.system(size: 60))
                            Text("Restart")
                                .font(.headline)
                        }
                        .frame(width: 750, height: 175)
                    }
                } .background(Color.red)
                    .cornerRadius(.infinity)
                
                // Respring | Restart Userspace
                Group {
                    Button {
                        pendingAction = { respring() }
                        message = "Respringing will reload PineBoard, the Home Screen process for your Apple TV. This will exit any apps you have open. Are you sure you'd like to continue?"
                        if enableAlerts {
                            showingAlert = true
                        } else {
                            pendingAction?()
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "goforward") // instead of arrow.clockwise, only to match the userspace reboot option
                                .font(.system(size: 60))
                            Text("Respring")
                                .font(.headline)
                        }
                        .frame(width: 750, height: 175)
                    }
                    Button {
                        pendingAction = { userspaceReboot() }
                        message = "Performing a userspace restart will reload everything except the kernel, allowing your jailbreak to persist. Are you sure you'd like to continue?"
                        if enableAlerts {
                            showingAlert = true
                        } else {
                            pendingAction?()
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 60))
                            Text("Restart Userspace")
                                .font(.headline)
                        }
                        .frame(width: 750, height: 175)
                    }
                } .background(Color.blue)
                    .cornerRadius(.infinity)
                
                // Refresh Icon Cache | Exit Volte
                Group {
                    Button {
                        pendingAction = { runUICache() }
                        message = "Refreshing icon cache will allow for new app installs or removals to apply on the Home Screen. Your Apple TV will freeze for a moment, before returning to the Home Screen. Are you sure you'd like to continue?"
                        if enableAlerts {
                            showingAlert = true
                        } else {
                            pendingAction?()
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 60))
                            Text("Refresh Icon Cache")
                                .font(.headline)
                        }
                        .frame(width: 750, height: 175)
                    }
                    Button {
                        pendingAction = { exit(0) }
                        message = "Exit Volte to return to the Home Screen. Are you sure you'd like to continue?"
                        if enableAlerts {
                            showingAlert = true
                        } else {
                            pendingAction?()
                        }
                    } label: {
                        VStack(spacing: 20) {
                            Image(systemName: "xmark.square")
                                .font(.system(size: 60))
                            Text("Exit Volte")
                                .font(.headline)
                        }
                        .frame(width: 750, height: 175)
                    }
                } .background(Color.green)
                    .cornerRadius(.infinity)
                
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Volte")
        // Confirmation alert
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Confirmation"),
                message: Text(message),
                primaryButton: .destructive(Text("Confirm")) {
                    pendingAction?() // Again may Anthropic bless your soul Claude for this idea
                },
                secondaryButton: .cancel(Text("Cancel"))
            )
        }
    }
    
    // Helper stuff to get posix_spawn dynamically, which we need for all the operations...
    // ChatGPT did all of this
    typealias posix_spawn_fn = @convention(c) (
        UnsafeMutablePointer<pid_t>?,
        UnsafePointer<CChar>?,
        UnsafePointer<posix_spawn_file_actions_t>?,
        UnsafePointer<posix_spawnattr_t>?,
        UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?,
        UnsafeMutablePointer<UnsafeMutablePointer<CChar>?>?
    ) -> Int32

    private let posix_spawn_ptr: posix_spawn_fn? = {
        guard let sym = dlsym(UnsafeMutableRawPointer(bitPattern: -2), "posix_spawn") else {
            return nil
        }
        return unsafeBitCast(sym, to: posix_spawn_fn.self)
    }()

    func spawnBinary(_ path: String, _ args: [String]) {
        guard let posix_spawn = posix_spawn_ptr else { return }
        var pid: pid_t = 0
        let argv = ([path] + args).map { strdup($0) } + [nil]
        argv.withUnsafeBufferPointer { buffer in
            posix_spawn(&pid, path, nil, nil, UnsafeMutablePointer(mutating: buffer.baseAddress), environ)
        }
        argv.forEach { if let p = $0 { free(p) } }
    }
    
    // Functions for the operations in question
    func shutdown() {
        spawnBinary("/usr/bin/launchctl", ["reboot", "halt"]) // Thank you, launchctl, for your reboot actions being callable without root.
        // I tried relentlessly to get spawning binaries as root working (Without just adding TSUtil.m, "think different" or something.) to no avail. Thankfully this exists.
    }
    
    func reboot() {
        // spawnBinary("/usr/sbin/reboot", [])
        // ^^^^^ Doing that would have required root, rebooting via launchctl is way better for that reason
        spawnBinary("/usr/bin/launchctl", ["reboot"])
    }
    
    // I was heavily thinking of doing respring + killall manually at first, but since I already am gonna just be using posix_spawn for a bunch of things, no need to beat around the bush anymore.
    func respring() {
        spawnBinary("/usr/bin/killall", ["PineBoard"])
    }
    
    func userspaceReboot() {
        spawnBinary("/usr/bin/launchctl", ["reboot", "userspace"])
    }
    
    func runUICache() {
        spawnBinary("/usr/bin/uicache", ["--all", "--force", "--respring"])
        // I don't like that I had to touch UIKit for this
        // Shoutouts to:
        // https://stackoverflow.com/questions/62660660/how-to-present-an-alert-in-swiftui-with-no-buttons
        // https://stackoverflow.com/questions/57134259/how-to-resolve-keywindow-was-deprecated-in-ios-13-0
        var dialog = UIAlertController(title: "Refreshing Icon Cache...", message: nil, preferredStyle: .alert)
        // Loading indicator goes to ChatGPT again
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        dialog.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: dialog.view.centerXAnchor),
            indicator.bottomAnchor.constraint(equalTo: dialog.view.bottomAnchor, constant: -40)
        ])
        let window = UIApplication.shared.windows.last { $0.isKeyWindow }
        window?.rootViewController?.present(dialog, animated: true)
    }
}
