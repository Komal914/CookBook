//
//  RecipeDetailsViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/27/21.
//

import UIKit
import AlamofireImage

class RecipeDetailsViewController: UIViewController {
    
    var recipeSummary = [String: Any]()
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    var recipe: [String: Any]! //now only a dictionary, not array of dic

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //**************************-title + image segue-****************************************
        titleLabel.text = recipe["title"] as? String
        summaryLabel.text = recipe["summary"] as? String
        let baseUrl = "https://spoonacular.com/recipeImages/"
        let imagePath = recipe["image"] as! String
        let imageUrl = URL(string: imagePath)
        posterView?.af_setImage(withURL: imageUrl!)
    
         
        
    }
}
        
//        //***********************************-summary url-****************************************
//        let summaryBaseUrl = "https://api.spoonacular.com/recipes/"
//        let id = recipe["id"]
//        let stringId = "\(String(describing: id))"
//        let end = "/summary"
//        let summaryUrl = URL(string: summaryBaseUrl + stringId + end)
//

//        //********************************-API Request for summary-***********************************
//        let url = URL(string: "https://api.spoonacular.com/recipes/" + "stringId" + "/summary?apiKey=15e74b8e65dc48a5ad0e694961d81aff")!
//        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//        let task = session.dataTask(with: request) { (data, response, error) in
//             // This will run when the network request returns
//             if let error = error {
//                    print(error.localizedDescription)
//             } else if let data = data {
//                    let summaryDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//
//
//                self.recipeSummary = summaryDictionary[""] as! [String: Any] //api info downloaded
//                //self.tableView.reloadData() //refresh data inside tableview (calls my funcs again and again)
//                print(summaryDictionary) //prints my api data
//
//             }
//        }
//        task.resume()
//
//    }
        
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
