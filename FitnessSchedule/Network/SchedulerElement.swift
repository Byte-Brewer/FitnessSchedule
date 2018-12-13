//
//  SchedulerElement.swift
//  FitnessSchedule
//
//  Created by Nazar Prysiazhnyi on 12/11/18.
//  Copyright © 2018 Nazar Prysiazhnyi. All rights reserved.
//

import Foundation

typealias Scheduler = [SchedulerElement]

struct SchedulerElement: Codable {
    let description: String
    let weekDay: WeekDays
    let appointment: Bool
    let serviceID, color: String
    let pay: Bool
    let availability: Int
    let endTime: String
    let teacherV2: TeacherV2
    let teacher, appointmentID, startTime, name: String
    let place: Place
    
    enum CodingKeys: String, CodingKey {
        case description, weekDay, appointment
        case serviceID = "service_id"
        case color, pay, availability, endTime
        case teacherV2 = "teacher_v2"
        case teacher
        case appointmentID = "appointment_id"
        case startTime, name, place
    }
}

enum Place: String, Codable {
    case залГрупповыхПрограмм = "Зал групповых программ"
}

struct TeacherV2: Codable {
    let shortName: String
    let imageURL: String
    let name: String
    let position: Position
    
    enum CodingKeys: String, CodingKey {
        case shortName = "short_name"
        case imageURL = "imageUrl"
        case name, position
    }
}

enum Position: String, Codable {
    case инструкторГрупповыхПрограмм = "Инструктор групповых программ"
    case персональныйТренер = "Персональный тренер"
}

enum WeekDays: Int, Codable {
    case Monday = 1, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    func introduce() -> String {
        switch self {
        case .Monday: return "Понедельник"
        case .Tuesday: return "Вторник"
        case .Wednesday: return "Среда"
        case .Thursday: return "Четверг"
        case .Friday: return "Пятница"
        case .Saturday: return "Суббота"
        case .Sunday: return "Воскресенье"
        }
    }
}
