//
//  ApiService.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/21/21.
//

import Foundation
import Combine

public class ApiService{
  
    private var decoder: JSONDecoder = {
       let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        return decoder
    }()
    
    private var session: URLSession = {
       let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.waitsForConnectivity = true
        config.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
    }()
    
   
   private func createPublisher<T: Codable>(for url: URL) -> AnyPublisher<T, Error>{
        return session.dataTaskPublisher(for: url)
                       .map({$0.data})
                       .decode(type: T.self, decoder: decoder)
                       .eraseToAnyPublisher()
    }
    
    func getNASAContent() -> AnyPublisher<ApiResponse, Error> {
        let url =  URL.fetchNasaContent()
        return createPublisher(for: url)
    }
    
    //add more calls
    
}

