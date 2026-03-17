Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FA1A073F;
	Tue, 17 Mar 2026 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773731019; cv=none; b=mgSoWotIJncPdkSe6sTd0/FqkyE2h4HcIW9Sg2QnwxWhoUI8LaoIb0+VYEh94rrWrNPVJK+sqYYzxhAeacAoPiV8EFCDsFyMLZf5jTgdViapc9EmlNLo0A88WK9xzlIGMIkHL8K0XdR0YBn4HuHbfX1kxMomtjrl81Ras2pk5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773731019; c=relaxed/simple;
	bh=RIwg2cC1FwGdnNjLTD7uT1V2fe8NxEwMbNkRum1LoXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhOMhy2s3LPwSr4cbF2txoaeAVycr539TnzzvBc4+gR72N28jcKsbX5wdyah+fsEfTABKq0Bvmm1K5cRQQDSqxFWjRPPpXXz+wPMnb1ZTp2dd4u66/0GdZZN4olmpPixJS27CPmSNak7VIrTWl3dY5YFikPI5q5BqLu6dGy+Xw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGzgsUIX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGzgsUIX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B656C4CEF7;
	Tue, 17 Mar 2026 07:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773731018;
	bh=RIwg2cC1FwGdnNjLTD7uT1V2fe8NxEwMbNkRum1LoXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZGzgsUIXHyJWx0Xk8TkHwGSVefb24qtouxFFmKuE9T66ZreDNVVvaIIVdCBLt0g8i
	 PQy13ESRaIZIZWxbixVArs9cnD+sC1QZgG+BhXg7/G5QCcAqx4P/myXut7JHleWpus
	 MVL7f2n+J0eR8A9nHA8dbw+HPbVlBxa5SzSXc2cpcQBmNBJa0p14eSbq5icQje1FeF
	 kxmjLU3S9VXu5ti2PY7IX0L/d1AdwNU8ztISJ7Hzkq41xcphE4+SM/subtpk45b0rz
	 j64kuiwBr/ehrfWFEcdDbzQU7Qx/0fSAAgujBq3QXFSnijKteKQMod6nXWCpUkmhH5
	 BzkhabS/xP7Rg==
Date: Tue, 17 Mar 2026 08:03:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
Message-ID: <20260317080332.355d451c@foz.lan>
In-Reply-To: <c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
	<8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
	<177370220974.1754131.9642805524574261129.b4-review@b4>
	<c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 16:29:37 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Uh, I find this review confusing.
> Do your (Jon) comments refer to the code above them?
> (more below)

I was about to comment the same thing: it sounds that b4 review did a
big mess with your comments, as it is very hard to identify what part
of the code you're referring to.

I'll reply to your comments on a separate e-mail - at least the ones I
understand.

> 
> 
> On 3/16/26 4:03 PM, Jonathan Corbet wrote:
> > On Thu, 12 Mar 2026 15:54:25 +0100, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:  
> >> Handling C code purely using regular expressions doesn't work well.
> >>
> >> Add a C tokenizer to help doing it the right way.
> >>
> >> The tokenizer was written using as basis the Python re documentation
> >> tokenizer example from:
> >> 	https://docs.python.org/3/library/re.html#writing-a-tokenizer
> >>
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> Message-ID: <c63ad36c81fe043e9e33ca55630414893f127413.1773074166.git.mchehab+huawei@kernel.org>
> >> Message-ID: <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>  
> > 
> > This is a combined effort to review this patch and to try out "b4 review",
> > we'll see how it goes :).
> >   
> >> diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
> >> index 085b89a4547c0..7bed4e9a88108 100644
> >> --- a/tools/lib/python/kdoc/kdoc_re.py
> >> +++ b/tools/lib/python/kdoc/kdoc_re.py
> >> @@ -141,6 +141,240 @@ class KernRe:
> >> [ ... skip 4 lines ... ]
> >> +
> >> +    @staticmethod
> >> +    def __str__(val):
> >> +        """Return the name of an enum value"""
> >> +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")
> >> +  
> > 
> > What is this class supposed to do?
> >   
> >> [ ... skip 27 lines ... ]
> >> +    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
> >> +
> >> +    # Dict to convert from string to an enum-like integer value.
> >> +    _name_to_val = {k: v for v, k in _name_by_val.items()}
> >> +
> >> +    @staticmethod  
> > 
> > This stuff strikes me as a bit overdone; _name_to_val is really just the
> > variable list for the class, right?
> >   
> >> [ ... skip 30 lines ... ]
> >> +               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
> >> +
> >> +#: Tokens to parse C code.
> >> +TOKEN_LIST = [
> >> +    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
> >> +  
> > 
> > So these aren't "tokens", this is a list of regexes; how is it intended
> > to be used?
> >   
> >> +    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
> >> +    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
> >> +
> >> +    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"  
> > 
> > How does "[\s\S]*" differ from plain old "*" ?
> >   
> >> [ ... skip 15 lines ... ]
> >> +    (CToken.STRUCT,  r"\bstruct\b"),
> >> +    (CToken.UNION,   r"\bunion\b"),
> >> +    (CToken.ENUM,    r"\benum\b"),
> >> +    (CToken.TYPEDEF, r"\bkinddef\b"),
> >> +
> >> +    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),  
> > 
> > "-" and "!" never need to be escaped.
> >   
> >> +
> >> +    (CToken.SPACE,   r"[\s]+"),
> >> +
> >> +    (CToken.MISMATCH,r"."),
> >> +]
> >> +  
> > 
> > "kinddef" ?  
> 
> What does that refer to?
> 
> >   
> >> +#: Handle C continuation lines.
> >> +RE_CONT = KernRe(r"\\\n")
> >> +
> >> +RE_COMMENT_START = KernRe(r'/\*\s*')
> >> +  
> > 
> > Don't need the [brackets] here  
> 
> what brackets?
> 
> >   
> >> [ ... skip 6 lines ... ]
> >> +
> >> +    When converted to string, it drops comments and handle public/private
> >> +    values, respecting depth.
> >> +    """
> >> +
> >> +    # This class is inspired and follows the basic concepts of:  
> > 
> > That seems weird, why don't you just initialize it here?  
> 
> I can't tell what that comments refers to.
> 
> >> [ ... skip 14 lines ... ]
> >> +        source = RE_CONT.sub("", source)
> >> +
> >> +        brace_level = 0
> >> +        paren_level = 0
> >> +        bracket_level = 0
> >> +  
> > 
> > Do you mean "iterator" here?  
> 
> Ditto.
> 
> >> [ ... skip 33 lines ... ]
> >> +        in this particular case, it makes sense, as we can pick the name
> >> +        when matching a code via re_scanner().
> >> +        """
> >> +        global re_scanner
> >> +
> >> +        if not re_scanner:  
> > 
> > Putting __init__() first is fairly standard, methinks.
> >   
> >> [ ... skip 15 lines ... ]
> >> +
> >> +        for tok in self.tokens:
> >> +            if tok.kind == CToken.BEGIN:
> >> +                show_stack.append(show_stack[-1])
> >> +
> >> +            elif tok.kind == CToken.END:  
> > 
> > I still don't understand why you do this here - this is all constant, right?
> >   
> >> +                prev = show_stack[-1]
> >> +                if len(show_stack) > 1:
> >> +                    show_stack.pop()
> >> +
> >> +                if not prev and show_stack[-1]:  
> > 
> > So you create a nice iterator structure, then just put it all together into a
> > list anyway?
> >   
> 



Thanks,
Mauro
