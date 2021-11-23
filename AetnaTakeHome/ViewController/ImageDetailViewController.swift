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
                
                if (self.selectedImage.imageDescription != "") {
//                    let attributedDescriptionWordText = NSAttributedString(string: "\nDescription: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)])
//
//                    imageDetailsAttributedText.append(attributedDescriptionWordText)
                    
                    //Created attributed text of the title
                    let attributedImageDescriptionText = NSAttributedString(string: "\n\"" + self.selectedImage.imageDescription + "\"\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)])
                    
                    imageDetailsAttributedText.append(attributedImageDescriptionText)
                }
                
                //TODO: Make constant for font size
                
                let attributedSizeWordText = NSAttributedString(string: "\nDimensions: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)])
                
                imageDetailsAttributedText.append(attributedSizeWordText)
                
                let attributedSizeText = NSAttributedString(string: self.selectedImage.width + " x " + self.selectedImage.height + " pixels", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)])
                
                imageDetailsAttributedText.append(attributedSizeText)
                
                if (self.selectedImage.dateTaken != "") {
                    let attributedDateTakenWordText = NSAttributedString(string: "\nDate Taken: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)])
                    
                    imageDetailsAttributedText.append(attributedDateTakenWordText)
                    
                    let attributedDateTakenText = NSAttributedString(string: self.selectedImage.dateTaken, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)])
                    
                    imageDetailsAttributedText.append(attributedDateTakenText)
                }
                
                if (self.selectedImage.dateUploaded != "") {
                    let attributedDateUploadedWordText = NSAttributedString(string: "\nDate Uploaded: ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0)])
                    
                    imageDetailsAttributedText.append(attributedDateUploadedWordText)
                    
                    let attributedDateUploadedText = NSAttributedString(string: self.selectedImage.dateUploaded, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)])
                    
                    imageDetailsAttributedText.append(attributedDateUploadedText)
                }
                
                let attributedImageLinkText = NSAttributedString(string: "\n\nImage Link", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16.0), NSAttributedString.Key.link: NSURL(string: self.selectedImage.imageLink) ?? NSURL()])
                
                imageDetailsAttributedText.append(attributedImageLinkText)
        
                //TODO: Set properties for interfaces using UIBuilder not programatically
                
                self.imageDetails.attributedText = imageDetailsAttributedText
            }
        }
    }
}

//NOTE: The tappable link code does not seem to work in the simulator, I can not test on my phone because it is old and not updated
extension ImageDetailViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}
