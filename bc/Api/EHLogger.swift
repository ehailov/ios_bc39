//
//  EHLogger.swift
//  bc
//
//  Created by Evgeny Hailov on 12.07.2023.
//

import Foundation

public class EHLogger {
    
    public static func verbose(_ text: String, error: NSError?) {
        if error != nil {
            printError(fromText: text, description: error!.localizedDescription)
            return
        }
        printLog(fromText: text)
    }
    
    static private func printError(fromText: String, description: String) {
        NSLog("BC Error: %@ %@", fromText, description)
    }
    
    static private func printLog(fromText: String) {
        NSLog("BC Log: %@ ", fromText)
    }
}
