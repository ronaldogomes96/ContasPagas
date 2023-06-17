//
//  SettingsView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 16/06/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel = AuthenticationViewModel()
    @State private var isDarkMode = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                
                List {
                    Text("Sair do App")
                        .foregroundColor(.red)
                        .onTapGesture {
                            // chamar logout
                            viewModel.signOut()
                        }
                }
                .listStyle(.grouped)
            }
            .navigationBarTitle(LocalizableStrings.tabbarSettings.localized)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
