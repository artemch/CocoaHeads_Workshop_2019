
import Foundation

public func environment<R>(production: () -> R, development: () -> R) -> R {
#if PRODUCTION
    return production()
#else
    return development()
#endif
}
