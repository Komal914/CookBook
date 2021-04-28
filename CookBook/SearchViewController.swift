//
//  SearchViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import AlamofireImage

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var recipes = [[String: Any]]() //array of dictionaries

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        print ("Hello")
        let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?apiKey=15e74b8e65dc48a5ad0e694961d81aff")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                self.recipes = dataDictionary["results"] as! [[String: Any] ] //api info downloaded
                self.tableView.reloadData() //refresh data inside tableview (calls my funcs again and again)
                print(dataDictionary)

                    // TODO: Get the array of recipes
                    // TODO: Store the recipe in a property to use elsewhere
                    // TODO: Reload your table view data

             }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell //recycles cells or creates new ones for table
        let recipe = recipes[indexPath.row]
        
        //getting title
        let title = recipe["title"] as! String
        cell.titleLabel!.text = title
        
        //getting image
        let baseUrl = "https://spoonacular.com/recipeImages/"
        let imagePath = recipe["image"] as! String
        let imageUrl = URL(string: imagePath)
        cell.posterView?.af_setImage(withURL: imageUrl!)
        
        
       
        return cell
    }
    

}
