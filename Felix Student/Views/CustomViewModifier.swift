//
//  StylerFIle.swift
//  StudentAndFacultyApp
//
//  Created by Mac on 07/07/21.
//

import Foundation
import SwiftUI

struct RedButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.red)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal)
    }
}

struct HollowTf : ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .border(Color.gray)
            .frame(width: 338, height: 50)
    }
}

struct TextStyle14 : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 14))
    }
}

struct CustomTextField : ViewModifier {
    func body(content: Content) -> some View {
        content
            .autocapitalization(.none)
            .padding()
            .frame(maxWidth : .infinity, minHeight: 50)
            .border(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), width: 2)
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(.horizontal)
    }
}

struct TextStyle10 : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 10.0))
    }
}

struct GrayShadow : ViewModifier{
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .clipped()
            .shadow(radius: 3)
    }
}

struct TextStyle20  : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 20))
    }
}

struct HStackModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth : .infinity, maxHeight: 54, alignment: .leading)
            .modifier(GrayShadow())
    }
}
