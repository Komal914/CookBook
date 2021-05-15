//
//  FavViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import CoreData

class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var models = [FavRecipe]()
    
    func fetchData(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavRecipe")
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject]{
                print (data.value(forKey: "title") as! String)
            }
        } catch{
            print("could not fetch favrecipe")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
               return 1
           }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath)
        cell.textLabel?.text = "hello world"
        return cell
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    //MARK: TableView
    @IBOutlet weak var favTableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        favTableView.dataSource = self
        favTableView.delegate = self
        //fetchData()
        //getAllItems()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Core Data
    //gets item out of database
//    func getAllItems(){
//        do {
//            models = try context.fetch(FavRecipe.fetchRequest())
//            DispatchQueue.main.sync {
//                //favTableView.reload()
//            }
//        }
//        catch{
//            //error handeling
//        }
//    }
//    
//    func createItem(item: FavRecipe){
//        let newItem = FavRecipe(context: context)
//        newItem.title = "NEW TITLE"
//        newItem.summary = "this is a summary"
//        newItem.picture = "wow such nice pic :0"
//        
//        do{
//            try context.save()
//        }
//        catch{
//            
//        }
//        
//    }
//    
//    func deleteItem(item:FavRecipe){
//        context.delete(item)
//        do{
//            try context.save()
//        }
//        catch{
//            
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
