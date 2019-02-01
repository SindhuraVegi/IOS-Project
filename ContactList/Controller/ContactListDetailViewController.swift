//
//  ContactListDetailViewController.swift
//  ContactList
//
//  Created by Sindhura VEGI on 24/01/19.
//  Copyright © 2019 Sindhura VEGI. All rights reserved.
//

import UIKit

class ContactListDetailViewController: UIViewController {
    
    @IBOutlet weak var img_View: UIImageView!
    @IBOutlet weak var firstname_lbl: UILabel!
    @IBOutlet weak var lastname_lbl: UILabel!
    @IBOutlet weak var street_lbl: UILabel!
    @IBOutlet weak var city_lbl: UILabel!
    @IBOutlet weak var email_lbl: UILabel!
    @IBOutlet weak var phone_lbl: UILabel!
    @IBOutlet weak var cell_lbl: UILabel!
    @IBOutlet weak var title_lbl: UILabel!


    var list_Details : Result?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "ContactDetails"
        details()
        // Do any additional setup after loading the view.
    }
    func details()  {
        let imgURL = URL(string: list_Details?.picture?.medium ?? "avatar")
        let data: Data = try! Data(contentsOf: imgURL!)
        self.img_View.image = UIImage(data: data)
        self.title_lbl.text = (list_Details?.name?.title).map { $0.rawValue }
        self.firstname_lbl.text = list_Details?.name?.first
        self.lastname_lbl.text = list_Details?.name?.last
        self.street_lbl.text = list_Details?.location?.street
        self.city_lbl.text = list_Details?.location?.city
        self.email_lbl.text = list_Details?.email
        self.phone_lbl.text = list_Details?.phone
        self.cell_lbl.text = list_Details?.cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
