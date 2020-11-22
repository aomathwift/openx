import Commander
import Foundation

let main = command(
    Argument<String>("filename", description: "The name of the file or directory to open")
) { (filename) in
    let pipe = Task(launchPath: "/usr/bin/xcrun").run("--find", "xcodebuild")
    guard let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8), let range = output.range(of: "/Contents/Developer/usr/bin/xcodebuild") else {
        fatalError("Could not select the appropriate Xcode")
    }
    let xcodeVersion = output
        .replacingCharacters(in: range, with: "")
        .trimmingCharacters(in: .newlines)
    
    Task(launchPath: "/usr/bin/open").run(filename, "-a", xcodeVersion)
}

main.run()
