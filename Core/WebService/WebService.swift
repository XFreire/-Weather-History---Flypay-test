//
//  WebService.swift
//  Core
//
//  Created by Alexandre Freire García on 3/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import RxSwift

internal enum WebServiceError: Error {
    case badStatus(Int, Data)
}


final internal class WebService {
    private let configuration: WebServiceConfiguration
    private let session = URLSession(configuration: .default)
    private let baseURL = URL(string: "https://api.openweathermap.org/data/2.5")!
    private let decoder = JSONDecoder()
    
    init(configuration: WebServiceConfiguration) {
        self.configuration = configuration
    }
    
    func load<T>(_ type: T.Type, from endpoint: Endpoint) -> Observable<T> where T: Decodable {
        let decoder = self.decoder
        let request = endpoint.request(with: baseURL, adding: configuration.parameters)
        
        return session.rx.data(request: request)
            .map { try decoder.decode(T.self, from: $0) }
            .catchError { error in
                guard let webServiceError = error as? WebServiceError else {
                    throw error
                }
                
                guard case let .badStatus(code, data) = webServiceError else {
                    throw error
                }
                
                throw WebServiceError.badStatus(code, data)
        }
    }
}

private extension Reactive where Base: URLSession {
    func data(request: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            let task = self.base.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer.onError(error)
                } else {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        fatalError("Unsupported protocol")
                    }
                    
                    if 200 ..< 300 ~= httpResponse.statusCode {
                        if let data = data {
                            observer.onNext(data)
                        }
                        observer.onCompleted()
                    } else {
                        observer.onError(WebServiceError.badStatus(httpResponse.statusCode, data ?? Data()))
                    }
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

