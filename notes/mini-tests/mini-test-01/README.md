# Preparation for Mini-Test-01

## Problem 01

Create a command that creates a folder named exercises. Inside the `exercises` folder, create folders `week01`, `week02`, …, `week12`, and `week13`. Then, inside `week01`, create a file named `Complete.txt` and save your username as the first line using the command `whoami`.
```
mkdir -p ~/exercises/week{01..13}; whoami > ~/exercises/week01/Complete.txt;
```

## Problem 02
```bash
mkdir -p ~/projects/project_{a..e}; date > ~/projects/project_a/info.txt
```
## Problem 03
```bash
mkdir -p ~/backup/{jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec}; echo "Backup completed" > ~/backup/jan/status.txt
```
## Problem 04
```bash
USERNAME=$(whoami); CURRENT_PATH=$(pwd);
mkdir -p ~/logs/log{1..10};
echo "$USERNAME" > ~/logs/log1/info.txt;
echo "$CURRENT_PATH" >> ~/logs/log1/info.txt;
date >> ~/logs/log1/info.txt;
```
## Problem 05


