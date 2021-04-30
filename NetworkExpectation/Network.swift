//
//  Network.swift
//  NetworkExpectation
//
//  Created by Mario Alberto Barragán Espinosa on 27/03/21.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

public class Network {
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol) {
        self.session = session
    }
    
    public func request(url: URL, completion: @escaping (Data) -> Void) {        
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error en el request: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            completion(data)
        }
        
        dataTask.resume()
    }
}
