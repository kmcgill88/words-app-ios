//
//  Word.swift
//  Words
//
//  Created by Kevin McGill on 6/11/17.
//  Copyright © 2017 McGill DevTech, LLC. All rights reserved.
//

import Foundation

open class Phrase {
    
    var adjective:String?
    var noun:String
    
    var pretty:String {
        get {
            return "\(adjective?.uppercased() ?? "") \(noun.uppercased())"
        }
    }
    
    init(adjective:String, noun:String) {
        self.noun = noun
        self.adjective = adjective
    }
    
    init(response:String) {
        let (adj, n) = response.split()
        
        self.adjective = adj
        self.noun = n
    }
    
    
    open func flippedOpen() -> String {
        
        return flippedPrivate()
    }
    
    public func flippedPublic() -> String {
        
        return flippedPrivate()
    }
    
    internal func flippedInternal() -> String {
        
        return flippedPrivate()
    }
    
    fileprivate func flippedFilePrivate() -> String {
        
        return flippedPrivate()
    }
    
    private func flippedPrivate() -> String {
        
        return "\(noun.uppercased()) \(adjective?.uppercased() ?? "")"
    }
    
}

extension Phrase {
    
    class func by(adjective:String) -> ((Phrase) -> Bool) {
        return { phrase in
            return adjective.uppercased() == phrase.adjective?.uppercased()
        }
    }
    
    class func byMatchingFirstLetter(phrase:Phrase) -> Bool {
        return phrase.adjective?.uppercased().characters.first == phrase.noun.uppercased().characters.first
    }
    
    class func byMatchingLastLetter(phrase:Phrase) -> Bool {
        return phrase.adjective?.uppercased().characters.last == phrase.noun.uppercased().characters.last
    }
    
    class func addStars(phrase:Phrase) -> Phrase {
        phrase.noun = "*\(phrase.noun)*"
        phrase.adjective = "*\(phrase.adjective ?? "N/A")*"
        return phrase
    }
}


extension String {
    
//    func split() -> [String] {
//        return self.components(separatedBy: "_")
//    }
    
    func split() -> (String,String) {
        let words = self.components(separatedBy: "_")
        return (words[0], words[1])
    }
    
}
