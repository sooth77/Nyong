#!/bin/bash

# 🔥 [중요 안내] 이 스크립트는 반드시 'source 스크립트명.sh'으로 실행해야 
# 터미널에 가상환경 활성화 상태가 유지됩니다!

VENV_NAME="venv"
IS_NEW_VENV=false

# 1. 가상환경 폴더 존재 여부 확인 및 생성
if [ ! -d "$VENV_NAME" ]; then
    echo "=================================================="
    echo "🚀 '$VENV_NAME' 가상환경이 없습니다. 새로 생성합니다..."
    echo "=================================================="
    
    if command -v python3 &>/dev/null; then
        python3 -m venv $VENV_NAME
    else
        python -m venv $VENV_NAME
    fi
    echo "✅ 가상환경 생성 완료!"
    IS_NEW_VENV=true
else
    echo "=================================================="
    echo "⚡ 이미 '$VENV_NAME' 가상환경이 존재합니다."
    echo "=================================================="
fi

# 2. OS별 활성화 스크립트 위치 분기 및 활성화
if [ -f "$VENV_NAME/bin/activate" ]; then
    VENV_PIPMODULE="$VENV_NAME/bin/python -m pip"
    source "$VENV_NAME/bin/activate"
elif [ -f "$VENV_NAME/Scripts/activate" ]; then
    VENV_PIPMODULE="$VENV_NAME/Scripts/python -m pip"
    source "$VENV_NAME/Scripts/activate"
else
    echo "❌ 가상환경 활성화 파일을 찾을 수 없습니다."
    return 1 2>/dev/null || exit 1
fi

# 3. 새 가상환경일 경우에만 패키지 설치 진행
if [ "$IS_NEW_VENV" = true ]; then
    if [ -f "requirements.txt" ]; then
        echo "=================================================="
        echo "📦 requirements.txt 패키지들을 설치합니다..."
        echo "=================================================="
        # 가상환경 바이너리를 직접 지정하여 pip 실행 (경로 꼬임 방지)
        $VENV_PIPMODULE install --upgrade pip
        $VENV_PIPMODULE install -r requirements.txt
        echo "🎉 모든 패키지 설치가 완료되었습니다!"
    else
        echo "⚠️ requirements.txt 파일이 없어 패키지 설치를 건너뜁니다."
    fi
fi

echo "=================================================="
echo "✨ 가상환경($VENV_NAME)이 성공적으로 활성화되었습니다!"
echo "💡 (주의) 가상환경 해제는 'deactivate'를 입력하세요."
echo "=================================================="
