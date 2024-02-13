# dotfiles

My dotfiles.

## Installation

1. Install [yadm](https://thelocehiliosan.github.io/yadm/);

   ```sh
   sudo apt install -y git yadm
   ```

2. Clone this repository:

   ```sh
   yadm clone git@github.com:voronkovich/dotfiles.git
   ```

3. Install [zsh](https://www.zsh.org/) and [tmux](https://github.com/tmux/tmux)

   ```sh
   sudo apt install zsh tmux
   ```

4. Make tmux default shell

   ```sh
   chsh -s "$(which tmux)"
   ```

## Utilities

```sh
sudo apt install curl htop bat ripgrep fzy
```

## License

Copyright (c) Voronkovich Oleg. Distributed under the MIT.
