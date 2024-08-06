# sinatra_memo_app

## このアプリについて
- SinatraとRubyで作成したメモアプリです
- データはJSONファイルに読み書きします

## インストール方法
次のURLでアプリをクローン
```
$ git clone https://github.com/Miya096jp/sinatra_memo_app.git
```

`sinatra_memo_app`ディレクトリに移動して、bundle installでgemをインストール
```
$ cd sinatra_memo_app
$ bundle install
```
次のgemがインストールされます
- sinatra
- sinatra/reloader
- RuboCop
- ERB Lint
- rackup

Ruby 3.0.0以降を使う場合、webrick gemをインストール
```
$ gem install webrick
```

RuboCopの設定
RuboCopを使う場合は.rubocop.ymlに下記の設定を追加
```
inherit_gem:
  rubocop-fjord:
    - "config/rubocop.yml"
```

`sinatra_memo_app`ディレクトリ直下に`data.json`を作成
```
$ touch data.json
```

## アプリの起動
bundle execを実行
```
bundel exec ruby main.rb
```

ブラウザで次のローカルホストURLにアクセス
```
http://localhost:4567
```







