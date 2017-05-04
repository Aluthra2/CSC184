//
//  ViewController.swift
//  MyCoreData
//
//  Created by Aman Luthra on 4/10/17.
//  Copyright © 2017 Aman Luthra. All rights reserved.
//

import UIKit;
import CoreData;

class ViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let modelContainer = appDelegate.persistentContainer.viewContext
        
        let getRequest = NSFetchRequest<NSManagedObject>(entityName: "GroceryItem")
        
        do{
            foodNames = try modelContainer.fetch(getRequest)
        } catch let error as NSError{
            print("Error getting data from entity managedObject. \(error) (error.userInfo)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        title = "Grocery List";
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell");
        
    }
    
    func save(foodItemName: String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        //get a referrence of the model
        let modelContainer = appDelegate.persistentContainer.viewContext
        
        //get a referrence of the entity or table
        let theGroceryItem = NSEntityDescription.entity(forEntityName: "GroceryItem", in: modelContainer)!
        
        //Create a foodItem object to insert into the Core Data Object
        let foodItem = NSManagedObject(entity: theGroceryItem, insertInto: modelContainer)
        
        //set the value for each key->value pair
        foodItem.setValue(foodItemName, forKeyPath: "productName")
        
        //Save the data to the model and append it to the current list
        do{
            try modelContainer.save()
            foodNames.append(foodItem)
        }catch let error as NSError{
            print("Failed to save foodItem. \(error), \(error.userInfo)")         
        }
    }

    @IBOutlet weak var tableView: UITableView!

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let dialogueBox = UIAlertController(title: "Adding Food Item", message: "Please add a Food Item", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save Item", style: .default){
            [unowned self] action in guard let foodItemTextField = dialogueBox.textFields?.first, let foodName = foodItemTextField.text else{
                return
            }
            
            self.save(foodItemName: foodName); //Wait for Implementation online
            self.tableView.reloadData()
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        dialogueBox.addTextField();
        dialogueBox.addAction(saveAction);
        dialogueBox.addAction(cancelAction);
        
        present(dialogueBox, animated: true);
        
    }
    
    var foodNames: [NSManagedObject] = [];
    
}


extension ViewController: UITableViewDataSource{
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodNames.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let foodName = foodNames[indexPath.row];
        let theItem = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath);
        theItem.textLabel?.text = foodName.value(forKeyPath: "productName") as? String;
        return theItem;
    }
}


