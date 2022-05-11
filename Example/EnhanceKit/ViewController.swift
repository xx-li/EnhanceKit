//
//  ViewController.swift
//  EnhanceKit
//
//  Created by lixinxing on 01/10/2022.
//  Copyright (c) 2022 lixinxing. All rights reserved.
//

import UIKit
import EnhanceKit

class TestTableViewCell: UITableViewCell, EHReusable {
    
}

class TestHeaderView: UITableViewHeaderFooterView, EHReusable {
}



class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.eh.register(cell: TestTableViewCell.self)
        tableView.eh.register(cell: TestNibTableViewCell.self, isCreateByNib: true)
        tableView.eh.register(headerFooterView: TestHeaderView.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView: TestHeaderView = tableView.eh.dequeueReusableHeaderFooterView()
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell: TestTableViewCell = tableView.eh.dequeueReusableCell(for: indexPath)
            return cell
        } else {
            let cell: TestNibTableViewCell = tableView.eh.dequeueReusableCell(for: indexPath)
            return cell
        }
    }
    
    
}



