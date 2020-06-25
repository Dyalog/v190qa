 array←RandomArray (id type shape);⎕FR;⎕IO;i
 ⎕IO←0
 RecordSeed id type shape ⎕RL

 :Select type
 :Case 11 ⋄ array←1=?shape⍴2
 :Case 83 ⋄ array←1+?shape⍴127
 :Case 163 ⋄ array←(2*7)+?shape⍴(2*15)-(2*7)
 :Case 323 ⋄ array←(2*15)+?shape⍴(2*31)-(2*15)
 :CaseList 645 1287 ⋄ ⎕FR←type ⋄ array←?shape⍴0
 :Case 1289 ⋄ array←(?shape⍴0)+0J1×(?shape⍴0)
 :Case 80 ⋄ array←⎕UCS?shape⍴(2*8)
 :Case 160 ⋄ array←⎕UCS?(2*8)+shape⍴(2*16)-(2*8)
 :Case 320 ⋄ array←⎕UCS?(2*16)+shape⍴(2*20)-(2*16)
 :EndSelect
