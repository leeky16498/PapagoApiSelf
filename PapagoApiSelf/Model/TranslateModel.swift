//
//  TranslateModel.swift
//  PapagoApiSelf
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation

struct TranslateModel : Codable {
    
    let message: Message
}

// MARK: - Message
struct Message: Codable {
    
    let type, service, version: String
    let result: Result

    enum CodingKeys: String, CodingKey {
        case type = "@type"
        case service = "@service"
        case version = "@version"
        case result
    }
}

// MARK: - Result
struct Result: Codable {
    let translatedText: String
}

