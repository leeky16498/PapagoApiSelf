//
//  HomeViewModel.swift
//  PapagoApiSelf
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import Foundation
import Combine

class HomeViewModel : ObservableObject {
    
    @Published var translated : TranslateModel?
    @Published var text : String = ""
    
    let dataService = PapagoDataService.instance
    var cancellable = Set<AnyCancellable>()
    
    init() {
        addSubscriber()
    }
    
    private func addSubscriber() {
        dataService.$translated
            .sink { [weak self] (receiveModel) in
                DispatchQueue.main.async {
                    self?.translated = receiveModel
                }
            }
            .store(in: &cancellable)
    }
}
