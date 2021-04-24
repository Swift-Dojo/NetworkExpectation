@testable import NetworkExpectation
import XCTest

final class NetworkClientTests: XCTestCase {
    
    func test_request_callsURL() {
        let url = URL(string: "https://google.com")!
        let session = URLSessionSpy()
        let sut = Network(session: session)
        
        sut.request(url: url) { _ in }
        
        XCTAssertEqual(session.requestedURL, [url])
    }

    func test_request_callsURLTwice() {
        let url = URL(string: "https://google.com")!
        let session = URLSessionSpy()
        let sut = Network(session: session)
        
        sut.request(url: url) { _ in }
        sut.request(url: url) { _ in }
        
        XCTAssertEqual(session.callCount, 2)
        XCTAssertEqual(session.requestedURL, [url, url])
    }
}

class URLSessionSpy: URLSessionProtocol {
    var callCount = 0
    var requestedURL = [URL]()
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        callCount += 1
        requestedURL.append(url)
        return DummyURLSessionDataTask()
    }
}

private class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() {}
}
