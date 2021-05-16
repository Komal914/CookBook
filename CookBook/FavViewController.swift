//
//  FavViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import CoreData

class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[FavRecipe]?
    
    func getAllItems(){
        do {
            self.items = try context.fetch(FavRecipe.fetchRequest())
                self.tableView.reloadData()
        }
        catch{
            //error handeling
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 4
    }
   //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavCell
        //getAllItems()
        let recipe = self.items?[indexPath.row]
    
        cell.titleLabel!.text = recipe?.title
        

        return cell
    }
    
    
   
    
    
    
    
    //MARK: TableView
    @IBOutlet weak var tableView: UITableView!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //fetchData()
        //getAllItems()
        
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

}
