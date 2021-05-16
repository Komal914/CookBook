//
//  RecipeDetailsViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/27/21.
//

import UIKit
import AVFoundation
import CoreData


//cell is already here
// need to load the button status every time the view appear 
class RecipeDetailsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var recipe: [String: Any]? //now only a dictionary, not array of dic
    var audioPlayer: AVAudioPlayer?
    var favorited:Bool = false
    let imageFilled = UIImage(named: "favor-icon-red")
    let imageUnfilled = UIImage(named: "favor-icon copy")
    var saveFav:Bool = false
    
    //refrence to the managed object context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //data for the table
    var items:[FavRecipe]?
    
    //MARK: Core Data
    //gets item out of database
    
    //gets items out of container
    func getAllItems(){
        do {
            self.items = try context.fetch(FavRecipe.fetchRequest())
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        catch{
            //error handeling
        }
    }
    
//creates an item
    func createItem(item: FavRecipe){
        let newItem = FavRecipe(context: self.context)
        newItem.title = "NEW TITLE"
        newItem.summary = "this is a summary"
        newItem.picture = "wow such nice pic :0"

        do{
            try context.save()
        }
        catch{

        }

    }
    

    func deleteItem(item:FavRecipe){
        context.delete(item)
        do{
            try context.save()
        }
        catch{

        }
    }
    
    
    

    
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

    override func viewDidAppear(_ animated: Bool) {
        print("this is the value for key liked:")
        print(UserDefaults.standard.bool(forKey: "liked"))
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        

        }
    }

    
    
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       
        
    }


