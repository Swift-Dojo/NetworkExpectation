//
//  Network.swift
//  NetworkExpectation
//
//  Created by Mario Alberto Barragán Espinosa on 27/03/21.
//

import Foundation

public protocol NetworkClient {
    func get(for url: URL, completion: @escaping (Data) -> Void)
}

public class URLSessionClient: NetworkClient {
    public init() {}
    
    public func get(for url: URL, completion: @escaping (Data) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print("Error en el request: \(error.localizedDescription)")
            }
            
            guard let data = data else { return }
            
            completion(data)
        }
        
        dataTask.resume()
    }
}

public class Network {
    private let client: NetworkClient
    
    public init(client: NetworkClient = URLSessionClient()) {
        self.client = client
    }
    
    public func request(url: URL, completion: @escaping (Data) -> Void) {        
        client.get(for: url, completion: completion)
    }
}
