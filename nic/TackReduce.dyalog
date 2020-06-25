 ok←TackReduce seed;Test;array;axis;dr;drs;fn;msg;rank;shape;type;types

 fn←⊃⎕XSI  ⍝ name of this function
 :If 0∊⍴seed  ⍝ use a truely random seed
     ⎕RL←⍬ 2 ⋄ seed←(?1000000000)1
 :EndIf
 ⎕RL←seed

 Test←fn{
     ⍵:⍵
     ⎕←⍺⍺,' ( ',⍵⍵,' ) ⍝ failed with ',(∊(,⊆⍺),[1.5]' ')
     ⍵
 }(⍕seed)

 types←'bool1' 'int8' 'int16' 'int32' 'float64' 'decf128' 'cmpx128' 'char8' 'char16' 'char32' 'strings'
 drs←11 83 163 323 645 1287 1289 80 160 320 326

 ok←1
 :For rank :In 0 1 2 3
     :For type dr :InEach types drs
         :If type≡'strings' ⋄ array←80 RandomArray¨?(?rank⍴10)⍴10
         :Else ⋄ array←dr RandomArray?rank⍴10
         :EndIf ⋄ shape←⍴array
         msg←'type=',type,' shape=[',(⍕⍴array),']'
         ok∧←'⊣⌿'msg Test(⊣⌿array)≡1⌷[1]⍣(rank>0)⊢array
         ok∧←'⊣/'msg Test(⊣/array)≡1⌷[rank]⍣(rank>0)⊢array
         ok∧←'⊢⌿'msg Test(⊢⌿array)≡(⊃shape)⌷[1]⍣(rank>0)⊢array
         ok∧←'⊢/'msg Test(⊢/array)≡(⊃⌽shape)⌷[rank]⍣(rank>0)⊢array
         :For axis :In ⍳rank
             ok∧←('⊣/[',(⍕axis),']')msg Test(⊣/[axis]array)≡(1⌷[axis]array)
             ok∧←('⊢/[',(⍕axis),']')msg Test(⊢/[axis]array)≡((axis⊃shape)⌷[axis]array)
         :EndFor
     :EndFor
 :EndFor
