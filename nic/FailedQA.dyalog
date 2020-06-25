 ok←FailedQA seed;⎕RL;Test;data;dr;fn;msg;seed;shape

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

 shape←2 3 4
 dr←⎕DR data←?shape⍴0
 msg←'⎕DR=',(⍕dr),' shape=[',(⍕shape),']'
 ok←msg Test data≡⎕NULL
