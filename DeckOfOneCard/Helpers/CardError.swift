//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Carla Lyra on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case noData
    case thrownError(Error)
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        
        case .invalidURL:
            return "Internal error."
        case .noData:
            return "the server responded with no data"
        case .thrownError(let error):
            return error.localizedDescription
        case .unableToDecode:
            return "The server responded with bad data"
        }
    }
}
