//
//  ContactListViewCell.swift
//  ContactList
//
//  Created by Sindhura VEGI on 23/01/19.
//  Copyright © 2019 Sindhura VEGI. All rights reserved.
//

import UIKit

class ContactListViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var subtitle_lbl: UILabel!
    var contactListModel : Result? {
        
        didSet{
            let imgURL = URL(string: contactListModel?.picture?.thumbnail ?? "avatar")
            let data: Data = try! Data(contentsOf: imgURL!)

            self.profileImage.image = UIImage(data: data)//contactListModel.picture.thumbnail
            self.profileImage.layer.cornerRadius = self.profileImage.bounds.size.width / 2.0
            self.profileImage.clipsToBounds = true
            self.title_lbl.text = ((contactListModel?.name?.first)!) + " " + ((contactListModel?.name?.last)!)
            self.subtitle_lbl.text = contactListModel?.email
            
            title_lbl.textColor = UIColor(red: 0, green: 128, blue:0, alpha:0.4)
            subtitle_lbl.textColor = UIColor(red: 0, green: 0, blue: 0, alpha:1.0)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
