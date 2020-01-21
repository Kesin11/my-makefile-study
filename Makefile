.PHONY: help
help:
	@echo "clean: Remove dist directory"
	@echo "build: Exec tsc"
	@echo "test: Exec jest"
	@echo "exec: Exec node dist/src/index.js"

# .PHONYは本物のファイルではない偽りのターゲットを定義できる
# 本物のファイルではないので実行不要と判断されることはなく、必ず実行される
# see: https://www.ecoop.net/coop/translated/GNUMake3.77/make_4.jp.html
.PHONY: clean
clean:
	rm -rf dist node_modules

.PHONY: build
build: dist

# コマンドを書かずに、単にターゲットを羅列する書き方も許容される
# その場合、左から順番に評価される
# cleanは.PHONYなので必ず実行され、buildが依存するdistが削除されるのでnpm iからやり直されることになる
.PHONY: clean-build
clean-build: clean build

.PHONY: test
test: dist
	node_modules/jest/bin/jest.js dist/__tests__/*.js

.PHONY: exec
exec: dist
	node dist/src/index.js

#
# build, test, execはすべてdistに依存している
# ts -> jsに変換されたdist/が存在しない場合はtscが自動的に実行される
#

# .SECONDARYはターゲットが中間生成物であることをmakeに伝える
# コマンドの中にターゲットと同名のファイルが現れない場合でも、一連のコマンドを実行することでターゲットが生成されることを伝えている
# .INTERMEDIATEとの違いは、ビルド後に破棄されるかどうか。.SECONDARYは保存される
# see: https://qiita.com/Shigets/items/27170827707e5136ee89
.SECONDARY: dist
dist: node_modules src/* __tests__/*
	node_modules/typescript/bin/tsc

#
# distはnode_modules, src/*, __tests__/*に依存している
# node_modulesが存在しなければnpm installが実行され、
# dist/とsrc/*, __tests__/*のタイムスタンプを比較し、更新されていた場合は自動的に再度tscが実行される
# 逆に、更新されていなければtscは実行されない
#

.SECONDARY: node_modules
node_modules: package.json package-lock.json
	npm i

#
# node_modulesはpackage.json, package-lock.jsonに依存している
# node_modulesが既に存在していても、package.json, package-lock.jsonが更新されれば再度npm iが実行される
#