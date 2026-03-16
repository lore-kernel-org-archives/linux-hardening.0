Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555D379987;
	Mon, 16 Mar 2026 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703784; cv=none; b=VbeOUm52LBOVK9lGnvYaOHSpf1zE6si+7Lgp++Tdoe2jfRYUUDuqVNJf31qxiRYPQRB79eUuKimaPXpNgl1GAQ1TWweF4+pZvNlspLYAyOx7xn8Lfy2PWm5ceGITCn2SebjKWKxtbh3Bnow1LIwGxVLH1NZINL26DEN8POqV4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703784; c=relaxed/simple;
	bh=xEBwoAUiruuZlOFy7D89Z59hQDIw+CrXQ2n9zPoTZ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=angDSPGTSpfmJmnGJV516JpUqu/91bXVlsy2DUABXVGR8PAp2U1OQBmQuKqPqhFNKE8bLicDeUZGEQlwvzBCqKEuMnfgkDPpiggineJFeKLvQjV+upx3zn4kB/8MUDIgio5GgfvnNwRlLazsswt/CP9QOZF/i/3v4NWjVG55HA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gepygvck; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gepygvck"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sRuxevEo//8oYkepBHBNokBtpf2pGr6lTMH20T9ZkJg=; b=gepygvckbVtODfXWZpp760wEXb
	Imn7rP+hPp93D3dDd+YvFNB6Itr2RtQK8RiY7TCizX/qFtlj/5ytg/4MQ29W1758KskcoQrCQTooX
	OBOvE71oY1QmXg1VAPDdb21cMxMZq8CN0IKc7qZeT8vEa1w1Z2IDpPWvWyy15lP0630Zbax8kGlvU
	gk2Zu8maDnZfL8OARV5eUb4sc9YMIHug5wZSvPMyDDH/vhvM5Ky4oC3uJuJ0qDOv2s+2cDxYHH6oX
	WemE4Y+LhYO91UKwlyZVQczXsq8CZ5iryDA7J0YPMxuI8w4qOGDsxoPctJXik/HbdJv0u6Z87A8m2
	JZ2FUgqg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2HNS-000000054q2-3psd;
	Mon, 16 Mar 2026 23:29:38 +0000
Message-ID: <c53a3638-7a72-472c-81e8-86a6c235b598@infradead.org>
Date: Mon, 16 Mar 2026 16:29:37 -0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/28] docs: kdoc_re: add a C tokenizer
To: Jonathan Corbet <corbet@lwn.net>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
 <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
 <177370220974.1754131.9642805524574261129.b4-review@b4>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <177370220974.1754131.9642805524574261129.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Uh, I find this review confusing.
Do your (Jon) comments refer to the code above them?
(more below)


On 3/16/26 4:03 PM, Jonathan Corbet wrote:
> On Thu, 12 Mar 2026 15:54:25 +0100, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>> Handling C code purely using regular expressions doesn't work well.
>>
>> Add a C tokenizer to help doing it the right way.
>>
>> The tokenizer was written using as basis the Python re documentation
>> tokenizer example from:
>> 	https://docs.python.org/3/library/re.html#writing-a-tokenizer
>>
>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Message-ID: <c63ad36c81fe043e9e33ca55630414893f127413.1773074166.git.mchehab+huawei@kernel.org>
>> Message-ID: <8541ffa469647db1a7154f274fb2d55b4c127dcb.1773326442.git.mchehab+huawei@kernel.org>
> 
> This is a combined effort to review this patch and to try out "b4 review",
> we'll see how it goes :).
> 
>> diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
>> index 085b89a4547c0..7bed4e9a88108 100644
>> --- a/tools/lib/python/kdoc/kdoc_re.py
>> +++ b/tools/lib/python/kdoc/kdoc_re.py
>> @@ -141,6 +141,240 @@ class KernRe:
>> [ ... skip 4 lines ... ]
>> +
>> +    @staticmethod
>> +    def __str__(val):
>> +        """Return the name of an enum value"""
>> +        return TokType._name_by_val.get(val, f"UNKNOWN({val})")
>> +
> 
> What is this class supposed to do?
> 
>> [ ... skip 27 lines ... ]
>> +    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
>> +
>> +    # Dict to convert from string to an enum-like integer value.
>> +    _name_to_val = {k: v for v, k in _name_by_val.items()}
>> +
>> +    @staticmethod
> 
> This stuff strikes me as a bit overdone; _name_to_val is really just the
> variable list for the class, right?
> 
>> [ ... skip 30 lines ... ]
>> +               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
>> +
>> +#: Tokens to parse C code.
>> +TOKEN_LIST = [
>> +    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
>> +
> 
> So these aren't "tokens", this is a list of regexes; how is it intended
> to be used?
> 
>> +    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
>> +    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
>> +
>> +    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
> 
> How does "[\s\S]*" differ from plain old "*" ?
> 
>> [ ... skip 15 lines ... ]
>> +    (CToken.STRUCT,  r"\bstruct\b"),
>> +    (CToken.UNION,   r"\bunion\b"),
>> +    (CToken.ENUM,    r"\benum\b"),
>> +    (CToken.TYPEDEF, r"\bkinddef\b"),
>> +
>> +    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
> 
> "-" and "!" never need to be escaped.
> 
>> +
>> +    (CToken.SPACE,   r"[\s]+"),
>> +
>> +    (CToken.MISMATCH,r"."),
>> +]
>> +
> 
> "kinddef" ?

What does that refer to?

> 
>> +#: Handle C continuation lines.
>> +RE_CONT = KernRe(r"\\\n")
>> +
>> +RE_COMMENT_START = KernRe(r'/\*\s*')
>> +
> 
> Don't need the [brackets] here

what brackets?

> 
>> [ ... skip 6 lines ... ]
>> +
>> +    When converted to string, it drops comments and handle public/private
>> +    values, respecting depth.
>> +    """
>> +
>> +    # This class is inspired and follows the basic concepts of:
> 
> That seems weird, why don't you just initialize it here?

I can't tell what that comments refers to.

>> [ ... skip 14 lines ... ]
>> +        source = RE_CONT.sub("", source)
>> +
>> +        brace_level = 0
>> +        paren_level = 0
>> +        bracket_level = 0
>> +
> 
> Do you mean "iterator" here?

Ditto.

>> [ ... skip 33 lines ... ]
>> +        in this particular case, it makes sense, as we can pick the name
>> +        when matching a code via re_scanner().
>> +        """
>> +        global re_scanner
>> +
>> +        if not re_scanner:
> 
> Putting __init__() first is fairly standard, methinks.
> 
>> [ ... skip 15 lines ... ]
>> +
>> +        for tok in self.tokens:
>> +            if tok.kind == CToken.BEGIN:
>> +                show_stack.append(show_stack[-1])
>> +
>> +            elif tok.kind == CToken.END:
> 
> I still don't understand why you do this here - this is all constant, right?
> 
>> +                prev = show_stack[-1]
>> +                if len(show_stack) > 1:
>> +                    show_stack.pop()
>> +
>> +                if not prev and show_stack[-1]:
> 
> So you create a nice iterator structure, then just put it all together into a
> list anyway?
> 

-- 
~Randy

