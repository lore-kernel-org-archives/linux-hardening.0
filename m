Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC8C290D96
	for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752184729; cv=none; b=sGN1cdzOBjuRUNJGvzhPy1Qr/fJ/OlIA3IGagRyDurgV7K1mcqYYl3X5FAmC2tMj29hWJoupxNiM/TLOQFQZX2QbgX9YFSQittehHB1q6u/49dEcuDfDX+0Sxq2P5gG/QscBmB4k2HHeoFjR4RPnxFfhDoSnkb3vafPo6Q8m2jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752184729; c=relaxed/simple;
	bh=ylyRbKljNFjJtaMPwqP1eMnpQYJpOhfIDXsclrUxY9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MDI4VAMEMxnTmfqddoquzNcB9uSBERaM+BdoqeGylG260APcCdN/PLfR3kpoKs8iLgYu42m+aD0I6D8KFMmoUgVwPaSZawGK7Rkja+ZBcKk2d007m64UxocjISxBy2ojaxHA32SVhBXcodPnrcj53kYGFUYFj4lh/Z8cOW9sHHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bg90fCdX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bg90fCdX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso256739766b.1
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 14:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752184725; x=1752789525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NOhvg1l0t2LaUB8HzcyN7Tq+OVNAbmeCuPM6bN+kiYw=;
        b=bg90fCdXoLqS6gFi+3GG0xgow0P5rF02iQUK/482h8Mud5B5CWqYM/As0X4bGlLHTU
         0e7c6XBg+W7LL7OYcrfI440erSeBfZVwM9s662n0Pi2HrjqZyPPt2BZRbASyUUB4G1Bm
         aXE2I2O5cgQIi9hK1qQqwB3eT4mlkhIWkf98g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752184725; x=1752789525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NOhvg1l0t2LaUB8HzcyN7Tq+OVNAbmeCuPM6bN+kiYw=;
        b=mtULaDIgsd3IWiHHOpCk0MtLlGvxAEnEZC1m5cdIDC7IkKDhNW13NOPb/v+l3QhYQf
         Dg0IXmoj2ws64IIiz9ShF2goXRGmH4KGX554wht8Kae1Qis5I2AHh1gUV9OzmEBwQvCG
         SJdmCZ1UuNiEsMncbXtMWRdRBsW1ECLtWIRX8CdZ5sbxG0VtjG+/4CmbaxLD9ajtwHwD
         AMvJ97RRcJAyxKVc2zhnOpBZbRWwURi/bJ9RpBn/5sBYlUivUZE3SX4dSBIEr1KC3gT8
         UWw9aFxFpceEGKUbV18jCDYgQZ4jq42IZyQ8GLpFcsUaGcBhF6QTJiaqtKS24kChdZvo
         JzQg==
X-Forwarded-Encrypted: i=1; AJvYcCXF6MuG0vNB7MeLMR5kTE1xEZwTmUESBJFAq7e6FRXG4aqvBi0uMedZuaXYMzWXNt5xTkyX/XB4gf4sg6cO6FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOSqgDVx5DX8Tpf9RzuGea+3mKePJ5qe2+x1Hn7M3vRMBvB2f
	gK5jfRwQrVD52H4hvGON1JPgdXeInaNpXWA3BCOiIwQ0/yRWtoBc3eE00qicmFs4vpo=
X-Gm-Gg: ASbGncs7tre/Ju2rrr1bQUV78LZcDb8KaJu9IGo2Tk/sLPBfyrXf6Q14tDtRsyEd1fV
	zE6K3PrZCE1JNMh3IYXkC0QxP6xsRM5hcoGsVs38etPwwDsFDR+hpZEBopOa4BCDiw6iq/U9EBt
	E9ryykoKjOHHvhKqjmlt15S+evVZQcrfF0a1aGwBenOYkVL6DE4wMckaq8TcbN6DxuZ9YQQbjml
	gTNGGyJyEUVlD/LtOlI4TMRFgtp4K2vBBineSWJhw6L+TwcoFfchXJwpIGQyxu4peXtOqr5W5Pg
	0oxI09aryGOBu1Yg4pUfYfZKiB49um0Tnjqz+DvgRdrWbjExIZZV09SsGLANozeyIK74Ag==
X-Google-Smtp-Source: AGHT+IGzEieCbCVxWhfQhpTQv2Has9Ybmsyx8lC+bYlj11CMb2MO9G84ehOEFI2Wt7X4OSSNLft92w==
X-Received: by 2002:a17:907:720e:b0:ae3:24c:6a21 with SMTP id a640c23a62f3a-ae6fc0f50fdmr80257866b.26.1752184723188;
        Thu, 10 Jul 2025 14:58:43 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8313c93sm191205566b.183.2025.07.10.14.58.41
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jul 2025 14:58:41 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so2373073a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 10 Jul 2025 14:58:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5c6WWbPgQT0muu69XQp6qhUUvFep83D98IFgk17+3GK8SZO5mBsQ1YO8WOj0Fx9wbnj4Q/nJOQ45cTFH0+o4=@vger.kernel.org
X-Received: by 2002:a05:6402:289c:b0:607:206f:a19 with SMTP id
 4fb4d7f45d1cf-611e84a9aa4mr389972a12.25.1752184721009; Thu, 10 Jul 2025
 14:58:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1751823326.git.alx@kernel.org> <cover.1752182685.git.alx@kernel.org>
 <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
In-Reply-To: <04c1e026a67f1609167e834471d0f2fe977d9cb0.1752182685.git.alx@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 10 Jul 2025 14:58:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
X-Gm-Features: Ac12FXwFBMXaxRHdcUswF9pkpuvbALmMtsHBeK-c4iMg5ugUB_Hn2l67aUaOXFU
Message-ID: <CAHk-=wiNJQ6dVU8t7oM0sFpSqxyK8JZQXV5NGx7h+AE0PY4kag@mail.gmail.com>
Subject: Re: [RFC v5 6/7] sprintf: Add [v]sprintf_array()
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Christopher Bazley <chris.bazley.wg14@gmail.com>, 
	shadow <~hallyn/shadow@lists.sr.ht>, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, 
	Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Michal Hocko <mhocko@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Martin Uecker <uecker@tugraz.at>, Sam James <sam@gentoo.org>, Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Jul 2025 at 14:31, Alejandro Colomar <alx@kernel.org> wrote:
>
> These macros are essentially the same as the 2-argument version of
> strscpy(), but with a formatted string, and returning a pointer to the
> terminating '\0' (or NULL, on error).

No.

Stop this garbage.

You took my suggestion, and then you messed it up.

Your version of sprintf_array() is broken. It evaluates 'a' twice.
Because unlike ARRAY_SIZE(), your broken ENDOF() macro evaluates the
argument.

And you did it for no reason I can see. You said that you wanted to
return the end of the resulting string, but the fact is, not a single
user seems to care, and honestly, I think it would be wrong to care.
The size of the result is likely the more useful thing, or you could
even make these 'void' or something.

But instead you made the macro be dangerous to use.

This kind of churn is WRONG. It _looks_ like a cleanup that doesn't
change anything, but then it has subtle bugs that will come and bite
us later because you did things wrong.

I'm NAK'ing all of this. This is BAD. Cleanup patches had better be
fundamentally correct, not introduce broken "helpers" that will make
for really subtle bugs.

Maybe nobody ever ends up having that first argument with a side
effect. MAYBE. It's still very very wrong.

                Linus
