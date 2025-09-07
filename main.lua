--- @sync entry

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

function M:entry(job)
  -- print('----')
  local func = job.args[1]
  local unit = job.args[2]
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

function M:peek(job)
	local start = os.clock()
	ya.sleep(math.max(0, rt.preview.image_delay / 1000 + start - os.clock()))
  -- print('----')

  local u = job.file.url
  local a = job.area
  local rmverr = " 2>/dev/null "

  local script = " ~/.config/yazi/plugins/mpviewer.yazi/exif_show.sh "
  local paramt = ' "'..u..'" '
  local cmd    = script..paramt..rmverr
  local info = io.popen(cmd):read("*a")
	local text = ui.Text.parse(info)
	ya.preview_widgets(job, { text:area(job.area) })

  local script = " ~/.config/yazi/plugins/mpviewer.yazi/mpv_play.sh "
  local paramt = ' "'..u..'" '..a.x..' '..a.y..' '..a.w..' '..a.h..' '
  local cmd    = script..paramt..rmverr
  local state = io.popen(cmd):read("*a")

  -- os.execute()
  end


return M


