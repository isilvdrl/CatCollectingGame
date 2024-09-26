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

        // Do any additional setup after loading the view.
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
