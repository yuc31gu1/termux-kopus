# Android Terminal (Termux fork)

A customized Android terminal app named **kopus**, forked from Termux (native app, not React Native/Expo), that connects to the user's Mac over SSH. The APK is built in the cloud (GitHub Actions, public repo) so no Android toolchain lives on the Mac, and installed by sideloading. The fork keeps all of Termux; the app's features are additive patches. Configurable to the user's preferences. Built with opencode.

## Language

**The app**:
A customized fork of Termux for Android. The thing the user installs and opens.
_Avoid_: app file, terminal app

**The Mac**:
The remote computer the phone connects to. The machine where commands actually run.
_Avoid_: host, server

**SSH session**:
The secure connection between the phone and the Mac over which terminal keys and output travel.
_Avoid_: link, tunnel

**opencode job**:
An opencode run on the Mac (a task, e.g. "grill me", "implement X") that the user starts from the terminal and waits to finish. "Done" means opencode finished processing.
_Avoid_: task, process

**done signal**:
The moment an opencode job finishes. Delivered from the Mac to the phone as a terminal bell (BEL) character written to the SSH session, which the app detects and answers with a relaxing chime. opencode stays open and interactive throughout.
_Avoid_: notification, alert, completion event

**page**:
A single live terminal session in the app, identified by its current directory on the Mac. The user swipes left/right to switch between pages, and presses a "+" button to open a new one.
_Avoid_: tab, screen, session view

**notification**:
A push sent from the Mac to the phone (via a free push service like ntfy.sh) when a job finishes while the app is not on screen. Tapping it opens the app and lands on the page where the job ran. The app runs a foreground service so the SSH session (and the job) survives backgrounding, and that same service holds the subscription that receives the push.
_Avoid_: alert, message, completion event

**recent sessions screen**:
The screen shown on launch, listing the user's recent opencode sessions pulled from the Mac. Tapping one resumes it. It is the launch default, alongside two other entries: a "connect to Mac" form (type the Mac's name/IP, connects passwordless via the phone's SSH key) and a plain terminal.
_Avoid_: history, session picker, resume list

**connect form**:
The launch-screen entry where the user types the Mac's address and username. On first use the app generates an SSH keypair and shows the public key (tap-to-copy) to paste into the Mac's `~/.ssh/authorized_keys` once; after that, connections are passwordless. The app remembers the last address used.
_Avoid_: setup wizard, login screen

**configuration**:
Everything the user wants the app to do differently. Deliberately NOT stored in the app: the app is a pure terminal and setup happens by typing normal commands (e.g. `ssh user@mac-ip`). Feature toggles and preferences are managed the same way. Single carve-out: the app remembers the last Mac address it connected to, so the launch screen can connect and list recent sessions.
_Avoid_: settings, preferences, config file