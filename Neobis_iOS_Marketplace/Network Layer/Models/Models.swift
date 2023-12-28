////
////  Models.swift
////  Neobis_iOS_Marketplace
////
////  Created by iPak Tulane on 22/12/23.
////
//
//import Foundation
//
//struct Login: Codable {
//    let username: String
//    let password: String
//}
//
//struct RegistrationModel: Codable {
//    let username: String
//    let email: String?
//    let password: String
//    let password_repeat: String
//}
//
//struct FullRegister: Codable {
//    let first_name: String?
//    let last_name: String?
//    let birthday: String?
//    let phone_number: String?
//    let photo: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case first_name = "first_name"
//        case last_name = "last_name"
//        case birthday
//        case phone_number = "phone_number"
//        case photo
//    }
//}
//
//struct User: Codable {
//    let id: Int
//    let password: String
//    let lastLogin: Date?
//    let isSuperuser: Bool
//    let username: String
//    let firstName: String?
//    let isStaff: Bool
//    let isActive: Bool
//    let dateJoined: Date
//    let email: String
//    let activationCode: String?
//    let phoneNumber: String?
//    let photo: String?
//    let lastName: String?
//    let birthday: Date?
//    let fullRegistered: Bool
//    let groups: [String]
//    let userPermissions: [String]
//    
//    enum CodingKeys: String, CodingKey {
//        case id, password, lastLogin, isSuperuser, username, firstName, isStaff, isActive, dateJoined, email
//        case activationCode = "activation_code"
//        case phoneNumber = "phone_number"
//        case photo, lastName, birthday, fullRegistered, groups, userPermissions
//    }
//}
//
//struct TokenResponse: Codable {
//    let access: String
//    let refresh: String
//}
//
//struct Product: Codable {
//    let images: [Data]
//    let title: String
//    let price: String
//    let shortDescription: String?
//    let fullDescription: String?
//    
//}
//
//struct GetProduct: Codable {
//    let id: Int
//    let user: String
//    let images: [String]
//    let title: String
//    let price: String
//    let likes: Int
//    let isFan: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case id, user, images, title, price, likes, isFan
//    }
//}
