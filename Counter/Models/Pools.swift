//
//  Pools.swift
//  Counter
//
//  Created by Ilya on 22.10.20.
//

import Foundation

public struct Pools {
    static let ids = ["30194", "30195", "30190", "129", "30208", "30197", "30184", "30182", "30187", "30199"]
    private static let titles = ["30194" :  "Bad Forstenrieder Park \nHallenbad",
                                 "30195" :  "Bad Giesing-Harlaching \nHallenbad",
                                 "30190" :  "Cosimawellenbad \nHallenbad",
                                 "30208" :  "Michaelibad \nHallenbad",
                                 "30197" :  "Müller´sches Volksbad \nHallenbad",
                                 "30184" :  "Nordbad \nHallenbad & Fitness",
                                 "30182" :  "Olympia-Schwimmhalle",
                                 "30187" :  "Südbad \nHallenbad",
                                 "30199" :  "Westbad \nHallenbad",
                                 "129" :    "Dante-Winter-Warmfreibad"]
    static func getTitle(for id: String) -> String {
        return titles[id]!
    }
}
