//
//  ServiceStatus.swift
//  NightscoutServiceKitUI
//
//  Created by Pete Schwamb on 9/30/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import SwiftUI
import LoopKitUI
import NightscoutServiceKit

struct ServiceStatusView: View, HorizontalSizeClassOverride {
    @Environment(\.dismissAction) private var dismiss

    @ObservedObject var viewModel: ServiceStatusViewModel
    @ObservedObject var otpViewModel: OTPViewModel
    @State private var selectedItem: String?
    var body: some View {
        VStack {
            Text("Nightscout")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Image(frameworkImage: "nightscout", decorative: true)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
            

            VStack(spacing: 0) {
                HStack {
                    Text("URL")
                    Spacer()
                    Text(viewModel.urlString)
                }
                .padding()
                Divider()
                HStack {
                    Text("Status")
                    Spacer()
                    Text(String(describing: viewModel.status))
                }
                .padding()
                NavigationLink(destination: OTPSelectionView(otpViewModel: otpViewModel), tag: "otp-view", selection: $selectedItem) {
                    HStack {
                        Text("One-Time Password")
                        Spacer()
                        Text(otpViewModel.otpCode)
                    }
                }
                .padding()
            }
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            
            Button(action: {
                viewModel.didLogout?()
            } ) {
                Text("Logout").padding(.top, 20)
            }
        }
        .padding([.leading, .trailing])
        .navigationBarTitle("")
        .navigationBarItems(trailing: dismissButton)
    }
    
    private var dismissButton: some View {
        Button(action: dismiss) {
            Text("Done").bold()
        }
    }
}

private struct RefreshOnAppearModifier<Tag: Hashable>: ViewModifier {
    @State private var viewId = UUID()
    @Binding var selection: Tag?
    
    func body(content: Content) -> some View {
        content
            .id(viewId)
            .onAppear {
                if selection != nil {
                    viewId = UUID()
                    selection = nil
                }
            }
    }
}

private extension View {
    func refreshOnAppear<Tag: Hashable>(selection: Binding<Tag?>? = nil) -> some View {
        modifier(RefreshOnAppearModifier(selection: selection ?? .constant(nil)))
    }
}
