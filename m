Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A5393DF1;
	Tue, 17 Mar 2026 07:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734377; cv=none; b=Up6usYDkYOrmb7D86XxtW37vVrFvCTgsYhbaqdr8jX+2wYGjAB53EyvdECNkDvS8nZ9rHTDiIZL8wFzdzguG30Bld7ezyWcqtlVnQ+HI1df/R4WymcHKaxcW1BMqrOZk43xXBiEDdppuJFvdXG8Ks5NN2b8OEOzZ+hFDpxxhcVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734377; c=relaxed/simple;
	bh=wMx2qUi6KLpSEaheXJYxH65YmjTNRhucNhufGESdUfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iGLJW84y1+v4fv0ujwVr4WbYOL5qWJvngeK0qz1dOREl0mQluWuFqIU4HjMo1Diu0OZYiWoa3IexCavcZlCS/zRkariDDiYAmGNz1RkfjGcGLB3kh0GAJrQU3dnc3PDGrN8e/aNYLZjrq0qPFbbc/pRCpmJdhj6/zmCZUwkrnv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSb8Xgnl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSb8Xgnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3178BC19424;
	Tue, 17 Mar 2026 07:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773734377;
	bh=wMx2qUi6KLpSEaheXJYxH65YmjTNRhucNhufGESdUfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jSb8Xgnl5HM8NKgBbuKIixO5Wfuac4ueDQHgZuRurqvnJG1lyWcM3qSj+HwxBAhZN
	 7HNKOjXQiRjlLjMtvK4eCLusK59Umg4M0nK/RaNxXDA23DzGTbjj0GwrIG4KKW4QPD
	 Oup1tv5GUS89E1JsvIMHZeAw8LZ1WCH7L8cA40JY8F4ZwYA0jFTmPHMlml3m/YaSNF
	 i0ta2OINOaPjaDPIQqv7kXakd82M5yBfX2VNJV48gHN9Ie0+rf1t45RI6kC6gr7Nv2
	 UsOcXKiXAIupj/z1c69uiaC6Qw9C6DbYgKTxWSsqm6fXELLOHEPKJcYC5gBZGtKmeR
	 rlSY1uOBoAd8A==
Date: Tue, 17 Mar 2026 08:59:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
Message-ID: <20260317085933.68440366@foz.lan>
In-Reply-To: <177370207134.1753752.17403055172165325174.b4-review@b4>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
	<8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
	<177370207134.1753752.17403055172165325174.b4-review@b4>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 17:01:11 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Thu, 12 Mar 2026 15:54:25 +0100, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Handling C code purely using regular expressions doesn't work well.
> > 
> > Add a C tokenizer to help doing it the right way.
> > 
> > The tokenizer was written using as basis the Python re documentation
> > tokenizer example from:
> > 	https://docs.python.org/3/library/re.html#writing-a-tokenizer
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Message-ID: <c63ad36c81fe043e9e33ca55630414893f127413.1773074166.git.mchehab+huawei@kernel.org>
> > Message-ID: <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>  
> 
> This is a combined effort to review this patch and to try out "b4 review",
> we'll see how it goes :).
> 
> > diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
> > index 085b89a4547c0..7bed4e9a88108 100644
> > --- a/tools/lib/python/kdoc/kdoc_re.py
> > +++ b/tools/lib/python/kdoc/kdoc_re.py
> > @@ -141,6 +141,240 @@ class KernRe:
> > [ ... skip 4 lines ... ]
> > +
> > +    @staticmethod
> > +    def __str__(val):
> > +        """Return the name of an enum value"""
> > +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")
> > +  
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
> > [ ... skip 27 lines ... ]
> > +    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
> > +
> > +    # Dict to convert from string to an enum-like integer value.
> > +    _name_to_val = {k: v for v, k in _name_by_val.items()}
> > +
> > +    @staticmethod  
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
> > [ ... skip 30 lines ... ]
> > +               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
> > +
> > +#: Tokens to parse C code.
> > +TOKEN_LIST = [
> > +    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
> > +  
> 
> So these aren't "tokens", this is a list of regexes; how is it intended
> to be used?

Right. I could have named it better, like RE_TOKEN_LIST, or
TOKEN_REGEX, as at the original example, which came from Python
documentation for "re" module:

	https://docs.python.org/3/library/re.html#writing-a-tokenizer

basically, we have the token type as the first element at the tuple,
and regex as the second one.

When regex matches, the CToken will be filed with kind=tuple[0].

the loop:
	for match in re.finditer(TOKEN_LIST, code):

will parse the entire C code source, in order, converting it into
a token list. So, a file like this:

	/**
	 * enum dmub_abm_ace_curve_type - ACE curve type.
	 */
	enum dmub_abm_ace_curve_type {
	        /**
	         * ACE curve as defined by the SW layer.
	         */
	        ABM_ACE_CURVE_TYPE__SW = 0,
	        /**
	         * ACE curve as defined by the SW to HW translation interface layer.
	         */
	        ABM_ACE_CURVE_TYPE__SW_IF = 1,
	};

will become (I used pprint here to better align the tokens):

	[CToken(CToken.ENUM, "enum", 0, (0, 0, 0)),
	 CToken(CToken.SPACE, " ", 4, (0, 0, 0)),
	 CToken(CToken.NAME, "dmub_abm_ace_curve_type", 5, (0, 0, 0)),
	 CToken(CToken.SPACE, " ", 28, (0, 0, 0)),
	 CToken(CToken.BEGIN, "{", 29, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 30, (0, 0, 1)),
	 CToken(CToken.COMMENT, "/**
	         * ACE curve as defined by the SW layer. */", 31, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 86, (0, 0, 1)),
	 CToken(CToken.NAME, "ABM_ACE_CURVE_TYPE__SW", 87, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 109, (0, 0, 1)),
	 CToken(CToken.OP, "=", 110, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 111, (0, 0, 1)),
	 CToken(CToken.NUMBER, "0", 112, (0, 0, 1)),
	 CToken(CToken.PUNC, ",", 113, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 114, (0, 0, 1)),
	 CToken(CToken.COMMENT, "/**
	         * ACE curve as defined by the SW to HW translation interface layer. */", 115, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 198, (0, 0, 1)),
	 CToken(CToken.NAME, "ABM_ACE_CURVE_TYPE__SW_IF", 199, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 224, (0, 0, 1)),
	 CToken(CToken.OP, "=", 225, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 226, (0, 0, 1)),
	 CToken(CToken.NUMBER, "1", 227, (0, 0, 1)),
	 CToken(CToken.PUNC, ",", 228, (0, 0, 1)),
	 CToken(CToken.SPACE, " ", 229, (0, 0, 1)),
	 CToken(CToken.END, "}", 230, (0, 0, 0)),
	 CToken(CToken.PUNC, ";", 231, (0, 0, 0))]

> 
> > +    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
> > +    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
> > +
> > +    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"  
> 
> How does "[\s\S]*" differ from plain old "*" ?

They are not identical, as "*" doesn't match "\n". As the tokenizer
also picks "\n" on several cases, like on comments, r"\s\S" works
better.

> > [ ... skip 15 lines ... ]
> > +    (CToken.STRUCT,  r"\bstruct\b"),
> > +    (CToken.UNION,   r"\bunion\b"),
> > +    (CToken.ENUM,    r"\benum\b"),
> > +    (CToken.TYPEDEF, r"\bkinddef\b"),
> > +
> > +    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),  
> 

> "-" and "!" never need to be escaped.

"-" usually needs to be escaped, because it can be a range. I had
some troubles with the parser due to the lack of escapes, so I
ended being conservative.

( I'm finding a little bit hard to follow your comments...
  Here, for instance, "!" is not at CToken.NAME regex.
  Did b4 review place your comment at the wrong place? )

> 
> > +
> > +    (CToken.SPACE,   r"[\s]+"),
> > +
> > +    (CToken.MISMATCH,r"."),
> > +]
> > +  
> 
> "kinddef" ?

Should be "typedef".

This was due to a "sed s,type,kind," I applied to avoid using
"type" for the token type, as, when I started integrating it
with kdoc_re, it became confusing.

I'll fix at the next respin.

> 
> > +#: Handle C continuation lines.
> > +RE_CONT = KernRe(r"\\\n")
> > +
> > +RE_COMMENT_START = KernRe(r'/\*\s*')
> > +  
> 
> Don't need the [brackets] here

where?

> 
> > [ ... skip 6 lines ... ]
> > +
> > +    When converted to string, it drops comments and handle public/private
> > +    values, respecting depth.
> > +    """
> > +
> > +    # This class is inspired and follows the basic concepts of:  
> 
> That seems weird, why don't you just initialize it here?

Hard to tell what you're referring to. Maybe this:

	RE_SCANNER = fill_re_scanner(TOKEN_LIST)

The rationale is that I don't want to re-create this every time,
as this is const.

> 
> > [ ... skip 14 lines ... ]
> > +        source = RE_CONT.sub("", source)
> > +
> > +        brace_level = 0
> > +        paren_level = 0
> > +        bracket_level = 0
> > +  
> 
> Do you mean "iterator" here?

If you mean the typo at _tokenize() help text, yes:

	interactor -> iterator

> 
> > [ ... skip 33 lines ... ]
> > +        in this particular case, it makes sense, as we can pick the name
> > +        when matching a code via re_scanner().
> > +        """
> > +        global re_scanner
> > +
> > +        if not re_scanner:  
> 
> Putting __init__() first is fairly standard, methinks.

class CTokenizer __init__() module calls _tokenize() method on it.

My personal preference is to have the caller methods before the methods 
that actually call them, even inside a class, where the order doesn't
matter - or even in C, when we have an include with all prototypes.

But if you prefer, I can reorder it.

> > [ ... skip 15 lines ... ]
> > +
> > +        for tok in self.tokens:
> > +            if tok.kind == CToken.BEGIN:
> > +                show_stack.append(show_stack[-1])
> > +
> > +            elif tok.kind == CToken.END:  
> 
> I still don't understand why you do this here - this is all constant, right?

This one I didn't get to what part of the code you're referring to.

All constants on this code are using upper case names. They are:

- TOKEN_LIST (which should probably be named as TOKEN_REGEX_LIST).
- CToken enum-like names (BEGIN, END, OP, NAME, ...)
- three regexes (RE_COUNT, RE_COMMENT_START, RE_SCANNER)

See, what the tokenizer does is a linear transformation from a C
source string into a token list.

So, for each instance, its content will change. Also, when we apply
CMatch logic, its content will also change.

> 
> > +                prev = show_stack[-1]
> > +                if len(show_stack) > 1:
> > +                    show_stack.pop()
> > +
> > +                if not prev and show_stack[-1]:  
> 
> So you create a nice iterator structure, then just put it all together into a
> list anyway?

Not sure what you meant here.

The end result of the tokenizer is a list of tokens, in the order
they appear at the source code.

To be able to handle public/private and do code transforms, using it 
as a list is completely fine.

Now, if we want to use the tokenizer to parse things like:

	typedef struct ca_descr_info {
	        unsigned int num;
	        unsigned int type;
	} ca_descr_info_t;

Then having iterators to parse tokens on both directions
would be great, as the typedef identifier is at the end.

Thanks,
Mauro
