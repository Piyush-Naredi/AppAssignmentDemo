//
//  ViewController.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 05/01/21.
//

import UIKit

///Items List Screen
class ItemsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Properties
    var itemListVM = ItemsListViewModel()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeVM()
    }
    
    // MARK: - Helper functions
    
    fileprivate func initializeVM() {
        itemListVM.updateLoaderClosure = {
            if self.itemListVM.showLoader {
                self.activityIndicatorView.startAnimating()
            } else {
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        itemListVM.updateResultClosure = {
            if self.itemListVM.isResultSuccess {
                self.tblView.isHidden = false
                self.tblView.reloadData()
            } else if let errorMsg = self.itemListVM.errorMessage {
                self.showAlert(title: "Error!!", message: errorMsg)
            }
        }
        
        self.tblView.isHidden = true
        itemListVM.getItemsData()
    }
    
    fileprivate func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - TableView DataSource & Delegates

extension ItemsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListVM.arrItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemTableViewCell") as? ListItemTableViewCell else {
            return UITableViewCell()
        }
        let item = itemListVM.arrItems[indexPath.row]
        cell.item = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let itemDetailVC = storyboard?.instantiateViewController(identifier: "ItemsDetailViewController") as? ItemsDetailViewController else {
            return
        }
        
        itemDetailVC.item = itemListVM.arrItems[indexPath.row]
        self.navigationController?.pushViewController(itemDetailVC, animated: true)
    }
}

