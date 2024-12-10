-- YAZI lua,
-- Maintainer:  Jessee Chan <CYPHER0@foxmail.com>
-- Last Change: 2024.11.14


local mpserver = '~/.config/yazi/plugins/mpviewer.yazi/'

local function server()
  local file  = mpserver..'mpserver.sh'
  local cmd   = file
  local state = io.popen(cmd):read("*a")

  ya.notify {
    title   = "mpserver",
    content = state,
    timeout = 2.0,
    }

  end

local function seek(func,unit)
  local file  = mpserver..'mpv_util.sh '
  local cmd   = file..func..' '..unit
  local state = io.popen(cmd):read("*a")
  -- os.execute(cmd)
  end

local function zoom(func,unit)
  local file  = mpserver..'mpv_util.sh '
  local cmd   = file..func..' '..unit
  local state = io.popen(cmd):read("*a")
  -- os.execute(cmd)
  end

local	function enter (func)
  local h = cx.active.current.hovered
  ya.manager_emit(h and h.cha.is_dir and "enter" or "open", { hovered = true })

  local file  = mpserver..'mpv_util.sh '
  local cmd   = file..func
  local state = os.execute( cmd )

  end


local M = { }

function M:entry(args)
  -- print('----')
  local func = args[1]
  local unit = args[2]
  if func == "server" then
    server()
  elseif func == "seek" then
    seek(func,unit)
  elseif func == "zoom" then
    zoom(func,unit)
  elseif func == "enter" then
    enter(func)
  end
  end

function M:peek()
	-- local url = ya.file_cache(self)
	-- if not url or not fs.cha(url) then url = self.file.url end
    ww = self.window.width
    wh = self.window.height
    wc = self.window.cols
    wr = self.window.rows
    ax = self.area.x
    ay = self.area.y
    aw = self.area.w
    ah = self.area.h

  u = self.file.url
  x = math.floor( (ax+1.0) * ww / wc )
  y = math.floor( (ay+0.2) * wh / wr )
  w = math.floor( (aw-0.2) * ww / wc )
  h = math.floor( (ah-0.2) * wh / wr )

  script = " ~/.config/yazi/plugins/mpviewer.yazi/mpv_play.sh "
  paramt = ' "'..u..'" '..x..' '..y..' '..w..' '..h..' '
  cmd    = script..paramt
  -- print(paramt)

  local state = io.popen(cmd):read("*a")
  -- os.execute(cmd)
  -- os.execute("echo 'hello'")

  end

return M


