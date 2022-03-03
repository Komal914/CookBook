//
//  favRecipeDetailsViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 3/2/22.
//

import UIKit
import Parse

class favRecipeDetailsViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var instructionsLabel: UILabel!
    
    var recipe: PFObject!
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 1000)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let instructions = recipe!["instructions"] as? String
        instructionsLabel.text = instructions

        // Do any additional setup after loading the view.
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
