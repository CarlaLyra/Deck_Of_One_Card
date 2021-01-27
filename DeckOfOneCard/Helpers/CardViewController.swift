//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Carla Lyra on 1/26/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchCard { (result) in
            DispatchQueue.main.async {
                
                switch result {
        
                case .success(let card):
                    self.fetchImageAndUpdateView(with: card)
                
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                }
            }
        }

    }
    
    func fetchImageAndUpdateView(with card: Card) {
        
        // Request an image from the CardController
        CardController.fetchImage(for: card) { [weak self] (result) in
            
            // Return to main thread after a fetch
            DispatchQueue.main.async {
                switch result {
      
                case .success(let image):
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                    self?.cardImageView.image = image
                    
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}


