//
//  GlobalExtension.swift
//  WhetherReport
//
//  Created by deepakmaheshwari on 21/02/24.
//
import UIKit
import Foundation

extension UIImageView {
    func roundCorner() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
       }
}

extension UIAlertController {
    func setLoader() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
    }
}

extension Date {
    func compare(secondDate:Date) -> DateComparison {
        // Comparing wether the dates are equal or not
            if self < secondDate {
                return .earlier
            } else if self > secondDate {
                return .later
            } else {
                return .equal
            }
    }
    
    func getDayName() -> String {
        // Getting day name from date
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat  = "EEEE"
        return dateFormatter.string(from: self)
    }

    func getStringDate() -> String {
        // Converting Date into String
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
}

extension Int {
    func dateFromTimeinterval() -> Date {
        var gmtDate = Date(timeIntervalSince1970: Double(self))
        let timeZone = TimeZone(secondsFromGMT: 5*60*60 + 30*60)  // 5 hours and 30 minutes ahead
        gmtDate = gmtDate.addingTimeInterval(TimeInterval(timeZone?.secondsFromGMT(for: gmtDate) ?? 0))
        let calendar = Calendar.current

        // Extracting date components
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: gmtDate)

        // Creating a new Date with extracted date components
        if let dateWithoutTime = calendar.date(from: dateComponents) {
            return dateWithoutTime
        } else {
            return gmtDate
        }
    }
}

enum DateComparison {
    case earlier
    case equal
    case later
}
