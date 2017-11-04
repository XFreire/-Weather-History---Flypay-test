//
//  ImageRepository.swift
//  Core
//
//  Created by Alexandre Freire García on 4/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import Kingfisher

public protocol ImageRepositoryProtocol {
    func image(at path: String) -> Observable<UIImage>
}

internal protocol ImageManager {
    func image(withURL url: URL) -> Observable<UIImage>
}

final internal class ImageRepository: ImageRepositoryProtocol {
    private let imageManager: ImageManager
    
    init(imageManager: ImageManager) {
        self.imageManager = imageManager
    }
    
    func image(at path: String) -> Observable<UIImage> {
        let imageManager = self.imageManager
        let request = Endpoint.image(name: path).request(with: URL(string: "https://api.openweathermap.org")!, adding: [:])
        return imageManager.image(withURL: request.url!)
    }
}

extension KingfisherManager: ImageManager {
    func image(withURL url: URL) -> Observable<UIImage> {
        return Observable.create { observer in
            let task = self.retrieveImage(
                with: ImageResource(downloadURL: url),
                options: nil,
                progressBlock: nil
            ) { image, error, _, _ in
                if let error = error {
                    observer.onError(error)
                } else {
                    observer.onNext(image ?? UIImage())
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
