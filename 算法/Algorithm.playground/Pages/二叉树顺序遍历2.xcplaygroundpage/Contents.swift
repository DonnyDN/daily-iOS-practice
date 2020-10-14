
/**
 给你一棵二叉树，请按层输出其的节点值，即：按从上到下，从左到右的顺序，例如，如果给你如下一棵二叉树：
 3
 / \
 9  20
 /  \
 15   7
 
 输出结果：
 [
 [3],
 [9,20],
 [15,7]
 ]
 
 1.判断输入参数是否是为空。
 2.将根节点加入到队列 level 中。
 3.如果 level 不为空，则：
 将 level 加入到结果 ans 中。
 遍历 level 的左子节点和右子节点，将其加入到 nextLevel 中。
 将 nextLevel 赋值给 level，重复第 3 步的判断。
 4.将 ans 中的节点换成节点的值，返回结果。
 
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

func levelOrder(_ root: TreeNode?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var result = [[TreeNode]]()
    var level = [TreeNode]()
    
    level.append(root)
    
    while level.count != 0 {
        result.append(level)
        var nextLevel = [TreeNode]()
        for node in level {
            if let leftNode = node.left {
                nextLevel.append(leftNode)
            }
            if let rightNode = node.right {
                nextLevel.append(rightNode)
            }
        }
        level = nextLevel
    }
    let ans = result.map { $0.map { $0.val }}
    return ans
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

levelOrder(node)




