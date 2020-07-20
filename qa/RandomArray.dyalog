 array←{seed}RandomArray(id types shape);⎕FR;⎕IO;i;type;subinds;subarray;cols;last;n;t;chunk;width;force;multiple;seedValue
 ⍝ id is used as a suffix for variable names to make it easier to reproduce a failure
 ⍝    when calling RandomArray, the result should assigned randXXX where XXX is the id provided
 ⍝ types can either be a single type or vector of types
 ⍝   if a vector, types are randomly inserted along last dimension (columns)
 ⍝ shape is the shape of the random array
 ⍝
 ⍝ Example:
 ⍝     rand0←RandomArray 0 (80 163) (10 7) ⍝ 10×7 matrix of UTF-8 chars and 2-byte integers

 ⎕IO←0

 :If 2=⎕NC'seed' ⋄ ⎕RL←seed 0           ⍝ Playback mode: regenerate an array
 :Else ⋄ RecordSeed id types shape ⎕RL  ⍝ Record mode
 :EndIf

 seedValue←{
 ⍝ return seed value for datatype to prevent compaction
     d←⎕DR ⍵
     d∊645 1287:?0⊣⎕FR←⊃(d∊645 1287)↓⎕FR,d
     d∊83 163 323:{t+?(2*⍵-1)-t←2*0⌈¯1+8×⌊⍵÷16}⌊0.1×d
     ⊃⍵
 }

 :Select type←⊃types
 :CaseList 11 83 163 323 645 1287
     width←⌊0.1×type
     array←type DR?(width××/shape)⍴2
 :Case 1289
     n←64××/shape ⋄ array←(645 DR?n⍴2)+0J1×(645 DR?n⍴2)
 :CaseList 80 160 320
     width←⌊0.1×type
     array←⎕UCS?shape⍴2*width
 :Case 82
     width←⌊0.1×type
     array←⎕AV[shape⍴255]
 :Case 326 ⋄ array←⎕NS¨shape⍴⊂''
 :EndSelect

 array←shape⍴array
 →0⍴⍨0∊shape

 multiple←1<≢types
 force←?shape
 array[⊂force]←seedValue array ⍝ force at least one element to be non-compactible (if applicable)

 →0⍴⍨1=t←≢types  ⍝ multiple types?

 cols←(⊢/force)~⍨⍳n←⊢/shape ⍝ column indices
 last←¯1+≢shape  ⍝ last axis
 chunk←1⌈⌊n÷t    ⍝ chunk size

 :For type :In 1↓types
     :If 0<≢cols
         shape←(¯1↓shape),chunk⌊≢cols
         :Select type
         :CaseList 11 83 163 323 645 1287
             width←⌊0.1×type
             subarray←type DR?(width××/shape)⍴2
         :Case 1289
             n←64××/shape ⋄ subarray←(645 DR?n⍴2)+0J1×(645 DR?n⍴2)
         :CaseList 80 160 320
             width←⌊0.1×type
             subarray←⎕UCS?shape⍴2*20⌊width
         :Case 326 ⋄ subarray←⎕NS¨shape⍴⊂''
         :EndSelect
         subinds←(⊢/shape)?≢cols
         ⍎'array[',(last⍴';'),'subinds]←shape⍴subarray'
         cols~←subinds
     :EndIf
 :EndFor
