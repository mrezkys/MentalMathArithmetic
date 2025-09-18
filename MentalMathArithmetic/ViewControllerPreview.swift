//
//  ViewControllerPreview.swift
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 16/09/25.
//

import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        return GameViewController()
    }

    func updateUIViewController(_ uiViewController: GameViewController, context: Context) {}
}

#Preview("ObjC UIViewController") {
    ViewControllerPreview()
}
