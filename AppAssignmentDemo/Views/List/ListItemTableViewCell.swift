//
//  ListItemTableViewCell.swift
//  AppAssignmentDemo
//
//  Created by Piyush Naredi on 06/01/21.
//

import UIKit

///Item repetable table cell
class ListItemTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var itemImgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblMessage: UILabel!
    
    // MARK: - Properties
    
    var item: ItemsModel? {
        didSet {
            itemImgView.downloadImage(imageURL: item?.image, placeholderImage: #imageLiteral(resourceName: "placeholder_img"))
            lblTitle.text = item?.title
            lblMessage.text = item?.description
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
