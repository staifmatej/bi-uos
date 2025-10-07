# Preparation for Mini-Test-01

## Problem 01

Create a command that creates a folder named exercises. Inside the `exercises` folder, create folders `week01`, `week02`, …, `week12`, and `week13`. Then, inside `week01`, create a file named `Complete.txt` and save your username as the first line using the command `whoami`.
```
mkdir -p ~/exercises/week{01..13}; whoami > ~/exercises/week01/Complete.txt;
```

## Problem 02
Create a command that creates a folder named `projects` in your home directory. Inside the `projects` folder, create folders `project_a`, `project_b`, `project_c`, `project_d`, and `project_e`. Then, inside `project_a`, create a file named `info.txt` and save the current date using the command `date`.
```bash
mkdir -p ~/projects/project_{a..e}; date > ~/projects/project_a/info.txt
```
## Problem 03
C## Problem 03
Create a command that creates a folder named `backup`. Inside the `backup` folder, create folders `jan`, `feb`, `mar`, `apr`, `may`, `jun`, `jul`, `aug`, `sep`, `oct`, `nov`, and `dec`. Then, inside the `jan` folder, create a file named `status.txt` and save the text "Backup completed" using the command `echo`.
```bash
mkdir -p ~/backup/{jan,feb,mar,apr,may,jun,jul,aug,sep,oct,nov,dec};
echo "Backup completed" > ~/backup/jan/status.txt
```
## Problem 04
Create a command that creates a variable `USERNAME` with the value of your username (use `whoami`) and a variable `CURRENT_PATH` with the current directory path (use `pwd`). Then create a folder named `logs` and inside it create folders `log1` through `log10`. Finally, inside `logs/log1/`, create a file named `info.txt` and save three separate lines: the first line should contain the value of `USERNAME`, the second line should contain the value of `CURRENT_PATH`, and the third line should contain the current date using the command date.
```bash
USERNAME=$(whoami); CURRENT_PATH=$(pwd);
mkdir -p ~/logs/log{1..10};
echo "$USERNAME" > ~/logs/log1/info.txt;
echo "$CURRENT_PATH" >> ~/logs/log1/info.txt;
date >> ~/logs/log1/info.txt;
```
## Problem 05
Create a command that creates a variable `PROJECT` with the value `"app"`. Then create a folder named `workspace`. Inside the `workspace` folder, create three files with names: `app_backup.txt`, `app_final.txt`, and `app_draft.txt`. Important: The file names MUST use the value of the `PROJECT` variable (not the literal text `"app"`). Finally, save the text `"Backup completed for app"` into the `app_backup.txt` file, where `"app"` MUST also come from the `PROJECT` variable.
```bash
declare PROJECT="app";
mkdir ~/workspace;
touch ~/workspace/${PROJECT}_{backup,final,draft}.txt;
echo "Backup completed for ${PROJECT}" > ~/workspace/${PROJECT}_backup.txt
```



