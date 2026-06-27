//
//  KeychainStore.swift
//  PhantomKeychain
//
//  Created by Niki Khomitsevych on 6/25/26.
//

import Foundation

public struct KeychainKey<Value: Sendable>: Sendable {
    public let name: String
    public init(name: String) {
        self.name = name
    }
}

/// A keyed secret store backed by the Keychain.
/// set/get/remove values that round-trip through `Data` type.
public protocol KeychainStore: Sendable {
    @discardableResult func set<Value: KeychainStorable>(_ value: Value, forKey key: KeychainKey<Value>) -> Bool
    func get<Value: KeychainStorable>(forKey key: KeychainKey<Value>) -> Value?
    @discardableResult func remove<Value>(by key: KeychainKey<Value>) -> Bool
    @discardableResult func clear() -> Bool
}
