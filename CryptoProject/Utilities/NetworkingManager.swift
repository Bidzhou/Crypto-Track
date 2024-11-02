//
//  NetworkingManager.swift
//  CryptoProject
//
//  Created by Frederico del' Bidzho on 22.10.2024.
//

import Foundation
import Combine
class NetworkingManager {
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case unknown
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "[🔥] Bad Response from URL. \(url)"
            case .unknown: return "[⚠️] Unknown error"
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
           // .subscribe(on: DispatchQueue.global(qos: .background)) data task publisher подписывается на очередь бэкграунда автоматически
//            .tryMap { (output) -> Data in
//                guard let response = output.response as? HTTPURLResponse,
//                      response.statusCode >= 200, response.statusCode < 300 else {
//
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
            .tryMap({try handleURlResponse(output: $0, url: url)})
            .retry(3) //если до retry доходит ошибка, то он запускает код выше заново столько раз, сколько впараметре
            .eraseToAnyPublisher() // для конвертации в удобный тип данных
    }
    
    static func handleURlResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data{
        guard let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200, response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
