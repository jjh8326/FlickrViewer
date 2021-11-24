//
//  ImageCell.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/20/21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageSizeDesc: UILabel!
    
    func configureCell(searchItem: RecentUpload) {
        self.backgroundColor = .white
        
        self.imageTitle.attributedText = NSAttributedString(string: searchItem.title, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 17.0)])
        self.imageSizeDesc.text = String(format: "%@ x %@ px", searchItem.width, searchItem.height)
        
        //Add an activity indicator for image loading
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        self.addSubview(activityIndicator)
        activityIndicator.frame = self.bounds
        activityIndicator.startAnimating()
        
        FlickrAPI.fetchImage(withString: searchItem.imageLink) { result in
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                self.imageView.image = result

                self.imageView.layer.borderWidth = 2
                self.imageView.layer.borderColor = UIColor.black.cgColor
            }
        }
    }
}
