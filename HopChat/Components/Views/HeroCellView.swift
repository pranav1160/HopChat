//
//  HeroCellView.swift
//  ChatterFly
//
//  Created by Pranav on 25/10/25.
//

import SwiftUI

struct HeroCellView: View {
    var title:String? = "Alpha"
    var subTitle:String? = "An alien is smiling in park and looking at you"
    var imageName:String? = Constants.randomImage
    var body: some View {
        ZStack{
            if let imageName{
                ImageLoaderView(url: imageName)
            } else{
                Rectangle()
                    .fill(.accent)
            }
        }
        .overlay(
            alignment: .bottomLeading,
            content: {
                VStack(alignment:.leading){
                    if let title{
                        Text(title)
                            .font(.headline)
                    }
                    
                    if let subTitle{
                        Text(subTitle)
                            .font(.subheadline)
                    }
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                .foregroundStyle(.white)
                .padding(8)
                .background {
                    textBackGroundGradient()
            }
        })
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .contentShape(Rectangle())
    }
}


#Preview {
    ScrollView{
        VStack{
            HeroCellView()
                .frame(width: 300,height: 200)
            
            
            HeroCellView(imageName: nil)
                .frame(width: 300,height: 200)
            
            HeroCellView()
                .frame(width: 300,height: 400)
            
            HeroCellView()
                .frame(width: 200,height: 200)
            
            HeroCellView(title: nil)
                .frame(width: 300,height: 200)
            
            HeroCellView(subTitle: nil)
                .frame(width: 300,height: 200)
    
        }
        .frame(maxWidth: .infinity)
    }
}
