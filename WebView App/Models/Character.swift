// Корневая структура
struct CharacterResponse: Codable {
    let results: [Character]
}

// Модель персонажа
struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    let origin: Origin
    let location: Location
}

struct Origin: Codable {
    let name: String
    let url: String
}

struct Location: Codable {
    let name: String
    let url: String
}
