using ADNLPModelProblems

n = 10
problems1 = ["arglina", "arglinb", "arglinc", "arwhead", "bdqrtic", "beale", "broydn7d",
"brybnd", "chainwoo", "chnrosnb_mod", "cosine", "cragglvy", "curly10", "curly20", 
"curly30", "dixon3dq", "dqdrtic",
"dqrtic", "edensch", "eg2", "engval1", "errinros_mod", "extrosnb", "fletcbv2",
"fletcbv3_mod", "fletchcr", "freuroth", "genhumps", "genrose", "genrose_nash",
"indef_mod", "liarwhd", "morebv", "ncb20", "ncb20b", "noncvxu2", "noncvxun",
"nondia", "nondquar", "NZF1", "penalty2", "penalty3", "powellsg", "power",
"quartc", "sbrybnd", "schmvett", "scosine", "sparsine", "sparsqur", "srosenbr",
"sinquad", "tointgss", "tquartic", "tridia", "vardim", "woods"]
for pb in problems1 # ADNLPModelProblems.problems
  eval(Meta.parse("ADNLPModelProblems.$(pb)_autodiff(n=$n)"))
  eval(Meta.parse("ADNLPModelProblems.$(pb)_reverse(n=$n)"))
  eval(Meta.parse("ADNLPModelProblems.$(pb)_zygote(n=$n)"))
  eval(Meta.parse("ADNLPModelProblems.$(pb)_jump(n=$n)"))
end