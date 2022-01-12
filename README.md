# EnhanceKit

用于增强系统框架的能力，主要是提供一些已有类的Extension，增强能力，简化日常使用。

需要主意的是：
1. 这部分不应该与任何业务发生关联。属于所有pod库的最底层。
2. 分Swift与OC部分，原则上将OC往Swift迁移，达到最终全Swift的目标

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
这个框架不能有任何依赖

## Installation

EnhanceFoundationKit is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EnhanceFoundationKit'
```

## 性能分析
对Extension和命名空间（前缀）两种实现方式进行了性能测试，循环调用10万次，得出结论：
- 命名空间比Extension减少了了2%的耗时。
- 命名空间比Extension新增了0.3%的内存消耗。
分析原因：
- 因为使用命名空间，调用对象已经被转换了，方法数量降低，提高了查找方法的效率。
- 因为前缀方式每一次调用会新建一个结构体，这个结构体只有调用者本身这一个成员变量，所以会增加内存消耗，但是内存消耗非常小，基本可以忽略不计。

## Author

lixinxing, x@devlxx.com

## License

EnhanceFoundationKit is available under the MIT license. See the LICENSE file for more info.

