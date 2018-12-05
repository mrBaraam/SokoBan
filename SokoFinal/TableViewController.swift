//
//  TableViewController.swift
//  Egerszegi_Steven_SokoFinal
//
//  Created by Period Three on 6/13/18.
//  Copyright © 2018 Period Three. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    //This class controls the level list displayed after selecting a level set
    
    var levelArray:[String] = []
    var levelName:String = ""
    var level = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return levelArray.count
    }
    

    var start: Int = -1
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        start += 1
        
        if(indexPath.row != 0) {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "cell1", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        cell.tag = indexPath.row
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier:
                "cell1", for: indexPath)

            return cell
        }
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if levelArray[indexPath.row] != levelArray[0]{
        level = levelArray[indexPath.row]
        performSegue(withIdentifier: "levelSelect", sender: nil)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? GameViewController else { return }
        viewController.level = level
        viewController.levelName = levelName
    }
    
}
