# %grout
A bot to access simple groups-related utilities directly in a groups chat.
Inspired by [%gato](https://github.com/midsum-salrux/gato/) by ~midsum-salrux.

## WARNING:
Messy and experimental. Commands subject to change. I expect to make a big mess while generating initial commands and then to hopefully extract some order out of the resulting chaos. I'm going to try to get this to work with [`%surf`](https://github.com/niblyx-malnus/surf) since much of the groups utils I want to build involve fine-grained control over nagivation.

## Installation
1. Clone this repo.
2. Boot up a ship (fakezod or moon or whatever you use).
4. `|new-desk %grout` to create a new desk called `%clibox.
5. `|mount %grout` to access the `%grout` desk from the unix command line.
6. At the unix command line `rm -rf [ship-name]/grout/*` to empty out the contents of the desk.
7. `cp -r grout/* [ship-name]/grout` to copy the contents of this repo into your new desk.
8. At the dojo command line `|commit %grout`.
9. Install with `|install our %grout`.

Or `|install ~dister-dozzod-niblyx-malnus %grout` for regular updates.

## Commands

| command | description |
| ------- | ----------- |
| `!` prefix instead of `;` | self-destruct in `~s10` |
| `;xpals` | extract group members as pals tagged with group name |
| `;portal` or `;portal 3` (`;portal @ud<=10`) | post links to the nearest groups ranked by jaccard index of recent posters in each group |
| `;lurn` | portal to groups with latest unread messages (for you) |
| `;moun` | portal to groups with most unread messages (for you) |
| ... | ... |
