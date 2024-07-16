//
//  NotchHeaderView.swift
//  NotchDrop
//
//  Created by 秋星桥 on 2024/7/7.
//

import ColorfulX
import SwiftUI

struct NotchHeaderView: View {
    @StateObject var vm: NotchViewModel
    @StateObject var tvm = TrayDrop.shared

    var body: some View {
        HStack {
            ColorButton(
                color: [.red],
                image: Image(systemName: "trash")
            )
            .onTapGesture {
                tvm.removeAll()
                vm.notchClose()
            }
            Spacer()
            ColorButton(
                color: [.red],
                image: Image(systemName: "xmark")
            )
            .onTapGesture {
                vm.notchClose()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NSApp.terminate(nil)
                }
            }
        }
        .font(.system(.headline, design: .rounded))
    }
}

private struct ColorButton: View {
    let color: [Color]
    let image: Image

    @State var hover: Bool = false

    var body: some View {
        Color.white
            .frame(width: 30,height: 20)
            .opacity(hover ? 0.5 : 0.1)
            .overlay(
                ColorfulView(
                    color: .constant(color),
                    speed: .constant(0)
                )
                .mask {image}
                .contentShape(Rectangle())
                .animation(.spring, value: hover)
                .onHover { hover = $0 }
            )
            .aspectRatio(1, contentMode: .fit)
            .contentShape(Rectangle())
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    NotchHeaderView(vm: .init())
}
