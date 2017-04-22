//
//  SessionViewModel.swift
//  WWDC
//
//  Created by Guilherme Rambo on 22/04/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

import Foundation
import ConfCore

struct SessionViewModel {
    
    let identifier: String
    let title: String
    let subtitle: String
    let context: String
    let imageUrl: URL?
    let color: NSColor
    
}

extension SessionViewModel {
    
    init?(session: Session) {
        guard let event = session.event.first else { return nil }
        guard let track = session.track.first else { return nil }
        
        let year = Calendar.current.component(.year, from: event.startDate)
        
        let imageAsset = session.assets.filter({ $0.assetType == SessionAssetType.image.rawValue }).first
        
        if let thumbnail = imageAsset?.remoteURL, let thumbnailUrl = URL(string: thumbnail) {
            self.imageUrl = thumbnailUrl
        } else {
            self.imageUrl = nil
        }
        
        let focuses: String
        
        if session.focuses.count == 4 {
            focuses = "All Platforms"
        } else {
            focuses = session.focuses.reduce("", { $0 + ", " + $1.name })
        }
        
        self.identifier = session.identifier
        self.title = session.title
        self.subtitle = "WWDC \(year) - Session \(session.number)"
        self.context = "\(focuses) - \(track.name)"
        self.color = .red
    }
    
}
