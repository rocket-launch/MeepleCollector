//
//  String+Ext.swift
//  MeepleCollector
//
//  Created by Fabián Ferreira on 2021-11-25.
//

import Foundation

extension String {
    
    var htmlToString: String? {
        guard let data = self.data(using: .utf8) else { return nil }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else { return nil }
        
        return attributedString.string
    }
}
