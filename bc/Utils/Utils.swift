//
//  Utils.swift
//  bc
//
//  Created by Evgeny Hailov on 04.07.2023.
//

import Foundation

public class Utils {
    
    public static func dateTimeFormat (_ string: String) -> String {
        return formate(getFormatter("yyyy-MM-dd'T'HH:mm:ss.SSSZ"), string: string)
    }
    
    public static func dateFormat (_ string: String) -> String {
        return formate(getFormatter("yyyy-MM-dd"), string: string)
    }
    
    private static func formate(_ formatter: DateFormatter, string: String) -> String {
        let date = formatter.date(from: string)
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy"
        if date == nil {
            return ""
        }
        return df.string(from: date!)
    }
    
    private static func getFormatter(_ format: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        return dateFormatter
    }
}
