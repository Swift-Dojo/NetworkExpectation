//
//  NetworkClientTests.swift
//  NetworkClientTests
//
//  Created by Mario Alberto Barragán Espinosa on 27/03/21.
//

import NetworkExpectation
import XCTest

class NetworkEndToEndClientTests: XCTestCase {
    func test_request_makesAPICall() {
        let url = URL(string: "https://google.com")!
        let sut = Network(session: URLSession.shared)
        let exp = expectation(description: "Network client expectation")
        
        sut.request(url: url) { _ in
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
}

extension URLSession: URLSessionProtocol {}
