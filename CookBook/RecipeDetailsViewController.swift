//
//  RecipeDetailsViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/27/21.
//

import UIKit
import AVFoundation
import CoreData

class RecipeDetailsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    var recipe: [String: Any]? //now only a dictionary, not array of dic
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var audioPlayer: AVAudioPlayer?
    var favorited:Bool = false
    let imageFilled = UIImage(named: "favor-icon-red")
    let imageUnfilled = UIImage(named: "favor-icon copy")
    var saveFav:Bool = false
    var listOfObjects: [Any]?

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
               return 1
           }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeDetailCell") as! recipeDetailCell //recycles cells or creates new ones for table
        
        let title = recipe?["title"] as? String
        guard let image = (recipe?["image"] as? String) else { return cell } //exit function if empty
        let url = NSURL(string:image)
         let imagedata = NSData.init(contentsOf: url as! URL)

         if imagedata != nil {
             cell.posterView.image = UIImage(data:imagedata! as Data)
         }
         else{
             print("NO IMAGE")
         }
        cell.title!.text = title
        let oldSummary = recipe!["summary"] as? String
        let newSummary = oldSummary?.trimHTMLTags()
        cell.summaryLabel!.text = newSummary
        
        let oldInstructions = recipe!["instructions"] as? String
        let newInstructions = oldInstructions?.trimHTMLTags()
        cell.instructionsLabel!.text = newInstructions
        

        
    

        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        // Do any additional setup after loading the view.
        
        //**************************-title + image segue-****************************************
//        let title = recipe!["title"] as? String
//        if(title != nil){
//            titleLabel.text = title
//        }
//        else{
//            titleLabel.text = "No title available"
//        }
////
//        //summaryLabel.text = recipe["summary"] as? String
//        let oldSummary = recipe!["summary"] as? String
//        let newSummary = oldSummary?.trimHTMLTags()
//        summaryLabel?.text = newSummary
//
////
//        guard let image = (recipe!["image"] as? String) else {
//            return
//        }
//
//        let url = NSURL(string:image)
//            let imagedata = NSData.init(contentsOf: url! as URL)
//
//        if imagedata == nil {
//            print("NO IMAGE")
//        }
//        else{
//            posterView.image = UIImage(data:imagedata! as Data)
        }
    }

    
    
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        //find the selected recipe
//
//        let cell = sender as! UITableViewCell //cell tapped on
//        let indexPath = tableView.indexPath(for: cell)! //gets path from cell
//        let recipe = recipesData[indexPath.row] //access the array
//
//        //pass the selected recipe to the details view controller
//
//        let detailsViewController = segue.destination as! RecipeDetailsViewController
//        detailsViewController.recipe = recipe //passes my dic to the new screen
//
//        tableView.deselectRow(at: indexPath, animated: true) //after user comes back to home, cell is deselected
        
        
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

    
