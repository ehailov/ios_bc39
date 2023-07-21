//
//  Utils.swift
//  bc
//
//  Created by Evgeny Hailov on 04.07.2023.
//

import Foundation
import SwiftUI

// MARK: - Utils
public class Utils {
    
    public static func stringFrom(date: Date) -> String {
        let df = getFormatterFrom(format: "dd.MM.yyyy")
        return df.string(from: date) ?? "-"
    }
    
    public static func dateFrom(string: String, format: String) -> String? {
        guard let date = getDateFrom(string: string, format: format) else {
            return nil
        }
        return getFormatterFrom(format: "dd.MM.yyyy").string(from: date)
    }
    
    public static func getDateFrom(string: String, format: String) -> Date? {
        let df = getFormatterFrom(format: format)
        return df.date(from: string)
    }
    
    private static func getFormatterFrom(format: String) -> DateFormatter {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US_POSIX")
        df.dateFormat = format
        return df
    }
    
}

// MARK: - Extension

extension LocalizedStringKey {
    
    var stringKey: String? {
        Mirror(reflecting: self).children.first(where: {
            $0.label == "key"
        })?.value as? String
    }
}

extension String {
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
}

extension LocalizedStringKey {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey!, locale: locale)
    }
}

extension String {
    static func localizedString(for key: String, locale: Locale = .current) -> String {
        let language = locale.languageCode
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        return localizedString
    }
}

extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view
        
        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

