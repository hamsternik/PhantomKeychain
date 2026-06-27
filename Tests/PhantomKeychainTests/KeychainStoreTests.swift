//
//  KeychainStoreTests.swift
//  PhantomKeychain
//
//  Created by Niki Khomitsevych on 6/26/26.
//

import Foundation
import Testing
import PhantomKeychain

@Suite struct KeychainStoreInMemoryTests {
    @Test func givenNewKeyWhenSetThenReturnsTrue() throws {
        let store = KeychainStoreInMemory()
        let key = KeychainKey<String>(name: "token")
        #expect(store.set("abc", forKey: key))
    }
    
    @Test func givenStringWhenRoundTrippedThenReturnSameValue() throws {
        let store = KeychainStoreInMemory()
        let key = KeychainKey<String>(name: "token")
        store.set("abc", forKey: key)
        #expect(store.get(forKey: key) == "abc")
    }
    
    @Test func givenBoolFalseWhenRoundTrippedThenStayFalse() throws {
        let store = KeychainStoreInMemory()
        let key = KeychainKey<Bool>(name: "boolflag")
        store.set(false, forKey: key)
        #expect(store.get(forKey: key) == false)
    }
    
    @Test func givenDataWhenRoundTrippedThenReturnsSameData() throws {
        let store = KeychainStoreInMemory()
        let key = KeychainKey<Data>(name: "boolflag")
        let payload = Data([0xDE, 0xAD, 0xFF])
        store.set(payload, forKey: key)
        #expect(store.get(forKey: key) == payload)
    }
    
    @Test func givenMissingKeyThenReturnNil() throws {
        let store = KeychainStoreInMemory()
        #expect(store.get(forKey: KeychainKey<String>(name: "missing")) == nil)
    }
    
    @Test func givenSetStringValueWhenRemovedThenGetReturnsNil() throws {
        let store = KeychainStoreInMemory()
        let key = KeychainKey<String>(name: "token")
        store.set("abc", forKey: key)
        #expect(store.remove(by: key) == true)
        #expect(store.get(forKey: key) == nil)
    }
    
    @Test func givenStoredValuesWhenClearedThenAllReturnsNil() throws {
        let store = KeychainStoreInMemory()
        let aKey = KeychainKey<String>(name: "a")
        let bKey = KeychainKey<String>(name: "b")
        store.set("1", forKey: aKey)
        store.set("2", forKey: bKey)
        #expect(store.clear() == true)
        #expect(store.get(forKey: aKey) == nil)
        #expect(store.get(forKey: bKey) == nil)
    }
}
