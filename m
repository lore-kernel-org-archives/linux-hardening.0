Received: from g4coop.com (lmx.g4coop.com [45.56.102.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B75B372EF9;
	Mon, 16 Mar 2026 23:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.56.102.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773702677; cv=none; b=hZM8rwhOcwSvvrYWlCPYhb+kkAM37yiUA8Qm9nonotrk7UFB1x4XzZjyNI9GsuAkhgQx7N7vGUowysTsZqu/sSv+HGsPdSJh7/wVer53u/loyOLHlwszLctI1TAV+tcG/2WxhcnKmgI7hhGPnOpZFT29I+BcWxrUjsDD/vlTXzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773702677; c=relaxed/simple;
	bh=u9Ye+s7yAwy1gcOvK+Rpx+0TnDyC5VJDIg61/9wdlko=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=SDXlW0B5CBJ2xNkJ8VbJo48yAd/Uwm5aVdDULTWwFv9yDc29mSmEeJKyDtWdD/Mm5GwkkW7lElj3tIs0swssvIa30JsBr+SiujlM6jzBADMssxFskvWK/CR2gQt+jesx1GnEa19KayM1fKt3ggGp/h2mllgDV+AY70akvywKmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=killermarmot.com; arc=none smtp.client-ip=45.56.102.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=killermarmot.com
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by g4coop.com (Postfix) with ESMTPSA id 3BAA14060C;
	Mon, 16 Mar 2026 17:01:13 -0600 (MDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 g4coop.com 3BAA14060C
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
 <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
Date: Mon, 16 Mar 2026 17:01:11 -0600
Message-Id: <177370207134.1753752.17403055172165325174.b4-review@b4>
X-Mailer: b4 0.15-dev-bf9d1

On Thu, 12 Mar 2026 15:54:25 +0100, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Handling C code purely using regular expressions doesn't work well.
> 
> Add a C tokenizer to help doing it the right way.
> 
> The tokenizer was written using as basis the Python re documentation
> tokenizer example from:
> 	https://docs.python.org/3/library/re.html#writing-a-tokenizer
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Message-ID: <c63ad36c81fe043e9e33ca55630414893f127413.1773074166.git.mchehab+huawei@kernel.org>
> Message-ID: <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>

This is a combined effort to review this patch and to try out "b4 review",
we'll see how it goes :).

> diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
> index 085b89a4547c0..7bed4e9a88108 100644
> --- a/tools/lib/python/kdoc/kdoc_re.py
> +++ b/tools/lib/python/kdoc/kdoc_re.py
> @@ -141,6 +141,240 @@ class KernRe:
> [ ... skip 4 lines ... ]
> +
> +    @staticmethod
> +    def __str__(val):
> +        """Return the name of an enum value"""
> +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")
> +

What is this class supposed to do?

> [ ... skip 27 lines ... ]
> +    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
> +
> +    # Dict to convert from string to an enum-like integer value.
> +    _name_to_val = {k: v for v, k in _name_by_val.items()}
> +
> +    @staticmethod

This stuff strikes me as a bit overdone; _name_to_val is really just the
variable list for the class, right?

> [ ... skip 30 lines ... ]
> +               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
> +
> +#: Tokens to parse C code.
> +TOKEN_LIST = [
> +    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
> +

So these aren't "tokens", this is a list of regexes; how is it intended
to be used?

> +    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
> +    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
> +
> +    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"

How does "[\s\S]*" differ from plain old "*" ?

> [ ... skip 15 lines ... ]
> +    (CToken.STRUCT,  r"\bstruct\b"),
> +    (CToken.UNION,   r"\bunion\b"),
> +    (CToken.ENUM,    r"\benum\b"),
> +    (CToken.TYPEDEF, r"\bkinddef\b"),
> +
> +    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),

"-" and "!" never need to be escaped.

> +
> +    (CToken.SPACE,   r"[\s]+"),
> +
> +    (CToken.MISMATCH,r"."),
> +]
> +

"kinddef" ?

> +#: Handle C continuation lines.
> +RE_CONT = KernRe(r"\\\n")
> +
> +RE_COMMENT_START = KernRe(r'/\*\s*')
> +

Don't need the [brackets] here

> [ ... skip 6 lines ... ]
> +
> +    When converted to string, it drops comments and handle public/private
> +    values, respecting depth.
> +    """
> +
> +    # This class is inspired and follows the basic concepts of:

That seems weird, why don't you just initialize it here?

> [ ... skip 14 lines ... ]
> +        source = RE_CONT.sub("", source)
> +
> +        brace_level = 0
> +        paren_level = 0
> +        bracket_level = 0
> +

Do you mean "iterator" here?

> [ ... skip 33 lines ... ]
> +        in this particular case, it makes sense, as we can pick the name
> +        when matching a code via re_scanner().
> +        """
> +        global re_scanner
> +
> +        if not re_scanner:

Putting __init__() first is fairly standard, methinks.

> [ ... skip 15 lines ... ]
> +
> +        for tok in self.tokens:
> +            if tok.kind == CToken.BEGIN:
> +                show_stack.append(show_stack[-1])
> +
> +            elif tok.kind == CToken.END:

I still don't understand why you do this here - this is all constant, right?

> +                prev = show_stack[-1]
> +                if len(show_stack) > 1:
> +                    show_stack.pop()
> +
> +                if not prev and show_stack[-1]:

So you create a nice iterator structure, then just put it all together into a
list anyway?

-- 
Jonathan Corbet <corbet@lwn.net>
