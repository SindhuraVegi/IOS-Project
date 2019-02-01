//
//  ViewController.swift
//  ContactList
//
//  Created by Sindhura VEGI on 21/01/19.
//  Copyright © 2019 Sindhura VEGI. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate {

    @IBOutlet weak var tableVW: UITableView!
    @IBOutlet weak var search_Bar: UISearchBar!
    var contactlist : Users?
    var refreshControl = UIRefreshControl()
    var searchActive : Bool = false
    var filtered : [String] = []
    var currentUserArray = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        search_Bar.delegate = self
        tableVW.tableFooterView = UIView()
        let xib = UINib(nibName: "ContactListViewCell", bundle:nil)
        self.tableVW.register(xib, forCellReuseIdentifier: "contactlistcellid")
        self.refreshControl.addTarget(self, action: #selector(updateData), for: .valueChanged)
        tableVW.refreshControl = refreshControl
        callAPI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func updateData(){
        callAPI()
        
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return currentUserArray.count
        }
        else if contactlist?.results != nil {
            return (contactlist?.results?.count)!
        }
        else {
        return 0
        }
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : ContactListViewCell = tableView.dequeueReusableCell(withIdentifier: "contactlistcellid", for: indexPath) as! ContactListViewCell
        if searchActive {
            let data = currentUserArray[indexPath.row]
            cell.contactListModel = data
        }
        else {
        let data = contactlist?.results![indexPath.row]
        cell.contactListModel = data
        }
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = UITableViewCell.SelectionStyle.none//UITableViewCell.SelectionStyle.none
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.tableVW.backgroundColor = UIColor.clear
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor(red: 0/255, green: 62/255, blue: 80/255, alpha: 0.4)
            
        } else {
            cell.backgroundColor = UIColor(red: 0/255, green: 62/255, blue: 80/255, alpha: 0.1)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexpath = contactlist?.results![indexPath.row]
        //tableVW.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "ContactDetailsVC") as! ContactListDetailViewController 
        detailsVC.list_Details = indexpath
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }

    func callAPI()  {
        RandomUser().getUsers({ (data, error) in
            guard let data = data else { return }
            print(data)
            DispatchQueue.main.async {
                self.contactlist = data
                self.tableVW.reloadData()
                self.refreshControl.endRefreshing()
            }
            
        })
            
            
        }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty  else {
            searchActive = false
            self.tableVW.reloadData()
            currentUserArray = (contactlist?.results)!
            return
            
        }
        
        currentUserArray = (contactlist?.results?.filter({ user -> Bool in
            return (user.name?.first?.lowercased().contains(searchText.lowercased()))!
        }))!
       
        if(currentUserArray.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableVW.reloadData()
    }
    


}


