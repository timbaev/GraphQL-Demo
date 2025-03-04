// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

/// The possible states of a subscription.
public enum SubscriptionState: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  /// The User is only notified when participating or @mentioned.
  case unsubscribed
  /// The User is notified of all conversations.
  case subscribed
  /// The User is never notified.
  case ignored
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "UNSUBSCRIBED": self = .unsubscribed
      case "SUBSCRIBED": self = .subscribed
      case "IGNORED": self = .ignored
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .unsubscribed: return "UNSUBSCRIBED"
      case .subscribed: return "SUBSCRIBED"
      case .ignored: return "IGNORED"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: SubscriptionState, rhs: SubscriptionState) -> Bool {
    switch (lhs, rhs) {
      case (.unsubscribed, .unsubscribed): return true
      case (.subscribed, .subscribed): return true
      case (.ignored, .ignored): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [SubscriptionState] {
    return [
      .unsubscribed,
      .subscribed,
      .ignored,
    ]
  }
}

public final class SearchRepositoriesQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query SearchRepositories($searchText: String!) {
      search(first: 20, query: $searchText, type: REPOSITORY) {
        __typename
        nodes {
          __typename
          ... on Repository {
            ...RepositorySearchResult
          }
        }
      }
    }
    """

  public let operationName: String = "SearchRepositories"

  public var queryDocument: String { return operationDefinition.appending(RepositorySearchResult.fragmentDefinition) }

  public var searchText: String

  public init(searchText: String) {
    self.searchText = searchText
  }

  public var variables: GraphQLMap? {
    return ["searchText": searchText]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("search", arguments: ["first": 20, "query": GraphQLVariable("searchText"), "type": "REPOSITORY"], type: .nonNull(.object(Search.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.resultMap])
    }

    /// Perform a search across resources.
    public var search: Search {
      get {
        return Search(unsafeResultMap: resultMap["search"]! as! ResultMap)
      }
      set {
        resultMap.updateValue(newValue.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SearchResultItemConnection"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("nodes", type: .list(.object(Node.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(nodes: [Node?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchResultItemConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// A list of nodes.
      public var nodes: [Node?]? {
        get {
          return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
        }
      }

      public struct Node: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["App", "Issue", "MarketplaceListing", "Organization", "PullRequest", "Repository", "User"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Repository": AsRepository.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeApp() -> Node {
          return Node(unsafeResultMap: ["__typename": "App"])
        }

        public static func makeIssue() -> Node {
          return Node(unsafeResultMap: ["__typename": "Issue"])
        }

        public static func makeMarketplaceListing() -> Node {
          return Node(unsafeResultMap: ["__typename": "MarketplaceListing"])
        }

        public static func makeOrganization() -> Node {
          return Node(unsafeResultMap: ["__typename": "Organization"])
        }

        public static func makePullRequest() -> Node {
          return Node(unsafeResultMap: ["__typename": "PullRequest"])
        }

        public static func makeUser() -> Node {
          return Node(unsafeResultMap: ["__typename": "User"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asRepository: AsRepository? {
          get {
            if !AsRepository.possibleTypes.contains(__typename) { return nil }
            return AsRepository(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsRepository: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositorySearchResult.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repositorySearchResult: RepositorySearchResult {
              get {
                return RepositorySearchResult(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class FetchRepositoryQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query FetchRepository($name: String!, $owner: String!) {
      repository(name: $name, owner: $owner) {
        __typename
        ...RepositoryDetailsFields
      }
    }
    """

  public let operationName: String = "FetchRepository"

  public var queryDocument: String { return operationDefinition.appending(RepositoryDetailsFields.fragmentDefinition) }

  public var name: String
  public var owner: String

  public init(name: String, owner: String) {
    self.name = name
    self.owner = owner
  }

  public var variables: GraphQLMap? {
    return ["name": name, "owner": owner]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("repository", arguments: ["name": GraphQLVariable("name"), "owner": GraphQLVariable("owner")], type: .object(Repository.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(repository: Repository? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "repository": repository.flatMap { (value: Repository) -> ResultMap in value.resultMap }])
    }

    /// Lookup a given repository by the owner and repository name.
    public var repository: Repository? {
      get {
        return (resultMap["repository"] as? ResultMap).flatMap { Repository(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "repository")
      }
    }

    public struct Repository: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Repository"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLFragmentSpread(RepositoryDetailsFields.self),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var repositoryDetailsFields: RepositoryDetailsFields {
          get {
            return RepositoryDetailsFields(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }
      }
    }
  }
}

public final class AddStarMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation AddStar($starrableID: String!) {
      addStar(input: {starrableId: $starrableID}) {
        __typename
        starrable {
          __typename
          ... on Repository {
            ...RepositoryDetailsFields
          }
        }
      }
    }
    """

  public let operationName: String = "AddStar"

  public var queryDocument: String { return operationDefinition.appending(RepositoryDetailsFields.fragmentDefinition) }

  public var starrableID: String

  public init(starrableID: String) {
    self.starrableID = starrableID
  }

  public var variables: GraphQLMap? {
    return ["starrableID": starrableID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("addStar", arguments: ["input": ["starrableId": GraphQLVariable("starrableID")]], type: .object(AddStar.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(addStar: AddStar? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "addStar": addStar.flatMap { (value: AddStar) -> ResultMap in value.resultMap }])
    }

    /// Adds a star to a Starrable.
    public var addStar: AddStar? {
      get {
        return (resultMap["addStar"] as? ResultMap).flatMap { AddStar(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "addStar")
      }
    }

    public struct AddStar: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["AddStarPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("starrable", type: .object(Starrable.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(starrable: Starrable? = nil) {
        self.init(unsafeResultMap: ["__typename": "AddStarPayload", "starrable": starrable.flatMap { (value: Starrable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The starrable.
      public var starrable: Starrable? {
        get {
          return (resultMap["starrable"] as? ResultMap).flatMap { Starrable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "starrable")
        }
      }

      public struct Starrable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Repository", "Topic", "Gist"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Repository": AsRepository.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeTopic() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Topic"])
        }

        public static func makeGist() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Gist"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asRepository: AsRepository? {
          get {
            if !AsRepository.possibleTypes.contains(__typename) { return nil }
            return AsRepository(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsRepository: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositoryDetailsFields.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repositoryDetailsFields: RepositoryDetailsFields {
              get {
                return RepositoryDetailsFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class RemoveStarMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation RemoveStar($starrableID: String!) {
      removeStar(input: {starrableId: $starrableID}) {
        __typename
        starrable {
          __typename
          ... on Repository {
            ...RepositoryDetailsFields
          }
        }
      }
    }
    """

  public let operationName: String = "RemoveStar"

  public var queryDocument: String { return operationDefinition.appending(RepositoryDetailsFields.fragmentDefinition) }

  public var starrableID: String

  public init(starrableID: String) {
    self.starrableID = starrableID
  }

  public var variables: GraphQLMap? {
    return ["starrableID": starrableID]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("removeStar", arguments: ["input": ["starrableId": GraphQLVariable("starrableID")]], type: .object(RemoveStar.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(removeStar: RemoveStar? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "removeStar": removeStar.flatMap { (value: RemoveStar) -> ResultMap in value.resultMap }])
    }

    /// Removes a star from a Starrable.
    public var removeStar: RemoveStar? {
      get {
        return (resultMap["removeStar"] as? ResultMap).flatMap { RemoveStar(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "removeStar")
      }
    }

    public struct RemoveStar: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["RemoveStarPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("starrable", type: .object(Starrable.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(starrable: Starrable? = nil) {
        self.init(unsafeResultMap: ["__typename": "RemoveStarPayload", "starrable": starrable.flatMap { (value: Starrable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The starrable.
      public var starrable: Starrable? {
        get {
          return (resultMap["starrable"] as? ResultMap).flatMap { Starrable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "starrable")
        }
      }

      public struct Starrable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Repository", "Topic", "Gist"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Repository": AsRepository.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeTopic() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Topic"])
        }

        public static func makeGist() -> Starrable {
          return Starrable(unsafeResultMap: ["__typename": "Gist"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asRepository: AsRepository? {
          get {
            if !AsRepository.possibleTypes.contains(__typename) { return nil }
            return AsRepository(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsRepository: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositoryDetailsFields.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repositoryDetailsFields: RepositoryDetailsFields {
              get {
                return RepositoryDetailsFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class UpdateSubscriptionMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation UpdateSubscription($subscribableID: String!, $state: SubscriptionState!) {
      updateSubscription(input: {subscribableId: $subscribableID, state: $state}) {
        __typename
        subscribable {
          __typename
          ... on Repository {
            ...RepositoryDetailsFields
          }
        }
      }
    }
    """

  public let operationName: String = "UpdateSubscription"

  public var queryDocument: String { return operationDefinition.appending(RepositoryDetailsFields.fragmentDefinition) }

  public var subscribableID: String
  public var state: SubscriptionState

  public init(subscribableID: String, state: SubscriptionState) {
    self.subscribableID = subscribableID
    self.state = state
  }

  public var variables: GraphQLMap? {
    return ["subscribableID": subscribableID, "state": state]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("updateSubscription", arguments: ["input": ["subscribableId": GraphQLVariable("subscribableID"), "state": GraphQLVariable("state")]], type: .object(UpdateSubscription.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(updateSubscription: UpdateSubscription? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "updateSubscription": updateSubscription.flatMap { (value: UpdateSubscription) -> ResultMap in value.resultMap }])
    }

    /// Updates the state for subscribable subjects.
    public var updateSubscription: UpdateSubscription? {
      get {
        return (resultMap["updateSubscription"] as? ResultMap).flatMap { UpdateSubscription(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "updateSubscription")
      }
    }

    public struct UpdateSubscription: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["UpdateSubscriptionPayload"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("subscribable", type: .object(Subscribable.selections)),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(subscribable: Subscribable? = nil) {
        self.init(unsafeResultMap: ["__typename": "UpdateSubscriptionPayload", "subscribable": subscribable.flatMap { (value: Subscribable) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The input subscribable entity.
      public var subscribable: Subscribable? {
        get {
          return (resultMap["subscribable"] as? ResultMap).flatMap { Subscribable(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "subscribable")
        }
      }

      public struct Subscribable: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Issue", "PullRequest", "Repository", "Team", "TeamDiscussion", "Commit"]

        public static let selections: [GraphQLSelection] = [
          GraphQLTypeCase(
            variants: ["Repository": AsRepository.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeIssue() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Issue"])
        }

        public static func makePullRequest() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "PullRequest"])
        }

        public static func makeTeam() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Team"])
        }

        public static func makeTeamDiscussion() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "TeamDiscussion"])
        }

        public static func makeCommit() -> Subscribable {
          return Subscribable(unsafeResultMap: ["__typename": "Commit"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var asRepository: AsRepository? {
          get {
            if !AsRepository.possibleTypes.contains(__typename) { return nil }
            return AsRepository(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap = newValue.resultMap
          }
        }

        public struct AsRepository: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Repository"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLFragmentSpread(RepositoryDetailsFields.self),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var repositoryDetailsFields: RepositoryDetailsFields {
              get {
                return RepositoryDetailsFields(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public struct RepositorySearchResult: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RepositorySearchResult on Repository {
      __typename
      id
      owner {
        __typename
        avatarUrl
        login
      }
      name
      description
      primaryLanguage {
        __typename
        color
        name
      }
      stargazers {
        __typename
        totalCount
      }
    }
    """

  public static let possibleTypes: [String] = ["Repository"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("primaryLanguage", type: .object(PrimaryLanguage.selections)),
    GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, owner: Owner, name: String, description: String? = nil, primaryLanguage: PrimaryLanguage? = nil, stargazers: Stargazer) {
    self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "owner": owner.resultMap, "name": name, "description": description, "primaryLanguage": primaryLanguage.flatMap { (value: PrimaryLanguage) -> ResultMap in value.resultMap }, "stargazers": stargazers.resultMap])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "owner")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The description of the repository.
  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  /// The primary language of the repository's code.
  public var primaryLanguage: PrimaryLanguage? {
    get {
      return (resultMap["primaryLanguage"] as? ResultMap).flatMap { PrimaryLanguage(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "primaryLanguage")
    }
  }

  /// A list of users who have starred this starrable.
  public var stargazers: Stargazer {
    get {
      return Stargazer(unsafeResultMap: resultMap["stargazers"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "stargazers")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Organization", "User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(avatarUrl: String, login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeUser(avatarUrl: String, login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A URL pointing to the owner's public avatar.
    public var avatarUrl: String {
      get {
        return resultMap["avatarUrl"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    /// The username used to login.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }

  public struct PrimaryLanguage: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Language"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("color", type: .scalar(String.self)),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(color: String? = nil, name: String) {
      self.init(unsafeResultMap: ["__typename": "Language", "color": color, "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The color defined for the current language.
    public var color: String? {
      get {
        return resultMap["color"] as? String
      }
      set {
        resultMap.updateValue(newValue, forKey: "color")
      }
    }

    /// The name of the current language.
    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }

  public struct Stargazer: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["StargazerConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "StargazerConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }
}

public struct RepositoryDetailsFields: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment RepositoryDetailsFields on Repository {
      __typename
      id
      owner {
        __typename
        avatarUrl
        login
      }
      name
      description
      stargazers {
        __typename
        totalCount
      }
      forkCount
      viewerHasStarred
      viewerSubscription
      issues {
        __typename
        totalCount
      }
      pullRequests {
        __typename
        totalCount
      }
      watchers {
        __typename
        totalCount
      }
      licenseInfo {
        __typename
        name
      }
    }
    """

  public static let possibleTypes: [String] = ["Repository"]

  public static let selections: [GraphQLSelection] = [
    GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
    GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
    GraphQLField("owner", type: .nonNull(.object(Owner.selections))),
    GraphQLField("name", type: .nonNull(.scalar(String.self))),
    GraphQLField("description", type: .scalar(String.self)),
    GraphQLField("stargazers", type: .nonNull(.object(Stargazer.selections))),
    GraphQLField("forkCount", type: .nonNull(.scalar(Int.self))),
    GraphQLField("viewerHasStarred", type: .nonNull(.scalar(Bool.self))),
    GraphQLField("viewerSubscription", type: .scalar(SubscriptionState.self)),
    GraphQLField("issues", type: .nonNull(.object(Issue.selections))),
    GraphQLField("pullRequests", type: .nonNull(.object(PullRequest.selections))),
    GraphQLField("watchers", type: .nonNull(.object(Watcher.selections))),
    GraphQLField("licenseInfo", type: .object(LicenseInfo.selections)),
  ]

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, owner: Owner, name: String, description: String? = nil, stargazers: Stargazer, forkCount: Int, viewerHasStarred: Bool, viewerSubscription: SubscriptionState? = nil, issues: Issue, pullRequests: PullRequest, watchers: Watcher, licenseInfo: LicenseInfo? = nil) {
    self.init(unsafeResultMap: ["__typename": "Repository", "id": id, "owner": owner.resultMap, "name": name, "description": description, "stargazers": stargazers.resultMap, "forkCount": forkCount, "viewerHasStarred": viewerHasStarred, "viewerSubscription": viewerSubscription, "issues": issues.resultMap, "pullRequests": pullRequests.resultMap, "watchers": watchers.resultMap, "licenseInfo": licenseInfo.flatMap { (value: LicenseInfo) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
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

  /// The User owner of the repository.
  public var owner: Owner {
    get {
      return Owner(unsafeResultMap: resultMap["owner"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "owner")
    }
  }

  /// The name of the repository.
  public var name: String {
    get {
      return resultMap["name"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// The description of the repository.
  public var description: String? {
    get {
      return resultMap["description"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "description")
    }
  }

  /// A list of users who have starred this starrable.
  public var stargazers: Stargazer {
    get {
      return Stargazer(unsafeResultMap: resultMap["stargazers"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "stargazers")
    }
  }

  /// Returns how many forks there are of this repository in the whole network.
  public var forkCount: Int {
    get {
      return resultMap["forkCount"]! as! Int
    }
    set {
      resultMap.updateValue(newValue, forKey: "forkCount")
    }
  }

  /// Returns a boolean indicating whether the viewing user has starred this starrable.
  public var viewerHasStarred: Bool {
    get {
      return resultMap["viewerHasStarred"]! as! Bool
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerHasStarred")
    }
  }

  /// Identifies if the viewer is watching, not watching, or ignoring the subscribable entity.
  public var viewerSubscription: SubscriptionState? {
    get {
      return resultMap["viewerSubscription"] as? SubscriptionState
    }
    set {
      resultMap.updateValue(newValue, forKey: "viewerSubscription")
    }
  }

  /// A list of issues that have been opened in the repository.
  public var issues: Issue {
    get {
      return Issue(unsafeResultMap: resultMap["issues"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "issues")
    }
  }

  /// A list of pull requests that have been opened in the repository.
  public var pullRequests: PullRequest {
    get {
      return PullRequest(unsafeResultMap: resultMap["pullRequests"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "pullRequests")
    }
  }

  /// A list of users watching the repository.
  public var watchers: Watcher {
    get {
      return Watcher(unsafeResultMap: resultMap["watchers"]! as! ResultMap)
    }
    set {
      resultMap.updateValue(newValue.resultMap, forKey: "watchers")
    }
  }

  /// The license associated with the repository
  public var licenseInfo: LicenseInfo? {
    get {
      return (resultMap["licenseInfo"] as? ResultMap).flatMap { LicenseInfo(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "licenseInfo")
    }
  }

  public struct Owner: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Organization", "User"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("avatarUrl", type: .nonNull(.scalar(String.self))),
      GraphQLField("login", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public static func makeOrganization(avatarUrl: String, login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "Organization", "avatarUrl": avatarUrl, "login": login])
    }

    public static func makeUser(avatarUrl: String, login: String) -> Owner {
      return Owner(unsafeResultMap: ["__typename": "User", "avatarUrl": avatarUrl, "login": login])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// A URL pointing to the owner's public avatar.
    public var avatarUrl: String {
      get {
        return resultMap["avatarUrl"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "avatarUrl")
      }
    }

    /// The username used to login.
    public var login: String {
      get {
        return resultMap["login"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "login")
      }
    }
  }

  public struct Stargazer: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["StargazerConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "StargazerConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct Issue: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["IssueConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "IssueConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct PullRequest: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["PullRequestConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "PullRequestConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct Watcher: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["UserConnection"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("totalCount", type: .nonNull(.scalar(Int.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(totalCount: Int) {
      self.init(unsafeResultMap: ["__typename": "UserConnection", "totalCount": totalCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// Identifies the total count of items in the connection.
    public var totalCount: Int {
      get {
        return resultMap["totalCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "totalCount")
      }
    }
  }

  public struct LicenseInfo: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["License"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("name", type: .nonNull(.scalar(String.self))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(name: String) {
      self.init(unsafeResultMap: ["__typename": "License", "name": name])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The license full name specified by <https://spdx.org/licenses>
    public var name: String {
      get {
        return resultMap["name"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "name")
      }
    }
  }
}
