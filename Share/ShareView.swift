//
//  ShareView.swift
//  Share
//
//  Created by 大沼朝陽 on 2023/09/23.
//

import SwiftUI

struct ShareView: View {
    @ObservedObject var model = ShareModel()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Shared Text", text: self.$model.sharedText)
            }
            .onSubmit {
                self.model.submit()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        self.model.cancel()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
        }
    }
}
