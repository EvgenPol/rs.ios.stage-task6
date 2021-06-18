import Foundation

protocol DeckBaseCompatible: Codable {
    var cards: [Card] {get set}
    var type: DeckType {get}
    var total: Int {get}
    var trump: Suit? {get}
}

enum DeckType:Int, CaseIterable, Codable {
    case deck36 = 36
}

struct Deck: DeckBaseCompatible {

    //MARK: - Properties

    var cards = [Card]()
    var type: DeckType
    var trump: Suit?

    var total:Int {
        return type.rawValue
    }
}

extension Deck {

    init(with type: DeckType) {
        self.type = type
       cards = createDeck(suits: Suit.allCases, values: Value.allCases)
    }

    public func createDeck(suits:[Suit], values:[Value]) -> [Card] {
        var deck = [Card]()
        //func for creating cards of the same suit
        func createCards (suit:Suit) -> [Card] {
            var cards = [Card]()
            for value in values {
                cards += [Card(suit: suit, value: value)]
            }
            return cards
        }
        //Creating a deck
        for suit in suits {
            switch suit {
            case .clubs: deck += createCards(suit: .clubs)
            case .spades: deck += createCards(suit: .spades)
            case .hearts: deck += createCards(suit: .hearts)
            case .diamonds: deck += createCards(suit: .diamonds)
            }
        }
        return deck
       
    }
    public mutating func shuffle() {
        cards.shuffle()
    }

    public mutating func defineTrump() {
        guard !cards.isEmpty else { return }
        trump = cards.last?.suit
        setTrumpCards(for: trump!)
        cards.insert(cards.removeLast(), at: 0)
    }

    public mutating func initialCardsDealForPlayers(players: [Player]) {
        for player in players {
            player.hand = Array(cards.dropFirst(cards.count - 6))
            cards.removeLast(6)
        }
    }

    public mutating func setTrumpCards(for suit:Suit) {
        for i in cards.indices {
            if cards[i].suit == suit { cards[i].isTrump = true }
        }
    }
}

