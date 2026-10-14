#!/bin/bash

VENV_NAME="venv"

# 1. 가상환경 폴더 존재 여부 확인
if [ ! -d "$VENV_NAME" ]; then
    echo "=================================================="
    echo "🚀 '$VENV_NAME' 가상환경이 없습니다. 새로 생성합니다..."
    echo "=================================================="
    
    # python3 또는 python으로 가상환경 생성
    if command -v python3 &>/dev/null; then
        python3 -m venv $VENV_NAME
    else
        python -m venv $VENV_NAME
    fi
    
    echo "✅ 가상환경 생성 완료!"

    # OS별 활성화 스크립트 위치 분기 (Mac/Linux는 bin, Windows Git Bash는 Scripts)
    if [ -f "$VENV_NAME/bin/activate" ]; then
        source $VENV_NAME/bin/activate
    elif [ -f "$VENV_NAME/Scripts/activate" ]; then
        source $VENV_NAME/Scripts/activate
    fi

    # requirements.txt 설치
    if [ -f "requirements.txt" ]; then
        echo "=================================================="
        echo "📦 requirements.txt 패키지들을 설치합니다..."
        echo "=================================================="
        pip install --upgrade pip
        pip install -r requirements.txt
        echo "🎉 모든 패키지 설치가 완료되었습니다!"
    else
        echo "⚠️ requirements.txt 파일이 없어 패키지 설치를 건너뜁니다."
    fi

else
    echo "=================================================="
    echo "⚡ 이미 '$VENV_NAME' 가상환경이 존재합니다."
    echo "=================================================="
    
    # 가상환경 활성화만 실행
    if [ -f "$VENV_NAME/bin/activate" ]; then
        source $VENV_NAME/bin/activate
    elif [ -f "$VENV_NAME/Scripts/activate" ]; then
        source $VENV_NAME/Scripts/activate
    fi
fi

echo "=================================================="
echo "✨ 가상환경($VENV_NAME)이 성공적으로 활성화되었습니다!"
echo "=================================================="
