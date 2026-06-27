//
//  KeychainStoreLive.swift
//  PhantomKeychain
//
//  Created by Niki Khomitsevych on 6/26/26.
//

import Foundation
import KeychainSwift

public struct KeychainStoreLive: KeychainStore {
    public func set<Value>(
        _ value: Value,
        forKey key: KeychainKey<Value>
    ) -> Bool where Value : KeychainStorable, Value : Sendable {
        keychain.set(value.keychainData, forKey: key.name, withAccess: access)
    }
    
    public func get<Value>(
        forKey key: KeychainKey<Value>
    ) -> Value? where Value : KeychainStorable, Value : Sendable {
        guard let data = keychain.getData(key.name) else { return nil }
        return .init(keychainData: data)
    }
    
    public func remove<Value>(
        by key: KeychainKey<Value>
    ) -> Bool where Value : Sendable {
        keychain.delete(key.name)
    }
    
    public func clear() -> Bool {
        keychain.clear()
    }
    
    private let keyPrefix: String
    public init(keyPrefix: String = "com.hamsternik.phantom-keychain.") {
        self.keyPrefix = keyPrefix
    }
    
    /// Fresh instance per call, as KeychainSwift has mutable state (lastResultCode);
    /// so no sharing the state keeps this a clean Sendable value type.
    private var keychain: KeychainSwift { KeychainSwift(keyPrefix: keyPrefix) }
    
    /// Device-local secret: readable after first unlock, never synced or restored elsewhere.
    private var access: KeychainSwiftAccessOptions { .accessibleAfterFirstUnlockThisDeviceOnly }
}
