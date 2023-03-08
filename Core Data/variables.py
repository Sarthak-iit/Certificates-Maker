import sys
arg = sys.argv[1]

f = open('data.txt','r')
for x in f.readlines():
    exec(x)
web_git_repo_name = web_git_repo_link.split('/')[-1].replace('.git','')
data_git_repo_name = data_git_repo_link.split('/')[-1].replace('.git','')
exec(f'print({arg})')
