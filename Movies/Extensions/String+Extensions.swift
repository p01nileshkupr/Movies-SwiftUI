//
//  String+Extensions.swift
//  Movies
//
//  Created by Nilesh Prajapati on 2023/09/01.
//

import Foundation

extension String {

    func localised() -> String {
        NSLocalizedString(self, comment: self)
    }
}
