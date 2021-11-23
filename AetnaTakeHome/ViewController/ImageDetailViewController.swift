//
//  ImageDetailVIewController.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/22/21.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDetails: UILabel!
    
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
            imageView.widthAnchor.constraint(equalToConstant: 240),
            imageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        
        
        
        //TODO: Use an image cache
        
        //Uncomment later
//        let downloadLink = selectedImage.media["m"] ?? ""
//
//        FlickrAPI.fetchImage(withString: downloadLink) { result in
//            DispatchQueue.main.async {
//                self.imageView.image = result
//                //self.imageView.layer.borderWidth = 2
//
//                //TODO: Need to create this view programatically so it sizes with the image
//
//                //TODO: ADD BACK SHADOWS
//                self.imageView.image = self.imageView.image?.addShadow()
//
//                //TODO: Using border for debug only
//                //self.imageView.layer.borderColor = UIColor.black.cgColor
//                self.imageDetails.text = "Piece of Art by Joe\nUploaded November 22, 2021\n\"Captured a deer in it's natural habitat on my Nokia 5000\"\n200 by 200 pixels\nMoreMetaData\nAndMore\nEmail this to yourself"
//
//                self.imageDetails.sizeToFit()
//                self.imageDetails.numberOfLines = 0
//                //self.imageDetails.layer.borderWidth = 2
//            }
//        }
    }
    
    

}
