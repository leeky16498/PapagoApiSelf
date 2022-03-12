//
//  HomeView.swift
//  PapagoApiSelf
//
//  Created by Kyungyun Lee on 09/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var tm = HomeViewModel()
    
    var body: some View {
        VStack{
            TextEditor(text: $tm.text)
                .foregroundColor(.blue)
                .frame(maxWidth : .infinity)
                .frame(height : 300)
                .colorMultiply(.gray)
        }
        .onChange(of: tm.text, perform:  {
            PapagoDataService.instance.apiCall(text: $0)
        })
        
        Button(action: {
            
        }, label: {
            Text("translate")
        })
        
        if let translated = tm.translated?.message.result.translatedText {
            Text(translated)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
