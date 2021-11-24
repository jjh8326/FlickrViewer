//
//  ImageDetailVIewController.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/22/21.
//

import UIKit

class ImageDetailViewController: UIViewController {
    
    //TODO: Set target back to 16.0
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageDetails: UITextView!
    
    //TODO: Yikes with the naming
    var selectedImage: RecentUpload!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //TODO: Use loading indicator
        
        //TODO: Use an image cache
        
        configureDetailedText()

        FlickrAPI.fetchImage(withString: selectedImage.imageLink) { result in
            DispatchQueue.main.async {
                self.imageView.image = result
                self.imageView.image = self.imageView.image?.addShadow()
                self.imageDetails.layer.borderWidth = 2
            }
        }
    }
        
    //Configures the attributed text that displays the image's meta data
    func configureDetailedText() {
        //Create object to hold all the attributed text
        let imageDetailsAttributedText = NSMutableAttributedString(string: "")
        
        //If there is a title make it italicized
        if (self.selectedImage.title != "") {
            let imageTitleAttributedText = NSMutableAttributedString(string: self.selectedImage.title, attributes: [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(imageTitleAttributedText)
        } else {
            let imageTitleAttributedText = NSMutableAttributedString(string: "Photo", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(imageTitleAttributedText)
        }

        //Create attributed author text
        let imageAuthorAttributesText = NSAttributedString(string: " by " + self.selectedImage.author + "\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize)])
        //Add it to the object that holds all the attributed text
        imageDetailsAttributedText.append(imageAuthorAttributesText)

        //If there is an image description then put it in the attributed text
        if (self.selectedImage.imageDescription != "") {
            let attributedImageDescriptionText = NSAttributedString(string: "\n\"" + self.selectedImage.imageDescription + "\"\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(attributedImageDescriptionText)
        }

        //Create attributed size text
        let attributedSizeWordText = NSAttributedString(string: "\nDimensions: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Constants.fontSize)])
        imageDetailsAttributedText.append(attributedSizeWordText)
        let attributedSizeText = NSAttributedString(string: self.selectedImage.width + " x " + self.selectedImage.height + " pixels", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize)])

        imageDetailsAttributedText.append(attributedSizeText)

        //If a date taken is provided then put it in the attributed text
        if (self.selectedImage.dateTaken != "") {
            let attributedDateTakenWordText = NSAttributedString(string: "\nDate Taken: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(attributedDateTakenWordText)

            let attributedDateTakenText = NSAttributedString(string: self.selectedImage.dateTaken, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(attributedDateTakenText)
        }

        //If a date uploaded is provided then put it in the attributed text
        if (self.selectedImage.dateUploaded != "") {
            let attributedDateUploadedWordText = NSAttributedString(string: "\nDate Uploaded: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(attributedDateUploadedWordText)

            let attributedDateUploadedText = NSAttributedString(string: self.selectedImage.dateUploaded, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.fontSize)])

            imageDetailsAttributedText.append(attributedDateUploadedText)
        }

        //Display the image link with a valid URL link in the attributed text
        let attributedImageLinkText = NSAttributedString(string: "\n\nImage Link", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: Constants.fontSize), NSAttributedString.Key.link: NSURL(string: self.selectedImage.imageLink) ?? NSURL()])

        imageDetailsAttributedText.append(attributedImageLinkText)

        //TODO: Set properties for interfaces using UIBuilder not programatically
        
        self.imageDetails.attributedText = imageDetailsAttributedText
    }
}
