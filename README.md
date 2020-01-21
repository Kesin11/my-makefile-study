# My Makefile Study
あえてTypeScriptで覚えるMakefileの基礎中の基礎

理解した内容は[Makefile](./Makefile)にコメントで書いています

## USAGE
Makefileの依存解決の仕組みにより、`npm install`や`tsc`を明示的に実行する必要はない。  
スクリプトやpackage.jsonが更新されない限りは、毎回実行されることもない。

### build

npm install + tsc

```bash
make build
```

### test
npm install + tsc + jest
```bash
make test
```

### exec
npm install + tsc + node dist/src/index.js

```bash
make exec
```

### clean
rm -rf dist/

```bash
make clean
```

## LICENSE
MIT