#!/bin/bash

# 快速创建一个空的python工程目录，并且实现进入时自动加载环境，退出时则自动退出
# 之后可以通过pipenv install在目录中安装所需的软件 

# 检查是否提供了项目名称
if [[ -z "$1" ]]; then
    echo "Usage: $0 <project_name>"
    exit 1
fi

PROJECT_NAME=$1

# 创建项目目录
mkdir -p "$PROJECT_NAME"
cd "$PROJECT_NAME"

# 创建 .envrc 文件
cat <<EOF > .envrc
if [[ -f "Pipfile" ]]; then
    echo "Activating existing Pipenv environment..."
else
    echo "No Pipfile found. Creating a new Pipenv environment..."
    pipenv --python 3.10
fi

layout_pipenv
EOF

# 授权 .envrc 文件
direnv allow

echo "Project '$PROJECT_NAME' initialized with Pipenv and direnv."
