## mpviewer.yazi  

Preview media (image|audio|vidwo) file in specific env (`sway`+`tmux`) base on `mpv`.  
It needs to be toggled manually, not start automatically.  
The previewed media can be `seek bw|fw` & `zoom in|out` by setting the key.  
**(Plugin contains shell scripts. Scripts have risks, use with caution.)**  


预览多媒体文件基于`mpv`在特定环境(`sway`+`tmux`)。  
需要手动开启不会自动启动。预览文件可以快进快退和放大缩小。  
**(插件包含执行脚本，脚本有风险，使用需谨慎使用。)**  

----  

### 📦 Installation 安装  

The path of the actual config file should be modified according to your own app.  
The following config file path base on `Arch Linux`.  

实际的配置文件的路径应该根据你自己的应用进行修改。  
以下的配置文件的路经基于`Arch Linux`。  

#### Install beforehand 前置安装  

```sh  
sudo pacman -S mpv  
```  

#### Install with package manager 包管理器安装  

```sh  
ya pack -a ovwxxwvo/mpviewer.yazi  
```  

#### Install manually 手动安装  

Clone the repo to your yazi config dir :  
```sh  
cd ~/.config/yazi/plugins/  
git clone https://github.com/ovwxxwvo/mpviewer.yazi.git  
```  

----  

### 🛠️ Configuration 配置  

Add this line to your `sway` config file `~/.config/sway/config` :  
```config  
# set `mpv` window that title contain "mpv-pts" to floating mode & hide in scratchpad  
set $appid mpviewer  
for_window [app_id="$appid"] floating enable  
for_window [app_id="$appid"] move scratchpad  
```  

Add this line to your `yazi` config file `~/.config/yazi/yazi.toml` :  
```toml  
[plugin]  
# set specific media file to be previewed by mpviewer  
previewers = [  

  # image  
  	{ name = "*.jpg",  run = "mpviewer" },  
  	{ name = "*.png",  run = "mpviewer" },  
  	{ name = "*.gif",  run = "mpviewer" },  
  	{ name = "*.bmp",  run = "mpviewer" },  
  	{ name = "*.tif",  run = "mpviewer" },  
  	{ name = "*.tiff", run = "mpviewer" },  

  # audio  
  	{ name = "*.mp3",  run = "mpviewer" },  
  	{ name = "*.m4a",  run = "mpviewer" },  
  	{ name = "*.aac",  run = "mpviewer" },  
  	{ name = "*.ogg",  run = "mpviewer" },  
  	{ name = "*.wav",  run = "mpviewer" },  
  	{ name = "*.flac", run = "mpviewer" },  

  # video  
  	{ name = "*.mp4",  run = "mpviewer" },  
  	{ name = "*.m4v",  run = "mpviewer" },  
  	{ name = "*.mkv",  run = "mpviewer" },  
  	{ name = "*.flv",  run = "mpviewer" },  
  	{ name = "*.avi",  run = "mpviewer" },  
  	{ name = "*.webm", run = "mpviewer" },  

  ]  
```  

Add this line to your `yazi` config file `~/.config/yazi/keymap.toml` :  
```toml  
[manager]  
keymap = [  
# toggle mpserver on|off  
  { on = [ "t","t" ], run = "plugin --sync mpviewer --args=server"     , desc = "toggle mpv server"  },  
# seek media(audio|video) bw|fw  
  { on = "<S-Left>" , run = "plugin --sync mpviewer --args='seek -5'"  , desc = "seek bw in preview" },  
  { on = "<S-Right>", run = "plugin --sync mpviewer --args='seek +5'"  , desc = "seek fw in preview" },  
# zoom media(image) in|out  
  { on = "<S-Up>"   , run = "plugin --sync mpviewer --args='zoom +0.1'", desc = "zoom in in preview" },  
  { on = "<S-Down>" , run = "plugin --sync mpviewer --args='zoom -0.1'", desc = "zoom ot in preview" },  
# rewrite smart-enter that stop playback when open a media file  
  { on = "<Enter>"  , run = "plugin --sync mpviewer --args=enter"      , desc = "open file" },  
  ]  
```  

----  

### 📚 Suggestion 建议  

Your app, Your rule. Feel free to modify the files.  
Doing this trick using `mpv` because `ueberzugpp` does not work on the env `sway`.  
I thought about this in the early days, but no motivation to implement it.  
& also inspired by 2 bili up ( unixchad & 帕特里柯基 ) recently.  
The plugin still in test.  


你的应用，你说了算。不要害怕修改文件。做这个源于原生不可用。  
早期想过这个，但没有动力去实现它，最近也受2个B站UP主的启发。  

---  

### 📜 [MIT](LICENSE) License 许可证  


