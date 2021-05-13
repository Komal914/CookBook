//
//  SearchCell.swift
//  CookBook
//
//  Created by Komal Kaur on 4/24/21.
//

import UIKit

class SearchCell: UITableViewCell {
    var favorited:Bool = false
    //let imageFilled = UIImage(named: "favor-icon-red")
    //let imageUnfilled = UIImage(named: "favor-icon copy")
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBAction func favButtonAction(_ sender: Any) {        
        print("Marking as fav!")
    }
    
    
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //favButton.addTarget(favButtonAction(self), action: #selector(favButtonAction(_:)), for: .touchUpInside)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
