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
    

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    
    var recipeData = [[String: Any?]]() //array of dictionaries
    var filteredRecipeData = [[String:Any?]]()
  
//MARK: Get API KEY
    private var apiKey: String {
      get {
        // 1
        guard let filePath = Bundle.main.path(forResource: "Info", ofType: "plist") else {
          fatalError("Couldn't find file 'Info.plist'.")
        }
        // 2
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "RandomUrl") as? String else {
          fatalError("Couldn't find key 'RandomUrl' in 'Info.plist'.")
        }
        return value
      }
    }

//MARK: API REQUEST
    private func callAPI() {
        let RandomUrl = URL(string: apiKey)!
        let request = URLRequest(url: RandomUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
        // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.recipeData = dataDictionary["recipes"] as? [[String: Any]] ?? [["empty" : "oh no"]]
                print("Recipes in dictionary!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                //api info downloaded
                self.filteredRecipeData = self.recipeData.compactMap { $0 }
                if self.tableView.numberOfRows(inSection: 0) != 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
                self.tableView.reloadWithAnimation()
 //refresh data
            }
        }
        task.resume()
    }
    
    let animationView = AnimationView()
    
    private func setupAnimation() {
        // 2. Start LottieAnimationView with animation name (without extension)
        
        animationView.animation = Animation.named("food-bowl")
        
        

        animationView.frame = view.bounds
        animationView.backgroundColor = UIColor.black
        

          // 3. Set animation content mode

        animationView.contentMode = .scaleAspectFit


          // 5. Adjust animation speed

        animationView.animationSpeed = 1.8

        view.addSubview(animationView)

          // 6. Play animation
        
        
        

        animationView.play(fromProgress: 0,
                                   toProgress: 1,
                                   loopMode: .playOnce,
                                   completion: { (finished) in
    
                                    if finished {
                                      print("Animation Complete")
                                        self.animationView.removeFromSuperview()
                                        
                                    } else {
                                      print("Animation cancelled")
                                    }
                })
        
        
    }
    
//MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        tableView.dataSource = self
        tableView.delegate = self
        callAPI()
        setupAnimation()
        
    }
    
    
@IBAction func onRefresh(_ sender: UIBarButtonItem) {
        // Refresh table view here
    callAPI()
    setupAnimation()
    
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
                
        UIView.animate(withDuration: 0.2, delay: 0.2*Double(indexPath.row),animations: {
            cell.alpha = 1
        })
        
        
    }

    
//MARK: Tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("how many recipes in table: \(recipeData.count)")
        
        return filteredRecipeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell") as! SearchCell //recycles cells or creates new ones for table
        
        cell.selectionStyle = .none
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.white.cgColor
        
        
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
