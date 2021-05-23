### Usage

##### land-g7 -> iLand
> **注意** 
> land-g7不支持三维圈地，因此设定领地高度y轴为0-255 <br>
> 为了避免某些麻烦（其实是没啥需求）原land-g7的领地好友数据将被丢弃
 - 将`player.json`重命名为`landg7-player.json`放到`input-data`目录下。
 - 确保您安装了Lua解释器
 ```
 lua land-g7.lua
 ```
  - 将在`output-data`目录下生成`owners.json`和`data.json`，复制到iland数据文件目录下覆盖即可

##### pland -> iLand
> 参考land-g7，但pland可以保留更多配置
 - 将`land.json`重命名为`pland.json`放到`input-data`目录下。
 - 确保您安装了Lua解释器
 ```
 lua pland.lua
 ```

##### BDXLand -> iLand
