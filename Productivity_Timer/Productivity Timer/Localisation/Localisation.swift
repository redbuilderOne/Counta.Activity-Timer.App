//
//  Localisation.swift
//  Productivity Timer
//
//  Created by Дмитрий Скворцов on 20.09.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self,
                                 tableName: "Localizable",
                                 bundle: .main,
                                 value: self,
                                 comment: self)
    }
}
