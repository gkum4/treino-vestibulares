import Foundation

class Vestibulares {
    private init() {}
    
    static let shared = Vestibulares()
    
    let vestibulares: [Vestibular] = [
        vestibular2022,
        vestibular2021
    ]
}
