# GRUB Loader Setup

Use the setup script to install GRUB and configure a theme:

```bash
sudo ./setup_grub.sh
```

The script installs required packages, lets you select a theme from the `themes/` directory and generates `grub.cfg` automatically. Three simple themes are provided:

* `themes/default`
* `themes/dark`
* `themes/light`

Each theme folder includes a `theme.txt` file that the script copies to
`/boot/grub/themes/`. You can add your own themes by creating additional folders
inside `themes/`.
