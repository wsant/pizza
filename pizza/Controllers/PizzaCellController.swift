//
//  PizzaCellController.swift
//  pizza
//
//  Created by William on 06/07/21.
//

import UIKit
import Alamofire

class PizzaCellController: UITableViewCell {
    
    //MARK: - StoryBoard Outlet
    
    @IBOutlet weak var cell: UIView!
    @IBOutlet weak var pizzaImageView: UIImageView!
    @IBOutlet weak var namePizzaLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    //MARK: - Functions
    
    func setup(pizza: Pizza) {
        namePizzaLabel.text = pizza.name
        priceLabel.text = "R$ \(pizza.priceP)"
        AF.request(pizza.imageUrl).responseData { (response) in
            guard let data = response.data else{return}
            self.pizzaImageView.image = UIImage(data: data)
        }
        cell.layer.cornerRadius = 10
    }
    

}
