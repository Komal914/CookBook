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

extension UITableView {

    func reloadWithAnimation() {
        self.reloadData()
        let tableViewHeight = self.bounds.size.height
        let cells = self.visibleCells
        var delayCounter = 0
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewHeight)
        }
        for cell in cells {
            UIView.animate(withDuration: 1.6, delay: 0.08 * Double(delayCounter),usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                cell.transform = CGAffineTransform.identity
            }, completion: nil)
            delayCounter += 1
        }
    }
}






