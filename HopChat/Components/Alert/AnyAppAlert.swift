//
//  AnyAppAlert.swift
//  ChatterFly
//
//  Created by Pranav on 20/12/25.
//

import SwiftUI

struct AnyAppAlert {
    let alertTitle: String
    let alertSubtitle: String?
    let buttons: () -> AnyView
    
    init(
        alertTitle: String,
        alertSubtitle: String? = nil,
        buttons: (() -> AnyView)? = nil
    ) {
        self.alertTitle = alertTitle
        self.alertSubtitle = alertSubtitle
        self.buttons = buttons ?? {
            AnyView(
                Button("OK", role: .cancel) { }
            )
        }
    }
    
    init(error: Error) {
        self.init(
            alertTitle: "ERROR",
            alertSubtitle: error.localizedDescription,
            buttons: nil
        )
    }
}


enum AlertType{
    case alert , confirmationDialog
}

extension View {
    
    @ViewBuilder
    func showCustomAlert(
        type: AlertType = .alert,
        alert: Binding<AnyAppAlert?>
    ) -> some View {
        
        switch type {
            
        case .alert:
            self
                .alert(
                    alert.wrappedValue?.alertTitle ?? "",
                    isPresented: Binding(ifNotNil: alert)
                ) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.alertSubtitle {
                        Text(subtitle)
                    }
                }
            
        case .confirmationDialog:
            self
                .confirmationDialog(
                    alert.wrappedValue?.alertTitle ?? "",
                    isPresented: Binding(ifNotNil: alert)
                ) {
                    alert.wrappedValue?.buttons()
                } message: {
                    if let subtitle = alert.wrappedValue?.alertSubtitle {
                        Text(subtitle)
                    }
                }
        }
    }
}
