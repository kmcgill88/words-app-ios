//
//  WordsTests.swift
//  WordsTests
//
//  Created by Kevin McGill on 6/11/17.
//  Copyright © 2017 McGill DevTech, LLC. All rights reserved.
//

import Quick
import Nimble

@testable import Words


class WordsTests: QuickSpec {
    
    override func spec() {
        
        describe("String Extension") {
//            it("Splits on underscore") {
//                
//                let words = "Happy_Cat".split()
//                
//                expect(words.count) == 2
//                expect(words[0]) == "Happy"
//                expect(words[1]) == "Cat"
//            }
            
            it("Splits on underscore") {
                
                let (adjective, noun) = "Happy_Cat".split()

                expect(adjective) == "Happy"
                expect(noun) == "Cat"
            }
        }
        
        
    
        describe("Computed Property", closure: {
            it("converts all things to upper"){
                let phrase = Phrase(adjective: "Stellar", noun: "Grimes")
                
                expect(phrase.pretty) == "STELLAR GRIMES"
            }
        })
        
        
        
        
        describe("Functional", closure: {
            
            let phrase0 = Phrase(adjective: "Hot", noun: "Dog")
            let phrase1 = Phrase(adjective: "Great", noun: "Country")
            let phrase2 = Phrase(adjective: "Georgous", noun: "Grimes")
            let phrase3 = Phrase(adjective: "Lazy", noun: "Susan")
            
            
            it("filters with by first letter of both words"){

                let phrases = [phrase0, phrase1, phrase2, phrase3].filter(Phrase.byMatchingFirstLetter)
                
                expect(phrases.count) == 2
            }
            
            it("filters with by first letter of both words AND last letter"){

                let phrases = [phrase0, phrase1, phrase2, phrase3]
                    .filter(Phrase.byMatchingFirstLetter)
                    .filter(Phrase.byMatchingLastLetter)
                
                expect(phrases.count) == 1
            }
            
            it("filters with by first letter of both words AND last letter, then adds stars"){

                let phrases = [phrase0, phrase1, phrase2, phrase3]
                    .filter(Phrase.byMatchingFirstLetter)
                    .filter(Phrase.byMatchingLastLetter)
                    .map(Phrase.addStars)
                
                expect(phrases.count) == 1
                let phrase = phrases.first!
                
                expect(phrase.adjective) == "*Georgous*"
                expect(phrase.noun) == "*Grimes*"
            }
            
            it("filters by Higher Order Function"){
                
                let phrases = [phrase0, phrase1, phrase2, phrase3].filter(Phrase.by(adjective: "hot"))

                expect(phrases.count) == 1
                let phrase = phrases.first!
                
                expect(phrase.adjective) == "Hot"
                expect(phrase.noun) == "Dog"
            }
        })
    }
}
