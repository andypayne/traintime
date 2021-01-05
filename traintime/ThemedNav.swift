import Foundation
import SwiftUI

extension UINavigationController {
  override open func viewDidLoad() {
    super.viewDidLoad()
    let standardAppr = UINavigationBarAppearance()
    standardAppr.backgroundColor = UIColor(Theme.bgColor)
    let compactAppr = UINavigationBarAppearance()
    compactAppr.backgroundColor = UIColor(Theme.bgColor)
    let scrollEdgeAppr = UINavigationBarAppearance()
    scrollEdgeAppr.backgroundColor = UIColor(Theme.bgColor)
    navigationBar.standardAppearance = standardAppr
    navigationBar.compactAppearance = compactAppr
    navigationBar.scrollEdgeAppearance = scrollEdgeAppr
  }
}
