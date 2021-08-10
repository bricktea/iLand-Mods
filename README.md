# iLand Data Converter
这些工具是iLand的衍生插件，为了方便部分用户更换领地插件又不方便让玩家全部重新圈地所开发的转换工具。
> ⛔ **这些转换插件均由用户提出需求才开发，iLand开发者并无兴趣竞争，不要再私聊我了。**

## Supported
数据类型 | 转换情况 | 转换器
-|-|-
pland | ✔️坐标、权限、好友数据 ❌并不全面 | pland.js
pfland | ✔️坐标 ❌并不全面 | pfland.js
land-g7 | ✔️坐标、权限 ❌好友数据 | land-g7.js

## Universal Usage
> ℹ️ 新的转换器不需要安装单独的解释器并使用ILAPI进行转换，兼容性更好。

 - **必须安装：** LiteXLoader、iLand
 - 将对应的转换器下载并当作插件加载

转换器 | 将原数据文件重命名为 | 放入 | 开服后运行命令
-|-|-|-
pland | `pland.json` | `land-data` | `land conv pland`
pfland | `pfland.json` | `land-data` | `land conv pfland`
land-g7 | `land-g7.json` | `land-data` | `land conv landg7`
 - **最后** 文件中包含的领地将被添加到当前数据文件中
