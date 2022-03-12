//
//  PapagoDataService.swift
//  PapagoApiSelf
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation
import Combine
import SwiftUI

class PapagoDataService {
    
    @Published var translated : TranslateModel?
    @Published var initialText : String = ""
    
    static let instance = PapagoDataService()
    
    var cancellables = Set<AnyCancellable>()
    
    private init() {
        
    }
    
    func apiCall(text : String) {
        
        let param = "source=ko&target=en&text=\(text)"
        let paramData = param.data(using: .utf8)
        let client_Id = "uper2EKrAl57W_VGdNRw"
        let client_Secret = "Vc7Ztinlmz"

        guard let url = URL(string: "https://openapi.naver.com/v1/papago/n2mt")
        else { return }
        print("0")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = paramData
        request.addValue(client_Id, forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue(client_Secret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        print("1")
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap(handleOutput)
            .decode(type: TranslateModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error to download")
                }
            } receiveValue: { [weak self] (translatedData) in
                self?.translated = translatedData
            }
            .store(in: &cancellables)
    }
    
    func handleOutput(output : URLSession.DataTaskPublisher.Output) throws -> Data {
        
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300  else {
                  throw URLError(.badServerResponse)
              }
        return output.data
    }
    
}
