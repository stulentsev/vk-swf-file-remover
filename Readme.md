## Usage

This little script will help you get rid of all those numerous additional SWF files that you had uploaded to VK. 

### First things first

You will need ruby interpreter. This is a good place to start: http://www.ruby-lang.org/en/downloads/

### Customize your script

In the beginning of the file you'll see some constants. 

	APP_ID = YOUR_APP_ID
	COOKIE = YOUR_AUTH_COOKIE
	
	USE_PROXY = false
	
	
	proxy_addr = 'localhost'
	proxy_port = 8888

These are self-explanatory, I guess. You must provide APP_ID (to which SWFs belong) and your VK cookie. Optionally, you may want to use a proxy.

### Let's nuke'em!

	ruby remove_swf_files.rb
	
This is as simple as that. If you see some cryptic output like this:

	5020<!>apps.css,apps.js<!>0<!>4500<!>0<!>???? ??????? ??????.
	5020<!>apps.css,apps.js<!>0<!>4500<!>0<!>???? ??????? ??????.
	5020<!>apps.css,apps.js<!>0<!>4500<!>0<!>???? ??????? ??????.

then things worked out fine. Reload your admin page and rejoice!