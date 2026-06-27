//
//  KeychainStoreInMemory.swift
//  PhantomKeychain
//
//  Created by Niki Khomitsevych on 6/26/26.
//

import Foundation

public final class KeychainStoreInMemory: KeychainStore, @unchecked Sendable {
    @discardableResult public func set<Value>(
        _ value: Value,
        forKey key: KeychainKey<Value>
    ) -> Bool where Value : KeychainStorable, Value : Sendable {
        lock.withLock {
            storage[key.name] = value.keychainData
            return true
        }
    }
    
    public func get<Value>(
        forKey key: KeychainKey<Value>
    ) -> Value? where Value : KeychainStorable, Value : Sendable {
        lock.withLock {
            guard let data = storage[key.name] else { return nil }
            return Value(keychainData: data)
        }
    }
    
    @discardableResult public func remove<Value>(
        by key: KeychainKey<Value>
    ) -> Bool where Value : Sendable {
        lock.withLock {
            storage.removeValue(forKey: key.name) != nil
        }
    }
    
    @discardableResult public func clear() -> Bool {
        lock.withLock {
            storage.removeAll()
            return true
        }
    }
    
    private let lock = NSLock()
    private var storage: [String: Data]
    public init(storage: [String : Data] = [:]) {
        self.storage = storage
    }
}
