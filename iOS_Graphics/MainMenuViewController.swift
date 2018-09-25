//
//  MainMenuViewController.swift
//  iOS_Graphics
//
//  Created by Miguel Gallego Martín on 25/9/18.
//  Copyright © 2018 Miguel Gallego Martín. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    enum TableItems: String {
        case CAShapeLayer      // Segues has the same id
        
        static var count: Int {
            return 1
        }
        
        static func item(at index: Int) -> String {
            switch index {
            case 0:     return TableItems.CAShapeLayer.rawValue
            default:    return ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.rowHeight = 60.0

    }

    // MARK: - UITableViewDataSource & UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: nil) //tableView.dequeueReusableCell
        cell.textLabel?.text = TableItems.item(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: TableItems.item(at: indexPath.row), sender: nil)
    }
    
    

}
