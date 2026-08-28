# kopus

A customized Android terminal app, forked from Termux (v0.99), that connects to your Mac over SSH. Built in the cloud on GitHub Actions; install the APK by sideloading.

## What kopus adds

- **Pages** — swipe left/right to switch between live terminal sessions, each labeled by its current directory on the Mac. `+` opens a new page.
- **Done signal** — when an opencode job finishes, the Mac emits a terminal bell (BEL) over the SSH session; kopus hears it and plays a relaxing chime.
- **Notification** — if the app isn't on screen, the Mac sends a push (ntfy.sh) instead; tapping it opens the page where the job ran. A foreground service keeps the SSH session (and the job) alive in the background.
- **Recent sessions screen** — on launch, lists your recent opencode sessions from the Mac; tap to resume. Also offers a "connect to Mac" form (passwordless, via the phone's SSH key) and a plain terminal.

Everything else is stock Termux. Configuration is done by typing normal commands — there is no settings screen for kopus features (see `docs/adr/0001-config-is-commands-not-settings.md`).

## Mac setup (one time)

1. Enable Remote Login: System Settings → General → Sharing → Remote Login.
2. Install the done-signal plugin:
   ```sh
   cd mac-setup && ./install.sh
   ```
   It copies the opencode `session.idle` → BEL plugin to `~/.config/opencode/plugins/`.
3. (If the TUI swallows the bell) use the wrapper fallback printed by the script.

## First connect from the phone

1. Install the kopus APK (see below) and open it.
2. On the launch screen choose **connect to Mac**, type your Mac's address (IP or `name.local`) and username.
3. First use: kopus generates an SSH keypair and shows the public key — tap to copy, then add it to `~/.ssh/authorized_keys` on the Mac once.
4. After that, connections are passwordless.

## Building the APK

Builds run on GitHub Actions (free) so no Android toolchain is needed on your Mac.

1. Push to `main` — or use **Actions → Build APK → Run workflow** for a manual build.
2. When the workflow finishes, open the run, download the **kopus-apk** artifact, and sideload the APK onto your phone (allow installs from unknown sources).

### Signing

The release APK is signed with a keystore stored as GitHub secrets. To set this up once:

```sh
keytool -genkeypair -v -keystore kopus-keystore.jks -alias kopus -keyalg RSA \
  -keysize 2048 -validity 10000
```

Then add to GitHub repo **Settings → Secrets and variables → Actions**:

| Secret | Value |
|---|---|
| `KOPUS_KEYSTORE` | base64 of the keystore: `base64 -i kopus-keystore.jks` |
| `KOPUS_KEYSTORE_PASSWORD` | keystore password |
| `KOPUS_KEY_ALIAS` | `kopus` |
| `KOPUS_KEY_PASSWORD` | key password |

Keep `kopus-keystore.jks` safe — it signs every update.

## Repository layout

- `app/`, `terminal-emulator/`, `terminal-view/` — forked Termux source (kept intact; kopus features are additive patches).
- `.github/workflows/build.yml` — cloud build pipeline.
- `mac-setup/` — the Mac-side done-signal plugin + installer.
- `docs/adr/` — architecture decisions.
- `CONTEXT.md` — domain glossary.

## License

GPL v3 (inherited from Termux). The forked source is public, satisfying the GPL obligation for distributed APKs.