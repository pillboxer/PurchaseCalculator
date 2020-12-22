//
//  RowViewWithButton.swift
//  PurchaseCalculator
//
//  Created by Henry Cooper on 29/11/2020.
//

import SwiftUI

private struct RowViewWithButton: View {
        
    let title: String
    let imageName: String?
    var usesSystemImage: Bool = false
    
    var buttonRotation: Double = 0
    
    var buttonImageName: String = "arrow.right.circle"
    var buttonHandler: () -> Void
    
    var image: Image {
        let name = imageName ?? "exclamationmark.triangle.fill"
        return usesSystemImage ? Image(systemName: name) : Image(name)
    }
    
    @ViewBuilder
    var body: some View {
        HStack {
            if imageName != nil {
                image
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 20, maxHeight: 20)
                    .padding(.trailing)
            }
            Text(title)
                .modifier(StandardFontModifier())
            Spacer()
            Button(action: {
                buttonHandler()
            }) {
                Image(systemName: buttonImageName)
            }
            .rotationEffect(.degrees(buttonRotation))
            .accentColor(.primary)
            .buttonStyle(PlainButtonStyle())
        }
        .padding()
    }
}

struct Divider: View {
    
    var body: some View {
        Rectangle()
            .fill(Color.primary)
            .edgesIgnoringSafeArea(.horizontal)
    }
    
}

struct ExpandableRowView<ExpandedContent: View>: View {
    
    @State var isExpanded: Bool = false
    var title: String
    var expandedContent: ExpandedContent
    var divider: Bool = true
    var buttonRotation: Double {
        isExpanded ? 90 : 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            RowViewWithButton(title: title, imageName: nil, buttonRotation: buttonRotation, buttonHandler: toggle)
                .onTapGesture(perform: toggle)
            expandedContent
                .hidden(!isExpanded)
                .padding([.leading, .bottom, .trailing])
                .frame(maxHeight: isExpanded ? .infinity : 0)
                .modifier(StandardFontModifier())
            Divider()
                .frame(height: divider ? 1 : 0)
        }

    }
    
    func toggle() {
        withAnimation {
            isExpanded.toggle()
        }
    }
    
}

struct OpacityReducingRowView: View {
    
    let title: String
    let imageName: String
    var divider: Bool = true
    var usesSystemImage: Bool = false
    var rowHandler: (() -> Void)?
    
    var shouldExecuteRowHandler: Bool {
        opacity != 1
    }
    
    @State private var opacity: Double = 1

    
    var body: some View {
        RowViewWithButton(title: title, imageName: imageName, buttonHandler: self.reduceOpacity)
            .onTapGesture {
                reduceOpacity()
            }
            .onAppear { resetOpacity() }
            .opacity(opacity)
            .onAnimationCompleted(for: opacity) {
                shouldExecuteRowHandler ? rowHandler?() : nil
            }
            Divider()
                .frame(height: divider ? 1 : 0)

    }
    
    func reduceOpacity() {
        withAnimation { opacity *= 0.5 }
    }
    
    func resetOpacity() {
        withAnimation(.easeIn(duration: 0.8)) { opacity = 1 }
    }
    
}
