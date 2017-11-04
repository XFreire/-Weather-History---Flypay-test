//
//  ImageLoadingRepository.swift
//  Core
//
//  Created by Alexandre Freire García on 4/11/17.
//  Copyright © 2017 Flypay. All rights reserved.
//

import Foundation
import Kingfisher

final class ImageLoadingAssembly {
    private(set) lazy var imageRepository: ImageRepositoryProtocol = ImageRepository(imageManager: KingfisherManager.shared)

}
