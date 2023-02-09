# %grout
A bot to access simple groups-related utilities directly in a groups chat.
Inspired by [%gato](https://github.com/midsum-salrux/gato/) by ~midsum-salrux.

## Installation
1. Clone this repo.
2. Boot up a ship (fakezod or moon or whatever you use).
4. `|new-desk %grout` to create a new desk called `%clibox.
5. `|mount %grout` to access the `%grout` desk from the unix command line.
6. At the unix command line `rm -rf [ship-name]/grout/*` to empty out the contents of the desk.
7. `cp -r grout/* [ship-name]/grout` to copy the contents of this repo into your new desk.
8. At the dojo command line `|commit %grout`.
9. Install with `|install our %grout`.

## WARNING:
Messy and experimental. Commands subject to change.

## Commands

| command | description |
| ------- | ----------- |
| `;xpals` | extract group members as pals tagged with group name |
| `;portal` or `;portal 3` (`;portal @ud<=10`) | post links to the nearest groups ranked by jaccard index of group membership |
| ... | ... |
