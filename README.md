# Commit Prefix
|  Prefix  | Meaning |
| -------- | ------- |
| feat     | 新機能   |
| fix      | バグ修正　　　|
| docs     | ドキュメント修正 |
| style    | 空白, フォーマット, セミコロン追加 |
| refactor | リファクタリング |
| perf     | パフォーマンス関連 |
| test     | テスト関連 |

# Command
### DB作成
```shell
$ docker-compose run app rails db:migrate
$ docker-compose run app rails db:create
```

### テスト
```shell
$ rspec
```

### リント
```shell
$ rubocop
```
