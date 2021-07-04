//
//  Encodable+Extension.swift
//  OutDoorOrder
//
//  Created by Mac on 2/25/21.
//

import Foundation
extension Encodable {

    /// Encode into JSON and return `Data`
    func jsonData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try encoder.encode(self)
    }
}
