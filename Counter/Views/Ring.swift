//
//  Ring.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import SwiftUI

struct Ring: View {
    @Binding var percent: Double
    var thickness: CGFloat = 5
    var gradientColors =  [Color.green]
    
    var body: some View {
        return drawRing()
    }
    
    private func drawRing() -> some View{
       // let formattedPercent = String(format: "%.f", CGFloat(self.percent))
        
        return ZStack(alignment: .top) {
            
            RingShape(percent: 100)
                .stroke(style: StrokeStyle(lineWidth: self.thickness))
                .fill(Color.red)
            
            RingShape(percent: self.percent)
                .stroke(style: StrokeStyle(lineWidth: self.thickness, lineCap: CGLineCap.round))
                .fill(
                    LinearGradient(
                        gradient: .init(colors: gradientColors), startPoint: .init(x: 0.2, y: 0.4), endPoint:  .init(x: 0.5, y: 1)
                    )
            )

        }
    }
}

struct Ring_Previews: PreviewProvider {
    static var previews: some View {
        Ring(percent: .constant(60))
        //max*current/100
    }
}
