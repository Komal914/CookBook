//
//  RecipeDetailsViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/27/21.
//

import UIKit
import AlamofireImage

class RecipeDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    var recipe: [String: Any]! //now only a dictionary, not array of dic

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = recipe["title"] as? String
        
        let baseUrl = "https://spoonacular.com/recipeImages/"
        let imagePath = recipe["image"] as! String
        let imageUrl = URL(string: imagePath)
        posterView?.af_setImage(withURL: imageUrl!)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
