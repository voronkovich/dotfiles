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

## Troubleshooting

### iMac 2017 21.5-inch 4K + Ubuntu 26.04

Fix brightness:

```sh
sudo systemctl mask iio-sensor-proxy.service
```

Fix sound:

- [davidjo/snd_hda_macbookpro](https://github.com/davidjo/snd_hda_macbookpro)

## License

Copyright (c) Voronkovich Oleg. Distributed under the MIT.
