import Foundation

@objc(TagTransformer)
public final class TagTransformer: ValueTransformer, Codable {
    static let name = NSValueTransformerName(rawValue: String(describing: TagTransformer.self))
    
    override public class func transformedValueClass() -> AnyClass {
        return Tag.self
    }

    override public class func allowsReverseTransformation() -> Bool {
        return true
    }
    
    public static func register() {
        let transformer = TagTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: TagTransformer.name)
    }

    override public func transformedValue(_ value: Any?) -> Any? {
        if let tag = value as? TagTransformer {
            do {
                let data = try JSONEncoder().encode(tag)
                return data
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return nil
    }

    override public func reverseTransformedValue(_ value: Any?) -> Any? {
        if let data = value as? Data {
            do {
                let tag = try JSONDecoder().decode(Tag.self, from: data)
                return tag
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        return nil
    }
}
