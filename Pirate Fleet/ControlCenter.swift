//
//  ControlCenter.swift
//  Pirate Fleet
//
//  Created by Jarrod Parkes on 9/2/15.
//  Copyright © 2015 Udacity. All rights reserved.
//

struct GridLocation {
    let x: Int
    let y: Int
}

struct Ship {
    let length: Int
    let location: GridLocation
    let isVertical: Bool
    let isWooden: Bool
    

// TODO: Add the computed property, cells.
    var cells: [GridLocation] {
        get {
            // Hint: These two constants will come in handy
            
            // We have start and end location of ship and we need to find all middle values to complete the cell's array.
            let start = self.location
            let end: GridLocation = ShipEndLocation(self)
            
            
            // Hint: The cells getter should return an array of GridLocations.
            
            // initializing an empty array
            var occupiedCells = [GridLocation]()
            
            // add start location in array
            occupiedCells.append(start)
            
            // create constnat for x and y differences of start and end location to determine if ship is in horizontal direction or vertical.
            let xDifference = end.x - start.x
            let yDifference = end.y - start.y
            
            // x-difference == 0 means both x has same values, so ship is in vertical dirrection.
            if xDifference == 0 {
                
                // create all the middle values and add it to array
                for i in 0  ..< yDifference  {
                    
                    let middleLocation = GridLocation(x: start.x, y: start.y + i )
                    occupiedCells.append(middleLocation)
                }
                
                
                
            }else
                // y-difference == 0 means both y has same values, so ship is in horizontal dirrection.
                if yDifference == 0 {
                
                    // create all the middle values and add it to array
                for i in 0  ..< xDifference  {
                    
                    let middleLocation = GridLocation(x: start.x + i, y: start.y )
                    occupiedCells.append(middleLocation)
                }

            }
            // append end location
            occupiedCells.append(end)
            return occupiedCells
        }
    }
    
    var hitTracker: HitTracker
// TODO: Add a getter for sunk. Calculate the value returned using hitTracker.cellsHit.
    var sunk: Bool {
        
        for location in cells {
           
            if let sinkValue = hitTracker.cellsHit[location] {
                
                if !sinkValue {
                    
                    return false
                }
                
            }
            
        }
        return true
    }

// TODO: Add custom initializers
    
    init(length: Int) {
        self.length = length
        self.hitTracker = HitTracker()
        
        // location,isVertical & isWooden parameters are not included in the function definition, but a constructor is required to initialize all the variable. 
        // initializing these three variables with these values.
        self.location=GridLocation(x: 0, y: 0)
        self.isVertical=false;
        self.isWooden=false
    }

    // Second initializer method
    init(length: Int,location: GridLocation,isVertical:Bool) {
        self.length = length
        self.hitTracker = HitTracker()
        self.location=location
        self.isVertical=isVertical;
        
        // isWooden parameter is not included in the function definition, but a constructor is required to initialize all the variable.
        // initializing this variable.
        self.isWooden=false
    }
    // third initialzer
    // This has values for all variables in its parameter list
    init(length: Int,location: GridLocation,isVertical:Bool,isWooden:Bool) {
        self.length = length
        self.hitTracker = HitTracker()
        self.location=location
        self.isVertical=isVertical
        self.isWooden=isWooden
    }
}

// TODO: Change Cell protocol to PenaltyCell and add the desired properties
protocol PenaltyCell {
    var location: GridLocation {get}
    var guaranteesHit : Bool {get}
    var penaltyText : String {get}
    
}

// TODO: Adopt and implement the PenaltyCell protocol
struct Mine: PenaltyCell {
    let location: GridLocation
    
    // Adding two more variables as they are necessory for confirming Penaltycell protocol
    let guaranteesHit: Bool
    let penaltyText: String
    
    init(location: GridLocation,penaltyText: String){
        
        self.location = location
        self.penaltyText = penaltyText
        self.guaranteesHit = false
    }
    
    init(location: GridLocation,penaltyText: String, guaranteesHit : Bool){
        
        self.location = location
        self.penaltyText = penaltyText
        self.guaranteesHit = guaranteesHit
    }
}

// TODO: Adopt and implement the PenaltyCell protocol
struct SeaMonster: PenaltyCell {
    let location: GridLocation
    
    // Adding two more variables as they are necessory for confirming Penaltycell protocol
    let guaranteesHit: Bool
    let penaltyText: String
}

class ControlCenter {
    
    func placeItemsOnGrid(human: Human) {
        
        
        // removing hitTracker parameter from initializer because its default value is in the init method itself
        
        let smallShip = Ship(length: 2, location: GridLocation(x: 3, y: 4), isVertical: true, isWooden: true)
        
        // printing array of locations to test getter method in exercise one
        
        print(smallShip.cells)
        human.addShipToGrid(smallShip)
        
        let mediumShip1 = Ship(length: 3, location: GridLocation(x: 0, y: 0), isVertical: false, isWooden: true)
        
        print(mediumShip1.cells)
        
        human.addShipToGrid(mediumShip1)
        
        let mediumShip2 = Ship(length: 3, location: GridLocation(x: 3, y: 1), isVertical: false, isWooden: true)
        human.addShipToGrid(mediumShip2)
        
        let largeShip = Ship(length: 4, location: GridLocation(x: 6, y: 3), isVertical: true, isWooden: true)
        human.addShipToGrid(largeShip)
        
        let xLargeShip = Ship(length: 5, location: GridLocation(x: 7, y: 2), isVertical: true, isWooden: true)
        human.addShipToGrid(xLargeShip)
        
        let mine1 = Mine(location: GridLocation(x: 6, y: 0) , penaltyText: "Mine 1 hits", guaranteesHit: true)
        human.addMineToGrid(mine1)
        
        let mine2 = Mine(location: GridLocation(x: 3, y: 3) ,penaltyText: "Mine 2 hits")
        human.addMineToGrid(mine2)
        
        // add two more parameters in function defination after confirming PenaltyCell protocol
        let seamonster1 = SeaMonster(location: GridLocation(x: 5, y: 6), guaranteesHit: true ,penaltyText: "Sea monster has been awaken!!!")
        human.addSeamonsterToGrid(seamonster1)
        
        let seamonster2 = SeaMonster(location: GridLocation(x: 2, y: 2), guaranteesHit: true ,penaltyText: "Sea monster two has been awaken")
        human.addSeamonsterToGrid(seamonster2)
    }
    
    func calculateFinalScore(gameStats: GameStats) -> Int {
        
        var finalScore: Int
        
        let sinkBonus = (5 - gameStats.enemyShipsRemaining) * gameStats.sinkBonus
        let shipBonus = (5 - gameStats.humanShipsSunk) * gameStats.shipBonus
        let guessPenalty = (gameStats.numberOfHitsOnEnemy + gameStats.numberOfMissesByHuman) * gameStats.guessPenalty
        
        finalScore = sinkBonus + shipBonus - guessPenalty
        
        return finalScore
    }
}