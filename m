Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A692F7AAB;
	Tue, 17 Mar 2026 08:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735718; cv=none; b=izbNCihl7YYTSmedJtFy2y48TsRBlj+zQa8roxQTdNv1EWW7aIEa6iN2OJYvcilxm8NiJ3wtwPMi8wg3gKOzrc25F5Ax57iSG+0m5hG46bX7amIR2rEJiDwTlkvJ+PEWLXDxmNYJ5U5fzm6iEvKFXW6FoJtZYBEU4RVWMwPWafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735718; c=relaxed/simple;
	bh=fTN94n5YikLrAdrBwsqn+R5jLfwVuqObhU1lgsxxFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0Xx11h2mwbOLMIJpKJ63DPCX4OLWYg+YWIS/I2lwQU72LokrX3qrU1mAbmn43VyBFJgrquV8R/rIRFlE18SRrniQrceXijZQK8GYCF9bxakXwFivI5UlW88DbtHPpZ732JK6PcKJBa9Y37uyHTFmBFEKZqrurOCbaUqKkpwCU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtbbaQMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtbbaQMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED0EC4CEF7;
	Tue, 17 Mar 2026 08:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773735718;
	bh=fTN94n5YikLrAdrBwsqn+R5jLfwVuqObhU1lgsxxFN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GtbbaQMciVsL+dnpkbI1MWB+fLYnXwwGk1J3+yJjAfia3zZ4W8AlkCgZ99RH8ijzh
	 myHZTSH0JzYj3U15MnqYuxT95LKfmhGBjQzcN4mHSfcG2/DhblxfV60UWIV27bhmjC
	 jV2DQvDdbSzNIOgspM3TUORaHYDZwLcfYNZl9XaRAvef3ZqVrtJRUPr80jZN7PIE0/
	 tgLqbVALAw2NJwF1RVtz0EuteIX3BjwAycUy6M20Em4NKcfFYLs1l5MiEBGxj4goKB
	 33TUBtPeINy2YFr5kGpnTywXIq+iBXkzX8wAOt1f0v5JBBCy7qjp/gUPORN8WTb7eA
	 y+Bk+za1d6lvQ==
Date: Tue, 17 Mar 2026 09:21:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
Message-ID: <20260317092153.11f2b10d@foz.lan>
In-Reply-To: <87ldfrfimx.fsf@trenco.lwn.net>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
	<8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
	<177370220974.1754131.9642805524574261129.b4-review@b4>
	<c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
	<87ldfrfimx.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 17:40:22 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Randy Dunlap <rdunlap@infradead.org> writes:
> 
> > Uh, I find this review confusing.
> > Do your (Jon) comments refer to the code above them?
> > (more below)  
> 
> They do
> 
> Or, at least, they did...but they clearly got mixed up in the sending
> somewhere.  Below is the intended version...

Oh, I should have read this one before... Ignore my previous comment.
I'll move the answers to this reply, and answer the other ones.

> > tools/lib/python/kdoc/kdoc_re.py | 234 +++++++++++++++++++++++++++++++
> >  1 file changed, 234 insertions(+)
> > 
> > diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
> > index 085b89a4547c..7bed4e9a8810 100644
> > --- a/tools/lib/python/kdoc/kdoc_re.py
> > +++ b/tools/lib/python/kdoc/kdoc_re.py
> > @@ -141,6 +141,240 @@ class KernRe:
> > 
> > 	 return self.last_match.groups()
> > 
> > +class TokType():
> > +
> > +    @staticmethod
> > +    def __str__(val):
> > +        ""Return the name of an enum value""
> > +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")  
> 
> What is this class supposed to do?

This __str__() method ensures that, when printing a CToken object,
the name will be displayed, instead of a number. This is really
useful when debugging.

See, if I add a print:

<snip>
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -87,6 +87,7 @@ def trim_private_members(text):
     """
 
     tokens = CTokenizer(text)
+    print(tokens.tokens)
     return str(tokens)
 
</snip>

the tokens will appear as names at the output:

$ ./scripts/kernel-doc -none er.c
[CToken(CToken.ENUM, "enum", 0, (0, 0, 0)), CToken(CToken.SPACE, " ", 4, (0, 0, 0)), CToken(CToken.NAME, "dmub_abm_ace_curve_type", 5, (0, 0, 0)), CToken(CToken.SPACE, " ", 28, (0, 0, 0)), CToken(CToken.BEGIN, "{", 29, (0, 0, 1)), CToken(CToken.SPACE, " ", 30, (0, 0, 1)), CToken(CToken.COMMENT, "/**
         * ACE curve as defined by the SW layer. */", 31, (0, 0, 1)), CToken(CToken.SPACE, " ", 86, (0, 0, 1)), CToken(CToken.NAME, "ABM_ACE_CURVE_TYPE__SW", 87, (0, 0, 1)), CToken(CToken.SPACE, " ", 109, (0, 0, 1)), CToken(CToken.OP, "=", 110, (0, 0, 1)), CToken(CToken.SPACE, " ", 111, (0, 0, 1)), CToken(CToken.NUMBER, "0", 112, (0, 0, 1)), CToken(CToken.PUNC, ",", 113, (0, 0, 1)), CToken(CToken.SPACE, " ", 114, (0, 0, 1)), CToken(CToken.COMMENT, "/**
         * ACE curve as defined by the SW to HW translation interface layer. */", 115, (0, 0, 1)), CToken(CToken.SPACE, " ", 198, (0, 0, 1)), CToken(CToken.NAME, "ABM_ACE_CURVE_TYPE__SW_IF", 199, (0, 0, 1)), CToken(CToken.SPACE, " ", 224, (0, 0, 1)), CToken(CToken.OP, "=", 225, (0, 0, 1)), CToken(CToken.SPACE, " ", 226, (0, 0, 1)), CToken(CToken.NUMBER, "1", 227, (0, 0, 1)), CToken(CToken.PUNC, ",", 228, (0, 0, 1)), CToken(CToken.SPACE, " ", 229, (0, 0, 1)), CToken(CToken.END, "}", 230, (0, 0, 0)), CToken(CToken.PUNC, ";", 231, (0, 0, 0))]

> 
> > +
> > +class CToken():
> > +    ""
> > +    Data class to define a C token.
> > +    ""
> > +
> > +    # Tokens that can be used by the parser. Works like an C enum.
> > +
> > +    COMMENT = 0     #: A standard C or C99 comment, including delimiter.
> > +    STRING = 1      #: A string, including quotation marks.
> > +    CHAR = 2        #: A character, including apostophes.
> > +    NUMBER = 3      #: A number.
> > +    PUNC = 4        #: A puntuation mark: ``;`` / ``,`` / ``.``.
> > +    BEGIN = 5       #: A begin character: ``{`` / ``[`` / ``(``.
> > +    END = 6         #: A end character: ``}`` / ``]`` / ``)``.
> > +    CPP = 7         #: A preprocessor macro.
> > +    HASH = 8        #: The hash character - useful to handle other macros.
> > +    OP = 9          #: A C operator (add, subtract, ...).
> > +    STRUCT = 10     #: A ``struct`` keyword.
> > +    UNION = 11      #: An ``union`` keyword.
> > +    ENUM = 12       #: A ``struct`` keyword.
> > +    TYPEDEF = 13    #: A ``typedef`` keyword.
> > +    NAME = 14       #: A name. Can be an ID or a type.
> > +    SPACE = 15      #: Any space characters, including new lines
> > +
> > +    MISMATCH = 255  #: an error indicator: should never happen in practice.
> > +
> > +    # Dict to convert from an enum interger into a string.
> > +    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
> > +
> > +    # Dict to convert from string to an enum-like integer value.
> > +    _name_to_val = {k: v for v, k in _name_by_val.items()}  
> 
> This stuff strikes me as a bit overdone; _name_to_val is really just the
> variable list for the class, right?

Those two vars are a kind of magic: they create two dictionaries:

- _name_by_val converts a token integer into a string;
- _name_to_val converts a string to an integer.

I opted to use this approach for a couple of reasons:

1. using tok.kind == "BEGIN" (and similar) everywhere is harder to
maintain, as python won't check for typos. Now, if one writes:
CToken.BEGHIN, an error will be raised;

2. the cost to convert from string to int is O(1), so not much
   a performance issue at the conversion;

3. using an integer on all checks should make the code faster as
   it doesn't require a loop to check the string.

> 
> > +
> > +    @staticmethod
> > +    def to_name(val):
> > +        ""Convert from an integer value from CToken enum into a string""
> > +
> > +        return CToken._name_by_val.get(val, f"UNKNOWN({val})")
> > +
> > +    @staticmethod
> > +    def from_name(name):
> > +        ""Convert a string into a CToken enum value""
> > +        if name in CToken._name_to_val:
> > +            return CToken._name_to_val[name]
> > +
> > +        return CToken.MISMATCH
> > +
> > +    def __init__(self, kind, value, pos,
> > +                 brace_level, paren_level, bracket_level):
> > +        self.kind = kind
> > +        self.value = value
> > +        self.pos = pos
> > +        self.brace_level = brace_level
> > +        self.paren_level = paren_level
> > +        self.bracket_level = bracket_level
> > +
> > +    def __repr__(self):
> > +        name = self.to_name(self.kind)
> > +        if isinstance(self.value, str):
> > +            value = '"' + self.value + '"'
> > +        else:
> > +            value = self.value
> > +
> > +        return f"CToken({name}, {value}, {self.pos}, " \
> > +               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
> > +
> > +#: Tokens to parse C code.
> > +TOKEN_LIST = [  
> 
> So these aren't "tokens", this is a list of regexes; how is it intended
> to be used?
> 
> > +    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),  
> 
> How does "[\s\S]*" differ from plain old "*" ?

They are not identical, as "*" doesn't match "\n". As the tokenizer
also picks "\n" on several cases, like on comments, r"\s\S" works
better.

> 
> > +
> > +    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
> > +    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
> > +
> > +    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
> > +                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
> > +
> > +    (CToken.PUNC,    r"[;,\.]"),
> > +
> > +    (CToken.BEGIN,   r"[\[\(\{]"),
> > +
> > +    (CToken.END,     r"[\]\)\}]"),
> > +
> > +    (CToken.CPP,     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
> > +
> > +    (CToken.HASH,    r"#"),
> > +
> > +    (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
> > +                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),  
> 
> "-" and "!" never need to be escaped.

"-" usually needs to be escaped, because it can be a range. I actually
tried without escaping it, but the regex failed. So I ended being 
conservative. 

> 
> > +
> > +    (CToken.STRUCT,  r"\bstruct\b"),
> > +    (CToken.UNION,   r"\bunion\b"),
> > +    (CToken.ENUM,    r"\benum\b"),
> > +    (CToken.TYPEDEF, r"\bkinddef\b"),  
> 
> "kinddef" ?

Should be "typedef".

This was due to a "sed s,type,kind," I applied to avoid using
"type" for the token type, as, when I started integrating it
with kdoc_re, it became confusing.

I'll fix at the next respin.


> 
> > +
> > +    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
> > +
> > +    (CToken.SPACE,   r"[\s]+"),  
> 
> Don't need the [brackets] here

True. This was [ \t] and there as a separate token for new line.
I merged them, but forgot stripping the brackets.

Will cleanup at the next respin.

> 
> > +
> > +    (CToken.MISMATCH,r"."),
> > +]
> > +
> > +#: Handle C continuation lines.
> > +RE_CONT = KernRe(r"\\\n")
> > +
> > +RE_COMMENT_START = KernRe(r'/\*\s*')
> > +
> > +#: tokenizer regex. Will be filled at the first CTokenizer usage.
> > +re_scanner = None  
> 
> That seems weird, why don't you just initialize it here?

Yeah, I changed this one to:

	def fill_re_scanner(token_list):
	    """Ancillary routine to convert TOKEN_LIST into a finditer regex"""
	    re_tokens = []

	    for kind, pattern in token_list:
	        name = CToken.to_name(kind)
	        re_tokens.append(f"(?P<{name}>{pattern})")

	    return KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)

	RE_SCANNER = fill_re_scanner(TOKEN_LIST)

but I guess tis is on a patch later on.

> 
> > +
> > +class CTokenizer():
> > +    ""
> > +    Scan C statements and definitions and produce tokens.
> > +
> > +    When converted to string, it drops comments and handle public/private
> > +    values, respecting depth.
> > +    ""
> > +
> > +    # This class is inspired and follows the basic concepts of:
> > +    #   https://docs.python.org/3/library/re.html#writing-a-tokenizer
> > +
> > +    def _tokenize(self, source):
> > +        ""
> > +        Interactor that parses ``source``, splitting it into tokens, as defined
> > +        at ``self.TOKEN_LIST``.
> > +
> > +        The interactor returns a CToken class object.
> > +        ""  
> 
> Do you mean "iterator" here?

Yes. will fix at the next respin.

> 
> > +
> > +        # Handle continuation lines. Note that kdoc_parser already has a
> > +        # logic to do that. Still, let's keep it for completeness, as we might
> > +        # end re-using this tokenizer outsize kernel-doc some day - or we may
> > +        # eventually remove from there as a future cleanup.
> > +        source = RE_CONT.sub(", source)
> > +
> > +        brace_level = 0
> > +        paren_level = 0
> > +        bracket_level = 0
> > +
> > +        for match in re_scanner.finditer(source):
> > +            kind = CToken.from_name(match.lastgroup)
> > +            pos = match.start()
> > +            value = match.group()
> > +
> > +            if kind == CToken.MISMATCH:
> > +                raise RuntimeError(f"Unexpected token '{value}' on {pos}:\n\t{source}")
> > +            elif kind == CToken.BEGIN:
> > +                if value == '(':
> > +                    paren_level += 1
> > +                elif value == '[':
> > +                    bracket_level += 1
> > +                else:  # value == '{'
> > +                    brace_level += 1
> > +
> > +            elif kind == CToken.END:
> > +                if value == ')' and paren_level > 0:
> > +                    paren_level -= 1
> > +                elif value == ']' and bracket_level > 0:
> > +                    bracket_level -= 1
> > +                elif brace_level > 0:    # value == '}'
> > +                    brace_level -= 1
> > +
> > +            yield CToken(kind, value, pos,
> > +                         brace_level, paren_level, bracket_level)
> > +
> > +    def __init__(self, source):  
> 
> Putting __init__() first is fairly standard, methinks.

Yes, but __init__ calls _tokenize().

My personal preference is to have the caller methods before the methods 
that actually call them, even inside a class, where the order doesn't
matter - or even in C, when we have an include with all prototypes.

But if you prefer, I can reorder it.

> 
> > +        ""
> > +        Create a regular expression to handle TOKEN_LIST.
> > +
> > +        While I generally don't like using regex group naming via:
> > +            (?P<name>...)
> > +
> > +        in this particular case, it makes sense, as we can pick the name
> > +        when matching a code via re_scanner().
> > +        ""
> > +        global re_scanner
> > +
> > +        if not re_scanner:
> > +            re_tokens = []
> > +
> > +            for kind, pattern in TOKEN_LIST:
> > +                name = CToken.to_name(kind)
> > +                re_tokens.append(f"(?P<{name}>{pattern})")
> > +
> > +            re_scanner = KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)  
> 
> I still don't understand why you do this here - this is all constant, right?

Yes. See above. I moved this logic to a function and called it during
module init time, for it to happen just once.

> 
> > +
> > +        self.tokens = []
> > +        for tok in self._tokenize(source):
> > +            self.tokens.append(tok)  
> 
> So you create a nice iterator structure, then just put it all together into a
> list anyway?

We could have used yield here, but what's the point? Due to C 
transforms, we'll need to navigate on all tokens multiple times. 

Having them on a list ends saving time, as we only need to 
tokenize once per source code.



> 
> > +
> > +    def __str__(self):
> > +        out="
> > +        show_stack = [True]
> > +
> > +        for tok in self.tokens:
> > +            if tok.kind == CToken.BEGIN:
> > +                show_stack.append(show_stack[-1])
> > +
> > +            elif tok.kind == CToken.END:
> > +                prev = show_stack[-1]
> > +                if len(show_stack) > 1:
> > +                    show_stack.pop()
> > +
> > +                if not prev and show_stack[-1]:
> > +                    #
> > +                    # Try to preserve indent
> > +                    #
> > +                    out += "\t" * (len(show_stack) - 1)
> > +
> > +                    out += str(tok.value)
> > +                    continue
> > +
> > +            elif tok.kind == CToken.COMMENT:
> > +                comment = RE_COMMENT_START.sub(", tok.value)
> > +
> > +                if comment.startswith("private:"):
> > +                    show_stack[-1] = False
> > +                    show = False
> > +                elif comment.startswith("public:"):
> > +                    show_stack[-1] = True
> > +
> > +                continue
> > +
> > +            if show_stack[-1]:
> > +                    out += str(tok.value)
> > +
> > +        return out
> > +
> > +
> >  #: Nested delimited pairs (brackets and parenthesis)
> >  DELIMITER_PAIRS = {
> >      '{': '}',  
> 
> Thanks,
> 
> jon
> 



Thanks,
Mauro
