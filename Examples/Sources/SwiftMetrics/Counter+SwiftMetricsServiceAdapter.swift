import class Metrics.Counter
import protocol Tracker.SwiftMetricsServiceAdapter

extension Counter: SwiftMetricsServiceAdapter {
    public static func incrementCounter(_ counter: String, dimensions: [(String, String)]) {
        let counter = Counter(label: counter, dimensions: dimensions)
        counter.increment()
    }
}
