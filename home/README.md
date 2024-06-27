# git grep exclude

https://stackoverflow.com/questions/10423143/how-to-exclude-certain-directories-files-from-git-grep-search/30084612#30084612

```
git config alias.mygrep '!git grep "$@" -- "${GIT_PREFIX}/*" ":!*.java*" #'
````

Or mark files binary via .gitattributes


