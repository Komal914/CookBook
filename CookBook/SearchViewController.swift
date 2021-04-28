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
        
        //********************************-API Request-***********************************
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
                print(dataDictionary) //prints my api data

             }
        }
        task.resume()
    }
    //********************************-TableView-***********************************
    
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
    //********************************-SegueToRecipeDetails-***********************************
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        //find the selected recipe
        let cell = sender as! UITableViewCell //cell tapped on
        let indexPath = tableView.indexPath(for: cell)! //gets path from cell
        let recipe = recipes[indexPath.row] //access the array
        
        //pass the selected recipe to the details view controller
        let detailsViewController = segue.destination as! RecipeDetailsViewController
        detailsViewController.recipe = recipe //passes my dic to the new screen
        
        tableView.deselectRow(at: indexPath, animated: true) //after user comes back to home, cell is deselected
        
        
    }
    

}
