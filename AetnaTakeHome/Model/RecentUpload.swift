//
//  RecentUpload.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/20/21.
//

import UIKit

struct RecentUpload: Decodable {
    let title: String
    let link: String
    let media: Dictionary<String,String>
    let date_taken: String
    let description: String
    let published: String
    let author: String
    let author_id: String
    let tags: String
}

struct RecentUploads: Decodable {
    let items: [RecentUpload]
}
