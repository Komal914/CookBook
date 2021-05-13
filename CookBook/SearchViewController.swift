//
//  SearchViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import CoreData
class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var recipesData = [[String: Any]]() //array of dictionaries
    var filteredRecipes = [[String:Any]]()
    let RandomUrl = URL(string: "https://api.spoonacular.com/recipes/random?number=100&apiKey=15e74b8e65dc48a5ad0e694961d81aff")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        SearchBar.delegate = self
        //filteredRecipes = recipes
        
        //********************************-API Request-***********************************
        
        let request = URLRequest(url: RandomUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                self.recipesData = dataDictionary["recipes"] as! [[String: Any] ] //api info downloaded
                self.tableView.reloadData() //refresh data
                print(self.recipesData)
                
                print(dataDictionary) //prints my api data

             }
        }
        
//        let baseUrl = URL(string: "")
//
//        let imageUrl = URL(string: "https://spoonacular.com/recipeImages/715511-556x370.jpg")
//            // 2
//            let imagesession = URLSession.shared
//            // 3
//            let dataTask = imagesession.dataTask(with: url) {data, response, error in
//              // 4
//              if let error = error {
//                print("Failure! \(error.localizedDescription)")
//              } else {
//                print("Success! \(response!)")
//              }
//            }
        task.resume()
    }
    
    //***********************-SearchBar-**********************************
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

//        filteredRecipes = []
//        for recipe in recipesData{
//            if recipe.contains(searchText.lowercased()){
//                filteredRecipes.append(recipe)
//            }
//        }
//        self.tableView.reloadData()

    }
    
    
    
    
    //********************************-TableView-***********************************
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell //recycles cells or creates new ones for table
        let recipe = recipesData[indexPath.row]
        
        //getting title
        let title = recipe["title"] as? String
        guard let image = (recipe["image"] as? String) else { return cell } //exit function if empty
        cell.titleLabel!.text = title
        
        let url = NSURL(string:image)
        let imagedata = NSData.init(contentsOf: url as! URL)

        if imagedata != nil {
            cell.posterView.image = UIImage(data:imagedata! as Data)
        }
        else{
            print("NO IMAGE")
        }

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
        let recipe = recipesData[indexPath.row] //access the array
        
        //pass the selected recipe to the details view controller
        let detailsViewController = segue.destination as! RecipeDetailsViewController
        detailsViewController.recipe = recipe //passes my dic to the new screen
        
        tableView.deselectRow(at: indexPath, animated: true) //after user comes back to home, cell is deselected
        
        
        
    }
    

}
