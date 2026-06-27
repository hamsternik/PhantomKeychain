//
//  KeychainStorable.swift
//  PhantomKeychain
//
//  Created by Niki Khomitsevych on 6/26/26.
//

import Foundation

/// A type that could be stored in the Keychain by round-tripping through `Data` type.
public protocol KeychainStorable {
    var keychainData: Data { get }
    init?(keychainData: Data)
}

// MARK: - Swift Type Extensions

extension Data: KeychainStorable {
    public var keychainData: Data { self }
    public init?(keychainData: Data) {
        self = keychainData
    }
}

extension String: KeychainStorable {
    public var keychainData: Data { Data(self.utf8) }
    
    public init?(keychainData: Data) {
        guard let string = String(data: keychainData, encoding: .utf8) else { return nil }
        self = string
    }
}

extension Bool: KeychainStorable {
    public var keychainData: Data {
        Data([self ? 1 : 0])
    }
    public init?(keychainData: Data) {
        self = (keychainData.first ?? 0) != 0
    }
}
