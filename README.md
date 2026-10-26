# dotfiles

My dotfiles.

## Installation

1. Install required tools:

   ```sh
   sudo apt install -y curl git yadm
   ```

2. Clone this repository using [yadm](https://yadm.io):

   ```sh
   yadm clone git@github.com:voronkovich/dotfiles.git
   ```

3. Install [mise](https://www.zsh.org):

   ```sh
   curl -fsSL https://mise.run | sh
   ```

4. Run bootstrap:

   ```sh
   mise bootstrap
   ```

## License

Copyright (c) Voronkovich Oleg. Distributed under the MIT.
