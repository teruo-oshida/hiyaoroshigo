# ひやおろしGO

## 開発用Docker環境

### イメージの取得 or ビルド

$ docker pull shugo/hiyaoroshigo

or 

$ docker build -t shugo/hiyaoroshigo .

### Railsサーバの実行

$ docker run --rm=true -v "$PWD":/usr/local/hiyaoroshigo -p 127.0.0.1:3000:3000 shugo/hiyaoroshigo 

### テストの実行

$ docker run --rm=true -v "$PWD":/usr/local/hiyaoroshigo shugo/hiyaoroshigo rake
