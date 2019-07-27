import ReactiveSwift

extension F {
    static func jsonMock<T: Decodable>(fileName: String) -> SignalProducer<T, BackendError> {
        return self.jsonMockInternal(fileName: fileName)
            .delay(0.5, on: QueueScheduler(name: "com.idap.mock_json"))
    }
    
    fileprivate static func jsonMockInternal<T: Decodable>(fileName: String) -> SignalProducer<T, BackendError> {
        if let url = F.moduleBundle().url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url)
        {
            return F.decode(jsonData: data)
        } else {
            return SignalProducer(error: .error(reason: "No \(fileName).json file"))
        }
    }
}
