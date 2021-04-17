@testable import NetworkExpectation
import XCTest


final class NetworkTests: XCTestCase {

    func test_request() {
        let client = NetworkClientStub()
        let sut = Network(client: client)        
    }
}

private class NetworkClientStub: NetworkClient {
    func get(for url: URL, completion: @escaping (Data) -> Void) {
        completion(Data())
    }
}
