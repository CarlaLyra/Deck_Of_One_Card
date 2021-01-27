//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Carla Lyra on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static func fetchCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        
        guard let baseURL = URL(string:"https://deckofcardsapi.com/api/deck/new/draw/") else { return completion(.failure(.invalidURL)) }
        
        
        
        
       // data Task
        URLSession.shared.dataTask(with: baseURL) { (data, _, error) in
            
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            do {
                let topLevel = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevel.cards.first else { return completion(.failure(.noData)) }
                return completion(.success(card))
            } catch {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
        }.resume()
    } // end of func
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        
       
        let url = card.image
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("======== ERROR ========")
                print("Function: \(#function)")
                print("Error: \(error)")
                print("Description: \(error.localizedDescription)")
                print("======== ERROR ========")
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else { return completion(.failure(.noData)) }
            
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            return completion(.success(image))
            
        }.resume()
    }// end of func
}//end of classs
