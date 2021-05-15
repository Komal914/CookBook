//
//  recipeDetailCell.swift
//  CookBook
//
//  Created by Komal Kaur on 5/14/21.
//

import UIKit
import AVFoundation
import CoreData

class recipeDetailCell: UITableViewCell {
    @IBOutlet weak var instructionsLabel: UILabel!
    var managedObjectContext: NSManagedObjectContext!
    var recipe: [String: Any]? //now only a dictionary, not array of dic
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var audioPlayer: AVAudioPlayer?
    var favorited:Bool = false
    let imageFilled = UIImage(named: "favor-icon-red")
    let imageUnfilled = UIImage(named: "favor-icon copy")
    var saveFav:Bool = false
    var listOfObjects: [Any]?

    @IBAction func favoriteRecipe(_ sender: Any) {
        let tobefavorited = !favorited
        if(tobefavorited){
            self.setFavorited(true)
            print("this pic is red")
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

    
    @IBOutlet weak var favRecipeButton: UIButton!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setFavorited(_ isFavorited:Bool) -> Bool{
        favorited = isFavorited //false = false
        if(favorited){ //if false
            favRecipeButton.setImage(imageFilled, for: UIControl.State.normal)
            favRecipeButton.zoomIn()
        }
        else{
            favRecipeButton.setImage(imageUnfilled, for: UIControl.State.normal)
            favRecipeButton.zoomIn()
        }
        return favorited
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

//    func fetchData(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavRecipe")
//        guard let title = self.RecipeDetailsController.objectAtIndexPath() as? title else {
//                    return
//        fetchRequest.fetchLimit = 1
        //fetchRequest.predicate = NSPredicate(format: "title", "Ankur")
//
//
//        do {
//
//            let result = try managedContext.fetch(fetchRequest)
//            print("fetch requested")
//            listOfObjects = result
////            for data in result as! [NSObject]{
////                print("inside array")
////                print (data.value(forKey: "title") as! String)
////                print("FETCHED")
//                //print("This is the array: ",[NSObject].self)
//            }
//         catch{
//            print("could not fetch favrecipe")
//        }
//        print("outside do")
//
//    }
//
//    func createItem(){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return
//        }
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        guard let favRecipeEntity = NSEntityDescription.entity(forEntityName: "FavRecipe", in: managedContext) else { return  }
//        let title = recipe!["title"] as? String
//
//
//
//
//        for i in recipe!{
//            var favorited:Bool = true
//            setFavorited(favorited)
//            if(favorited == true){
//                let favRecipe = NSManagedObject(entity: favRecipeEntity, insertInto: managedContext)
//                favRecipe.setValue(title, forKey: "title")
//                print("my object",favRecipe.self)
//            }
//            else{
//                print("item not favorited")
//            }
//
//        }
//
//        do {
//            try managedContext.save()
//            print("item saved!!")
//            print(title)
//        }
//        catch let error as NSError{
//            print("could not save inside container. Error: \(error)")
//        }
//
//    }
//
//


    }


