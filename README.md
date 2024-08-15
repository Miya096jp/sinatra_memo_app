# sinatra_memo_app

## このアプリについて
- SinatraとRubyで作成したメモアプリです
- データベースはPostgreSQLを利用します

## データベースの準備
事前にPostgreSQLをインストールしてください

PostgreSQLにログインユーザーでログイン
```
$ psql -U${USER} postgres
```

DB操作用に任意のユーザを作成
```
postgres=# create user <username> with SUPERUSER;
CREATE ROLE
```

一旦ログアウト
```
postgres=# \q
```

作成したユーザーでログイン
```
$ psql -U <username> postgres
```


データベースmemo_dbを作成

```
postgres# create databese memo_db owner=<username>;
```

データベースの切り替え
```
postgres=# \c memo_db
```

memosテーブルの作成
```
memo_db=# CREATE TABLE memos (id SERIAL PRIMARY KEY, title VARCHAR(255) NOT NULL, body TEXT NOT NULL,);
```




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
- ruby_pg

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

`sinatra_memo_app`ディレクトリ直下に`data.json`と`highest_id.json`を作成
```
$ touch data.json
$ touch highest_id.json
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







