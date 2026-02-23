// filepath: Components/Dashboard/GreetingSectionView.swift
import SwiftUI

public struct GreetingSectionView: View {
    public let name: String

    public init(name: String) {
        self.name = name
    }

    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning")
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(name)
                    .font(.title)
                    .fontWeight(.bold)
            }
            Spacer()
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 56, height: 56)
                .foregroundStyle(.blue)
        }
        .padding()
        .background(.regularMaterial)
        .cornerRadius(12)
    }
}
