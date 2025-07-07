#!/bin/bash

mkdir -p ./data

# 生成校验和文件
generate_sum() {
    local file=$1
    local sum_file=$2
    sha256sum "$file" > "$sum_file"
}

# 优先从WebDAV恢复数据
if [ ! -z "$WEBDAV_URL" ] && [ ! -z "$WEBDAV_USERNAME" ] && [ ! -z "$WEBDAV_PASSWORD" ]; then
    echo "尝试从WebDAV恢复数据..."
    curl -L --fail --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/webui.db" -o "./data/webui.db" && {
        echo "从WebDAV恢复数据成功"
    } || {
        if [ ! -z "$G_NAME" ] && [ ! -z "$G_TOKEN" ]; then
            echo "从WebDAV恢复失败,尝试从GitHub恢复..."
            REPO_URL="https://${G_TOKEN}@github.com/${G_NAME}.git"
            git clone "$REPO_URL" ./data/temp && {
                if [ -f ./data/temp/webui.db ]; then
                    mv ./data/temp/webui.db ./data/webui.db
                    echo "从GitHub仓库恢复成功"
                    rm -rf ./data/temp
                else
                    echo "GitHub仓库中未找到webui.db"
                    rm -rf ./data/temp
                fi
            }
        else
            echo "WebDAV恢复失败,且未配置GitHub"
        fi
    }
else
    echo "未配置WebDAV,跳过数据恢复"
fi

# 同步函数
sync_data() {
    while true; do
        echo "开始同步..."
        HOUR=$(date +%H)
        
        if [ -f "./data/webui.db" ]; then
            # 生成新的校验和文件
            generate_sum "./data/webui.db" "./data/webui.db.sha256.new"
            
            # 检查文件是否变化
            if [ ! -f "./data/webui.db.sha256" ] || ! cmp -s "./data/webui.db.sha256.new" "./data/webui.db.sha256"; then
                echo "检测到文件变化，开始同步..."
                mv "./data/webui.db.sha256.new" "./data/webui.db.sha256"
                
                # 同步到WebDAV
                if [ ! -z "$WEBDAV_URL" ] && [ ! -z "$WEBDAV_USERNAME" ] && [ ! -z "$WEBDAV_PASSWORD" ]; then
                    echo "同步到WebDAV..."
                    
                    # 上传数据文件
                    curl -L -T "./data/webui.db" --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/webui.db" && {
                        echo "WebDAV更新成功"
                        
                        # 每日备份(包括WebDAV和GitHub)，在每天0点进行
                        if [ "$HOUR" = "00" ]; then
                            echo "开始每日备份..."
                            
                            # 获取前一天的日期
                            YESTERDAY=$(date -d "yesterday" '+%Y%m%d')
                            FILENAME_DAILY="webui_${YESTERDAY}.db"
                            
                            # WebDAV每日备份
                            curl -L -T "./data/webui.db" --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/$FILENAME_DAILY" && {
                                echo "WebDAV日期备份成功: $FILENAME_DAILY"
                                
                                # GitHub每日备份
                                if [ ! -z "$G_NAME" ] && [ ! -z "$G_TOKEN" ]; then
                                    echo "开始GitHub每日备份..."
                                    REPO_URL="https://${G_TOKEN}@github.com/${G_NAME}.git"
                                    git clone "$REPO_URL" ./data/temp || {
                                        echo "GitHub克隆失败"
                                        rm -rf ./data/temp
                                    }
                                    
                                    if [ -d "./data/temp" ]; then
                                        cd ./data/temp
                                        git config user.name "AutoSync Bot"
                                        git config user.email "autosync@bot.com"
                                        git checkout main || git checkout master
                                        cp ../webui.db ./webui.db
                                        
                                        if [[ -n $(git status -s) ]]; then
                                            git add webui.db
                                            git commit -m "Auto sync webui.db for ${YESTERDAY}"
                                            git push origin HEAD && {
                                                echo "GitHub推送成功"
                                            } || echo "GitHub推送失败"
                                        else
                                            echo "GitHub: 无数据变化"
                                        fi
                                        cd ../..
                                        rm -rf ./data/temp
                                    fi
                                fi
                            } || echo "WebDAV日期备份失败"
                        fi
                    } || {
                        echo "WebDAV上传失败,重试..."
                        sleep 10
                        curl -L -T "./data/webui.db" --user "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" "$WEBDAV_URL/webui.db" || {
                            echo "WebDAV重试失败"
                        }
                    }
                fi
            else
                echo "文件未发生变化，跳过同步"
                rm -f "./data/webui.db.sha256.new"
            fi
        else
            echo "未找到webui.db,跳过同步"
        fi
        
        echo "当前时间: $(date '+%Y-%m-%d %H:%M:%S')"
        echo "下次同步: $(date -d '+5 minutes' '+%Y-%m-%d %H:%M:%S')"
        sleep 300
    done
}

# 启动同步进程
sync_data &
