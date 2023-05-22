//
//  SearchViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import CoreData
import Lottie
class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var managedObjectContext: NSManagedObjectContext!
    @IBOutlet weak var tableView: UITableView!
    var recipeData = [[String: Any?]]() //array of dictionaries
    var filteredRecipeData = [[String:Any?]]()
    let RandomUrl = URL(string: "https://api.spoonacular.com/recipes/random?number=20&apiKey=5c64c21cbd3640f59a7afaf7f06f70c7")!
//MARK: VIEWDIDLOAD
    
    let animationView = AnimationView()
    
    private func setupAnimation() {
        animationView.animation = Animation.named("cooking-pot")
        animationView.frame = view.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.backgroundColor = .red
        animationView.play()
        view.addSubview(animationView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
   
//MARK: ADDING LOTTIE
        
        //setupAnimation()
        
        // 2. Start LottieAnimationView with animation name (without extension)
          
//        animationView.animation = Animation.named("cooking-pot")
//
//        animationView.frame = view.bounds
//
//          // 3. Set animation content mode
//
//        animationView.contentMode = .scaleAspectFit
//
//          // 4. Set animation loop mode
//
//        animationView.loopMode = .playOnce
//
//          // 5. Adjust animation speed
//
//        animationView.animationSpeed = 1.5
//
//        view.addSubview(animationView)
//
//          // 6. Play animation
//
//        animationView.play()
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        //filteredRecipes = recipes
        
        
        
//MARK: API REQUEST
        
        
        
        let request = URLRequest(url: RandomUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                self.recipeData = dataDictionary["recipes"] as! [[String: Any]]
//                 print("Recipes in dictionary:", self.recipeData)
                    //api info downloaded
                
                 self.filteredRecipeData = self.recipeData.flatMap { $0 }

                self.tableView.reloadData() //refresh data

             }
        }
        task.resume()
    }

    
    
    
    
    //MARK:TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("how many recipes in table: \(recipeData.count)")
        
        return filteredRecipeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell //recycles cells or creates new ones for table
        
        cell.selectionStyle = .none
        
//        print("Printing...filtered recipe......")
//        print(filteredRecipeData)
        
        //one recipe for one cell
        let recipe = filteredRecipeData[indexPath.row]

       
        //getting title
        let title = recipe["title"] as? String
        
        //getting image
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
    //MARK: SegueToRecipeDetails
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        //find the selected recipe
        let cell = sender as! UITableViewCell //cell tapped on
        let indexPath = tableView.indexPath(for: cell)! //gets path from cell
        let recipe = recipeData[indexPath.row] //access the array
        
        //pass the selected recipe to the details view controller
        let detailsViewController = segue.destination as! RecipeDetailsViewController
        detailsViewController.recipe = recipe //passes my dic to the new screen
        
        tableView.deselectRow(at: indexPath, animated: true) //after user comes back to home, cell is deselected
        
        
    }
    

}
