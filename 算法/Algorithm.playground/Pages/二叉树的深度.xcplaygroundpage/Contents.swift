//链接：https://leetcode-cn.com/problems/er-cha-shu-de-shen-du-lcof

import Foundation

/**
 输入一棵二叉树的根节点，求该树的深度。从根节点到叶节点依次经过的节点（含根、叶节点）形成树的一条路径，最长路径的长度为树的深度。

 例如：给定二叉树 [3,9,20,null,null,15,7]，
 
     3
    / \
   9  20
     /  \
    15   7
 返回它的最大深度 3 。
 

 解法：
 
 方法1.树的后序遍历（DFS），递归思路如下：
 此树的深度和其左（右）子树的深度之间的关系（整个树的深度 = 左右子树的最大深度 +1）
 时间复杂度O(n)
 空间复杂度O(n)
 
 方法2：层序遍历（BFS），队列思路如下：
 每遍历一层，则计数器 +1+1 ，直到遍历完成，则可得到树的深度
 时间复杂度O(n)
 空间复杂度O(n)
 */


/** 二叉树遍历经验总结
 树的遍历方式总体分为两类：深度优先搜索（DFS）、广度优先搜索（BFS）；

 常见的 DFS ： 先序遍历、中序遍历、后序遍历（深度优先搜索往往利用 递归 或 栈 实现）
 常见的 BFS ： 层序遍历（即按层遍历，广度优先搜索往往利用 队列 实现）
 
 求树的深度需要遍历树的所有节点。
 */



class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


//DFS（递归）
func maxDepth(_ root: TreeNode?) -> Int {
    guard (root != nil) else {
        return 0
    }
    return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
}

//BFS (使用一个队列，一个暂存队列)
func maxDepth1(_ root: TreeNode?) -> Int {
    guard (root != nil) else {
        return 0
    }
    var queue : [TreeNode] = []
    queue.append(root!)
    
    var tmp : [TreeNode] = []
    var res = 0
    while queue.isEmpty == false {
        tmp.removeAll()
        for node in queue {
            if let left = node.left {
                tmp.append(left)
            }
            if let right = node.right {
                tmp.append(right)
            }
        }
        queue = tmp
        res += 1
    }
    return res
}


//BFS （使用一个队列）
func maxDepth2(_ root: TreeNode?) -> Int {
    guard (root != nil) else {
        return 0
    }
    var queue : [TreeNode] = []
    queue.append(root!)
    
    var res = 0
    while queue.isEmpty == false {
        res += 1
        for _ in 0..<queue.count {
            let node : TreeNode = queue.removeFirst()
            if let left = node.left {
                queue.append(left)
            }
            if let right = node.right {
                queue.append(right)
            }
        }
    }
    return res
}


let node:TreeNode = TreeNode.init(3)
let node1:TreeNode = TreeNode.init(9)
let node2:TreeNode = TreeNode.init(20)
let node3:TreeNode = TreeNode.init(15)
let node4:TreeNode = TreeNode.init(7)
node.left = node1
node.right = node2
node2.left = node3
node2.right = node4

maxDepth(node)

maxDepth1(node)

maxDepth2(node)




