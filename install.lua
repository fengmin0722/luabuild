--- Lake script to install script wrappers in bin
local exec, join = utils.execute, path.join
if WINDOWS then
    bat_ext, all_args, shebang = '.bat',' %*', '@echo off\n'
else
    bat_ext, all_args, shebang = '',' $*','#!/bin/sh\n'
end

local function bin_dir(f) return join('bin',f) end

local function make_wrapper(target,exe,name)
    if not name then
        local _
        _, name = path.splitpath(target)
        name = path.splitext(name)
    end
    target = path.abs(target)
    exe = exe or 'lua52'
    exe = path.abs(bin_dir(exe))
    local wrap = bin_dir (name)..bat_ext
    file.write(wrap,shebang..exe..' '..target..all_args..'\n')
    if not WINDOWS then
        exec('chmod +x '..wrap)
    end
end

make_wrapper ('tools/soar.lua',nil,'soar52')
make_wrapper ('tools/srlua.lua','lake')
make_wrapper 'lake'

