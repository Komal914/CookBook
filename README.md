# CookBook
##### Tags: `Xcode` `iOS` `UIKit` `REST API` `Spoonacular` `Parse` `Back4App` `alamoFireImage` `lottie` 
Source: [https://hackmd.io/@PN7C6hJWRlarnh710w4j-w/H1o_moSb5](https://)

## Table of Contents
1. [Overview](#Overview)
2. [Video Walkthrough](#Video-Walkthrough)
3. [How to Run](#How-to-Run)
4. [Wireframe](#Wireframe)
5. [Product Spec](#Product-Spec)
6. [Schema](#Schema)
7. [Upcoming](#Upcoming)


## Overview
### Description
Cookbook is an ios application which calls random recipes for the user to explore. You can refresh the recipes by using the refresh button which will update the tableview. You are able to find more information on the recipe like the summary, ingredients used and instructions on how to recreate the dish. If you like the recipe, click the heart to save in inside the favorites tab for the future. The project urtilizes the Spoonacular API for the data, Parse back4app to store favorite recipes and lottie animations. 


## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://user-images.githubusercontent.com/44416323/156668905-8ddc25f5-1775-438c-9e42-e4b642c00807.mov

## How-to-Run

[Required]Download Xcode
1. Open Terminal
2. Change directory to where you want to clone the file
3. Type `git clone https://github.com/Komal914/CookBook.git`
4. Open the cloned repository in Xcode and press CMD + R to run the app

OR download the zip file

Double click the file "Cookbook.xcodeproj"
Press two keys simultaneously: CMD + R to run the app



## Product Spec


### 1. Screen Archetypes

* Random Recipe Search
   * 20 random recipes are called for the user to Browse
   * Each recipe's photo and title are listed 
   * refesh button available to update the recipes  

* Recipe Details
   * The recipe's summary, ingredients and instructions are provided 
   * By clicking the heart button, the button dings and the recipe has been saved

* Favorites
   * List of your favorite recipes with associated name and photo 

* Favorite Recipe Details
   * Lists out the ingredients and instructions for the fav recipe


### 2. Navigation

**Tab Navigation** (Tab to Screen)

* Random recipes 
* Favorites

**Flow Navigation** (Screen to Screen)

* Random Recipes  -> Recipe details 
* Favorites -> favorite recipe's instructions 


## Wireframe
![](https://i.imgur.com/BW1BJxr.jpg)

## Schema 
### Model
#### Recipe:

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | Recipe name      | String   |  The name of the recipe |
   | Recipe Image     | String |  The image URL associated with relevant recipe|
   | Recipe Description | String | Brief summary of the food |
   | Recipe Ingredients | String | Ingredients used for the recipe listed |
   | Recipe Instructions | String | List of instructions on how to prepare the dish |
 
 
 
### Networking
#### Lists of Network Requests by Screen
 - Random Recipes
    - (Read/Get) Query random recipes from the Spoonacular API

```swift
 //MARK:API Request
        
        let request = URLRequest(url: RandomUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                
                self.recipeData = dataDictionary["recipes"] as! [[String: Any]] //api info downloaded
                    
                self.tableView.reloadData() //refresh data

             }
        }
  ```
  After this data is loaded, once the user clicks on the recipe selected -> that recipe's details are segued onto the recipe details screen


  - Favorites 
    - (Read/Get) Query all saved recipes of the user
```swift
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
```

-
   - (Delete) Users can delete a saved recipe 
```swift
drecipe.deleteInBackground() { (success, error) in
                if success{
                    print("deleted")
                }
                else{
                    print("not deleted ")
                }
```
 After this data is loaded, once the user clicks on the favorited recipe  -> that recipe's details are segued onto the fav recipe details screen
 
 
## Upcoming

### UI Updates and more functionality 
* Setting tab for the user to update their diet prefrences to filter recipes inside search
   








