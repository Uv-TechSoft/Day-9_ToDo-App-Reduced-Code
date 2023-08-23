//
//  ViewController.swift
//  Alertcontroller_Day8
//
//  Created by Imam MohammadUvesh on 25/10/21.
//

import UIKit

struct AlertModel
{
    var firstName: String
    var lastName: String
}
enum ContactCRUD{
    case add
    case edit
    case delete
}

class ViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var alertButton: UIButton!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // MARK: Array of Model
    var alertArray = [AlertModel]()
    
    // MARK: Main Function
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    
    // MARK: Tap Button Activity
    
    
    @IBAction func buttonTapped(_ sender: UIBarButtonItem) {
        
       // self.contactConfiguration(isAdd: true, isDelete: false)
        self.contactConfiguration(contactCRUD: .add)
        let alertControl = UIAlertController(title: "ALERT", message: "Fill Out All Fields", preferredStyle: .alert)
        
        let save = UIAlertAction(title: "Save", style: .default)
        {
            _ in print("Save Tapped")
            if let firstname = alertControl.textFields?.first?.text, let lastname = alertControl.textFields?[1].text
            {
                let contact = AlertModel(firstName: firstname, lastName: lastname)
                self.alertArray.append(contact)
                self.tabelView.reloadData()
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        {
            _ in print("Cancel Tapped")
        }
        
        alertControl.addTextField
        {
            firstnameField in firstnameField.placeholder = "Enter Your First Name"
            
        }
        alertControl.addTextField
        {
            lastnameField in lastnameField.placeholder = "Enter Your Last Name"
        }
        
        alertControl.addAction(save)
        alertControl.addAction(cancel)
        self.present(alertControl, animated: true)
    }
    
    // MARK: Extention & Table View DataSource
    
    
    
    // MARK: Tap Button
    
    @IBAction func alertAction(_ sender: UIButton) {
        let alertController = UIAlertController(title: "ALERT", message: "This is the Alert Message", preferredStyle: .alert)
        let save = UIAlertAction(title: "Save", style: .default)
        {
            _ in print("Save Tapped")
            
        }
        let cancel = UIAlertAction(title: "Delete", style: .destructive)
        {
            _ in print("Delete Tapped")
            
        }
        let ok = UIAlertAction(title: "Cancel", style:.cancel){_ in print("Cancel Tapped")
            
        }
        alertController.addAction(ok)
        alertController.addAction(save)
        alertController.addAction(cancel)
        self.present(alertController, animated: true)
    }
 

}
 // MARK: TabelView DataSource
extension ViewController:UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        alertArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
            }
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = alertArray[indexPath.row].firstName
        cell.detailTextLabel?.text = alertArray[indexPath.row].lastName
        
        return cell
    }
}

// MARK: TabelView Delegate

extension ViewController:UITableViewDelegate {
    
    func contactConfiguration(contactCRUD: ContactCRUD ,index: Int = 0){
        
        switch contactCRUD{
        case .delete:
            //delete
            self.alertArray.remove(at: index)
            self.tabelView.reloadData()
        default:
            //append and edit
            let alertController = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
            
            let save = UIAlertAction(title: contactCRUD == .add ? "Save" : "Update", style: .default) { _ in
                if let firstname = alertController.textFields?.first?.text, let lastname = alertController.textFields?[1].text{
                    let contact = AlertModel(firstName: firstname
                                             , lastName: lastname)
                    
                    if contactCRUD == .add{
                        //Append
                        self.alertArray.append(contact) //Append
                    }else{
                        //Update
                        self.alertArray[index] = contact //Update
                    }
                    
                    self.tabelView.reloadData()
                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("cancel tapped")
            }
            
            alertController.addTextField { firstnameField in
                firstnameField.placeholder = contactCRUD == .add ? "Enter your firstname" : self.alertArray[index].firstName
            }
            
            alertController.addTextField { lastnameField in
                lastnameField.placeholder = contactCRUD == .add ? "Enter your lastname": self.alertArray[index].lastName
            }
            
            alertController.addAction(save)
            alertController.addAction(cancel)
            
            self.present(alertController, animated: true)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (_,_,_) in
                    print("Edit Action Tapped")
            self.contactConfiguration(contactCRUD: .edit, index: indexPath.row)
    }
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){
            (_,_,_) in
            print("Deleted Data Tapped")
            self.contactConfiguration(contactCRUD: .delete, index: indexPath.row)
        }
    let swipeConfiguration = UISwipeActionsConfiguration(actions: [editAction,deleteAction])
        return swipeConfiguration
}
}

