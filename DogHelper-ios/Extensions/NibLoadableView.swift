
import Foundation
import UIKit

protocol NibLoadableView: class {
    static var nibName: String { get }
    static var bundle: Bundle { get }

}

extension UIView: NibLoadableView {}

extension NibLoadableView where Self: UIView {
	
	static var nibName: String {
		return String(describing: self)
	}

    static var bundle: Bundle {
        return Bundle(for: Self.self)
    }

    static var instance: Self {
        let nib = UINib(nibName: Self.nibName, bundle: nil)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }

}

public func printWithParams(_ items: Any...) {
    #if DEBUG
    let output = items.map { "\($0)" }.joined(separator: " ")
    print(output, terminator: "\n")
    #endif
}
