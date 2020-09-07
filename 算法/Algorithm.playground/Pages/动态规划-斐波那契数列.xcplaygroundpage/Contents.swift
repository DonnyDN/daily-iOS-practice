//: [Previous](@previous)

import Foundation

/**
 写一个函数，输入 n ，求斐波那契（Fibonacci）数列的第 n 项。斐波那契数列的定义如下：

 F(0) = 0,   F(1) = 1
 F(N) = F(N - 1) + F(N - 2), 其中 N > 1.
 斐波那契数列由 0 和 1 开始，之后的斐波那契数就是由之前的两数相加而得出。

 答案需要取模 1e9+7（1000000007），如计算初始结果为：1000000008，请返回 1。

 解法：
 1.递归法：
 原理： 把 f(n)f(n) 问题的计算拆分成 f(n-1)f(n−1) 和 f(n-2)f(n−2) 两个子问题的计算，并递归，以 f(0)f(0) 和 f(1)f(1) 为终止条件。
 缺点： 大量重复的递归计算，例如 f(n)f(n) 和 f(n - 1)f(n−1) 两者向下递归需要 各自计算 f(n - 2)f(n−2) 的值。
 
 2.记忆化递归法：
 原理： 在递归法的基础上，新建一个长度为 nn 的数组，用于在递归时存储 f(0)f(0) 至 f(n)f(n) 的数字值，重复遇到某数字则直接从数组取用，避免了重复的递归计算。
 缺点： 记忆化存储需要使用 O(N)O(N) 的额外空间。
 
 3.动态规划：
 原理： 以斐波那契数列性质 f(n + 1) = f(n) + f(n - 1)f(n+1)=f(n)+f(n−1) 为转移方程。
 从计算效率、空间复杂度上看，动态规划是本题的最佳解法。

 0,1,1,2,3,5,8,13,21,34..
 */


//动态规划
//时间复杂度 O(N)O(N) ： 计算 f(n)f(n) 需循环 nn 次，每轮循环内计算操作使用 O(1)O(1) 。
//空间复杂度 O(1)O(1) ： 几个标志变量使用常数大小的额外空间。

func fib(_ n: Int) -> Int {
    var a = 0, b = 1, sum = 1
    for _ in 0..<n {
        sum = (a + b)
        a = b
        b = sum
    }
    return a
}

fib(5)


/**
 其他例子：
 青蛙跳台阶：
 一只青蛙一次可以跳上1级台阶，也可以跳上2级台阶。求该青蛙跳上一个 n 级的台阶总共有多少种跳法。
 
 */


 

