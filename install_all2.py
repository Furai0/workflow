#!/usr/bin/env python3
import subprocess
from datetime import datetime
from pathlib import Path

# юзернейм для вставки конфигов
username = ""
# Список команд
commands = [
    "sudo apt update",
    "sudo apt install snapd",
    # шрифты
    "sudo apt install fonts-font-awesome",
    "mkdir -p ~/.local/share/fonts",
    "cd /tmp",
    'wget -O FiraCode.zip "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip"',
    "unzip FiraCode.zip -d ~/.local/share/fonts",
    # soft
    "sudo apt install qutebrowser",
    "sudo snap install btop",
    "sudo snap install terminal-parrot",
    "sudo snap install telegram-desktop",
]

script_dir = Path(__file__).resolve().parent


def run_command(cmd, index):
    print(f"-> Running: {cmd}")
    try:
        proc = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    except Exception as e:
        save_error_log(index, cmd, f"Exception: {e}\n")
        print(f"ERR: saved")
        return

    if proc.returncode == 0:
        print(f"OK: {cmd}")
    else:
        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = script_dir / f"error_{index}_{ts}.log"
        content = (
            f"Command: {cmd}\n"
            f"Exit code: {proc.returncode}\n\n"
            f"--- STDOUT ---\n{proc.stdout}\n\n"
            f"--- STDERR ---\n{proc.stderr}\n"
        )
        filename.write_text(content, encoding="utf-8")
        print(f"ERR CODE: {proc.returncode}. ALL INFO: {filename}")


def save_error_log(index, cmd, text):
    ts = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = script_dir / f"error_{index}_{ts}.log"
    filename.write_text(f"Command: {cmd}\n\n{text}", encoding="utf-8")
    print(f"log saved in file: {filename}")


if __name__ == "__main__":
    for i, c in enumerate(commands, start=1):
        run_command(c, i)
