# Fivem Anticheat

This anticheat can detect more cheat in server.

Also if cheater change steam or ... , Anticheat detect new data of cheater and add to database

Developed by [Erfan Ebrahimi](http://erfanebrahimi.ir)

[Support Discord](https://discord.gg/2rZBFXhGGQ)

### Detected Cheats
- Explosions
- Events
- Object and peds spawn
- Chat box cheats
- Detect start or stop resource
- Detect client side cheats like super jump or godmode ....
- Auto screen shot from doubtful player

### Requirements
* If You want to get screen shot from player page, you should have :
	* [screenshot-basic](https://github.com/citizenfx/screenshot-basic)
	* [discord-screenshot](https://github.com/jaimeadf/discord-screenshot) 

## Download & Installation

### Using Git
```
cd resources
git clone https://github.com/yeganehha/anticheat [anticheat]/anticheat
```

### Manually
- Download https://github.com/yeganehha/anticheat/archive/master.zip
- Put it in the resource directory


## Installation
- Add this to end of `server.cfg` file:

```
add_principal identifier.steam:xxxxxxxxxx group.anticheatOwner
add_ace group.anticheatOwner anticheat.unban allow
add_ace group.anticheatOwner anticheat.ShowBans allow
add_ace group.anticheatOwner anticheat.undetect allow
start anticheat
```
change `xxxxxxxxxx` to your steam hex to access manage gangs 

- Please modify all files in `config` folder

- Restart your Fivem Server


## commands
- `/erfban [Player Id]` ban permanet player

- `/erfunban [Ban Id]` unban player

- `/erfbaninfo [Ban Id]` show ban information of cheater


### Thank you for contributing to the progress and well-being of the project 🖤


# Legal
### License
anticheat - Fivem Anticheat

Copyright (C) 2021-2021 Erfan Ebrahimi

This program Is free software: you can redistribute it And/Or modify it under the terms Of the GNU General Public License As published by the Free Software Foundation, either version 3 Of the License, Or (at your option) any later version.

This program Is distributed In the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty Of MERCHANTABILITY Or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License For more details.

You should have received a copy Of the GNU General Public License along with this program. If Not, see http://www.gnu.org/licenses/.
