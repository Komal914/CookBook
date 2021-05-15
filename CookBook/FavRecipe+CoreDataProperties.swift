//
//  FavRecipe+CoreDataProperties.swift
//  
//
//  Created by Komal Kaur on 5/13/21.
//
//

import Foundation
import CoreData



extension FavRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavRecipe> {
        return NSFetchRequest<FavRecipe>(entityName: "FavRecipe")
    }

    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var picture: String?

}
