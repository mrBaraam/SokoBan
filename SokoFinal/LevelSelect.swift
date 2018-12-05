//
//  LevelSelect.swift
//  Egerszegi_Steven_SokoFinal
//
//  Created by Period Three on 6/5/18.
//  Copyright © 2018 Period Three. All rights reserved.
//

import Foundation
import UIKit

class LevelSelect: UIViewController {
    
    //This class is controls the main menu
    
    var level = ""
    var levelArray: [String] = []
    var filename = ""

    @IBOutlet weak var levelField: UITextField!
    
    @IBOutlet weak var levelNumberField: UITextField!
    
    
    @IBAction func enterLevelSet(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "microban"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func masmicroban(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "masmicroban"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func microbaniii(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "Microban_III"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func microbaniv(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "Microban_IV"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    
    
    
    
    @IBAction func levelEnter(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "sasquatch"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func massasquatch(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "mas_sasquatch"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func sasquatchiii(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "sasquatch_iii"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func sasquatchiv(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "sasquatch_iv"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    @IBAction func original(_ sender: Any) {
        
        if !levelArray.isEmpty{
            levelArray = []
        }
        
        filename = "default"
        
        
        if let path = Bundle.main.path(forResource: filename, ofType: "txt") {
            do {
                
                let levels = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                
                levelArray += levels.components(separatedBy: ";")
            } catch {
                print("Failed to read text from \(filename)")
            }
        } else {
            print("Failed to load file from app bundle \(filename)")
        }
        
        performSegue(withIdentifier: "levelSetSegue", sender: sender)
    }
    
    
    
    

    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? GameViewController else { return }
        viewController.level = level
        viewController.levelName = filename
    }*/
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? TableViewController else { return }
        viewController.levelArray = levelArray
        viewController.levelName = filename
    }
    
}
