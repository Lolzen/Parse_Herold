Parse_Herold
============

A script to parse certain fields from www.herold.at to an excel file

Uses Lua and luasocket libraries

TODO: 
* finish script
* eliminate eventual bugs
* do some cleanup in the code


INSTALL & Usage:
----
[Windows]
* Install Lua for Windows https://code.google.com/p/luaforwindows/downloads/
* Download Parse_Herold.lua from this repository
* Open the downloaded file with LCSI (rightclick -> open with Lua Console Standalone Interpreter)

[Linux] (No functionality yet)
* Install latest Lua and luasocket librarieas with your Package Manager
* * Download Parse_Herold.lua from this repository or type in your terminal emulator [b]git clone https://github.com/Lolzen/Parse_Herold.git[/b] and copy the file to ~ (/home/yourusername/)
* type in your terminal emulator [b]lua Parse_Herold.lua[/b]

How does this script work?
----
Once you execute the file and start it with the [b]fetch[/b] command, it will lookup the hardcoded places and branch tables on www.herold.at, then fetch the results and lookup the result's fields.

Like this:
* go to branch/place url
* look if we got redirected or got actual results
* if we didn't get redirected, go to every resulturl and gather [name] [address] [postalcode] [place] [phnenumber] [mobilenumber] [email] and [website].
* (NOT YET IMPLEMETED) Write the results to an excel file