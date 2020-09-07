//: [Previous](@previous)

import Foundation

/**
 在一个长度为 n 的数组 nums 里的所有数字都在 0～n-1 的范围内。数组中某些数字是重复的，但不知道有几个数字重复了，也不知道每个数字重复了几次。请找出数组中任意一个重复的数字。限制：2 <= n <= 100000

 例：
 输入：[2, 3, 1, 0, 2, 5, 3]
 输出：2 或 3

 */

//时间复杂度：O(n)。遍历数组一遍。使用哈希集合（HashSet），添加元素的时间复杂度为 O(1)，故总的时间复杂度是 O(n)。
//空间复杂度：O(n)。不重复的每个元素都可能存入集合，因此占用 O(n) 额外空间。

func findRepeatNumber(_ nums: [Int]) -> Int {
    var dict = [Int:Int]()
    var a: Int = -1
    for i in 0..<nums.count  {
        let num = nums[i]
        if dict.keys.contains(num) {
            a = num
            break
        }else {
            dict.updateValue(i, forKey: num)
        }
    }
    return a
}

func findRepeatNumber1(_ nums: [Int]) -> Int {
    var dict = [Int:Int]()
    var a: Int = -1
    for i in 0..<nums.count  {
        let num = nums[i]
        if let _ = dict.updateValue(i, forKey: num) {
            a = num
            break
        }
    }
    return a
}

findRepeatNumber1([1,2,3,4,5,6,2,4,3])

