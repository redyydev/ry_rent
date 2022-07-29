fx_version 'adamant'
game 'gta5'

author 'Redyy'
version '1.0'

ui_page {'html/index.html'}

client_script {
    'config.lua',
    'client/main.lua',
    'functions/main.lua',
    'functions/events.lua',
}
server_script {'config.lua', 'server/main.lua'}

files {'html/index.html','html/js/*.js','html/css/*.css', 'html/assets/*.png', 'html/assets/*.jpg'}
