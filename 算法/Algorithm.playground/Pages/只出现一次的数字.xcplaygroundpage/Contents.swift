//https://leetcode-cn.com/problems/single-number/
import Foundation

/**
 给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。

 思考：可以不使用额外空间来实现吗？

 示例:
 输入: [4,1,2,1,2]
 输出: 4
 */

/**
 多解法：
 1.暴力法：从头遍历，把每个值和整个数组的值对比，时间复杂O(n²)
 
 2.新建一个数组arr，遍历当前数组的每个值，并通过遍历arr判断是否存在于arr中，
   存在于arr就从arr中移除，最后在arr剩的即为所得；
 
 3.把上面方法新建的数组改为字典（哈希表）
 
 4.先数组元素求和m1，再把数组改为set集合，去除了重复项之后求和m2，最后 m2 x 2 - m1 即为所得
 
 5.先排序，再顺序比对
 
 6.巧妙法：所有元素异或，性能待确认（a ^ a = 0, a ^ 0 = a, 异或满足交换律、结合律）
 */

//新建字典
func singleNumber(_ nums: [Int]) -> Int {
    var dict = Dictionary<Int,Int>()
    for i in 0..<nums.count {
        let value = nums[i]
        if dict[value] == nil {
            dict[value] = 1
        }else {
            dict.removeValue(forKey: value)
        }
    }
    
    if let single = dict.keys.first {
        return single
    }else {
        return 0
    }
}

//异或
func singleNumber1(_ nums: [Int]) -> Int {
    var single: Int = 0
    for value in nums {
        single ^= value
    }
    return single
}


let arr = [3,4,1,3,2,1,2]

singleNumber(arr)

singleNumber1(arr)



