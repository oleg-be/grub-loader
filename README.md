# GRUB Loader Setup

Use the setup script to install GRUB and configure a theme. The script will
automatically install required packages using your system's package manager
(`pacman`, `apt`, or `dnf`):

```bash
sudo ./setup_grub.sh
```

The script installs required packages, lets you select a theme from the
`themes/` directory and generates `grub.cfg` automatically.

## Themes

Available themes are stored under the `themes/` directory:

- `dark`
- `light`

You will be prompted to choose one of these themes when the script runs.

## Usage

Run the setup script with root privileges:

```bash
sudo ./setup_grub.sh
```

Follow the prompts to install packages and select a theme.

