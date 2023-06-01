//
//  FavViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit
import Parse
import Lottie


class FavViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    var frecipes = [PFObject]()
    
    let animationView = AnimationView()
    
    private func setupAnimation() {
        // 2. Start LottieAnimationView with animation name (without extension)
        
        animationView.animation = Animation.named("heart")
        animationView.frame = view.bounds
        animationView.backgroundColor = UIColor.black
        

          // 3. Set animation content mode

        animationView.contentMode = .scaleAspectFit


          // 5. Adjust animation speed

        animationView.animationSpeed = 3.0

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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setupAnimation()
    
        let query = PFQuery(className:"FaveRecipes")
        query.includeKey("title")
        query.limit = 300
        query.findObjectsInBackground{
            (frecipes, error) in
            if frecipes != nil{
                self.frecipes = frecipes!
                self.tableView.reloadWithAnimation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        //setupAnimation()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.alpha = 0
                
        UIView.animate(withDuration: 0.1, delay: 0.1*Double(indexPath.row),animations: {
            cell.alpha = 1
        })
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return frecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell") as! FavCell
        let recipe = frecipes.reversed()[indexPath.row]
        
        cell.selectionStyle = .none
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.white.cgColor
        
        cell.titleLabel.text = recipe["title"] as? String
        
        let imageString = (recipe["imageUrl"] as? String)!
        
        let url = NSURL(string:imageString )
        let imagedata = NSData.init(contentsOf: url! as URL)

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
            let drecipe = frecipes[indexPath.row]
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
        
        //we need to send data to the recipe details from this fav recipe selected by the user
    
        //find the selected recipe
        let cell = sender as! UITableViewCell //cell tapped on
        let indexPath = tableView.indexPath(for: cell)! //gets path from cell
        let recipe = frecipes[indexPath.row] //access the array

        //pass the selected recipe to the details view controller
        let detailsViewController = segue.destination as! favRecipeDetailsViewController
        
        detailsViewController.recipe = recipe //passes my dic to the new screen

        tableView.deselectRow(at: indexPath, animated: true) //after user comes back to home, cell is deselected
        
        
    }
    
    
    
    

}


