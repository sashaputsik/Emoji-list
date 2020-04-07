//
//  EmojiTableViewController.swift
//  Emoji list
//
//  Created by Sasha Putsikovich on 07.04.2020.
//  Copyright © 2020 Sasha Putsikovich. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    @IBAction func addEmoji(_ sender: UIBarButtonItem) {
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else{return UITableViewCell()}
        
        return cell
    }
    
    @IBAction func addedEmoji(_ unwind: UIStoryboardSegue){
        guard let vc = unwind.source as? AddedViewController else{return}
        tableView.reloadData()
    }
}
