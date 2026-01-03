//
//  Storage.swift
//  cubie
//
//  Created by chris on '26.1.2.
//

import SwiftUI

class Storage {
    static var main: Storage = Storage()
    
    var algSets: [AlgSet] {
        get {
            return _algSets
        } set {
            _algSets = newValue
            saveAlgSets()
        }
    }
    
    var currentAlgSet: AlgSet? = nil
    
    private var _algSets: [AlgSet] = [
        AlgSet(title: "ico", header: "what?", subOptions: [
                    SubMenuOptionView(title: "U left", header: "where?", subOptions: []),
                    SubMenuOptionView(title: "D up", header: "where?", subOptions: []),
                ]),
    ]
//            SubMenuOptionView(title: "U left", header: "what?", subOptions: [
//                AlgMenuOptionView(title: "cool!", alg: Alg("R U R'")!)
//            ]),
//            SubMenuOptionView(title: "U down", header: "what?", subOptions: []),
//            SubMenuOptionView(title: "D down", header: "what?", subOptions: []),
//            SubMenuOptionView(title: "D left", header: "what?", subOptions: []),
//            SubMenuOptionView(title: "D right", header: "what?", subOptions: []),
//        ]
//    ]
    
    init() {
        refreshAlgSets()
        currentAlgSet = algSets[0]
        saveAlgSets()
    }
    
    private func saveAlgSets() {
        var algSetDict: [Any] = []
        for algSet in algSets {
            algSetDict.append(menuOptionToDict(algSet))
        }
        
        print(algSetDict)
        save(algSetDict, as: .algsets)
    }
    
    private func refreshAlgSets() {
        guard let algSetList = getList(for: .algsets) as? [[String: Any]] else { return }
        var newAlgSets: [AlgSet] = []
        for algSetDict in algSetList {
            guard let algSetData = dictToMenuOption(algSetDict) as? AlgSet else { return }
            newAlgSets.append(algSetData)
        }
        _algSets = newAlgSets
    }
    
    private func dictToMenuOption(_ dict: [String: Any]) -> (any MenuOptionView)? {
        if dict[Key.alg.rawValue] != nil {
            guard let algString = dict[Key.alg.rawValue] as? String, let alg = Alg(algString) else { return nil }
            guard let title = dict[Key.title.rawValue] as? String else { return nil }
            return AlgMenuOptionView(title: title, alg: alg)
        } else {
            guard let title = dict[Key.title.rawValue] as? String else { return nil }
            guard let header = dict[Key.header.rawValue] as? String else { return nil }
            guard let subOptionsData = dict[Key.subOptions.rawValue] as? [[String: Any]] else { return nil }
            let subOptions = subOptionsData.compactMap { dictToMenuOption($0) }
            guard subOptions.count == subOptionsData.count else { return nil }
            return SubMenuOptionView(title: title, header: header, subOptions: subOptions)
        }
    }
    
    private func menuOptionToDict(_ menuOption: any MenuOptionView) -> [String: Any] {
        if let alg = menuOption as? AlgMenuOptionView {
            return [
                Key.title.rawValue: alg.title,
                Key.alg.rawValue: alg.alg.string,
            ]
        } else {
            guard let subMenu = menuOption as? SubMenuOptionView else { return [:] }
            return [
                Key.title.rawValue: subMenu.title,
                Key.header.rawValue: subMenu.header,
                Key.subOptions.rawValue: subMenu.subOptions.map { menuOptionToDict($0) },
            ]
        }
    }
    
    private func getDictionary(for key: Key) -> [String: Any]? {
        UserDefaults.standard.dictionary(forKey: key.rawValue)
    }
    
    private func getList(for key: Key) -> [Any]? {
        UserDefaults.standard.array(forKey: key.rawValue)
    }
    
    private func save(_ data: Any, as key: Key) {
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
}

enum Key: String {
    case algsets = "algsets"
    case alg = "alg"
    case title = "title"
    case header = "header"
    case subOptions = "subOptions"
}


/*
 
 [
    [
        "title": "ico",
        "header": "what?",
        "subOptions": [
            [
                "title": "U left",
                "header": "where?",
                "subOptions": []
            ],
            [
                "subOptions": [],
                "title": "D up",
                "header": "where?"
            ]
        ]
    ]
 ]
 
 
 */
