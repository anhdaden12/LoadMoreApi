//
//  ViewController.swift
//  GetDataGitLoadMore
//
//
//

import UIKit

class ViewController: UITableViewController {
    
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    var dataItem: Array<Items> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFromapi()
    }
    
    
    func dataFromapi(){
        DataService.instance.getDataApi { data in
            self.dataItem.append(contentsOf: data)
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataItem.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! customTableViewCell
        let adata = dataItem[indexPath.row]
        cell.id.text = String(Double((adata.id)))
        cell.name.text = adata.name
        cell.fullName.text = adata.full_name
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == dataItem.count  * 2 / 3 {
            dataFromapi()
        }
    }
    
    
    
}


