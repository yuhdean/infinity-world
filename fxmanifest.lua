fx_version 'cerulean'
game 'gta5'

author 'Infinity Development'
description 'Time and Weather Control'
version '2.0.2'
lua54 'yes'

shared_script '@ox_lib/init.lua'

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'ox_lib'
}
