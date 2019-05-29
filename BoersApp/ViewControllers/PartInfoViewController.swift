//
//  PartInfoViewController.swift
//  BoersApp
//
//  Created by Dmitry Rozov on 29/05/2019.
//  Copyright © 2019 SPBSTU. All rights reserved.
//

import UIKit


// TODO: - Все по аналогии с Product Info
class PartInfoViewController: PanModalPresentbleViewController {

    @IBOutlet var tableView: UITableView!

    override var panScrollable: UIScrollView? {
        return tableView
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
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

}
