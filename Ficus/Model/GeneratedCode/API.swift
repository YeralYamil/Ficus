//  This file was automatically generated and should not be edited.

import Apollo

public enum EfficiencyType: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case lp100km
  case kwhP100km
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "LP100km": self = .lp100km
      case "KwhP100km": self = .kwhP100km
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .lp100km: return "LP100km"
      case .kwhP100km: return "KwhP100km"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: EfficiencyType, rhs: EfficiencyType) -> Bool {
    switch (lhs, rhs) {
      case (.lp100km, .lp100km): return true
      case (.kwhP100km, .kwhP100km): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public enum CarType: RawRepresentable, Equatable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case gas
  case electric
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "Gas": self = .gas
      case "Electric": self = .electric
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .gas: return "Gas"
      case .electric: return "Electric"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: CarType, rhs: CarType) -> Bool {
    switch (lhs, rhs) {
      case (.gas, .gas): return true
      case (.electric, .electric): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }
}

public final class AllElectricityProviderQuery: GraphQLQuery {
  public let operationDefinition =
    "query allElectricityProvider {\n  allElectricityProviders {\n    __typename\n    electricityPriceDetails {\n      __typename\n      type\n      price\n    }\n    name\n    city {\n      __typename\n      name\n      countryCode\n    }\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allElectricityProviders", type: .nonNull(.list(.nonNull(.object(AllElectricityProvider.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allElectricityProviders: [AllElectricityProvider]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allElectricityProviders": allElectricityProviders.map { (value: AllElectricityProvider) -> ResultMap in value.resultMap }])
    }

    public var allElectricityProviders: [AllElectricityProvider] {
      get {
        return (resultMap["allElectricityProviders"] as! [ResultMap]).map { (value: ResultMap) -> AllElectricityProvider in AllElectricityProvider(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllElectricityProvider) -> ResultMap in value.resultMap }, forKey: "allElectricityProviders")
      }
    }

    public struct AllElectricityProvider: GraphQLSelectionSet {
      public static let possibleTypes = ["ElectricityProvider"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("electricityPriceDetails", type: .list(.nonNull(.object(ElectricityPriceDetail.selections)))),
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("city", type: .nonNull(.object(City.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(electricityPriceDetails: [ElectricityPriceDetail]? = nil, name: String, city: City) {
        self.init(unsafeResultMap: ["__typename": "ElectricityProvider", "electricityPriceDetails": electricityPriceDetails.flatMap { (value: [ElectricityPriceDetail]) -> [ResultMap] in value.map { (value: ElectricityPriceDetail) -> ResultMap in value.resultMap } }, "name": name, "city": city.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var electricityPriceDetails: [ElectricityPriceDetail]? {
        get {
          return (resultMap["electricityPriceDetails"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [ElectricityPriceDetail] in value.map { (value: ResultMap) -> ElectricityPriceDetail in ElectricityPriceDetail(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [ElectricityPriceDetail]) -> [ResultMap] in value.map { (value: ElectricityPriceDetail) -> ResultMap in value.resultMap } }, forKey: "electricityPriceDetails")
        }
      }

      public var name: String {
        get {
          return resultMap["name"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var city: City {
        get {
          return City(unsafeResultMap: resultMap["city"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "city")
        }
      }

      public struct ElectricityPriceDetail: GraphQLSelectionSet {
        public static let possibleTypes = ["ElectricityPriceDetail"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("type", type: .nonNull(.scalar(String.self))),
          GraphQLField("price", type: .nonNull(.scalar(Double.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(type: String, price: Double) {
          self.init(unsafeResultMap: ["__typename": "ElectricityPriceDetail", "type": type, "price": price])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var type: String {
          get {
            return resultMap["type"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "type")
          }
        }

        public var price: Double {
          get {
            return resultMap["price"]! as! Double
          }
          set {
            resultMap.updateValue(newValue, forKey: "price")
          }
        }
      }

      public struct City: GraphQLSelectionSet {
        public static let possibleTypes = ["City"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("countryCode", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, countryCode: String) {
          self.init(unsafeResultMap: ["__typename": "City", "name": name, "countryCode": countryCode])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var countryCode: String {
          get {
            return resultMap["countryCode"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "countryCode")
          }
        }
      }
    }
  }
}

public final class AllCarsQuery: GraphQLQuery {
  public let operationDefinition =
    "query allCars {\n  allCars {\n    __typename\n    carCategory {\n      __typename\n      name\n      id\n    }\n    comparisonText\n    efficiency\n    efficiencyType\n    type\n    kgCO2PerLiter\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allCars", type: .nonNull(.list(.nonNull(.object(AllCar.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allCars: [AllCar]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allCars": allCars.map { (value: AllCar) -> ResultMap in value.resultMap }])
    }

    public var allCars: [AllCar] {
      get {
        return (resultMap["allCars"] as! [ResultMap]).map { (value: ResultMap) -> AllCar in AllCar(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllCar) -> ResultMap in value.resultMap }, forKey: "allCars")
      }
    }

    public struct AllCar: GraphQLSelectionSet {
      public static let possibleTypes = ["Car"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("carCategory", type: .nonNull(.object(CarCategory.selections))),
        GraphQLField("comparisonText", type: .nonNull(.scalar(String.self))),
        GraphQLField("efficiency", type: .nonNull(.scalar(Double.self))),
        GraphQLField("efficiencyType", type: .nonNull(.scalar(EfficiencyType.self))),
        GraphQLField("type", type: .nonNull(.scalar(CarType.self))),
        GraphQLField("kgCO2PerLiter", type: .nonNull(.scalar(Double.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(carCategory: CarCategory, comparisonText: String, efficiency: Double, efficiencyType: EfficiencyType, type: CarType, kgCo2PerLiter: Double) {
        self.init(unsafeResultMap: ["__typename": "Car", "carCategory": carCategory.resultMap, "comparisonText": comparisonText, "efficiency": efficiency, "efficiencyType": efficiencyType, "type": type, "kgCO2PerLiter": kgCo2PerLiter])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var carCategory: CarCategory {
        get {
          return CarCategory(unsafeResultMap: resultMap["carCategory"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "carCategory")
        }
      }

      public var comparisonText: String {
        get {
          return resultMap["comparisonText"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "comparisonText")
        }
      }

      public var efficiency: Double {
        get {
          return resultMap["efficiency"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "efficiency")
        }
      }

      public var efficiencyType: EfficiencyType {
        get {
          return resultMap["efficiencyType"]! as! EfficiencyType
        }
        set {
          resultMap.updateValue(newValue, forKey: "efficiencyType")
        }
      }

      public var type: CarType {
        get {
          return resultMap["type"]! as! CarType
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var kgCo2PerLiter: Double {
        get {
          return resultMap["kgCO2PerLiter"]! as! Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "kgCO2PerLiter")
        }
      }

      public struct CarCategory: GraphQLSelectionSet {
        public static let possibleTypes = ["CarCategory"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, id: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "CarCategory", "name": name, "id": id])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }
      }
    }
  }
}

public final class AllNewsQuery: GraphQLQuery {
  public let operationDefinition =
    "query allNews {\n  allNews {\n    __typename\n    title\n    description\n    url\n    type\n    createdAt\n    imageUrl\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("allNews", type: .nonNull(.list(.nonNull(.object(AllNews.selections))))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(allNews: [AllNews]) {
      self.init(unsafeResultMap: ["__typename": "Query", "allNews": allNews.map { (value: AllNews) -> ResultMap in value.resultMap }])
    }

    public var allNews: [AllNews] {
      get {
        return (resultMap["allNews"] as! [ResultMap]).map { (value: ResultMap) -> AllNews in AllNews(unsafeResultMap: value) }
      }
      set {
        resultMap.updateValue(newValue.map { (value: AllNews) -> ResultMap in value.resultMap }, forKey: "allNews")
      }
    }

    public struct AllNews: GraphQLSelectionSet {
      public static let possibleTypes = ["News"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("title", type: .nonNull(.scalar(String.self))),
        GraphQLField("description", type: .nonNull(.scalar(String.self))),
        GraphQLField("url", type: .nonNull(.scalar(String.self))),
        GraphQLField("type", type: .nonNull(.scalar(String.self))),
        GraphQLField("createdAt", type: .nonNull(.scalar(String.self))),
        GraphQLField("imageUrl", type: .nonNull(.scalar(String.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(title: String, description: String, url: String, type: String, createdAt: String, imageUrl: String) {
        self.init(unsafeResultMap: ["__typename": "News", "title": title, "description": description, "url": url, "type": type, "createdAt": createdAt, "imageUrl": imageUrl])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var description: String {
        get {
          return resultMap["description"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "description")
        }
      }

      public var url: String {
        get {
          return resultMap["url"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "url")
        }
      }

      public var type: String {
        get {
          return resultMap["type"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "type")
        }
      }

      public var createdAt: String {
        get {
          return resultMap["createdAt"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "createdAt")
        }
      }

      public var imageUrl: String {
        get {
          return resultMap["imageUrl"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "imageUrl")
        }
      }
    }
  }
}