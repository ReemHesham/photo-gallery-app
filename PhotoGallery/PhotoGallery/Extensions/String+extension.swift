//
//  String+extension.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/5/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

extension String {
    /**
     localized return the localized value of the current string depending on the current selected app language.
     if there is no langauge selected yet, use a default value
     */
    var localized: String {
        let language = "en" // TODOs: check on the current app language here
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path) else {
            return ""
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
