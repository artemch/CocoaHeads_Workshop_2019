import Foundation

extension F {
    
    static func executeOn<T>(simulator: () -> (T), device: () -> (T)) -> T {
        #if targetEnvironment(simulator)
        return simulator()
        #else
        return device()
        #endif
    }
    
    
    static func executeOn(simulator: (() -> ())? = nil, device: (() -> ())? = nil) {
        executeOn(simulator: simulator ?? {}, device: device ?? {})
    }
}
