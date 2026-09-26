# KDE settings on Kubuntu

chezmoi manages reusable KDE preferences in `home/dot_config/`:

- `kdeglobals`: KDE application preferences and icon theme.
- `kglobalshortcutsrc`: global shortcuts, including Meta+Space for KRunner.
- `kwinrc`: window behavior and KWin Night Color (currently constant 3000 K).
- `krunnerrc`: KRunner preferences.

The Plasma 5 desktop layout file (`plasma-org.kde.plasma.desktop-appletsrc`) is intentionally ignored by chezmoi. It contains panel, widget, and screen-layout state that should be rebuilt for Plasma 6. A snapshot of the old layout is in `ubuntu_backup/config-snapshots/current-machine/` for reference only.

## First login on Kubuntu / Plasma 6

1. Install Kubuntu, sign in to Dropbox, and wait for `ubuntu_backup` to sync.
2. Run `chezmoi init --apply hibiki-kato` (or `chezmoi apply` if already initialized).
3. Add panels/widgets and arrange displays in System Settings. Do not restore the old Plasma 5 applet layout wholesale.
4. Check System Settings > Keyboard > Shortcuts. Meta/Super alone should open the application launcher; Meta+W opens Overview and Meta+Space opens KRunner. If the launcher shortcut is unset, assign Meta in the Application Launcher widget's shortcut settings.
5. Set Fcitx5 as the virtual keyboard, then set Ctrl+Space in Fcitx5 Configuration as the input-method toggle. Set Caps Lock to Left Ctrl under System Settings > Keyboard > Advanced > Ctrl position.
6. Check System Settings > Display & Monitor > Night Color. KWin's Night Color is the color-temperature control; Redshift settings are not migrated or installed.
7. If the icon theme configured in `kdeglobals` is missing, restore the bundled theme:

   ```sh
   mkdir -p ~/.local/share/icons
   cp -a ~/Dropbox/ubuntu_backup/kde-assets/icons/Mkos-Big-Sur-Panel-white ~/.local/share/icons/
   ```

Plasma version changes can rename or remove individual shortcut actions. Review them once after applying and adjust in System Settings if Plasma 6 does not recognize an action.
