//
//  ContentView.swift
//  WanderingShadows
//
//  Created by Thomas Schatton on 25.06.22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject var motions = Motions()
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Rotate the device in any direction!")
                .font(.title2.bold())
                .shadow(color: .gray, radius: 1, x: motions.x, y: motions.y)
            
            ZStack {
                Group {
                    Image(systemName: "bubble.left.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.blue.opacity(0.8))
         

                    Image(systemName: "bubble.left")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: .black.opacity(0.6), radius: 3, x: motions.x, y: motions.y)
                }
                .frame(width: 300, height: 300, alignment: .center)

                Image(systemName: "arrow.up.and.down.and.arrow.left.and.right")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 100, alignment: .center)
                    .offset(x: 0, y: -25)
                    .shadow(color: .black.opacity(0.6), radius: 3, x: motions.x, y: motions.y)
            }
            
            Text(motions.isTimerRunning ? "Stop Timer" : "Restart Timer")
                .padding()
                .foregroundStyle(.white)
                .font(.title)
                .background(motions.isTimerRunning ? .red : .green)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .contentShape(RoundedRectangle(cornerRadius: 15))
                .onTapGesture {
                    motions.isTimerRunning ? motions.stopTimer() : motions.restartTimer()
                }
                .shadow(color: .gray, radius: 3, x: motions.x, y: motions.y)
        }
        .rotation3DEffect(.degrees(motions.xRot), axis: (x: 0, y: 1, z: 0))
        .rotation3DEffect(.degrees(motions.yRot), axis: (x: 1, y: 0, z: 0))
        .onReceive(motions.timer) { _ in
            motions.updateShadows()
        }
        .onChange(of: scenePhase) { phase in
            if phase != .active {
                motions.stopMotions()
            } else {
                motions.startMotions()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
