//  This file was automatically generated and should not be edited.

import Apollo

public final class AllElectricityProvidersQuery: GraphQLQuery {
  public let operationDefinition =
    "query allElectricityProviders {\n  allElectricityProviders {\n    __typename\n    name\n    onPeakPrice\n    offPeakPrice\n    midPeakPrice\n    city {\n      __typename\n      name\n      code\n      countryCode\n    }\n  }\n}"

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
        GraphQLField("name", type: .nonNull(.scalar(String.self))),
        GraphQLField("onPeakPrice", type: .scalar(Double.self)),
        GraphQLField("offPeakPrice", type: .scalar(Double.self)),
        GraphQLField("midPeakPrice", type: .scalar(Double.self)),
        GraphQLField("city", type: .nonNull(.object(City.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(name: String, onPeakPrice: Double? = nil, offPeakPrice: Double? = nil, midPeakPrice: Double? = nil, city: City) {
        self.init(unsafeResultMap: ["__typename": "ElectricityProvider", "name": name, "onPeakPrice": onPeakPrice, "offPeakPrice": offPeakPrice, "midPeakPrice": midPeakPrice, "city": city.resultMap])
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

      public var onPeakPrice: Double? {
        get {
          return resultMap["onPeakPrice"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "onPeakPrice")
        }
      }

      public var offPeakPrice: Double? {
        get {
          return resultMap["offPeakPrice"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "offPeakPrice")
        }
      }

      public var midPeakPrice: Double? {
        get {
          return resultMap["midPeakPrice"] as? Double
        }
        set {
          resultMap.updateValue(newValue, forKey: "midPeakPrice")
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

      public struct City: GraphQLSelectionSet {
        public static let possibleTypes = ["City"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("name", type: .nonNull(.scalar(String.self))),
          GraphQLField("code", type: .nonNull(.scalar(String.self))),
          GraphQLField("countryCode", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String, code: String, countryCode: String) {
          self.init(unsafeResultMap: ["__typename": "City", "name": name, "code": code, "countryCode": countryCode])
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

        public var code: String {
          get {
            return resultMap["code"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "code")
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