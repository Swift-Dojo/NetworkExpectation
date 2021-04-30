@testable import NetworkExpectation
import XCTest

final class NetworkClientTests: XCTestCase {

    func test_request_invokesDataTaskOnce() {
        let anyURL = URL(string: "https://google.com")!
        let session = URLSessionSpy()
        let sut = Network(session: session)
        
        sut.request(url: anyURL) { _ in }
        
        XCTAssertEqual(session.messages, [.dataTask(url: anyURL)])
    }
    
    func test_request_invokesDataTaskTwice() {
        let anyURL = URL(string: "https://google.com")!
        let anotherURL = URL(string: "https://apple.com")!
        let session = URLSessionSpy()
        let sut = Network(session: session)
        
        sut.request(url: anyURL) { _ in }
        sut.request(url: anotherURL) { _ in }
        
        XCTAssertEqual(session.messages, [.dataTask(url: anyURL), .dataTask(url: anotherURL)])
    }
    
    //MARK:- Helpers
    
    private class URLSessionSpy: URLSessionProtocol {
        var messages = [Messages]()
        
        enum Messages: Equatable {
            case dataTask(url: URL)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            messages.append(.dataTask(url: url))
            
            return DummyURLSessionDataTask()
        }
    }

    private class DummyURLSessionDataTask: URLSessionDataTask {
        override func resume() {}
    }
}
