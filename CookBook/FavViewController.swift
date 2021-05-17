//
//  FavViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import Parse

class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var frecipes = [PFObject]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"FaveRecipes")
        query.includeKey("title")
        query.limit = 300
        query.findObjectsInBackground{
            (frecipes, error) in
            if frecipes != nil{
                self.frecipes = frecipes!
                self.tableView.reloadData()
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavCell
        let recipe = frecipes[indexPath.row]
        
        cell.titleLabel.text = recipe["title"] as! String
        
        let imageString = (recipe["imageUrl"] as? String)!
        
        let url = NSURL(string:imageString ?? "https://spoonacular.com/recipeImages/639891-556x370.jpg")
        let imagedata = NSData.init(contentsOf: url as! URL)

        if imagedata != nil {
            cell.posterView.image = UIImage(data:imagedata! as Data)
        }
        else{
            print("NO IMAGE")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let drecipe = frecipes[indexPath.row] as! PFObject
            self.frecipes.remove(at: indexPath.row)
            self.tableView.deleteRows(at:[indexPath], with: .automatic )
            drecipe.deleteInBackground() { (success, error) in
                if success{
                    print("deleted")
                }
                else{
                    print("not deleted ")
                }
            }

        }
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//
//        //find the selected recipe
//        let cell = sender as! UITableViewCell //cell tapped on
//        let indexPath = tableView.indexPath(for: cell)! //gets path from cell
//        let recipe = frecipes[indexPath.row] as! [String : Any] //access the array
//
//        //pass the selected recipe to the details view controller
//        let detailsViewController = segue.destination as! RecipeDetailsViewController
//        detailsViewController.recipe = recipe //passes my dic to the new screen
//
//        tableView.deselectRow(at: indexPath, animated: true) //after user comes back to home, cell is deselected
        
        
    }

}
