//
//  RecipeDetailsViewController.swift
//  CookBook
//
//  Created by Komal Kaur on 4/27/21.
//

import UIKit
import AVFoundation
import Parse


//cell is already here
// need to load the button status every time the view appear 
class RecipeDetailsViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var instructions: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favRecipeButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewWillLayoutSubviews(){
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: 375, height: 1000)
    }
    
    
    var recipe: [String: Any]? //now only a dictionary, not array of dic
    var audioPlayer: AVAudioPlayer?
    var favorited:Bool = false
    let imageFilled = UIImage(named: "favor-icon-red")
    let imageUnfilled = UIImage(named: "favor-icon copy")
    
    func setFavorited(_ isFavorited:Bool) -> Bool{
        favorited = isFavorited //false = false
        if(favorited){ //if false
            favRecipeButton.setImage(imageFilled, for: UIControl.State.normal)
            favRecipeButton.zoomIn()
            UserDefaults.standard.setValue(true, forKey: "liked")
            print("liked")
        }
        else{
            favRecipeButton.setImage(imageUnfilled, for: UIControl.State.normal)
            favRecipeButton.zoomIn()
            UserDefaults.standard.setValue(false, forKey: "liked")
            print("not liked")
        }
        return favorited
    }
    

    @IBAction func favoriteRecipe(_ sender: Any) {
        let tobefavorited = !favorited
        //var buttonPressed:Bool = true
        if(tobefavorited){
            //sets the color to red and zooms animation
            self.setFavorited(true)
            let frecipe = PFObject(className: "FaveRecipes")
            guard let title = (recipe?["title"] as? String) else { return  }
            frecipe["title"] = title
            guard let image = (recipe?["image"] as? String) else { return  }
            frecipe["imageUrl"] = recipe!["image"] as? String
            //what saves my data to parse
            frecipe.saveInBackground { (success, error) in
                if success{
                    print("yay saved!")
                }
                else{
                    print("couldnt save it smh")
                }
            }
        }
        else{
            self.setFavorited(false)
        }

        favRecipeButton.tag = 1
        let selectedButton = (sender as AnyObject).tag
        switch selectedButton {
        case 1:
            let pathToSound = Bundle.main.path(forResource: "dingSound", ofType: "mp3")!
            let url = URL(fileURLWithPath: pathToSound)

            do{
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch{
                //error handled
            }
        default:
            return
        }
    }

    


    override func viewDidAppear(_ animated: Bool) {
        print(UserDefaults.standard.bool(forKey: "liked"))
        //remembers for user if liked or not
        if(UserDefaults.standard.bool(forKey: "liked") == true)
        {
            favRecipeButton.setImage(imageFilled, for: UIControl.State.normal)
        }
        else{
            favRecipeButton.setImage(imageUnfilled, for: UIControl.State.normal)
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let title = recipe?["title"] as? String
        guard let image = (recipe?["image"] as? String) else { return  } //exit function if empty
        let url = NSURL(string:image)
         let imagedata = NSData.init(contentsOf: url as! URL)

         if imagedata != nil {
             posterView.image = UIImage(data:imagedata! as Data)
         }
         else{
             print("NO IMAGE")
         }
        titleLabel!.text = title
        let oldSummary = recipe!["summary"] as? String
        let newSummary = oldSummary?.trimHTMLTags()
        summaryLabel!.text = newSummary
        summaryLabel.sizeToFit()
        
        let oldInstructions = recipe!["instructions"] as? String
        let newInstructions = oldInstructions?.trimHTMLTags()
        instructions!.text = newInstructions
        }
    }

    
    
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       
        
    }
