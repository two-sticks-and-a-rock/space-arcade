# space-arcade
Pilot a spaceship in a 2D bullet heaven

# Setup for Development

## Download the Godot Game Engine
This project is written in **GDScript** using **Godot 4**. 
~~Our latest build used [Godot 4.7.2-stable](https://godotengine.org/download/archive/4.7.2-stable/).~~ (we do not currently have a build @ToyaDR keep this updated)

Places to download Godot:
- [Official Godot site](https://godotengine.itch.io/godot)
- [itch.io](https://godotengine.itch.io/godot)
- [Steam](https://store.steampowered.com/app/404790/Godot_Engine/?curator_clanid=41324400)
- [Epic Games](https://store.epicgames.com/p/godot-engine)

## Get the actual project

### Option A) Download Github Desktop
TODO: @ToyaDR go through setup with Github Desktop

For setup instructions via Github CLI, go [here](#option-b-download-github-cli)

### Option B) Download Github CLI
For setup instructions via Github Desktop (which has a GUI), go [here](#option-a-download-github-desktop).

**1. Download Github CLI**

[See Github's installation documentation](https://github.com/cli/cli?ref_product=cli&ref_type=engagement&ref_style=text#installation)

**2. Log in via Github CLI**

```
gh auth login
```

See [Github CLI's Quickstart guide](https://docs.github.com/en/github-cli/github-cli/quickstart) if you run into any issues.

**3. Clone the repo**

Choose one of the following commands
```
// Github CLI (might as well use this one since you downloaded the CLI anyways)
gh repo clone two-sticks-and-a-rock/space-arcade 

/** 
 * The remaining two will depend on whether you chose 
 * HTTPS or SSH while logging in via Github CLI 
 * If you chose HTTPS then use the HTTPS command
 * If you chose SSH then use the SSH command
 **/

// HTTPS
git clone https://github.com/two-sticks-and-a-rock/space-arcade.git

// SSH
git clone git@github.com:two-sticks-and-a-rock/space-arcade.git
```
