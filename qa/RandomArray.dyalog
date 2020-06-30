 array←{seed}RandomArray(id types shape);⎕FR;⎕IO;i;type;subinds;subarray;cols;last;n;t;chunk
 ⍝ id is used as a suffix for variable names to make it easier to reproduce a failure
 ⍝    when calling RandomArray, the result should assigned randXXX where XXX is the id provided
 ⍝ types can either be a single type or vector of types
 ⍝   if a vector, types are randomly inserted along last dimension (by column)
 ⍝ shape is the shape of the random array

 ⎕IO←0

 :If 2=⎕NC'seed' ⋄ ⎕RL←seed 0          ⍝ Playback mode: regenerate an array
 :Else ⋄ RecordSeed id types shape ⎕RL  ⍝ Record mode
 :EndIf


 :Select type←⊃types
 :Case 11 ⋄ array←1=?shape⍴2
 :Case 83 ⋄ array←1+?shape⍴127
 :Case 163 ⋄ array←(2*7)+?shape⍴(2*15)-(2*7)
 :Case 323 ⋄ array←(2*15)+?shape⍴(2*31)-(2*15)
 :CaseList 645 1287 ⋄ ⎕FR←type ⋄ array←?shape⍴0
 :Case 1289 ⋄ array←(?shape⍴0)+0J1×(?shape⍴0)
 :Case 80 ⋄ array←⎕UCS?shape⍴(2*8)
 :Case 160 ⋄ array←⎕UCS?(2*8)+shape⍴(2*16)-(2*8)
 :Case 320 ⋄ array←⎕UCS?(2*16)+shape⍴(2*20)-(2*16)
 :Case 326 ⋄ array←⎕NS¨shape⍴⊂''
 :EndSelect

 →0⍴⍨1=t←≢types  ⍝ multiple types?
 cols←⍳n←⊢/shape ⍝ column indices
 last←¯1+≢shape  ⍝ last axis
 chunk←⌈n÷t      ⍝ chunk size

 :For type :In 1↓types
     :If 0<≢cols
         shape←(¯1↓shape),chunk⌊≢cols
         :Select type
         :Case 11 ⋄ subarray←1=?shape⍴2
         :Case 83 ⋄ subarray←1+?shape⍴127
         :Case 163 ⋄ subarray←(2*7)+?shape⍴(2*15)-(2*7)
         :Case 323 ⋄ subarray←(2*15)+?shape⍴(2*31)-(2*15)
         :CaseList 645 1287 ⋄ ⎕FR←type ⋄ array←?shape⍴0
         :Case 1289 ⋄ subarray←(?shape⍴0)+0J1×(?shape⍴0)
         :Case 80 ⋄ subarray←⎕UCS?shape⍴(2*8)
         :Case 160 ⋄ subarray←⎕UCS?(2*8)+shape⍴(2*16)-(2*8)
         :Case 320 ⋄ subarray←⎕UCS?(2*16)+shape⍴(2*20)-(2*16)
         :Case 326 ⋄ subarray←⎕NS¨shape⍴⊂''
         :EndSelect
         subinds←(⊢/shape)?≢cols
         ⍎'array[',(last⍴';'),'subinds]←subarray'
         cols~←subinds
     :EndIf
 :EndFor
