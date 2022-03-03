# CookBook
##### Tags: `iOS` `REST API` `Spoonacular` `Parse` `Back4App` `alamoFireImage` 

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframe](#Wireframe)
2. [Schema](#Schema)
3. [Video Walkthrough](#Video-Walkthrough)

## Overview
### Description
This Application generates random recipes for the user to inspire users to try new recipes. By clicking on the recipe, the user is able to view the summary and intructions for the recipe. User is able to save the recipe through clicking the heart button. Favorite recipes can be found on the favorites tab which are stored by using a custom Parse backend server hosted on Back4App. 



## Product Spec


### 1. Screen Archetypes

* Random Recipe Search
   * 20 random recipes are called for the user to Browse
   * Each recipe's photo and title are listed  

* Recipe Details
   * The recipe's summary and instructions are listed for the user
   * By clicking the heart button, the button dings and the recipe has been saved

* Favorites
   * List of your favorite recipes with associated name and photo 

* Favorite Recipe Details
   * Lists out the instructions for the fav recipe


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
#### Recipes:

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | Recipe name      | String   |  The name of the recipe |
   | Recipe Image     | png |  The image associated with relevant recipe|
   | Recipe Description | string | Brief summary of the food |
   | Recipe Instructions | string | List of instructions on how to prepare the dish |
 
 
 
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

## Video Walkthrough

Here's a walkthrough of implemented user stories:

https://user-images.githubusercontent.com/44416323/156479014-9d2aee62-f109-40be-bd4f-5a27644ff4d7.mov





