//
//  SkorVC.swift
//  iosGame
//
//  Created by IŞIL VARDARLI on 25.09.2024.
//

import UIKit

class SkorVC: UIViewController {
    
    @IBOutlet weak var lastSkorLabel: UILabel!
    
    @IBOutlet weak var highestSkorLabel: UILabel!
    
    @IBAction func sendStartButton(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let d = UserDefaults.standard
        let lastSkor = d.integer(forKey: "lastSkor")
        let highestSkor = d.integer(forKey: "highestSkor")
        
        lastSkorLabel.text = "\(lastSkor)"
        
        if lastSkor > highestSkor {
            d.set(lastSkor, forKey: "highestSkor")
        }
        
        highestSkorLabel.text = String(d.integer(forKey: "highestSkor"))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

}
