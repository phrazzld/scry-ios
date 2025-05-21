import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Image(systemName: "sparkles.rectangle.stack")
                    .imageScale(.large)
                    .font(.system(size: 80))
                    .foregroundStyle(.blue)
                
                Text("Welcome to Scry")
                    .font(.largeTitle)
                    .bold()
                
                Text("iOS App")
                    .font(.title2)
                    .foregroundStyle(.secondary)
                
                Spacer().frame(height: 40)
                
                Button(action: {
                    // Using a comment instead of print for logging
                    // TODO: Add proper logging mechanism
                }) {
                    Text("Get Started")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}