//
//  main.swift
//  Lesson4_hw
//
//  Created by Владимир on 15.04.2021.
//

import Foundation

enum EngineActivityStatus: String {
    case running = "Двигатель запущен"
    case notRunning = "Двигатель не запущен"
}

enum WindowPosition: String {
    case opened = "Окна открыты"
    case closed = "Окна закрыты"
}

enum TurboModeStatus: String {
    case active = "Турбо режим включен"
    case disactive = "Турбо режим выключен"
}

enum RetractableRearWing: String {
    case advanced = "Спойлер выдвинут"
    case closed = "Спойлер спрятан"
}

enum NitrousOxideLevel: String {
    case fullBallon = "Полный баллон закиси азота"
    case emptyBalloon = "Пустой баллон закиси азота"
}

enum PositionTrailer: String {
    case connected = "Прицеп соединен"
    case disconnected = "Прицеп разъединен"
}

enum FullnessOfTheCargoCompartment: String {
    case emptyCargoCompartment = "Грузовой отсек пуст"
    case filledInAt25Per = "Заполнен на 25%"
    case filledInAt50Per = "Заполнен на 50%"
    case filledInAt75Per = "Заполнен на 75%"
    case filledInAt100Per = "Заполнен полностью"
}

//--------------------- main class Car

class Car {
    let carBrand: String
    let yearOfRelease: String
    let upperHatch: Bool
    var engineActivityStatus: EngineActivityStatus
    var windowPosition: WindowPosition
    var color: String
    
    
    
    init(carBrand: String, yearOfRelease: String, upperHatch: Bool, engineActivityStatus: EngineActivityStatus, windowPosition: WindowPosition, color: String) {
        self.carBrand = carBrand
        self.yearOfRelease = yearOfRelease
        self.upperHatch = upperHatch
        self.engineActivityStatus = engineActivityStatus
        self.windowPosition = windowPosition
        self.color = color
    }
    
    init(upperHatch: Bool, windowPosition: WindowPosition, color: String) {
        self.carBrand = "Ford"
        self.yearOfRelease = "2010"
        self.upperHatch = upperHatch
        self.engineActivityStatus = .notRunning
        self.windowPosition = windowPosition
        self.color = color
    }
    
    func changeEngineActivityStatus(_ action: EngineActivityStatus) {
        engineActivityStatus = action
    }
    
    func changeWindowPosition(_ action: WindowPosition) {
        windowPosition = action
    }
    
    func printCar() {
        
        print("Марка авто - \(self.carBrand)")
        print("Год выпуска - \(self.yearOfRelease)")
        print("Наличие люка - \(self.upperHatch ? "есть" : "нет")")
        print("Состояния двигателя - \(self.engineActivityStatus.rawValue)")
        print("Состояние окон - \(self.windowPosition.rawValue)")
        print("Цвет - \(self.color)")
        
    }
}

var myCarOne = Car(upperHatch: false, windowPosition: .closed, color: "grey")

//--- открыть окно
myCarOne.changeWindowPosition(.opened)

myCarOne.printCar()

var myCarTwo = Car(carBrand: "Mazda", yearOfRelease: "2012", upperHatch: false, engineActivityStatus: .notRunning, windowPosition: .opened, color: "green")

//--- запуск двигателя
myCarTwo.changeEngineActivityStatus(.running)

myCarTwo.printCar()

//----------------------- subclass SportCar

class SportCar: Car {
    
    var retractableRearWing: RetractableRearWing
    private var turboModeStatus: TurboModeStatus = .disactive
    var nitrousOxideLevel: NitrousOxideLevel{
        
        willSet {
            if newValue == .emptyBalloon {
                turboModeStatus = .disactive
            }
        }
    }
    override var engineActivityStatus: EngineActivityStatus
    {
        willSet {
            if newValue == .notRunning {
                turboModeStatus = .disactive
            }
        }
    }
    
    init(carBrand: String, yearOfRelease: String, upperHatch: Bool, engineActivityStatus: EngineActivityStatus, windowPosition: WindowPosition, color: String, retractableRearWing: RetractableRearWing, nitrousOxideLevel: NitrousOxideLevel){
        
        self.retractableRearWing = retractableRearWing
        self.nitrousOxideLevel = nitrousOxideLevel
        
        
        super.init(carBrand: carBrand, yearOfRelease: yearOfRelease, upperHatch: upperHatch, engineActivityStatus: engineActivityStatus, windowPosition: windowPosition, color: color)
    }
    
    func changeTurboModeStatus(_ action: TurboModeStatus) {
        
        guard engineActivityStatus == .running && nitrousOxideLevel == .fullBallon else {
            return
        }
        turboModeStatus = action
        
    }
    
    func changeRetractableRearWing(_ action: RetractableRearWing) {
        retractableRearWing = action
    }
    
    override func changeEngineActivityStatus(_ action: EngineActivityStatus) {
        super.changeEngineActivityStatus(action)
        
        switch action {
        case .running:
            print("Подача сигнала ремня безопасности")
        case .notRunning:
            print("Разблокировка дверей")
        }
    }
    
    override func printCar() {
        
        super.printCar()
        
        print("Состояние спойлера - \(self.retractableRearWing.rawValue)")
        print("Уровень закиси азота - \(self.nitrousOxideLevel.rawValue)")
        print("Статус Турбо-режима - \(self.turboModeStatus.rawValue)")
        
    }
}

var mySportCarOne = SportCar(carBrand: "Ferrari", yearOfRelease: "2018", upperHatch: true, engineActivityStatus: .notRunning, windowPosition: .closed, color: "red", retractableRearWing: .closed, nitrousOxideLevel: .fullBallon)

//--- запуск двигателя
mySportCarOne.changeEngineActivityStatus(.running)

//--- включение Турбо-режима
mySportCarOne.changeTurboModeStatus(.active)

//--- завершение работы двигателя
mySportCarOne.changeEngineActivityStatus(.notRunning)
//--- Турбо-режим отключился автоматически

mySportCarOne.printCar()

var mySportCarTwo = SportCar(carBrand: "Aston Martin", yearOfRelease: "2007", upperHatch: true, engineActivityStatus: .notRunning, windowPosition: .closed, color: "grey", retractableRearWing: .closed, nitrousOxideLevel: .fullBallon)

//--- выдвигаем спойлер
mySportCarTwo.changeRetractableRearWing(.advanced)

mySportCarTwo.printCar()

//------------------subclass TrunkCar

class TrunkCar: Car {
    
    let cargoCompartmentVolume: Double
    var fullnessOfTheCargoCompartment: FullnessOfTheCargoCompartment
    var positionTrailer: PositionTrailer
    
    //--- под каждый груз своя максимальная скорость
    
    private var maxSpeed: Int {
        switch fullnessOfTheCargoCompartment {
        case .emptyCargoCompartment:
            return 140
        case .filledInAt25Per:
            return 130
        case .filledInAt50Per:
            return 100
        case .filledInAt75Per:
            return 80
        case .filledInAt100Per:
            return 60
            
        }
    }
    
    init(carBrand: String, yearOfRelease: String, upperHatch: Bool, engineActivityStatus: EngineActivityStatus, windowPosition: WindowPosition, color: String, cargoCompartmentVolume: Double, fullnessOfTheCargoCompartment: FullnessOfTheCargoCompartment, positionTrailer: PositionTrailer) {
        
        self.cargoCompartmentVolume = cargoCompartmentVolume
        self.fullnessOfTheCargoCompartment = fullnessOfTheCargoCompartment
        self.positionTrailer = positionTrailer
        
        super.init(carBrand: carBrand, yearOfRelease: yearOfRelease, upperHatch: upperHatch, engineActivityStatus: engineActivityStatus, windowPosition: windowPosition, color: color)
        
    }
    
    func changeFullnessOfTheCargoCompartment(_ action: FullnessOfTheCargoCompartment) {
        
        fullnessOfTheCargoCompartment = action
    }
    
    func changePositionTrailer(_ action: PositionTrailer) {
        
        positionTrailer = action
        
    }
    
    override func changeEngineActivityStatus(_ action: EngineActivityStatus) {
        super.changeEngineActivityStatus(action)
        
        switch action {
        case .running:
            print("Автоматическое включение кондиционера")
        case .notRunning:
            print("Автоматическое отключение радиостанции")
        }
    }
    
    override func printCar() {
        
        super.printCar()
        
        print("Объем грузового отсека - \(self.cargoCompartmentVolume)")
        print("Уровень заполнения грузового отсека - \(self.fullnessOfTheCargoCompartment.rawValue)")
        print("Состояние прицепа - \(self.positionTrailer.rawValue)")
        print("Максимальная скорость - \(self.maxSpeed)")
        
        
    }
}

var myTrunkCarOne = TrunkCar(carBrand: "Ford", yearOfRelease: "2015", upperHatch: true, engineActivityStatus: .notRunning, windowPosition: .closed, color: "green", cargoCompartmentVolume: 80_000, fullnessOfTheCargoCompartment: .emptyCargoCompartment, positionTrailer: .disconnected)



//--- загрузка и разгрузка грузового отсека

myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt25Per)
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt50Per)
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt75Per)
myTrunkCarOne.changeFullnessOfTheCargoCompartment(.filledInAt25Per)

myTrunkCarOne.printCar()

var myTrunkCarTwo = TrunkCar(carBrand: "Hyundai", yearOfRelease: "2007", upperHatch: true, engineActivityStatus: .notRunning, windowPosition: .closed, color: "grey", cargoCompartmentVolume: 70_000, fullnessOfTheCargoCompartment: .filledInAt25Per, positionTrailer: .disconnected)

//--- соединение с прицепом
myTrunkCarTwo.changePositionTrailer(.connected)

//--- запуск двигателя
myTrunkCarOne.changeEngineActivityStatus(.running)

myTrunkCarTwo.printCar()
