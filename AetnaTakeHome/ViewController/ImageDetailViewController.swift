//
//  ImageDetailVIewController.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/22/21.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDetails: UITextView!
    
    //TODO: Yikes with the naming
    var selectedImage: RecentUpload!

    override func viewDidLoad() {
        
        //TODO: Do this programatically
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TODO: This view is ugly
        //TODO: Constraints are bad
        //TODO: Use loading indicator
        
//        let margins = imageView.layoutMarginsGuide
//        imageView.leadingAnchor.constraint(equalTo:  margins.leadingAnchor, constant: 5).isActive = true
//        imageView.trailingAnchor.constraint(equalTo:  margins.trailingAnchor, constant: 5).isActive = true
        
        //Set our anchors to the image width and height (need to pass this in)
        
        
        let widthString = self.selectedImage.width
        let heightString = self.selectedImage.height
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0
        
        if let w = NumberFormatter().number(from: widthString) {
            width = CGFloat(truncating: w)
        }
        
        if let h = NumberFormatter().number(from: heightString) {
            height = CGFloat(truncating: h)
        }
        
        //Set the constraints to the image
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        
        
        
        //TODO: Use an image cache

        FlickrAPI.fetchImage(withString: selectedImage.imageLink) { result in
            DispatchQueue.main.async {
                self.imageView.image = result
                //self.imageView.layer.borderWidth = 2
                
                //TODO: Need to create this view programatically so it sizes with the image

                self.imageView.image = self.imageView.image?.addShadow()

                //TODO: Using border for debug only
                //TODO: Consider moving this out of dispatch queue
                //TODO: Attributed text

                self.imageDetails.sizeToFit()
                
                self.imageDetails.layer.borderWidth = 2
                
                //TODO: Make title italicized
                
//                self.imageDetails.text = String(format: "%@\n%@\n%@\n%@\n%@\n%@\n", self.selectedImage.title, self.selectedImage.dateTaken, self.selectedImage.dateUploaded, "selectedImage.size", self.selectedImage.imageDescription, self.selectedImage.author)
                                
                //Make title italics
                let imageDetailsAttributedText = NSMutableAttributedString(string: "")
                
                if (self.selectedImage.title != "") {
                    let imageTitleAttributedText = NSMutableAttributedString(string: self.selectedImage.title, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 15)])
                    
                    imageDetailsAttributedText.append(imageTitleAttributedText)
                } else {
                    let imageTitleAttributedText = NSMutableAttributedString(string: "Photo", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
                    
                    imageDetailsAttributedText.append(imageTitleAttributedText)
                }
                
                let imageAuthorAttributesText = NSAttributedString(string: " by " + self.selectedImage.author + "\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])
                
                imageDetailsAttributedText.append(imageAuthorAttributesText)
                
                //TODO: If description is blank then skip it
                if (self.selectedImage.imageDescription != "") {
                    let attributedDescriptionWordText = NSAttributedString(string: "\nDescription: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)])
                    
                    imageDetailsAttributedText.append(attributedDescriptionWordText)
                    
                    //Created attributed text of the title
                    let attributedImageDescriptionText = NSAttributedString(string: "\"" + self.selectedImage.imageDescription + "\"", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)])
                    
                    imageDetailsAttributedText.append(attributedImageDescriptionText)
                }
                
                let attributedSizeWordText = NSAttributedString(string: "\nDimensions: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15.0)])
                
                imageDetailsAttributedText.append(attributedSizeWordText)
                
                let attributedSizeText = NSAttributedString(string: self.selectedImage.width + " by " + self.selectedImage.height + " pixels", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15.0)])
                
                imageDetailsAttributedText.append(attributedSizeText)
                
                self.imageDetails.attributedText = imageDetailsAttributedText
            }
        }
    }
}
