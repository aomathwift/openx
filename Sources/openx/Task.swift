import Foundation

struct Task {
    let launchPath: String
    @discardableResult
    func run(_ args: String...) -> Pipe {
        let pipe = Pipe()
        let process = Process()
        process.launchPath = self.launchPath
        process.arguments = args
        process.standardOutput = pipe
        process.launch()
        process.waitUntilExit()
        return pipe
    }
}
