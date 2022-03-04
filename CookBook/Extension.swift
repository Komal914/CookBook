//
//  Extension.swift
//  CookBook
//
//  Created by Komal Kaur on 5/11/21.
//

import Foundation
import UIKit

extension String {
    
    func emptyAsNil() -> String? {
        self.isEmpty ? nil : self
    }
    
    
    public func trimHTMLTags() -> String? {
        guard let htmlStringData = self.data(using: String.Encoding.utf8) else {
            return nil
        }
    
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
    
        let attributedString = try? NSAttributedString(data: htmlStringData, options: options, documentAttributes: nil)
        return attributedString?.string
    }
    
}
extension UIView {

func zoomIn(duration: TimeInterval = 0.3) {
    self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    UIView.animate(withDuration: duration, delay: 0.1, options: [.curveLinear], animations: { () -> Void in
        self.transform = CGAffineTransform.identity
    }) { (animationCompleted: Bool) -> Void in
    }
}
}






