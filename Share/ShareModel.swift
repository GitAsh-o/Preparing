//
//  ShareModel.swift
//  Share
//
//  Created by 大沼朝陽 on 2023/09/23.
//

import SwiftUI
import UniformTypeIdentifiers

class ShareModel: ObservableObject {
    @Published var sharedText: String = ""
    var extensionContext: NSExtensionContext?
    
    init() {
        // 初期化処理
    }
    
    func configure(context: NSExtensionContext?) {
        self.extensionContext = context
        
        guard let item = context?.inputItems.first as? NSExtensionItem else { return }
        guard let itemProvider = item.attachments?.first else { return }
        
        // テキストが共有された場合
        if itemProvider.hasItemConformingToTypeIdentifier(UTType.text.identifier) {
            // テキストを取り出して代入
            itemProvider.loadItem(forTypeIdentifier: UTType.text.identifier, options: nil) { data, error in
                guard let sharedText = data as? String else { return }
                DispatchQueue.main.async {
                    self.sharedText = sharedText
                }
            }
        }
    }
    
    func cancel() {
        self.extensionContext?.cancelRequest(withError: ShareError.cancel) // 共有をキャンセル
    }
    
    func submit() {
        // ここに共有処理を記述する
        
        self.extensionContext?.completeRequest(returningItems: nil) // 共有完了
    }
    
    enum ShareError: Error {
        case cancel
    }
}
