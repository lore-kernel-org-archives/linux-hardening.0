Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC9116CD33;
	Mon, 16 Mar 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704425; cv=none; b=AvitEpO+mDz66J5+2EbV5CCuGeAcCukNVdQoTXU6LkXCMDus4GYekV5SXkgbbh4xS4PSrQq26/5T6AoMP+9J2v/DXTtJgu8lZzc1kNxwfRBhJqvBjinQSx5YqBk3fyw7vweLD1AhJPtX/KmBeYAB/7x57k/UeHz/VdeROG5yUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704425; c=relaxed/simple;
	bh=R+T0s17avtD0q3f3P47GPMVrxIF0CqljA/s4d7BXvxE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VdT5+oMjJWk6sOYyAZ/UAayhngKX8cbC4yxGt/Xi4kXn6FDOkk2dq0CalzAvXqdkMOfISM0CZs7NZnUOf+jlTO3hVKVa4kW0mQdD2AgFP6uR2QXlcmJoxY0KU6zMb1TsFa0WieEUiGbZH6SrEB6uL1EOG7ZGxtZAzE4NW5VfUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qgr9/J4e; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qgr9/J4e"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E801340423
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773704423; bh=+w/AeBTsq6X3q5djXR2SGDaTkkQ7rm/COPJ6wEGPR4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qgr9/J4e7boAK+N0MlIaoz3K8Yzf0kpGovOQQAuREyfgxv6j8etFX+/GFw5NwD+J6
	 tMc2ifmXvn5SCKk/zuO/9jGk+d/hsNj6M62MxLMIqn9gLFYyIS2lCRfYLWS5MdXjdi
	 UzruyLHUFc//qb2LMfrWiVf6HuEx9RvyuUzigt9kQvcdNsOPNXXCBA0zxGQdJij7ro
	 ruYPF0y2ffH6YQT+/XwTFgnuESif0nW3fcax9PsMAhr1uZPdZ0F5MWNXzOctwOLSDQ
	 qb0DSacVTWq7QriQsuM8RMvRfSfr/6ICLcPC+iDDoxglaT+7jzpqrX95OgzWl4ULLV
	 HkBM6GAWAeM7A==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E801340423;
	Mon, 16 Mar 2026 23:40:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
In-Reply-To: <c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
 <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
 <177370220974.1754131.9642805524574261129.b4-review@b4>
 <c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
Date: Mon, 16 Mar 2026 17:40:22 -0600
Message-ID: <87ldfrfimx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Uh, I find this review confusing.
> Do your (Jon) comments refer to the code above them?
> (more below)

They do

Or, at least, they did...but they clearly got mixed up in the sending
somewhere.  Below is the intended version...

> tools/lib/python/kdoc/kdoc_re.py | 234 +++++++++++++++++++++++++++++++
>  1 file changed, 234 insertions(+)
> 
> diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
> index 085b89a4547c..7bed4e9a8810 100644
> --- a/tools/lib/python/kdoc/kdoc_re.py
> +++ b/tools/lib/python/kdoc/kdoc_re.py
> @@ -141,6 +141,240 @@ class KernRe:
> 
> 	 return self.last_match.groups()
> 
> +class TokType():
> +
> +    @staticmethod
> +    def __str__(val):
> +        ""Return the name of an enum value""
> +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")

What is this class supposed to do?

> +
> +class CToken():
> +    ""
> +    Data class to define a C token.
> +    ""
> +
> +    # Tokens that can be used by the parser. Works like an C enum.
> +
> +    COMMENT = 0     #: A standard C or C99 comment, including delimiter.
> +    STRING = 1      #: A string, including quotation marks.
> +    CHAR = 2        #: A character, including apostophes.
> +    NUMBER = 3      #: A number.
> +    PUNC = 4        #: A puntuation mark: ``;`` / ``,`` / ``.``.
> +    BEGIN = 5       #: A begin character: ``{`` / ``[`` / ``(``.
> +    END = 6         #: A end character: ``}`` / ``]`` / ``)``.
> +    CPP = 7         #: A preprocessor macro.
> +    HASH = 8        #: The hash character - useful to handle other macros.
> +    OP = 9          #: A C operator (add, subtract, ...).
> +    STRUCT = 10     #: A ``struct`` keyword.
> +    UNION = 11      #: An ``union`` keyword.
> +    ENUM = 12       #: A ``struct`` keyword.
> +    TYPEDEF = 13    #: A ``typedef`` keyword.
> +    NAME = 14       #: A name. Can be an ID or a type.
> +    SPACE = 15      #: Any space characters, including new lines
> +
> +    MISMATCH = 255  #: an error indicator: should never happen in practice.
> +
> +    # Dict to convert from an enum interger into a string.
> +    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
> +
> +    # Dict to convert from string to an enum-like integer value.
> +    _name_to_val = {k: v for v, k in _name_by_val.items()}

This stuff strikes me as a bit overdone; _name_to_val is really just the
variable list for the class, right?

> +
> +    @staticmethod
> +    def to_name(val):
> +        ""Convert from an integer value from CToken enum into a string""
> +
> +        return CToken._name_by_val.get(val, f"UNKNOWN({val})")
> +
> +    @staticmethod
> +    def from_name(name):
> +        ""Convert a string into a CToken enum value""
> +        if name in CToken._name_to_val:
> +            return CToken._name_to_val[name]
> +
> +        return CToken.MISMATCH
> +
> +    def __init__(self, kind, value, pos,
> +                 brace_level, paren_level, bracket_level):
> +        self.kind = kind
> +        self.value = value
> +        self.pos = pos
> +        self.brace_level = brace_level
> +        self.paren_level = paren_level
> +        self.bracket_level = bracket_level
> +
> +    def __repr__(self):
> +        name = self.to_name(self.kind)
> +        if isinstance(self.value, str):
> +            value = '"' + self.value + '"'
> +        else:
> +            value = self.value
> +
> +        return f"CToken({name}, {value}, {self.pos}, " \
> +               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
> +
> +#: Tokens to parse C code.
> +TOKEN_LIST = [

So these aren't "tokens", this is a list of regexes; how is it intended
to be used?

> +    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),

How does "[\s\S]*" differ from plain old "*" ?

> +
> +    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
> +    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
> +
> +    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
> +                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
> +
> +    (CToken.PUNC,    r"[;,\.]"),
> +
> +    (CToken.BEGIN,   r"[\[\(\{]"),
> +
> +    (CToken.END,     r"[\]\)\}]"),
> +
> +    (CToken.CPP,     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
> +
> +    (CToken.HASH,    r"#"),
> +
> +    (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
> +                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),

"-" and "!" never need to be escaped.

> +
> +    (CToken.STRUCT,  r"\bstruct\b"),
> +    (CToken.UNION,   r"\bunion\b"),
> +    (CToken.ENUM,    r"\benum\b"),
> +    (CToken.TYPEDEF, r"\bkinddef\b"),

"kinddef" ?

> +
> +    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
> +
> +    (CToken.SPACE,   r"[\s]+"),

Don't need the [brackets] here

> +
> +    (CToken.MISMATCH,r"."),
> +]
> +
> +#: Handle C continuation lines.
> +RE_CONT = KernRe(r"\\\n")
> +
> +RE_COMMENT_START = KernRe(r'/\*\s*')
> +
> +#: tokenizer regex. Will be filled at the first CTokenizer usage.
> +re_scanner = None

That seems weird, why don't you just initialize it here?

> +
> +class CTokenizer():
> +    ""
> +    Scan C statements and definitions and produce tokens.
> +
> +    When converted to string, it drops comments and handle public/private
> +    values, respecting depth.
> +    ""
> +
> +    # This class is inspired and follows the basic concepts of:
> +    #   https://docs.python.org/3/library/re.html#writing-a-tokenizer
> +
> +    def _tokenize(self, source):
> +        ""
> +        Interactor that parses ``source``, splitting it into tokens, as defined
> +        at ``self.TOKEN_LIST``.
> +
> +        The interactor returns a CToken class object.
> +        ""

Do you mean "iterator" here?

> +
> +        # Handle continuation lines. Note that kdoc_parser already has a
> +        # logic to do that. Still, let's keep it for completeness, as we might
> +        # end re-using this tokenizer outsize kernel-doc some day - or we may
> +        # eventually remove from there as a future cleanup.
> +        source = RE_CONT.sub(", source)
> +
> +        brace_level = 0
> +        paren_level = 0
> +        bracket_level = 0
> +
> +        for match in re_scanner.finditer(source):
> +            kind = CToken.from_name(match.lastgroup)
> +            pos = match.start()
> +            value = match.group()
> +
> +            if kind == CToken.MISMATCH:
> +                raise RuntimeError(f"Unexpected token '{value}' on {pos}:\n\t{source}")
> +            elif kind == CToken.BEGIN:
> +                if value == '(':
> +                    paren_level += 1
> +                elif value == '[':
> +                    bracket_level += 1
> +                else:  # value == '{'
> +                    brace_level += 1
> +
> +            elif kind == CToken.END:
> +                if value == ')' and paren_level > 0:
> +                    paren_level -= 1
> +                elif value == ']' and bracket_level > 0:
> +                    bracket_level -= 1
> +                elif brace_level > 0:    # value == '}'
> +                    brace_level -= 1
> +
> +            yield CToken(kind, value, pos,
> +                         brace_level, paren_level, bracket_level)
> +
> +    def __init__(self, source):

Putting __init__() first is fairly standard, methinks.

> +        ""
> +        Create a regular expression to handle TOKEN_LIST.
> +
> +        While I generally don't like using regex group naming via:
> +            (?P<name>...)
> +
> +        in this particular case, it makes sense, as we can pick the name
> +        when matching a code via re_scanner().
> +        ""
> +        global re_scanner
> +
> +        if not re_scanner:
> +            re_tokens = []
> +
> +            for kind, pattern in TOKEN_LIST:
> +                name = CToken.to_name(kind)
> +                re_tokens.append(f"(?P<{name}>{pattern})")
> +
> +            re_scanner = KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)

I still don't understand why you do this here - this is all constant, right?

> +
> +        self.tokens = []
> +        for tok in self._tokenize(source):
> +            self.tokens.append(tok)

So you create a nice iterator structure, then just put it all together into a
list anyway?

> +
> +    def __str__(self):
> +        out="
> +        show_stack = [True]
> +
> +        for tok in self.tokens:
> +            if tok.kind == CToken.BEGIN:
> +                show_stack.append(show_stack[-1])
> +
> +            elif tok.kind == CToken.END:
> +                prev = show_stack[-1]
> +                if len(show_stack) > 1:
> +                    show_stack.pop()
> +
> +                if not prev and show_stack[-1]:
> +                    #
> +                    # Try to preserve indent
> +                    #
> +                    out += "\t" * (len(show_stack) - 1)
> +
> +                    out += str(tok.value)
> +                    continue
> +
> +            elif tok.kind == CToken.COMMENT:
> +                comment = RE_COMMENT_START.sub(", tok.value)
> +
> +                if comment.startswith("private:"):
> +                    show_stack[-1] = False
> +                    show = False
> +                elif comment.startswith("public:"):
> +                    show_stack[-1] = True
> +
> +                continue
> +
> +            if show_stack[-1]:
> +                    out += str(tok.value)
> +
> +        return out
> +
> +
>  #: Nested delimited pairs (brackets and parenthesis)
>  DELIMITER_PAIRS = {
>      '{': '}',

Thanks,

jon

