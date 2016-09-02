# ひやおろしGO

[松江トランキーロ2016](https://www.facebook.com/events/1571262126511755/)のためのWebアプリケーションです。

[![Build Status](https://travis-ci.org/matsueoss/hiyaoroshigo.svg?branch=master)](https://travis-ci.org/matsueoss/hiyaoroshigo)

## 開発環境のセットアップ

前提条件: [CentOS 6.8の環境設定](https://github.com/matsueoss/hiyaoroshigo/wiki/Minimal-steps-to-install-our-Rails)が終わっていること。

1. 依存するgemをインストールします。

   ```
   $ bundle install
   ```

2. データベースをセットアップします。

   ```
   $ rake db:migrate
   $ rake db:seed
   ```

3. Railsサーバを起動します。

   ```
   $ rails server
   ```

4. http://localhost:3000/admin/ にブラウザでアクセスします。

5. 管理ユーザを登録します。

TODO: Facebook連携の設定

## 開発用Docker環境

CentOS 6.8の環境がない場合に使用してください。

前提条件: Dockerが使えるLinuxマシンがあること。

### イメージの取得 or ビルド

```
$ docker pull shugo/hiyaoroshigo
```

or

```
$ docker build -t shugo/hiyaoroshigo .
```

### Railsサーバの実行

```
$ docker run --rm=true -v "$PWD":/usr/local/hiyaoroshigo -p 127.0.0.1:3000:3000 shugo/hiyaoroshigo
```

### テストの実行

```
$ docker run --rm=true -v "$PWD":/usr/local/hiyaoroshigo shugo/hiyaoroshigo rake
```

## チケットの発行

以下のコマンドでtickets.pdfが生成されます。

```
$ rake tickets:generate
$ rake tickets:report
```

以下のコマンドでチケットデータが削除されます。

```
$ rake tickets:clean
```

以下のコマンドでdb/tickets.csvのダンプ・ロードができます。

```
$ rake tickets:csv:dump
$ rake tickets:csv:load
```

## ライセンス

(The MIT License)

Copyright (c) 2016 Oishii Sake and Soba Society Matsue

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
