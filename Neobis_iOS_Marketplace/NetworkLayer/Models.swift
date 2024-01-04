//
//  MarketplaceModels.swift
//  Neobis_iOS_Marketplace
//
//  Created by iPak Tulane on 25/12/23.
//

import Foundation

// Replace with your Swagger-generated models
struct RegistrationResponse: Codable {
    let username: String
    let email: String
    let password: String
    let passwordConfirm: String
    
    enum CodingKeys: String, CodingKey {
        case username
        case email
        case password
        case passwordConfirm = "password_confirm"
    }
}

// Replace with your Swagger-generated models
struct LoginResponse: Codable {
    let username: String
    let password: String
    let tokens: Tokens
    
    struct Tokens: Codable {
        let refresh: String
        let access: String
    }
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let marketplace = try? JSONDecoder().decode(Marketplace.self, from: jsonData)

import Foundation

// MARK: - Marketplace
struct Marketplace: Codable {
    let swagger: String
    let info: Info
    let host: String
    let schemes: [String]
    let basePath: String
    let consumes, produces: [String]
    let securityDefinitions: SecurityDefinitions
    let security: [Security]
    let paths: Paths
    let definitions: Definitions
}

// MARK: - Definitions
struct Definitions: Codable {
    let tokenObtainPair: TokenObtainPair
    let codeCheck: CodeCheck
    let codeSend: CodeSend
    let login: Login
    let logout: Logout
    let profileRegistration: ProfileRegistration
    let profile: Profile
    let registration: Registration
    let tokenRefresh: TokenRefresh
    let product: Product

    enum CodingKeys: String, CodingKey {
        case tokenObtainPair = "TokenObtainPair"
        case codeCheck = "CodeCheck"
        case codeSend = "CodeSend"
        case login = "Login"
        case logout = "Logout"
        case profileRegistration = "ProfileRegistration"
        case profile = "Profile"
        case registration = "Registration"
        case tokenRefresh = "TokenRefresh"
        case product = "Product"
    }
}

// MARK: - CodeCheck
struct CodeCheck: Codable {
    let codeCheckRequired: [String]
    let type: String
    let properties: CodeCheckProperties

    enum CodingKeys: String, CodingKey {
        case codeCheckRequired = "required"
        case type, properties
    }
}

// MARK: - CodeCheckProperties
struct CodeCheckProperties: Codable {
    let verificationCode: VerificationCode

    enum CodingKeys: String, CodingKey {
        case verificationCode = "verification_code"
    }
}

// MARK: - VerificationCode
struct VerificationCode: Codable {
    let title: String
    let type: TypeEnum
    let maxLength, minLength: Int?
    let xNullable: Bool?
    let format: String?
    let readOnly: Bool?

    enum CodingKeys: String, CodingKey {
        case title, type, maxLength, minLength
        case xNullable = "x-nullable"
        case format, readOnly
    }
}

enum TypeEnum: String, Codable {
    case integer = "integer"
    case string = "string"
}

// MARK: - CodeSend
struct CodeSend: Codable {
    let type: String
    let properties: CodeSendProperties
}

// MARK: - CodeSendProperties
struct CodeSendProperties: Codable {
    let phoneNumber: VerificationCode

    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone_number"
    }
}

// MARK: - Login
struct Login: Codable {
    let loginRequired: [String]
    let type: String
    let properties: LoginProperties

    enum CodingKeys: String, CodingKey {
        case loginRequired = "required"
        case type, properties
    }
}

// MARK: - LoginProperties
struct LoginProperties: Codable {
    let username, password, tokens: VerificationCode
}

// MARK: - Logout
struct Logout: Codable {
    let logoutRequired: [String]
    let type: String
    let properties: LogoutProperties

    enum CodingKeys: String, CodingKey {
        case logoutRequired = "required"
        case type, properties
    }
}

// MARK: - LogoutProperties
struct LogoutProperties: Codable {
    let refresh: VerificationCode
}

// MARK: - Product
struct Product: Codable {
    let productRequired: [String]
    let type: String
    let properties: ProductProperties

    enum CodingKeys: String, CodingKey {
        case productRequired = "required"
        case type, properties
    }
}

// MARK: - ProductProperties
struct ProductProperties: Codable {
    let id, name, description: VerificationCode
    let available: Available
    let photo, shortDescription, price: VerificationCode

    enum CodingKeys: String, CodingKey {
        case id, name, description, available, photo
        case shortDescription = "short_description"
        case price
    }
}

// MARK: - Available
struct Available: Codable {
    let title, type: String
}

// MARK: - Profile
struct Profile: Codable {
    let profileRequired: [String]
    let type: String
    let properties: ProfileProperties

    enum CodingKeys: String, CodingKey {
        case profileRequired = "required"
        case type, properties
    }
}

// MARK: - ProfileProperties
struct ProfileProperties: Codable {
    let avatar, username, email, firstName: VerificationCode
    let lastName, dateOfBirth, phoneNumber: VerificationCode

    enum CodingKeys: String, CodingKey {
        case avatar, username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case dateOfBirth = "date_of_birth"
        case phoneNumber = "phone_number"
    }
}

// MARK: - ProfileRegistration
struct ProfileRegistration: Codable {
    let type: String
    let properties: ProfileRegistrationProperties
}

// MARK: - ProfileRegistrationProperties
struct ProfileRegistrationProperties: Codable {
    let avatar, username, email, firstName: VerificationCode
    let lastName, dateOfBirth: VerificationCode

    enum CodingKeys: String, CodingKey {
        case avatar, username, email
        case firstName = "first_name"
        case lastName = "last_name"
        case dateOfBirth = "date_of_birth"
    }
}

// MARK: - Registration
struct Registration: Codable {
    let registrationRequired: [String]
    let type: String
    let properties: RegistrationProperties

    enum CodingKeys: String, CodingKey {
        case registrationRequired = "required"
        case type, properties
    }
}

// MARK: - RegistrationProperties
struct RegistrationProperties: Codable {
    let username, email, password, passwordConfirm: VerificationCode

    enum CodingKeys: String, CodingKey {
        case username, email, password
        case passwordConfirm = "password_confirm"
    }
}

// MARK: - TokenObtainPair
struct TokenObtainPair: Codable {
    let tokenObtainPairRequired: [String]
    let type: String
    let properties: TokenObtainPairProperties

    enum CodingKeys: String, CodingKey {
        case tokenObtainPairRequired = "required"
        case type, properties
    }
}

// MARK: - TokenObtainPairProperties
struct TokenObtainPairProperties: Codable {
    let username, password: VerificationCode
}

// MARK: - TokenRefresh
struct TokenRefresh: Codable {
    let tokenRefreshRequired: [String]
    let type: String
    let properties: TokenRefreshProperties

    enum CodingKeys: String, CodingKey {
        case tokenRefreshRequired = "required"
        case type, properties
    }
}

// MARK: - TokenRefreshProperties
struct TokenRefreshProperties: Codable {
    let refresh, access: VerificationCode
}

// MARK: - Info
struct Info: Codable {
    let title, description: String
    let termsOfService: String
    let contact: Contact
    let license: License
    let version: String
}

// MARK: - Contact
struct Contact: Codable {
    let email: String
}

// MARK: - License
struct License: Codable {
    let name: String
}

// MARK: - Paths
struct Paths: Codable {
    let authAPIToken, authCodeCheck: AuthAPITokenClass
    let authCodeSend: AuthCodeSendClass
    let authLogin, authLogout: AuthAPITokenClass
    let authProfileUpdate: AuthCodeSendClass
    let authProfileView: AuthProfileView
    let authRegister, authTokenRefresh: AuthAPITokenClass
    let productsCreateUpdateList: ProductsCreateUpdateList
    let productsCreateUpdateListID: ProductsCreateUpdateListID
    let productsLikeCountsProductID: ProductsLikeCountsProductID
    let productsLikeProductID: ProductsLikeProductID
    let productsList: ProductsList
    let productsUnlikeProductID: ProductsUnlikeProductID

    enum CodingKeys: String, CodingKey {
        case authAPIToken = "/auth/api/token/"
        case authCodeCheck = "/auth/code-check/"
        case authCodeSend = "/auth/code-send/"
        case authLogin = "/auth/login/"
        case authLogout = "/auth/logout/"
        case authProfileUpdate = "/auth/profile-update/"
        case authProfileView = "/auth/profile-view/"
        case authRegister = "/auth/register/"
        case authTokenRefresh = "/auth/token/refresh/"
        case productsCreateUpdateList = "/products/create-update-list/"
        case productsCreateUpdateListID = "/products/create-update-list/{id}/"
        case productsLikeCountsProductID = "/products/like-counts/{product_id}/"
        case productsLikeProductID = "/products/like/{product_id}/"
        case productsList = "/products/list/"
        case productsUnlikeProductID = "/products/unlike/{product_id}/"
    }
}

// MARK: - AuthAPITokenClass
struct AuthAPITokenClass: Codable {
    let post: AuthAPITokenPost
    let parameters: [JSONAny]
}

// MARK: - AuthAPITokenPost
struct AuthAPITokenPost: Codable {
    let operationID, description: String
    let parameters: [Parameter]
    let responses: PurpleResponses
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags
    }
}

// MARK: - Parameter
struct Parameter: Codable {
    let name: Name
    let parameterIn: In
    let parameterRequired: Bool
    let schema: ItemsClass?
    let type: TypeEnum?

    enum CodingKeys: String, CodingKey {
        case name
        case parameterIn = "in"
        case parameterRequired = "required"
        case schema, type
    }
}

enum Name: String, Codable {
    case data = "data"
    case id = "id"
    case productID = "product_id"
}

enum In: String, Codable {
    case body = "body"
    case path = "path"
}

// MARK: - ItemsClass
struct ItemsClass: Codable {
    let ref: String

    enum CodingKeys: String, CodingKey {
        case ref = "$ref"
    }
}

// MARK: - PurpleResponses
struct PurpleResponses: Codable {
    let the201: The201

    enum CodingKeys: String, CodingKey {
        case the201 = "201"
    }
}

// MARK: - The201
struct The201: Codable {
    let description: String
    let schema: ItemsClass
}

// MARK: - AuthCodeSendClass
struct AuthCodeSendClass: Codable {
    let put: Put
    let parameters: [JSONAny]
}

// MARK: - Put
struct Put: Codable {
    let operationID, description: String
    let parameters: [Parameter]
    let responses: PutResponses
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags
    }
}

// MARK: - PutResponses
struct PutResponses: Codable {
    let the200: The201

    enum CodingKeys: String, CodingKey {
        case the200 = "200"
    }
}

// MARK: - AuthProfileView
struct AuthProfileView: Codable {
    let authProfileViewGet: Put
    let parameters: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case authProfileViewGet = "get"
        case parameters
    }
}

// MARK: - ProductsCreateUpdateList
struct ProductsCreateUpdateList: Codable {
    let productsCreateUpdateListGet: ProductsCreateUpdateListGet
    let post: AuthAPITokenPost
    let parameters: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case productsCreateUpdateListGet = "get"
        case post, parameters
    }
}

// MARK: - ProductsCreateUpdateListGet
struct ProductsCreateUpdateListGet: Codable {
    let operationID, description: String
    let parameters: [JSONAny]
    let responses: FluffyResponses
    let tags: [String]
    let summary: String?

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags, summary
    }
}

// MARK: - FluffyResponses
struct FluffyResponses: Codable {
    let the200: The200

    enum CodingKeys: String, CodingKey {
        case the200 = "200"
    }
}

// MARK: - The200
struct The200: Codable {
    let description: String
    let schema: PurpleSchema
}

// MARK: - PurpleSchema
struct PurpleSchema: Codable {
    let type: String
    let items: ItemsClass
}

// MARK: - ProductsCreateUpdateListID
struct ProductsCreateUpdateListID: Codable {
    let productsCreateUpdateListIDGet, put, patch: Put
    let delete: Delete
    let parameters: [Parameter]

    enum CodingKeys: String, CodingKey {
        case productsCreateUpdateListIDGet = "get"
        case put, patch, delete, parameters
    }
}

// MARK: - Delete
struct Delete: Codable {
    let operationID, description: String
    let parameters: [JSONAny]
    let responses: DeleteResponses
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags
    }
}

// MARK: - DeleteResponses
struct DeleteResponses: Codable {
    let the204: The204

    enum CodingKeys: String, CodingKey {
        case the204 = "204"
    }
}

// MARK: - The204
struct The204: Codable {
    let description: String
}

// MARK: - ProductsLikeCountsProductID
struct ProductsLikeCountsProductID: Codable {
    let productsLikeCountsProductIDGet: ProductsLikeCountsProductIDGet
    let parameters: [Parameter]

    enum CodingKeys: String, CodingKey {
        case productsLikeCountsProductIDGet = "get"
        case parameters
    }
}

// MARK: - ProductsLikeCountsProductIDGet
struct ProductsLikeCountsProductIDGet: Codable {
    let operationID, description: String
    let parameters: [JSONAny]
    let responses: TentacledResponses
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags
    }
}

// MARK: - TentacledResponses
struct TentacledResponses: Codable {
    let the200: The204

    enum CodingKeys: String, CodingKey {
        case the200 = "200"
    }
}

// MARK: - ProductsLikeProductID
struct ProductsLikeProductID: Codable {
    let post: ProductsLikeProductIDPost
    let parameters: [Parameter]
}

// MARK: - ProductsLikeProductIDPost
struct ProductsLikeProductIDPost: Codable {
    let operationID, description: String
    let parameters: [JSONAny]
    let responses: StickyResponses
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case operationID = "operationId"
        case description, parameters, responses, tags
    }
}

// MARK: - StickyResponses
struct StickyResponses: Codable {
    let the201: The204

    enum CodingKeys: String, CodingKey {
        case the201 = "201"
    }
}

// MARK: - ProductsList
struct ProductsList: Codable {
    let productsListGet: ProductsCreateUpdateListGet
    let parameters: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case productsListGet = "get"
        case parameters
    }
}

// MARK: - ProductsUnlikeProductID
struct ProductsUnlikeProductID: Codable {
    let delete: Delete
    let parameters: [Parameter]
}

// MARK: - Security
struct Security: Codable {
    let basic: [JSONAny]

    enum CodingKeys: String, CodingKey {
        case basic = "Basic"
    }
}

// MARK: - SecurityDefinitions
struct SecurityDefinitions: Codable {
    let basic: Basic

    enum CodingKeys: String, CodingKey {
        case basic = "Basic"
    }
}

// MARK: - Basic
struct Basic: Codable {
    let type: String
}

// MARK: - Encode/decode helpers

//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
