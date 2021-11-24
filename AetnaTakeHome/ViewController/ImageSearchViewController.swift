//
//  ImageSearchViewController.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/20/21.
//

import UIKit

class ImageSearchViewController: UICollectionViewController {
    private var searchItems: [RecentUpload] = [RecentUpload]()
    private let itemsPerRow: CGFloat = 1
    
    private let sectionInsets = UIEdgeInsets(
        top: 20.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Show some message when first loading the view

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imageSearchReuseIdentifier, for: indexPath) as! ImageCell
        
        let searchItem = searchItems[indexPath.row]
        //Configure the cell
        cell.configureCell(searchItem: searchItem)
        
        return cell
    }
    
    //TODO: Constants
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowImageDetails") {
            if let destination = segue.destination as? ImageDetailViewController,
               let indexPath = self.collectionView.indexPathsForSelectedItems?.first {
                destination.selectedImage = searchItems[indexPath.row]
            }
        }
    }
}

extension ImageSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return true
        }
        
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        textField.addSubview(activityIndicator)
        activityIndicator.frame = textField.bounds
        activityIndicator.startAnimating()
        
        FlickrAPI.getGetRecentUploadsWith(searchTerm: text) { result in
            self.searchItems = result
            
            //TODO: Handle errors
            
            DispatchQueue.main.async {
                activityIndicator.removeFromSuperview()
                self.collectionView.reloadData()
                
                //Scroll the collection view to the top when a search is complete
                if self.searchItems.count != 0 {
                    self.collectionView.setContentOffset(CGPoint(x:0,y:0), animated: true)
                }
            }
        }
        
        //TODO: Set a title so user knows what they searched
        textField.text = nil
        textField.resignFirstResponder()
        
        return true
    }
}

extension ImageSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
