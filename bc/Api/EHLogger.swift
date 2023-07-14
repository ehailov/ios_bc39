//
//  EHLogger.swift
//  bc
//
//  Created by Evgeny Hailov on 12.07.2023.
//

import Foundation

public class EHLogger {
    
    public static func verbose(_ text: String, _ error: NSError?) {
        if error != nil {
            NSLog("BC Error: %@ %@", text, error!.localizedDescription)
            return
        }
        NSLog("BC Log: %@ ", text)
    }
}
