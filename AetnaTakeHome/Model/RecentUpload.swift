//
//  RecentUpload.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/20/21.
//

import UIKit


//TODO: Consider making this a class
//TODO: Consider rename

//TODO: Make this get the json manually so we can parse it and store the data that we care about

//TODO: Cleanup all code and address json issues before moving on

class RecentUpload {
    var title: String = ""
    var imageLink: String = ""
    var dateTaken: String = ""
    var dateUploaded: String = ""
    var width: String = ""
    var height: String = ""
    var imageDescription: String = ""
    var author: String = ""
    //let tags: String
    
    init(dict: [String: Any]) {
        
        //TODO: Handle no title
        
        if let _title = dict["title"] {
            self.title = _title as! String
        }
        if let _imageLink = RecentUpload.getImageLink(dict: dict["media"] as! [String? : String?]) {
            self.imageLink = _imageLink
        }
        if let _dateTaken = RecentUpload.getDateFormatted(dateString: dict["date_taken"] as! String) {
            self.dateTaken = _dateTaken
        }
        if let _width = RecentUpload.getWidth(apiText: dict["description"] as! String) {
            self.width = _width
        }
        if let _height = RecentUpload.getWidth(apiText: dict["description"] as! String) {
            self.height = _height
        }
        if let _imageDescription = RecentUpload.getImageDescription(apiText: dict["description"] as! String) {
            self.imageDescription = _imageDescription
        }
        if let _dateUploaded = RecentUpload.getDateFormatted(dateString: dict["published"] as! String) {
            self.dateUploaded = _dateUploaded
        }
        if let _author = RecentUpload.getAuthor(apiText: dict["author"] as! String) {
            self.author = _author
        }
    }
    
    private static func getImageLink(dict: [String?: String?]) -> String? {
        if let imageLink = dict["m"] {
            return imageLink
        }
        
        return ""
    }
    
    private static func getDateFormatted(dateString: String) -> String? {
        //The date that is in the json is an ISO date
        let isoDateFormatter = DateFormatter()
        //Set the locale to the user's locale
        isoDateFormatter.locale = Locale.current
        //Set the formatter to the ISO format
        isoDateFormatter.dateFormat = Constants.isoDateFormatString
        
        //Create the date if it's valid
        if let date = isoDateFormatter.date(from: dateString) {
            //Format the date as per the requirements
            let requiredDateFormatter = DateFormatter()
            requiredDateFormatter.dateFormat = Constants.dateFormatString
            return requiredDateFormatter.string(from: date)
        }
        //TODO: Error logging class
        print("Failed to format date!")
        //If for whatever reason the date failed to format then return the original date
        return dateString
    }
    
    //TODO: Stress test this class, use indices check
    
    //Note: I am pretty sure that this data is innaccurate, this may be user entered and not the correct width of the image
    private static func getWidth(apiText: String) -> String? {
        let components = apiText.components(separatedBy: " ")

        var widthString = ""

        for i in 0..<components.count {
            let component: String = components[i]
            if component.contains("width") {
                let widthComponents = component.components(separatedBy: "\"")
                if widthComponents.indices.contains(1) {
                    widthString = widthComponents[1];
                }
            }
        }
        
        return widthString
    }
    
    //Note: I am pretty sure that this data is innaccurate, this may be user entered and not the correct height of the image
    private static func getHeight(apiText: String) -> String? {
        let components = apiText.components(separatedBy: " ")

        var heightString = ""

        for i in 0..<components.count {
            let component: String = components[i]
            if component.contains("height") {
                let widthComponents = component.components(separatedBy: "\"")
                if widthComponents.indices.contains(1) {
                    heightString = widthComponents[1];
                }
            }
        }
        
        return heightString
    }
    
    //TODO: Need to use a HTML parser here?
    //Note: This is a very hard-coded esque way to do things, that being said, since the description is so difficult to reliably retrieve due to random HTML tags in the api text, I do not think a HTML parser would be any less hard-coded
    private static func getImageDescription(apiText: String) -> String? {
        //Try to sanitize the HTML text with common tags found in descriptions
        var sanitized = apiText.replacingOccurrences(of: "</p>", with: "<p>")
        sanitized = sanitized.replacingOccurrences(of: "&quot;", with: "\"")
        sanitized = sanitized.replacingOccurrences(of: "<br />", with: "")
        sanitized = sanitized.replacingOccurrences(of: "&amp;", with: "&")
        
        let components = sanitized.components(separatedBy: "<p>")
        //TODO: Add more things to sanitize the description
        
        var description = ""
        
        //Check to see if the description is valid
        //NOTE: There is no great way to get the description, sometimes you get a description with lots of HTML based formatting, if we get one of those we will just discord the description
        
        if !components[components.count - 2].contains("<a href=\"https://www.flickr.com/") {
            description = components[components.count - 2]
        }
        
        return description
    }
    
    private static func getAuthor(apiText: String) -> String? {
        let components = apiText.components(separatedBy: "\"")
        
        if components.indices.contains(1) {
            return components[1]
        }
        
        return "(Author uknown)"
    }
}
