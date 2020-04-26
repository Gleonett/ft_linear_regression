//
//  ContentView.swift
//  ft_linear_regression
//
//  Created by Student21 on 26.04.2020.
//  Copyright © 2020 Student21. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button(action: {
                let data = DataCSV().read_csv()
                print(data)
            }) {
                HStack {
                    Image(systemName: "play")
                        .font(.title)
                    Text("Train")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(15)
            }
            Button(action: {
                print("Run")
            }) {
                HStack {
                    Image(systemName: "play")
                        .font(.title)
                    Text(" Run ")
                        .fontWeight(.semibold)
                        .font(.title)
                }
                .padding()
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.orange]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(15)
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
