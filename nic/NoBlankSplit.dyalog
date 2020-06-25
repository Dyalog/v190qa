 ok←NoBlankSplit seed;NBS1;NBS2;Test;array;blanks;dr;fn;msg;rank;seed;shape;⎕RL

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

 NBS1←{~∘' '¨↓⍵}
 NBS2←{(↓⍵)~¨' '}

 ok←1
 :For dr :In 80 160 320 11 83 645
     :For rank :In 0 1 2 3
         :For blanks :In 0 0.1 0.5  ⍝ proportion of blanks
             shape←⍴array←dr RandomArray?rank⍴20
             ((blanks>?(×/shape)⍴0)/,array)←' '
             msg←'⎕DR=',(⍕dr),' shape=[',(⍕shape),']'
             ok∧←msg Test(NBS1 array)≡(NBS2 array)
         :EndFor
     :EndFor
 :EndFor
