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
        
        //Set the constraints to the image
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: selectedImage.size.width),
            imageView.heightAnchor.constraint(equalToConstant: selectedImage.size.height)
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
                //self.imageView.layer.borderColor = UIColor.black.cgColor
                //TODO: Attributed text

                self.imageDetails.sizeToFit()
                
                self.imageDetails.layer.borderWidth = 2
                
                //Created attributed text of the title
                let attributedImageDescription = NSAttributedString(string: self.selectedImage.imageDescription, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 17.0)])
                
//                self.imageDetails.text = String(format: "%@\n%@\n%@\n%@\n%@\n%@\n", self.selectedImage.title, self.selectedImage.dateTaken, self.selectedImage.dateUploaded, "selectedImage.size", self.selectedImage.imageDescription, self.selectedImage.author)
                
                let imageDetailsAttributedText = NSMutableAttributedString(string: String(format: "%@\n", self.selectedImage.title))
                imageDetailsAttributedText.append(attributedImageDescription)
                
                self.imageDetails.attributedText = imageDetailsAttributedText
                
//                // create attributed string
//                let myString = "Swift Attributed String"
//                let myAttribute = [ NSAttributedString.Key.foregroundColor: UIColor.blue ]
//                let myAttrString = NSAttributedString(string: myString, attributes: myAttribute)
//
//                // set attributed text on a UILabel
//                myLabel.attributedText = myAttrString
            }
        }
    }
    
    

}
