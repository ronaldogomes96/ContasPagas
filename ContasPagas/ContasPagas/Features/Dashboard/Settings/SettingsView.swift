//
//  SettingsView.swift
//  ContasPagas
//
//  Created by Ronaldo Gomes on 16/06/23.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel: SettingsViewModel
    @State private var isDarkMode = true
    private let viewFactory: ViewFactory
    
    init(viewModel: SettingsViewModel,
         viewFactory: ViewFactory) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.viewFactory = viewFactory
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGray6)
                
                List {
                    Text("Sair do App")
                        .foregroundColor(.red)
                        .onTapGesture {
                            viewModel.tryToSignOutWithSucess { sucess in
                                // chamar logout
                            }
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
        SettingsView(viewModel: SettingsViewModel(authenticationFacade: AuthenticationFacade()),
                     viewFactory: ViewFactory(viewModelFactory: ViewModelFactory()))
    }
}
