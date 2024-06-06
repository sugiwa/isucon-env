# private-isu環境

## 接続
```
sh connect.sh
```

## アプリ起動
```
cd ./private-isu/webapp/golang
app
```

## ベンチマーカー実行
```
cd ./private-isu/benchmarker
make
./bin/benchmarker --target {host} --userdata ./userdata
```