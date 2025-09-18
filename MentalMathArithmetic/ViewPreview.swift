//
//  ViewPreview.swift
//  MentalMathArithmetic
//
//  Created by Muhammad Rezky on 18/09/25.
//

import SwiftUI

struct View_Preview: UIViewRepresentable {
    func makeUIView(context: Context) -> GameQuestionCardAnswerBoxView {
        GameQuestionCardAnswerBoxView()
    }
    func updateUIView(_ uiView: GameQuestionCardAnswerBoxView, context: Context) { }
}

#Preview("UIView") {
    View_Preview()
        .frame(height: 200)
}
