//
//  ViewController.swift
//  ToDoApp
//
//  Created by Yogesh Patel on 23/10/21.
//

import UIKit

struct ContactModel{
    var firstname: String
    var lastname: String
}

enum ContactCRUD{
    case add
    case edit
    case delete
}

class ViewController: UIViewController {

    @IBOutlet weak var contactTableView: UITableView!
    
    var arrData = [ContactModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    //MARK: Button Tapped
    @IBAction func addContactTapped(_ sender: UIBarButtonItem) {
        
//        self.contactConfiguration(isAdd: true, isDelete: false)
        self.contactConfiguration(contactCRUD: .add)
        
    }
}
// MARK: TabelView DataSource
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrData.count
    }
    //MARK: TabelView CellforRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: "cell") else{
            return UITableViewCell()
        }
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = arrData[indexPath.row].firstname
        cell.detailTextLabel?.text = arrData[indexPath.row].lastname
        
//      cell.accessoryType = .detailDisclosureButton
        return cell
    }
}
/*
 add - 0
 edit - 1
 delete - 2
 */

    // MARK: TabelView Delegate

extension ViewController: UITableViewDelegate{
    
    // MARK: CRUD
    func contactConfiguration(contactCRUD: ContactCRUD ,index: Int = 0){
        
        switch contactCRUD{
        case .delete:
            //delete
            self.arrData.remove(at: index)
            self.contactTableView.reloadData()
        default:
            //append and edit
            let alertController = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
            
            let save = UIAlertAction(title: contactCRUD == .add ? "Save" : "Update", style: .default) { _ in
                if let firstname = alertController.textFields?.first?.text, let lastname = alertController.textFields?[1].text{
                    let contact = ContactModel(firstname: firstname, lastname: lastname)
                    
                    if contactCRUD == .add{
                        //Append
                        self.arrData.append(contact) //Append
                    }else{
                        //Update
                        self.arrData[index] = contact //Update
                    }
                    
                    self.contactTableView.reloadData()
                }
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
                print("cancel tapped")
            }
            
            alertController.addTextField { firstnameField in
                firstnameField.placeholder = contactCRUD == .add ? "Enter your firstname" : self.arrData[index].firstname
            }
            
            alertController.addTextField { lastnameField in
                lastnameField.placeholder = contactCRUD == .add ? "Enter your lastname": self.arrData[index].lastname
            }
            
            alertController.addAction(save)
            alertController.addAction(cancel)
            
            self.present(alertController, animated: true)
        }
        
    }
    
    // MARK: TabelView TrialingSwipeActionConfigurationForRowAt
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let edit = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            self.contactConfiguration(contactCRUD: .edit, index: indexPath.row)
        }
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
//            self.contactConfiguration(isAdd: false, isDelete: true)
            self.contactConfiguration(contactCRUD: .delete, index: indexPath.row)
        }
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [delete, edit])
        return swipeConfiguration
    }
}

/*
 Make one function  - AlertController
 swipe 2 button add karna 6e edit and delete
 didselect no code remove karvano 6e ae edit ma aavshe
 - deprycated method use nai karvani - Without deprycated method use karvani 6e
 */


/*
 
 if isDelete{
     //delete
     self.arrData.remove(at: index)
     self.contactTableView.reloadData()
 }else{
     //append and edit
     let alertController = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
     
//        var saveTitle = ""
//        if isAdd{
//            saveTitle = "Save"
//        }else{
//            saveTitle = "Update"
//        }
     
     let save = UIAlertAction(title: isAdd == true ? "Save" : "Update", style: .default) { _ in
         if let firstname = alertController.textFields?.first?.text, let lastname = alertController.textFields?[1].text{
             let contact = ContactModel(firstname: firstname, lastname: lastname)
             
             if isAdd{
                 //Append
                 self.arrData.append(contact) //Append
             }else{
                 //Update
                 self.arrData[index] = contact //Update
             }
             
             self.contactTableView.reloadData()
         }
     }
     
     let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
         print("cancel tapped")
     }
     
     alertController.addTextField { firstnameField in
//            if isAdd{
//                firstnameField.placeholder = "Enter your firstname"
//            }else{
//                firstnameField.placeholder = self.arrData[index].firstname
//            }
         firstnameField.placeholder = isAdd ? "Enter your firstname" : self.arrData[index].firstname
     }
     
     alertController.addTextField { lastnameField in
//            if isAdd{
//                lastnameField.placeholder = "Enter your lastname"
//            }else{
//                lastnameField.placeholder = self.arrData[index].lastname
//            }
         lastnameField.placeholder = isAdd ? "Enter your lastname": self.arrData[index].lastname
     }
     
     alertController.addAction(save)
     alertController.addAction(cancel)
     
     self.present(alertController, animated: true)
 */

// MARK: - Task
/*
 
 Swipe ma Add two buttons karo
 
 1. function contactconfiguration nu - isAdd(BOOL) and index lai lo (Arguments)
 2. Save and Update title aene change karo - parameter, variable, ternary operator thi
 3. ternary - firstname placeholder change karo
 4. isdelete aene function ma nakhvanu try karo (Argument laine)
 5. enum use karyo!
 
 */
