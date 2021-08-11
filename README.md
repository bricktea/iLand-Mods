# iLand Data Converter
这些工具是iLand的衍生插件，为了方便部分用户更换领地插件又不方便让玩家全部重新圈地所开发的转换工具。
> ⛔ **这些转换插件均由用户提出需求才开发，并无兴趣参与什么竞争，不要再私聊我了。**

## Supported
数据类型 | 转换情况
-|-|-
pland | ✔️大部分数据 ❌丢弃UseItem控制项 
pfland | ✔️大部分数据 ❌存在丢弃
land-g7 | 请先用pland转换后，再使用本工具转换pland数据

## Universal Usage
> ℹ️ 新的转换器不需要安装单独的解释器并使用ILAPI进行转换，兼容性更好。

 - **必须安装：** LiteXLoader、iLand
 - 将对应的转换器下载并当作插件加载

转换器 | 将原数据文件重命名为 | 放入 | 开服后运行命令
-|-|-|-
pland | `pland.json` | `land-data` | `iconv pland`
pfland | `pfland.json` | `land-data` | `iconv pfland`
 - **最后** 文件中包含的领地将被添加到当前数据文件中
