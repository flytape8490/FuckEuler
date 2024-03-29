[EULER 002:    https://projecteuler.net/problem=2
               Each new term in the Fibonacci sequence is generated by adding the previous two
               terms. By starting with 1 and 2, the first 10 terms will be:
               1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
               By considering the terms in the Fibonacci sequence whose values do not exceed 
               four million, find the sum of the even-valued terms.

               There is only one optimization beyond the naïve case: I've implemented 
               place-value arithmetic algorithms for the addition and subtraction when 
               calculating the Fibonacci numbers and the sums (basically implementing what you 
               would call long-addition and long-subtraction when doing this by hand). While 
               this results in more complex code, it speeds up the execution significantly as 
               the interpreter is not adding large numbers by subtracting one from one cell and 
               adding one to another one by one, hundreds or even thousands of times (or in this 
               case, up to 4 million times). I could have sped this up even further by 
               implementing place-value division for the conversion to base-10 at the end, but 
               that would have required me to really think much harder about how long-division 
               works than I have any interest in doing.
]

Main Flags
     000  PROGRAM_LOOP
     001  B'2
     002  B'1       B'1_F     B'1_B
     005  B'0       B'0_F     B'0_B
     008  COPY'0
     009  C'2       C'1       C'0
     012  A'2       A'1       A'0
     015  COPY'1
     016  SUM'2
     017  SUM'1     SUM'1_F   SUM'1_B
     020  SUM'0     SUM'0_F   SUM'0_B
     023  LT4M_FLAG E_FLAG    LOOP_FLAG

Comparison Flags
     026  CONT_FLAG
     027  WORK      WORK_F    WORK_B
     030  4M        4M_F      4M_B

Modulo Flags
     026  CMP_FLAG
     027  N
     028  WORK      WORK_F    WORK_B
     031  MOD       MOD_F     MOD_B

Even Flags
     026  CMP_FLAG
     027  N         N_F       N_B

Conversion Flags
     015  LOOP_FLAG      CMP_FLAG
     017  WORK'2         WORK'2_F       WORK'2_B
     020  WORK'1         WORK'1_F       WORK'1_B
     023  WORK'0         WORK'0_F       WORK'0_B
     026  NOT'0          NOT'0_F        NOT'0_B
     029  MOD            MOD_F          MOD_B
     032  Q'2
     033  Q'1            Q'1_F          Q'1_B
     036  Q'0            Q'0_F          Q'0_B
     039  Output

# INITIALIZE
     >>>>>>>>>>>>>>+     # goto A0; set 1
     <<<<<<<<<++         # goto B0; set 2

# START PROGRAM_LOOP
     <<<<<+              # goto PROGRAM_LOOP; set TRUE
     [                   # while PROGRAM_LOOP
          # USE COMPARISON FLAGS
          # Is A lessthan 4Million? {4mil == 061 009 000}
               # Comparison '2 Setup
                    >>>>>>>>>>>>        # goto A'2
                    [->>>+>>>>>>>>>     # copy A'2:WORK via COPY'1
                         >>>+<<<<<<
                         <<<<<<<<<]
                         >>>[-<<<+>
                         >>]            # endcopy @COPY'1
                    >>>>>>>>>>>>>>>>    # goto 4M_F
                    ++++++[-<++++++     # multiply 6 * 10 = 60 into 4M
                         ++++>]         # endmult @4M_F
                    <+                  # goto 4M; add 1; 4M = 61
               # Comparison '2
                    <<<<<+              # goto LOOP_FLAG; set TRUE
                    [                   # while LOOP_FLAG == TRUE
                         >>>+                # goto WORK_F; set TRUE
                         <                   # goto WORK
                         [                   # if WORK != 0
                              >>>>+               # goto 4M_F; set TRUE
                              <                   # goto 4M
                              [                   # if 4M != 0
                                   -                   # 4M subtract 1
                                   <<<-                # goto WORK; subtract 1
                                   >>>>-               # goto 4M_F; set FALSE
                              ]>[                 # elif 4M == 0:
                                   # WORK gt 4M'2; A GT 4M
                                   -                   # 4M_F set FALSE
                                   <<<<<<-                  # goto LOOP_FLAG; set FALSE
                                   <<<<<<<<<<<<<<<     # goto PROGRAM_LOOP
                                        <<<<<<<<<<
                                   -                   # PROGRAM_LOOP set FALSE
                                   >>>>>>>>>>>>>>>     # goto WORK; drain
                                        >>>>>>>>>>
                                        >>[-]
                                   >>>>>               # goto 4M_B
                              ]                   # endif @4M_B
                              <<<<-               # goto WORK_F; set FALSE
                         ]>[                 # elif WORK == 0
                              -                   # WORK_F set FALSE
                              >>>+                # goto 4M_F; set TRUE
                              <                   # goto 4M
                              [                   # if 4M != 0
                                   # WORK IS LT 4M'2; A LT 4M
                                   [-]                 # 4M drain
                                   <<<<<-              # goto LOOP_FLAG; set FALSE
                                   <<+                 # goto LT4M_FLAG; set TRUE
                                   >>>>>>>>-           # goto 4M_F; set FALSE
                              ]>[                 # elif 4M == 0:
                                   # WORK IS EQ 4M'2; DO COMPARISON '1
                                   -                   # 4M_F set FALSE
                                   <<<<<+              # goto CONT_FLAG; set TRUE
                                   <-                  # goto LOOP_FLAG; set FALSE
                                   >>>>>>>             # goto 4M_B
                              ]                   # endif @4M_B
                              <<<                 # goto WORK_B
                         ]                   # endif @WORK_B
                         <<<<                # goto LOOP_FLAG
                    ]                   # endwhile @LOOP_FLAG
               # Comparison '1 Setup
                    >                   # goto CONT_FLAG
                    [                   # if CONT_FLAG == TRUE
                         <<<<<<<<<<<<<       # goto A'1
                         [->>+>>>>>>>>>>     # copy A'1:WORK via COPY'1
                              >>+<<<<<<<
                              <<<<<<<]>>
                              [-<<+>>]       # endcopy @COPY'1
                         >>>>>>>>>>+         # goto LOOP_FLAG; set TRUE
                         >>>>>+++++++++      # goto 4M; set 9
                         <<<<-               # goto CONT_FLAG; set FALSE
                    ]                   # endif @CONT_FLAG
               # Comparison '1
                    <                   # goto LOOP_FLAG
                    [                   # while LOOP_FLAG == TRUE
                         >>>+                # goto WORK_F; set TRUE
                         <                   # goto WORK
                         [                   # if WORK != 0
                              >>>>+               # goto 4M_F; set TRUE
                              <                   # goto 4M
                              [                   # if 4M != 0
                                   -                   # 4M subtract 1
                                   <<<-                # goto WORK; subtract 1
                                   >>>>-               # goto 4M_F; set FALSE
                              ]>[                 # elif 4M == 0:
                                   # WORK gt 4M'1; A GT 4M
                                   -                   # 4M_F set FALSE
                                   <<-                 # goto LOOP_FLAG; set FALSE
                                   <<<<<<<<<<<<<<<     # goto PROGRAM_LOOP
                                        <<<<<<<<<<
                                   -                   # PROGRAM_LOOP set FALSE
                                   >>>>>>>>>>>>>>>     # goto WORK; drain
                                        >>>>>>>>>>
                                        >>[-]
                                   >>>>>               # goto 4M_B
                              ]                   # endif @4M_B
                              <<<<-               # goto WORK_F; set FALSE
                         ]>[                 # elif WORK == 0
                              -                   # WORK_F set FALSE
                              >>>+                # goto 4M_F; set TRUE
                              <                   # goto 4M
                              [                   # if 4M != 0
                                   # WORK IS LT 4M'1; A LT 4M
                                   [-]                 # 4M drain
                                   <<<<<-              # goto LOOP_FLAG; set FALSE
                                   <<+                 # goto LT4M_FLAG; set TRUE
                                   >>>>>>>>-           # goto 4M_F; set FALSE
                              ]>[                 # elif 4M == 0:
                                   # WORK IS EQ 4M'1; DO COMPARISON '0
                                   -                   # 4M_F set FALSE
                                   <<<<<+              # goto CONT_FLAG; set TRUE
                                   <-                  # goto LOOP_FLAG; set FALSE
                                   >>>>>>>             # goto 4M_B
                              ]                   # endif @4M_B
                              <<<                 # goto WORK_B
                         ]                   # endif @WORK_B
                         <<<<                # goto LOOP_FLAG
                    ]                   # endwhile @LOOP_FLAG
               # Comparison '0:    Since 4M'0 == 0; A will be GT/E 4M if execution has 
                    made it to this point: The value of A'0 does not 
                    matter so the code for Comparison '0 is to just halt
                    operation
                    >                   # goto CONT_FLAG
                    [                   # if CONT_FLAG == TRUE
                         -                   # CONT_FLAG set FALSE
                         <<<<<<<<<<<<<<<     # goto PROGRAM_LOOP; set FALSE
                              <<<<<<<<<<
                              <-
                         >>>>>>>>>>>>>>>     # goto CONT_FLAG; set FALSE
                              >>>>>>>>>>
                              >
                    ]                   # endif @CONT_FLAG

          # USE MODULO FLAGS
          # If LT4M_FLAG == TRUE; check if A is even
               <<<                 # goto LT4M_FLAG
               [                   # if LT4M_FLAG == TRUE
                    # N % 2 Setup
                         <<<<<<<<<           # goto A'0
                         [->+>>>>>>>>>>>     # copy A'0:N via COPY'1
                              >+<<<<<<<<
                              <<<<<]>[-<
                              +>]            # endcopy @ COPY'1
                    # N % 2
                         # Process
                              >>>>>>>>>>+         # goto LOOP_FLAG; set TRUE
                              [                   # while LOOP_FLAG == TRUE
                                   >>                  # goto N
                                   [->+>+<<]>>[-<<+>>] # copy N:WORK via WORK_F; endcopy @WORK_F
                                   >>++                # goto MOD; set 2
                                   <<<<<+              # goto CMP_FLAG; set TRUE
                                   [                   # while CMP_FLAG
                                        >>>+                # goto WORK_F; set TRUE
                                        <                   # goto WORK
                                        [                   # if WORK != 0
                                             >>>>+               # goto MOD_F; set TRUE
                                             <                   # goto MOD
                                             [                   # if MOD != 0
                                                  <<<-                # goto WORK; subtract 1
                                                  >>>-                # goto MOD; subtract 1
                                                  >-                  # goto MOD_F; set FALSE
                                             ]>[                 # elif MOD == 0
                                                  -                   # MOD_F set FALSE
                                                  <<<<<<-             # goto CMP_FLAG; set FALSE
                                                  >--                 # goto N; subtract 2
                                                  >[-]                # goto WORK; drain
                                                  >>>>>               # goto MOD_B
                                             ]                   # endif @MOD_B
                                             <<<<-               # goto WORK_F; set FALSE
                                        ]>[                 # elif WORK == 0
                                             # WORK IS LTE MOD
                                             -                   # WORK_F set FALSE
                                             <<-                 # goto N; subtract 1
                                             <-                  # goto CMP_FLAG; set FALSE
                                             <-                  # goto LOOP_FLAG; set FALSE
                                             >>>>>>[-]           # goto MOD; drain
                                             <                   # goto WORK_B
                                        ]                   # endif @WORK_B
                                        <<<<                # goto CMP_FLAG
                                   ]                   # endwhile @CMP_FLAG
                                   <                   # goto LOOP_FLAG
                              ]                   # endwhile @LOOP_FLAG
                         # USE EVEN FLAGS
                         # Results
                              >>>+                # goto N_F; set TRUE
                              <                   # goto N
                              [                   # if N != 0
                                   # A is even
                                   [-]                 # N drain
                                   <<<+                # goto E_FLAG; set TRUE
                                   >>>>-               # goto N_F; set FALSE
                              ]>[                 # elif N == 0
                                   # A is odd
                                   -                   # N_F set FALSE
                                   >                   # goto N_B
                              ]                   # endif @N_B
                    <<<<<<-             # goto LT4M_FLAG; set FALSE
               ]                   # endif @ LT4M_FLAG

          # MAIN FLAGS ONLY
          # If E_FLAG == TRUE; add A to SUM
               >                   # goto E_FLAG
               [                   # if E_FLAG == TRUE
                    # Add A'0:SUM'0 via COPY'1
                         <<<<<<<<<<          # goto A'0
                         [                   # while A'0 !=0
                              -                   # A'0 subtract 1
                              >+                  # goto COPY'1; add 1
                              >>>>>>+             # goto SUM'0_F; set TRUE
                              <+                  # goto SUM'0; add 1
                              [                   # if SUM'0 != 0
                                   >-                  # goto SUM'0_F; set FALSE
                              ]>[                 # elif SUM'0 == 0
                                   -                   # SUM'0_F set FALSE
                                   <<<+                # goto SUM'1_F; set TRUE
                                   <+                  # goto SUM'1; add 1
                                   [                   # if SUM'1 != 0
                                        >-                  # goto SUM'1_F; set FALSE
                                   ]>[                 # elif SUM'1 == 0
                                        -                   # SUM'1_F set FALSE
                                        <<+                 # goto SUM'2; add 1
                                        >>>                 # goto SUM'1_B
                                   ]                   # endif @SUM'1_B
                                   >>>                 # goto SUM'0_B
                              ]                   # endif @SUM'0_B
                              <<<<<<<<            # goto A'0
                         ]                   # endwhile @A'0
                         >[-<+>]             # goto COPY'1; cut COPY'1:A'0; endcut @COPY'1
                    # Add A'1:SUM'1 via COPY'1
                         <<                  # goto A'1
                         [                   # while A'1
                              -                   # A'1 subtract 1
                              >>+                 # goto COPY'1; add 1
                              >>>+                # goto SUM'1_F; set TRUE
                              <+                  # goto SUM'1; add 1
                              [                   # if SUM'1 != 0
                                   >-                  # goto SUM'1_F; set FALSE
                              ]>[                 # elif SUM'1 == 0
                                   -                   # SUM'1_F set FALSE
                                   <<+                 # goto SUM'2; add 1
                                   >>>                 # goto SUM'1_B
                              ]                   # endif @SUM'1_B
                              <<<<<<              # goto A'1
                         ]                   # endwhile @A'1
                         >>[-<<+>>]          # goto COPY'1; cut COPY'1:A'1; endcut @COPY'1
                    # Add A'2:SUM'2 via COPY'1
                         <<<                 # goto A'2
                         [                   # while A'2 != 0
                              -                   # A'2 subtract 1
                              >>>+                # goto COPY'1; add 1
                              >+                  # goto SUM'2; add 1
                              <<<<                # goto A'2
                         ]                   # endwhile @A'2
                         >>>[-<<<+>>>]       # goto COPY'1; cut COPY'1:A'2; endcut @COPY'1
                    >>>>>>>>>-          # goto E_FLAG; set FALSE
               ]                   # endif @E_FLAG

          # Generate Next Term
               # Copy B:C via COPY'0
                    <<<<<<<<<<<<<<<     # goto B'2
                         <<<<<<<<       
                    [->>>>>>>+>+<<<     # copy B'2:C'2 via COPY'0
                         <<<<<]>>>>
                         >>>[-<<<<<
                         <<+>>>>>>>]    # endcopy @COPY'0
                    <<<<<<              # goto B'1
                    [->>>>>>+>>+<<<     # copy B'1:C'1 via COPY'0
                         <<<<<]>>>>
                         >>[-<<<<<<
                         +>>>>>>]       # endcopy @COPY'0
                    <<<                 # goto B'0
                    [->>>+>>>+<<<<<     # copy B'0:C'0 via COPY'0
                         <]>>>[-<<<
                         +>>>]          # endcopy @COPY'0
               # Add A:B (destructive)
                    # Add A'0:B'0
                         >>>>>>              # goto A'0
                         [                   # while A'0 != 0
                              -                   # A'0 subtract 1
                              <<<<<<<<+           # goto B'0_F; set TRUE
                              <+                  # goto B'0; add 1
                              [                   # if B'0 != 0
                                   >-                  # goto B'0_F; set FALSE
                              ]>[                 # elif B'0 == 0
                                   -                   # B'0_F set FALSE
                                   <<<+                # goto B'1_F; set TRUE
                                   <+                  # goto B'1; add 1
                                   [                   # if B'1 != 0
                                        >-                  # goto B'1_F; set FALSE
                                   ]>[                 # elif B'1 == 0
                                        -                   # B'1_F set FALSE
                                        <<+                 # goto B'2; add 1
                                        >>>                 # goto B'1_B
                                   ]                   # endif @B'1_B
                                   >>>                 # goto B'0_B
                              ]                   # endif @B'0_B
                              >>>>>>>             # goto A'0
                         ]                   # endwhile @A'0
                    # Add A'1:B'1
                         <                   # goto A'1
                         [                   # while A'1 != 0
                              -                   # A'1 subtract 1
                              <<<<<<<<<<+         # goto B'1_F; set TRUE
                              <+                  # goto B'1; add 1
                              [                   # if B'1 != 0
                                   >-                  # goto B'1_F; set FALSE
                              ]>[                 # elif B'1 == 0
                                   -                   # B'1_F set FALSE
                                   <<+                 # goto B'2; add 1
                                   >>>                 # goto B'1_B
                              ]                   # endif @B'1_B
                              >>>>>>>>>           # goto A'1
                         ]                   # endwhile @A'1
                    # Add A'2:B'2
                         <                   # goto A'2
                         [                   # while A'2 != 0
                              -                   # A'2 subtract 1
                              <<<<<<<<<<<+        # goto B'2; add 1
                              >>>>>>>>>>>         # goto A'2
                         ]                   # endwhile @A'2
               # Cut C:A
                    <                   # goto C'0
                    [->>>+<<<]          # cut C'0:A'0; endcut @C'0
                    <                   # goto C'1
                    [->>>+<<<]          # cut C'1:A'1; endcut @C'1
                    <                   # goto C'2
                    [->>>+<<<]          # cut C'2:A'2; endcut @C'2
          <<<<<<<<<           # goto PROGRAM_LOOP
     ]                   # endwhile PROGRAM_LOOP

# CONVERT AND PRINT SUM AS BASE 10
     # Conversion Setup
          >>>>>>>>>>>>>>>     # goto SUM'0;cut SUM'0:23; endcut @20
               >>>>>[->>>
               +<<<]
          <<<[->>>+<<<]       # goto SUM'1; cut SUM'1:20; endcut @17
          <[->+<]             # goto SUM'0; cut SUM'0:17; endcut @16
     # USE CONVERSION FLAGS
     # Conversion
          <+        # goto LOOP_FLAG; set TRUE
          [                   # while LOOP_FLAG == TRUE
               # Division Setup
                    >>>>>>>>>>>>>>+     # goto MOD; set 10
                         +++++++++
               # Division
                    <<<<<<<<<<<<<+      # goto CMP_FLAG; set TRUE
                    [                   # while CMP_FLAG == TRUE
                         # Check if WORK != 0; store result in NOT'0
                              # tested: checking 0 first results in fewer executions
                              >>>>>>>>+           # goto WORK'0_F; set TRUE
                              <                   # goto WORK'0
                              [                   # if WORK'0 != 0
                                   >>>[-]+             # goto NOT'0; clear; set TRUE
                                   <<-                 # goto WORK'0_F; set FALSE
                              ]>[                 # elif WORK'0 == 0
                                   -                   # WORK'0_F set FALSE
                                   <<<+                # goto WORK'1_F; set TRUE
                                   <                   # goto WORK'1
                                   [                   # if WORK'1 != 0
                                        >>>>>>[-]+          # goto NOT'0; clear; set TRUE
                                        <<<<<-              # goto WORK'1_F; set FALSE
                                   ]>[                 # elif WORK'1 == 0
                                        -                   # WORK'1_F set FALSE
                                        <<<+                # goto WORK'2_F set TRUE
                                        <                   # goto WORK_2
                                        [                   # if WORK'2 != 0
                                             >>>>>>>>>[-]+       # goto NOT'0; clear; set TRUE
                                             <<<<<<<<-           # goto WORK'2_F; set FALSE
                                        ]>[                 # elif WORK'2 == 0
                                             -                   # WORK'2_F set FALSE
                                             >                   # goto WORK'2_B
                                        ]                   # endif @WORK'2_B
                                        >>>                 # goto WORK'1_B
                                   ]                   # endif @WORK'1_B
                                   >>>                 # goto WORK'0_B
                              ]                   # endif @WORK'0_B
                         # Division
                              >>+                 # goto NOT'0_F; set TRUE
                              <                   # goto NOT'0
                              [                   # if NOT'0 == TRUE (if WORK != 0)
                                   >>>>+               # goto MOD_F; set TRUE
                                   <                   # goto MOD
                                   [                   # if MOD != 0
                                        # Continue Subtraction
                                        -                   # MOD subtract 1
                                        # WORK subtract 1
                                             <<<<<+              # goto WORK'0_F; set TRUE
                                             <                   # goto WORK'0
                                             [                   # if WORK'0 != 0
                                                  -                   # WORK'0 subtract 1
                                                  >-                  # goto WORK'0_F; set FALSE
                                             ]>[                 # elif WORK'0 == 0
                                                  -                   # WORK'0_F set FALSE
                                                  <-                  # goto WORK'0; subtract 1
                                                  <<+                 # goto WORK'1_F; set TRUE
                                                  <                   # goto WORK'1
                                                  [                   # if WORK'1 != 0
                                                       -                   # WORK'1 subtract 1
                                                       >-                  # goto WORK'1_F; set FALSE
                                                  ]>[                 # elif WORK'1 == 0
                                                       -                   # WORK'1_F set FALSE
                                                       <-                  # goto WORK'1; subtract 1
                                                       # WORK'2 is unlikely to underflow: do not need to test
                                                       <<<-                # goto WORK'2; subtract 1
                                                       >>>>>               # goto WORK'1_B
                                                  ]                   # endif @WORK'1_B
                                                  >>>                 # goto WORK'0_B
                                             ]                   # endif @WORK'0_B
                                        >>>>>-              # goto MOD_F; set FALSE
                                   ]>[                 # elif MOD == 0
                                        # WORK gt MOD: increment Q
                                        -                   # MOD_F set FALSE
                                        <<<<<<<<<<<<<<-     # goto CMP_FLAG; set FALSE
                                        # Q add 1
                                             >>>>>>>>>>>>>>>     # goto Q'0_F; set TRUE
                                                  >>>>>>+
                                             <+                  # goto Q'0; add 1
                                             [                   # if Q'0 != 0
                                                  >-                  # goto Q'0_F; set FALSE
                                             ]>[                 # elif Q'0 == 0
                                                  -                   # Q'0_F set FALSE
                                                  <<<+                # goto Q'1_F; set TRUE
                                                  <+                  # goto Q'1; add 1
                                                  [                   # if Q'1 != 0
                                                       >-                  # goto Q'1_F; set FALSE
                                                  ]>[                 # elif Q'1 == 0
                                                       -                   # Q'1_F set FALSE
                                                       <<+                 # goto Q'2; add 1
                                                       >>>                 # goto Q'1_B
                                                  ]                   # endif @Q'1_B
                                                  >>>                 # goto Q'0_B
                                             ]                   # endif @ Q'0_B
                                        <<<<<<<                  # goto MOD_B
                                   ]                   # endif @MOD_B
                                   <<<<-               # goto NOT'0_F; set FALSE
                              ]>[                 # elif NOT'0 == FALSE (elif WORK == 0)
                                   -                   # NOT'0_F set FALSE
                                   # Move MOD to Output List
                                        # Convert MOD into an ascii numeral
                                             >>>++++++++++       # goto MOD_F; set 10
                                             <[->-<]             # 10 minus MOD into MOD_F; endminus @MOD
                                             >[->+<]             # goto MOD_F; cut MOD_F:MOD_B; endcut @MOD_F
                                             <++++++[->+++++     # goto MOD; MOD_F set 6 * 8 = 48; endset @MOD
                                                  +++<]
                                        # Move first unit without loop (ensures ZIP behaves predictably)
                                             >>[-<+>]            # goto MOD_B; cut MOD_B:MOD_F; endcut @MOD_B
                                             <-                  # goto MOD_F; subtract 1 (manually handles first operation of move so zip functions predictably)
                                             >>>>>>>>>[>]+       # goto Output; zip to first open; add 1
                                        # Move remaining unit with loop
                                             [<]<<<<<<<<         # zip to Q'0_B; goto MOD_F
                                             [                   # while MOD_F != 0
                                                  -                   # MOD_F subtract 1
                                                  >>>>>>>>>[>]        # goto Output; zip to first open; step to last occupied; add 1
                                                  <+                  # step to last occupied number; add 1
                                                  [<]<<<<<<<<         # zip to Q'0_B; goto MOD_F
                                             ]                   # endwhile @MOD_F
                                   & DUMP THE VALUES HERE AND MAKE SURE THAT WORK IS ALL ZEROES
                                   # Cut Q:WORK
                                        >>[-<<<<<<<<<<<          # goto Q'2; cut Q'2:WORK'2
                                             <<<<+>>>>>
                                             >>>>>>>>>>]         # endcut @Q'2
                                        >[-<<<<<<<<<<<<          # goto Q'1; cut Q'1:WORK'1
                                             <+>>>>>>>>
                                             >>>>>]              # endcut @Q'1
                                        >>>[-<<<<<<<<<<          # goto Q'0; cut Q'0:WORK'0
                                             <<<+>>>>>>
                                             >>>>>>>]            # endcut @Q'0
                                   <<<<<<<<<<<<<<<<<<<<-    # goto CMP_FLAG; set FALSE
                                   # Check if WORK != 0; if zero: LOOP_FLAG set FALSE
                                        >>>>>>>>+           # goto WORK'0_F; set TRUE
                                        <                   # goto WORK'0
                                        [                   # if WORK'0 != 0
                                             >-                  # goto WORK'0_F; set FALSE
                                        ]>[                 # elif WORK'0 == 0
                                             -                   # WORK'0_F set FALSE
                                             <<<+                # goto WORK'1_F; set TRUE
                                             <                   # goto WORK'1
                                             [                   # if WORK'1 != 0
                                                  >-             # goto WORK'1_F; set FALSE
                                             ]>[                 # elif WORK'1 == 0
                                                  -                   # WORK'1_F set FALSE
                                                  <<<+                # goto WORK'2_F set TRUE
                                                  <                   # goto WORK_2
                                                  [                   # if WORK'2 != 0
                                                       >-             # goto WORK'2_F; set FALSE
                                                  ]>[                 # elif WORK'2 == 0
                                                       -                   # WORK'2_F set FALSE
                                                       <<<-                # goto LOOP_FLAG; set FALSE
                                                       >>>>                # goto WORK'2_B
                                                  ]                   # endif @WORK'2_B
                                                  >>>                 # goto WORK'1_B
                                             ]                   # endif @WORK'1_B
                                             >>>                 # goto WORK'0_B
                                        ]                   # endif @WORK'0_B
                                   >>>            # goto NOT'0_B
                              ]                   # endif @NOT'0_B
                              <<[-]               # goto NOT'0; clear
                              <<<<<<<<<<          # goto CMP_FLAG
                    ]                   # endwhile CMP_FLAG
               <                   # goto LOOP_FLAG
          ]                   # endwhile @LOOP_FLAG

# PRINT RESULT
     >>>>>>>>>>>>>>>>>>>>     # goto Output list; zip to first open; step to last filled; print
          >>>>[>]<[.<]