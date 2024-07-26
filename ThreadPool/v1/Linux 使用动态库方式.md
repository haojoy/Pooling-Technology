### Linux 使用动态库方式

```shell
# 1. 编译静态库
$ g++ -fPIC -shared threadpool.cpp -o libtdpool.so -std=c++17

# 2. 切换超级用户.
$ mv libtdpool.so /usr/local/lib
$ mv threadpool.h /usr/local/include

# 3. 编译运行项目.
$ g++ threadpooltest.cpp -std=c++17 -ltdpool -lpthread
#遇到ld链接错误，按如下方法解决
# cd etc/ld.so.conf 
# vim mylib.conf
# 首行加入: /usr/local/lib
# ldconfig 
# 编译运行
```