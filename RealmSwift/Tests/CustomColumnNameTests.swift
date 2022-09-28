////////////////////////////////////////////////////////////////////////////
//
// Copyright 2022 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

import XCTest
import RealmSwift

// MARK: - Objects

let propertiesModernCustomMapping: [String: String] = {
    ["pk": "custom_pk",
     "boolCol": "custom_boolCol",
     "intCol": "custom_intCol",
     "int8Col": "custom_int8Col",
     "int16Col": "custom_int16Col",
     "int32Col": "custom_int32Col",
     "int64Col": "custom_int64Col",
     "floatCol": "custom_floatCol",
     "doubleCol": "custom_doubleCol",
     "stringCol": "custom_stringCol",
     "binaryCol": "custom_binaryCol",
     "dateCol": "custom_dateCol",
     "decimalCol": "custom_decimalCol",
     "objectIdCol": "custom_objectIdCol",
     "objectCol": "custom_objectCol",
     "arrayCol": "custom_arrayCol",
     "setCol": "custom_setCol",
     "mapCol": "custom_mapCol",
     "anyCol": "custom_anyCol",
     "uuidCol": "custom_uuidCol",
     "intEnumCol": "custom_intEnumCol",
     "embeddedObject": "custom_embeddedObject",
     "linkingObjects": "custom_linkingObjects"]
}()

class ModernCustomObject: Object, CustomObject {
    @Persisted(primaryKey: true) var pk: ObjectId
    @Persisted var boolCol: Bool
    @Persisted var intCol: Int
    @Persisted var int8Col: Int8 = 1
    @Persisted var int16Col: Int16 = 2
    @Persisted var int32Col: Int32 = 3
    @Persisted var int64Col: Int64 = 4
    @Persisted var floatCol: Float = 5
    @Persisted var doubleCol: Double = 6
    @Persisted var stringCol: String
    @Persisted var binaryCol: Data
    @Persisted var dateCol: Date
    @Persisted var decimalCol: Decimal128
    @Persisted var uuidCol: UUID
    @Persisted var objectIdCol: ObjectId
    @Persisted var objectCol: ModernCustomObject?
    @Persisted var arrayCol = List<ModernCustomObject>()
    @Persisted var setCol = MutableSet<ModernCustomObject>()
    @Persisted var mapCol = Map<String, ModernCustomObject?>()
    @Persisted var anyCol: AnyRealmValue
    @Persisted var intEnumCol: ModernIntEnum

    @Persisted var embeddedObject: EmbeddedModernCustomObject?

    @Persisted(originProperty: "objectCol")
    var linkingObjects: LinkingObjects<ModernCustomObject>

    override class func propertiesMapping() -> [String: String] {
        propertiesModernCustomMapping
    }

    func createObject() -> Object {
        let object = ModernCustomObject()
        object.pk = try! ObjectId(string: "000000000000ffbeef91906c")
        object.boolCol = false
        object.intCol = 333
        object.int8Col = 3
        object.int16Col = 331
        object.int32Col = 330
        object.int64Col = 229
        object.floatCol = 228.228
        object.doubleCol = 227.227
        object.stringCol = "string_226"
        object.binaryCol = "data_225".data(using: String.Encoding.utf8)!
        object.dateCol = Date(timeIntervalSince1970: 224)
        object.decimalCol = try! Decimal128(string: "223")
        object.uuidCol = UUID(uuidString: "ab98ac38-ff84-4646-9f0e-6a42b4c46428")!
        object.objectIdCol = try! ObjectId(string: "000000000000ffbfff91906a")
        let linkedObject = ModernCustomObject()
        object.objectCol = linkedObject
        object.arrayCol.append(linkedObject)
        object.setCol.insert(linkedObject)
        object.mapCol["key"] = object
        object.anyCol = .string("string_222")
        object.intEnumCol = .value3

        let embeddedObect = EmbeddedModernCustomObject()
        embeddedObect.intCol = 221
        embeddedObect.stringCol = "string_220"
        let embeddedNested = EmbeddedNestedCustomObject()
        embeddedNested.boolCol = true
        embeddedObect.child = embeddedNested
        embeddedObect.children.append(EmbeddedNestedCustomObject())
        object.embeddedObject = embeddedObect
        return object
    }
}

let propertiesModernEmbeddedCustomMapping: [String: String] = {
    ["intCol": "custom_intCol",
     "stringCol": "custom_stringCol",
     "child": "custom_child",
     "children": "custom_children"]
}()

class EmbeddedModernCustomObject: EmbeddedObject {
    @Persisted var intCol = 123
    @Persisted var stringCol = "12345"
    @Persisted var child: EmbeddedNestedCustomObject?
    @Persisted var children: List<EmbeddedNestedCustomObject>

    override class func propertiesMapping() -> [String: String] {
        propertiesModernEmbeddedCustomMapping
    }
}

class EmbeddedNestedCustomObject: EmbeddedObject {
    @Persisted var boolCol = false

    override class func propertiesMapping() -> [String: String] {
        ["boolCol": "custom_boolCol"]
    }
}

let propertiesCustomMapping: [String: String] = {
    ["pk": "custom_pk",
     "boolCol": "custom_boolCol",
     "intCol": "custom_intCol",
     "int8Col": "custom_int8Col",
     "int16Col": "custom_int16Col",
     "int32Col": "custom_int32Col",
     "int64Col": "custom_int64Col",
     "floatCol": "custom_floatCol",
     "doubleCol": "custom_doubleCol",
     "stringCol": "custom_stringCol",
     "binaryCol": "custom_binaryCol",
     "dateCol": "custom_dateCol",
     "decimalCol": "custom_decimalCol",
     "uuidCol": "custom_uuidCol",
     "objectIdCol": "custom_objectIdCol",
     "objectCol": "custom_objectCol",
     "arrayCol": "custom_arrayCol",
     "setCol": "custom_setCol",
     "mapCol": "custom_mapCol",
     "anyCol": "custom_anyCol",
     "intEnumCol": "custom_intEnumCol",
     "embeddedObject": "custom_embeddedObject",
     "linkingObjects": "custom_linkingObjects"]
}()

class OldCustomObject: Object, CustomObject {
    @objc dynamic var pk = ObjectId.generate()
    @objc dynamic var boolCol = false
    @objc dynamic var intCol = 123
    @objc dynamic var int8Col: Int8 = 123
    @objc dynamic var int16Col: Int16 = 123
    @objc dynamic var int32Col: Int32 = 123
    @objc dynamic var int64Col: Int64 = 123
    @objc dynamic var floatCol = 1.23 as Float
    @objc dynamic var doubleCol = 12.3
    @objc dynamic var stringCol = "a"
    @objc dynamic var binaryCol = "a".data(using: String.Encoding.utf8)!
    @objc dynamic var dateCol = Date(timeIntervalSince1970: 1)
    @objc dynamic var decimalCol = Decimal128("123e4")
    @objc dynamic var uuidCol: UUID = UUID(uuidString: "137decc8-b300-4954-a233-f89909f4fd89")!
    @objc dynamic var objectIdCol = ObjectId("1234567890ab1234567890ab")
    @objc dynamic var objectCol: OldCustomObject?
    let arrayCol = List<OldCustomObject>()
    let setCol = MutableSet<OldCustomObject>()
    let mapCol = Map<String, OldCustomObject?>()
    var anyCol = RealmProperty<AnyRealmValue>()
    @objc dynamic var intEnumCol = IntEnum.value1

    @objc dynamic var embeddedObject: EmbeddedCustomObject?

    let linkingObjects = LinkingObjects(fromType: OldCustomObject.self, property: "objectCol")

    override class func primaryKey() -> String? {
        return "pk"
    }
    override class func propertiesMapping() -> [String: String] {
        propertiesCustomMapping
    }

    func createObject() -> Object {
        let object = OldCustomObject()
        object.pk = try! ObjectId(string: "000000000000ffbeef91906c")
        object.boolCol = false
        object.intCol = 333
        object.int8Col = 3
        object.int16Col = 331
        object.int32Col = 330
        object.int64Col = 229
        object.floatCol = 228.228
        object.doubleCol = 227.227
        object.stringCol = "string_226"
        object.binaryCol = "data_225".data(using: String.Encoding.utf8)!
        object.dateCol = Date(timeIntervalSince1970: 224)
        object.decimalCol = try! Decimal128(string: "223")
        object.uuidCol = UUID(uuidString: "ab98ac38-ff84-4646-9f0e-6a42b4c46428")!
        object.objectIdCol = try! ObjectId(string: "000000000000ffbfff91906a")
        let linkedObject = OldCustomObject()
        object.objectCol = linkedObject
        object.arrayCol.append(linkedObject)
        object.setCol.insert(linkedObject)
        object.mapCol["key"] = linkedObject
        object.anyCol.value = .bool(true)
        object.intEnumCol = .value2

        let embeddedObect = EmbeddedCustomObject()
        embeddedObect.intCol = 221
        embeddedObect.stringCol = "string_220"
        let embeddedNested = EmbeddedNestedCustomObject()
        embeddedNested.boolCol = true
        embeddedObect.child = embeddedNested
        embeddedObect.children.append(EmbeddedNestedCustomObject())
        object.embeddedObject = embeddedObect
        return object
    }
}

protocol CustomObject: Object {
    func createObject() -> Object
}

let propertiesEmbeddedCustomMapping: [String: String] = {
    ["intCol": "custom_intCol",
     "stringCol": "custom_stringCol",
     "child": "custom_child",
     "children": "custom_children"]
}()

class EmbeddedCustomObject: EmbeddedObject {
    @objc dynamic var intCol = 123
    @objc dynamic var stringCol = "12345"
    @objc dynamic var child: EmbeddedNestedCustomObject?
    let children = List<EmbeddedNestedCustomObject>()

    override class func propertiesMapping() -> [String: String] {
        propertiesEmbeddedCustomMapping
    }
}

// MARK: - Schema Discovery

class CustomColumnNamesSchemaTest: TestCase {
    func testCustomColumnNameSchema() {
        let modernCustomObjectSchema = ModernCustomObject().objectSchema
        for property in modernCustomObjectSchema.properties {
            XCTAssertEqual(propertiesModernCustomMapping[property.name], property.columnName)
        }

        let modernEmbeddedCustomObjectSchema = EmbeddedModernCustomObject().objectSchema
        for property in modernEmbeddedCustomObjectSchema.properties {
            XCTAssertEqual(propertiesModernEmbeddedCustomMapping[property.name], property.columnName)
        }

        let oldCustomObjectSchema = OldCustomObject().objectSchema
        for property in oldCustomObjectSchema.properties {
            XCTAssertEqual(propertiesCustomMapping[property.name], property.columnName)
        }

        let oldEmbeddedCustomObjectSchema = EmbeddedCustomObject().objectSchema
        for property in oldEmbeddedCustomObjectSchema.properties {
            XCTAssertEqual(propertiesEmbeddedCustomMapping[property.name], property.columnName)
        }
    }
}

class CustomColumnObjectTests<T: CustomObject>: TestCase {
    private var realm: Realm!

    override func setUp() {
        realm = inMemoryRealm("CustomColumnTests")
        try! realm.write {
            let object = T().createObject()
            realm.add(object)
        }
    }

    override func tearDown() {
        realm = nil
    }

    // MARK: - Queries

    func testCustomColumnQueries() {
        // All objects
        let objects = realm.objects(T.self)
        XCTAssertEqual(objects.count, 2)

        // By primary key
        let primaryKey = try! ObjectId(string: "000000000000ffbeef91906c")
        let objectByPrimaryKey = realm.object(ofType: T.self, forPrimaryKey: primaryKey)
        XCTAssertNotNil(objectByPrimaryKey)
    }
}

class CustomObjectTests: TestCase {
    override class var defaultTestSuite: XCTestSuite {
        let suite = XCTestSuite(name: "Custom Column Name Tests")
        CustomColumnObjectTests<ModernCustomObject>.defaultTestSuite.tests.forEach(suite.addTest)
        CustomColumnObjectTests<OldCustomObject>.defaultTestSuite.tests.forEach(suite.addTest)
        return suite
    }
}
