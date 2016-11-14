# SimpleVote

ShimaneCommunities2016のためのWebアプリケーションです。

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
