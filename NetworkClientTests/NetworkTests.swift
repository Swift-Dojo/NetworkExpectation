@testable import NetworkExpectation
import XCTest


final class NetworkTests: XCTestCase {

    func test_request() {
        let anyData = Data()
        let anyURL = URL(string: "https://google.com")!
        let client = NetworkClientStub(completesWith: anyData)
        let sut = Network(client: client)
        let exp = expectation(description: "Network client expectation")
        
        sut.request(url: anyURL) { data in
            XCTAssertNotNil(data)
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

private class NetworkClientStub: NetworkClient {
    
    private let data: Data
    
    init(completesWith data: Data) {
        self.data = data
    }
    
    func get(for url: URL, completion: @escaping (Data) -> Void) {
        completion(data)
    }
}
