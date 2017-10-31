# WechatTimeLine
实现微信朋友圈功能，为后续需要学习研究的人提供了一些思路，和我面对朋友圈项目中遇到问题时的一些解决方法

![image](https://github.com/sishenyihuba/WechatTimeLine/blob/master/WeChatSheet.gif)

**WechatTimeLine** 是一个使用OC编写的小Demo.实现了朋友圈功能，具体包括了：

- 朋友圈状态展示，使用Masonry代码布局库完成UI的布局，使用HYBMasonryAutoCellHeight自动计算Cell的高度。 
- 因为之前的微博项目是使用Swift+StoryBoard+AutoLayout实现的，这个微信朋友圈项目使用代码布局，上面两个库在代码自动布局中简直是神库。
- 九宫格图片展示+ 图片Browser，实现了类似Keynote中的神奇移动效果。
- 展开和收缩朋友圈内容功能。
- 点赞和取消点赞。
- 评论功能。  使用第三方键盘ChatKeyBoard，实现了表情功能发送和键盘弹起到Cell最后一条评论处的功能。
- 删除自己的评论+回复他人的评论。
- 点赞和评论中的人名点击事件，使用支持Link高亮显示的第三方库MLLabel

**PS**：朋友圈中所有数据为本地JSON，其中图片地址是七牛服务器保存的图片Url。

## Contribute
We welcome any contributions. If u have any issue ,please let me know. -- my Email address is sishenyihubaba@gmail.com
 
## License
This demo is available under the MIT license. See the LICENSE file for more info.
