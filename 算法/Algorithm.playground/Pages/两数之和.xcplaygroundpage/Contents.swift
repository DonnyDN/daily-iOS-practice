
/*
给定一个整数数组 nums 和一个目标值 target，请你在该数组中找出和为目标值的那 两个 整数，并返回他们的数组下标。
你可以假设每种输入只会对应一个答案。但是，数组中同一个元素不能使用两遍。

示例:
给定 nums = [2, 7, 11, 15], target = 9
因为 nums[0] + nums[1] = 2 + 7 = 9
所以返回 [0, 1]
*/

func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    
    var cacheMap : [Int : Int] = [:]
    for (idx, num) in nums.enumerated() {
        if let otherIdx = cacheMap[target - num] {
            return [otherIdx, idx]
        }else {
            cacheMap[num] = idx
        }
    }
    return []
}

twoSum([1,2,3,4,5,6,7,8,9,2], 4)


