 ok←CarryLessMultiply seed;DRF1;DRF2;DRL1;DRL2;DSF1;DSF2;DSL1;DSL2;DWF1;DWF2;DWL1;DWL2;ERF1;ERF2;ERL1;ERL2;ESF1;ESF2;ESL1;ESL2;EWF1;EWF2;EWL1;EWL2;For;Test;array;cells;fn;length;msg;rank;shape;⎕RL

 fn←⊃⎕XSI  ⍝ name of this function
 :If 0∊⍴seed  ⍝ use a truely random seed
     ⎕RL←⍬ 2 ⋄ seed←(?1000000000)1
 :EndIf
 ⎕RL←seed

 Test←fn{
     ⍵:⍵
     ∘∘∘
     ⎕←⍺⍺,' ( ',⍵⍵,' ) ⍝ failed with ',(∊(,⊆⍺),[1.5]' ')
     ⍵
 }(⍕seed)


 DRF1←{≠⌿⍵} ⋄ DRF2←{2|+⌿⍵} ⍝ difference reduce on first axis
 DRL1←{≠/⍵} ⋄ DRL2←{2|+/⍵} ⍝ differente reduce on last axis

 DWF1←{⍺≠⌿⍵} ⋄ DWF2←{DRF2¨⍺,⌿⍵}  ⍝ difference windowed reduction on first axis
 DWL1←{⍺≠/⍵} ⋄ DWL2←{DRL2¨⍺,/⍵}  ⍝ difference windowed reduction on last axis

 DSF1←{≠⍀⍵} ⋄ DSF2←{2|+⍀⍵} ⍝ difference scan on first axis
 DSL1←{≠\⍵} ⋄ DSL2←{2|+\⍵} ⍝ difference scan on last axis

 ERF1←{=⌿⍵} ⋄ ERF2←{~2|+⌿~⍵} ⍝ equal reduce on first axis
 ERL1←{=/⍵} ⋄ ERL2←{~2|+/~⍵} ⍝ equal reduce on last axis

 EWF1←{⍺=⌿⍵} ⋄ EWF2←{ERF2¨⍺,⌿⍵}  ⍝ equal windowed reduction on first axis
 EWL1←{⍺=/⍵} ⋄ EWL2←{ERL2¨⍺,/⍵}  ⍝ equal windowed reduction on last axis

 ESF1←{=⍀⍵} ⋄ ESF2←{~2|+⍀~⍵} ⍝ equal scan on first axis
 ESL1←{=\⍵} ⋄ ESL2←{~2|+\~⍵} ⍝ equal scan on last axis


 ok←1
 :For rank :In 0 1 2 3
     cells←1↓?rank⍴10

     ⍝ 1. Monadic ≠/ on ≤64 bit rows
     :For length :In 0 1 63 64,?5⍴64
         array←11 RandomArray shape←cells,length
         msg←'shape=[',(⍕shape),']'
         ok∧←'≠/⍵'msg Test(DRL1 array)≡(DRL2 array)
         ok∧←'=/⍵'msg Test(ERL1 array)≡(ERL2 array)
     :EndFor

     ⍝ 2. Dyadic ≠/ when the window spans 64 or fewer elements (64-bit builds only)
     array←11 RandomArray shape←cells,length←100
     :For length :In 0 1 63 64,?5⍴64
         msg←'shape=[',(⍕shape),'] ⍺=',⍕length
         ok∧←'⍺≠/⍵'msg Test(length DWL1 array)≡(length DWL2 array)
         ok∧←'⍺=/⍵'msg Test(length EWL1 array)≡(length EWL2 array)
     :EndFor

     ⍝ 3. ≠\ on ≥128 bit rows
     :For length :In 128+0 1 127 128,?5⍴128
         array←11 RandomArray shape←cells,length
         msg←'shape=[',(⍕shape),']'
         ok∧←'≠\⍵'msg Test(DSL1 array)≡(DSL2 array)
         ok∧←'=\⍵'msg Test(ESL1 array)≡(ESL2 array)
     :EndFor

     ⍝ 4. ≠⍀ with cell size a divisor of 32 bits
     :For cells :In 0 1 2 4 8 16 32
         shape←cells,1↓?rank⍴100
         msg←'shape=[',(⍕shape),']'
         ok∧←'≠⍀⍵'msg Test(DSF1 array)≡(DSF2 array)
         ok∧←'=⍀⍵'msg Test(ESF1 array)≡(ESF2 array)
     :EndFor
 :EndFor
