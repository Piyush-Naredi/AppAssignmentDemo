//
//  ItemsDetailViewController.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 06/01/21.
//

import UIKit

///Items Detail Screen
class ItemsDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    // MARK: - Properties
    
    var item: ItemsModel?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemImgView.downloadImage(imageURL: item?.image, placeholderImage: #imageLiteral(resourceName: "placeholder_img"))
        lblTitle.text = item?.title
        lblMessage.text = item?.description
    }

}
