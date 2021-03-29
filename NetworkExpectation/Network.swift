//
//  Network.swift
//  NetworkExpectation
//
//  Created by Mario Alberto Barragán Espinosa on 27/03/21.
//

import Foundation

public class Network {
    public init() {}
    
    public func request(url: URL, completion: @escaping (Data) -> Void) {        
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
