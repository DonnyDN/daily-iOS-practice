

/**
 
 1.当person对象的某个属性被观察时，系统会在运行时创建一个子类（NSKVONotifying_Person）
 在该子类中重写被观察属性的setter方法，当该属性被赋值时，就会走到这个setter方法，从而监听到值的变化。那怎么才能走到这个子类的setter方法呢？
 
 2.通过打印得知，person对象的isa指针由之前指向类对象Person，变为指向类对象NSKVONotifying_Person；
 当给person的属性赋值时，通过isa指针去找setter方法，就会跑到NSKVONotifying_Person这个子类对象中寻找，发现有setter方法，就调用了
 
 3.经过查阅资料我们可以了解到:
 NSKVONotifying_Person中的setAge方法中其实调用了 Fundation 框架中C语言函数_NSsetIntValueAndNotify;
 _NSsetIntValueAndNotify内部做的操作相当于:
 先调用willChangeValueForKey将要改变方法，
 再调用父类的setAge方法对成员变量赋值，
 最后调用didChangeValueForKey已经改变方法。
 didChangeValueForKey中会调用监听器的监听方法，最终来到监听者的observeValueForKeyPath方法中。

 还有其他相关类型方法：
 _NSSetLongValueAndNotify
 _NSSetFloatValueAndNotify
 _NSSetBoolValueAndNotify
 _NSSetCharValueAndNotify
 
 4.通过打印NSKVONotifying_Person类的方法列表，发现有4个对象方法，分别是：
 setAge:
 class
 dealloc
 _isKVOA
 
 注意这里的class方法，返回的其实是其父类Person，这样可以巧妙地隐藏此类的存在，猜测其实现为：
 - (Class) class {
      return class_getSuperclass(object_getClass(self));
 }
 
 5.如何验证didChangeValueForKey:内部会调用observer的observeValueForKeyPath:ofObject:change:context:方法？
 我们在Person类中重写willChangeValueForKey:和didChangeValueForKey:方法，模拟他们的实现，通过打印log顺序可以验证

 
 */

/**
并不是如此创建文件，这里只演示用
*/
//#import "NSKVONotifying_Person.h"
//
//@implementation NSKVONotifying_Person
//
//-(void)setAge:(int)age{
//    [super setAge:age];
//
//    [self willChangeValueForKey:@"age"];
//    [self didChangeValueForKey:@"age"];
//}
//@end


