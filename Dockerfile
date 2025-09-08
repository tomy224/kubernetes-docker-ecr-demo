# ベースイメージとして軽量な Nginx (alpine版) を指定
# Nginx は Web サーバーで、index.html を配信してくれる役割
FROM nginx:alpine  

# ローカルの index.html をコンテナ内の Nginx の公開ディレクトリにコピー
# /usr/share/nginx/html/ は Nginx がデフォルトで参照する場所
COPY index.html /usr/share/nginx/html/index.html  

# このコンテナはポート80で待ち受ける（HTTPの標準ポート）
# EXPOSE は「このポートを使うよ」という宣言（必須ではないが慣習的に書く）
EXPOSE 80  
