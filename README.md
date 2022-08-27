# 世界语输入方案

用原字母 + <kbd>x</kbd> 输入六个带帽字母 ĉĝĥĵŝŭ。

相比于 dekvar (Darcy Shen: sadhen@zoho.com) 和 arsenali 的[原版](https://github.com/arsenali/rime-esperanto)有以下区别：

- 现在方案通过将候选项中的 cghjsu + x 替换为 ĉĝĥĵŝŭd 的方法，避免了原方案 cghjsu 结尾需要打空格时，需要按两次空格的问题
- 通过 lua 脚本的方式实现更好的自定义
- 添加词库

![Preview](./preview.gif)


## ~~安装~~

~~由于东风破不能修改 `rime.lua` 文件，所以只能手动安装~~

1. 将 `lua` 文件夹和 `esperanto.schema.yaml` 文件放入用户文件

2. 在 `default.custom.yaml` 中启用

```diff
...
patch:
  schema_list:
    - schema: flypy
    - schema: japanese
+    - schema: esperanto
...
```

3. 在 `rime.lua` 中添加代码:

```diff
+esperanto = require("esperanto")
+epo_translator = esperanto.epo_translator
+epo_append_blank_filter = esperanto.epo_append_blank_filter
```

<br>