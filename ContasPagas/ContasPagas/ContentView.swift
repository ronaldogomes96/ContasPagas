//
//  ContentView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 19/03/23.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack(spacing: 58) {
            Image("Logo_levi")
                .frame(width: 170, height: 170)
                .background(Color.blue)
                .clipShape(Circle())
            
            Text("ContasPagas")
                .font(.largeTitle)
            
            Text("Inicie sua sessão e comece a gerenciar suas despesas")
                .font(.title2)
                .multilineTextAlignment(.center)
            
            SignInWithAppleButton(onRequest: { _ in
                
            }, onCompletion: { _ in
                
            })
            .signInWithAppleButtonStyle(colorScheme == .light ? .black : .white)
            .frame(height: 42)
        }
        .padding(24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
