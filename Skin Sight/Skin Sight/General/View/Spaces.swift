//
//  Spaces.swift
//  Skin Sight
//
//  Created by Marie Harmsen on 19/09/2021.
//

import UIKit

public enum Spaces {
    case big
    case medium
    case small
    case tiny
    
    public var size: CGFloat {
        switch self {
            case .big:
                return CGFloat(24.0)
            case .medium:
                return CGFloat(16.0)
            case .small:
                return CGFloat(12.0)
            case .tiny:
                return CGFloat(8.0)
        }
    }
}
