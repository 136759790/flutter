#aa
# 生成序列化代码
~~~
flutter packages pub run build_runner build --delete-conflicting-outputs
~~~
# 打包
~~~
flutter build apk --target-platform android-arm64 --split-per-abi
~~~