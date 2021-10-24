//
//  DetailsViewController.swift
//  CodeChallenge
//
//  Created by Tendai Maswaya on 10/22/21.
//

import Foundation
import UIKit

class DetailsViewController : BaseViewController{
    

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageContainer: UIImageView!
    
    var item:Item!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        imageContainer.image = UIImage(named: Constants.Assets.imagePlaceholder)
        var imageUrl = Constants.placeholderImageUrl
        if let url = item?.links[0].href {
            imageUrl = url
        }
        imageContainer.downloaded(from: imageUrl)
        
        guard let data = item?.data[0] else { return }
        var photographer = ""
        if let _photographer = data.photographer {
            photographer = "\(_photographer) | "
        }
        var dateCreated = ""
        if let _dateCreated = data.date_created {
            dateCreated = _dateCreated.convertDateToFriendly()
        }
        subTitleLabel.text = "\(photographer)\(dateCreated)"
        titleLabel.text = data.title
        descriptionTextView.text = data.description
    }
    
}
