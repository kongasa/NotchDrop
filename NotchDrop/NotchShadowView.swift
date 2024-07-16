//
//  NotchShadowView.swift
//  NotchDrop
//
//  Created by Kongasa on 2024/7/16.
//

import SwiftUI

struct NotchShadowView: View {
    @StateObject var vm: NotchViewModel
    
    var notchSize: CGSize {
        var ans = CGSize(
            width: vm.deviceNotchRect.width,
            height: vm.deviceNotchRect.height
        )
        if ans.width < 0 { ans.width = 0 }
        if ans.height < 0 { ans.height = 0 }
        return ans
    }
    let notchCornerRadius: CGFloat = 8

    var body: some View {
        Rectangle()
            .foregroundStyle(.black)
            .mask(notchBackgroundMaskGroup)
            .frame(
                width: notchSize.width + notchCornerRadius * 2,
                height: notchSize.height
            )
            .shadow(
                color: .white,
                radius: 16
            )
    }
    
    var notchBackgroundMaskGroup: some View {
        Rectangle()
            .foregroundStyle(.black)
            .frame(
                width: notchSize.width,
                height: notchSize.height
            )
            .clipShape(.rect(
                bottomLeadingRadius: notchCornerRadius,
                bottomTrailingRadius: notchCornerRadius
            ))
            .overlay {
                ZStack(alignment: .topTrailing) {
                    Rectangle()
                        .frame(width: notchCornerRadius, height: notchCornerRadius)
                        .foregroundStyle(.black)
                    Rectangle()
                        .clipShape(.rect(topTrailingRadius: notchCornerRadius))
                        .foregroundStyle(.white)
                        .frame(
                            width: notchCornerRadius + vm.spacing,
                            height: notchCornerRadius + vm.spacing
                        )
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .offset(x: -notchCornerRadius - vm.spacing + 0.5, y: -0.5)
            }
            .overlay {
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .frame(width: notchCornerRadius, height: notchCornerRadius)
                        .foregroundStyle(.black)
                    Rectangle()
                        .clipShape(.rect(topLeadingRadius: notchCornerRadius))
                        .foregroundStyle(.white)
                        .frame(
                            width: notchCornerRadius + vm.spacing,
                            height: notchCornerRadius + vm.spacing
                        )
                        .blendMode(.destinationOut)
                }
                .compositingGroup()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .offset(x: notchCornerRadius + vm.spacing - 0.5, y: -0.5)
            }
    }
}
