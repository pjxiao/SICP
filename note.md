1.2 手続きとその生成プロセス
----

* 優れたプログラマになるには、検討中のプロセスを視覚化することを学ばなくてはならない


1.2.1 線形再帰と反復
----

### 再帰的プロセス (recursive process)

* 置き換えモデルで、膨張と収縮の形をとる
* 膨張は、 *遅延演算* (deferred operations) の列を作るとき
* 収縮は、演算が実際に実行されるとき
* 解釈系は、遅延演算の列を記憶しておく必要がある
* 線形再帰的プロセス (linear recursive process)
    * 遅延演算の列が線形に成長するプロセス

### 反復的プロセス (iterative process)

* 置き換えモデルで、伸縮しない
* 構成
    * *状態変数* (state variables)
    * 状態変数の更新方法
    * 停止条件
* 線形反復的プロセス (linear iterative process)
    * ステップ数が線形に成長するプロセス
* 末尾再帰的 (tail recursive)
    * 固定スペースで実行できる

### プロセス (process) と手続き (procedure)

* 手続きは、構文上の事実
    * 反復的プロセスは、再帰的手続きで実装されるが、再帰的プロセスではない


1.2.2 木構造再帰 (tree recursion)
----

* 木構造再帰は、階層構造のデータを扱うとき、反復的アルゴリズムより直感的
* ただし、計算量は反復的アルゴリズムくらべて、はるかに多い
* テーブル化 (tabulation) やメモ化 (memoization) 冗長な計算を回避できる


1.2.3 増加の程度 (order of growth)
----

* 計算資源の消費速度は、プロセスによって大いに違う
* *増加の程度* (order of growth) で、見積もる
* `Θ(f(n))`
    * `n` 問題の大きさを表すパラメタ
    * `R(n)` `n` に対して、プロセスが必要とする基本機械演算数
    * `k1 * f(n) <= R(n) <= k2 * f(n)` を満たす独立な正の定数 `k1`, `k2` が存在する

1.3.4 値として返される手続き
----

* 手続きを受け取り手続きを返す手続きを作ると、さらなる表現力を得られる
    * `procedure :: (a -> b) -> (c -> d)`
* 抽象を用いて手続きを表すと、考え方が明瞭になる
* Newton 法
    * `x -> g(x)` が微分可能
    * `f(x) = dg(x)/dx`
    * `Dg(x)` は、 `x -> f(x)` の不動点
    * Newton 法は、不動点プロセスで表される
* 抽象と第一手続き
    * プログラムから抽象を見つけ、より一般的な抽象を構成するよう努めなければならい
    * 抽象のレベルは、時と場合によって適切選ぶ
    * 抽象を使って考えると、異なる状況にも応用できる
    * 高階手続きは、抽象を他の計算要素のように扱うことができるという点で、重要である
    * 第一級 (first-class)
        * 変数として命名できる
        * 手続きが引数としてとれる
        * 手続きの返り値になれる
        * データ構造に組み込むことができる


2.1 データ抽象入門
----

* 合成データオブジェクト
    * より基本的なデータから作られたデータ
* データ抽象 (data abstraction)
    * 合成データオブジェクトの使い方を、詳細な作り方から隔離する
    * プログラムを抽象データオブジェクトの操作で構成するようにする
    * プログラムを具体的なデータ表現から隔離する


2.1.2 抽象の壁
----

### 抽象の壁 (abstraction barrier)

* システムを異なるレベルで隔離する
* 上位レベル
    * データ抽象を使う
* 下位レベル
    * データ抽象を実装する
* データ抽象を使うレベルでの依存を少数のインタフェース手続きに制限することは、プログラムの設計に役立つ
* 上のレベルを変更せずに、下のレベルを別の実装へ変更する柔軟性を与える


2.1.3 データとはなにか
----

### データ (data)

* 選択子
* 構成子
* これらの手続きを有効な表現とするために満たす条件

### メッセージパッシング (message passing)

* 手続きをオブジェクトとして操作する能力が自動的に合成データを表現する


2.2 階層データ構造と閉包性
----

### 箱ポインタ記法 (box-and-pointer notaion)

各オブジェクトを箱（対, `cons`）へのポインタ (pointer) で表す

### 閉包性 (closure property)

* データオブジェクトを合成する演算結果に対して、同様の演算で更に合成ができること
* 階層的 (hierarchical) 構造を作ることができる

2.2.1 並びの表現
----

### 並び (sequence)

* データオブジェクトの順序付けられた集まり
* 入れ子構造の `cons` で作られた並びを リスト (list) と呼ぶ

### nil

* ラテン語の nihil の短縮形
* 空リスト (empty list) として考える

### リスト演算

* リストを先頭から順に *cdr ダウン* する慣習的な技法
    * `list-ref`, `length` など
* cdr ダウンしつつ *cons* アップする
    * `append` など

### ドット末尾記法

```scheme
(define (f x y . z) (...))
```

関数 `f` を `(f 1 2 3 4 5)` と呼び出すと、`z` は `.` 以降の引数のリストになる。
Python の `*args` みたいなもの。

* `x`: `1`
* `y`: `2`
* `z`: `(list 3 4 5)`

### 関数の写像

`map` は、手続きとリストを引数に取り、手続きをリストの各要素に作用させた結果のリストを返す

```scheme
(define (map proc items)
  (if (null? items)
    nil
    (cons (proc (car items))
          (map proc (cdr items)))))
```

`map` は、単に共通パターンを取り込むだけでなく、
「リストの要素を変換する」「リストの要素を取り出し組み合わせる」というふたつの処理を
抽象の壁で隔離している。

2.2.3 公認インタフェースとしての並び
---

### 信号処理構造として考える

1. 数え上げ (enumerator)
    * 信号を発する
2. フィルタ (filter)
    * 要素を除去する
3. 写像 (map)
    * 変換器
4. アキュムレータ (accumulator)
    * 写像の出力を混合する

#### フィルタ (filter)

```scheme
(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))
```

#### アキュムレータ (accumulator)

右畳み込み

```scheme
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))
```

#### 左畳み込み (fold-left)

```scheme
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
      result
      (iter (op result (car rest))
            (cdr rest))))
  (iter initial sequence))
```

#### 問題 2.38

```scheme
(fold-right / 1 (list 1 2 3))
(/ 1 (/ 2 (/ 3 1)))
3 / 2
```

```scheme
(fold-left / 1 (list 1 2 3))
(iter (/ 1 1) (list 2 3))
(iter (/ (/ 1 1) 2) (list 3))
(iter (/ (/ (/ 1 1) 2) 3) (list))
(/ (/ (/ 1 1) 2) 3)
```

```scheme
(fold-right list nil (list 1 2 3))
(list 1 (list 2 (list 3 nil)))
(1 (2 (3 ())))
```

```scheme
(fold-left list nil (list 1 2 3))
(iter (list nil 1) (list 2 3))
(iter (list (list nil 1) 2) (list 3))
(iter (list (list (list nil 1) 2) 3) (list))
(list (list (list nil 1) 2) 3)
(((() 1) 2) 3)
```
