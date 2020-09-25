//
//  FlagError.swift
//  Fun With Flags
//
//  Created by Jason Koceja on 9/23/20.
//

import Foundation

enum FlagError : LocalizedError {
    case invalidURL
    case thrownError(Error)
    case invalidData
}
