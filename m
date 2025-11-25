Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00611274659
	for <linux-hardening@vger.kernel.org>; Tue, 25 Nov 2025 01:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764034427; cv=none; b=Zq/VHM09Rv/A1z1TA0SXB0K/tGaFeAzAQAuUB8SFh5Vbnh4yhV9grpsdgCuoiGsg7oBKoobooxkK+IyP9CtAzL/4jUSJ7fyp3jhgOjSXqVZvmKnXlzdqFVSJYIJg/LfQILePvTDXmfk4g/+izwb/prsEClWhfrfej6gMm2o8IQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764034427; c=relaxed/simple;
	bh=YqWh9GzlQ+M85xmWJJAhz65Uv8DVVpNHfkEVeveBRMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+FSBgxdTtGYGlzvIdJBnOkXtFeXsC9zhm6Oh0HqzW3yp66haoapIJlQHo4lvdOuicNG9Bb3cyrbGJipFAVN4MzwLaQkTuVnWhS30J7eNVkcngPn8Wf2A9iWJEgrAE9eolKjdnGykNOKMJcNaJKZuRPZcQkk7k7EZPIqvHbTAMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U4WotPTh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U4WotPTh"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73a9592fb8so490530966b.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 17:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764034423; x=1764639223; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tqKMRjrSvi+tqRWkNIWke9++rsIS8F7SgGKQGWYYtJA=;
        b=U4WotPTh4/NlCPe6Y+CA4kZadfgdNKnQTk25gH2vU2lz/BnGkygsHWVRpfUhYSHaYT
         MAps0fzaCnfRMjDE2ve+iMutjek0IHAnjEvKCIW+tBtsK3EswSY530h6+Yk5L6z1V7zK
         qI9evtoQKqRg7k98BopiEa/ZSrEoqbLU7iBr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764034423; x=1764639223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqKMRjrSvi+tqRWkNIWke9++rsIS8F7SgGKQGWYYtJA=;
        b=eHvpTCstbwdEEWnlelbkW4S5J5eP1e2RtV2YF6URtRdvf7ldfT7d8N33tHZ2NQzFJB
         YPxU2TfvfxmgQ/ay+Lm+H9d2Di/WCOdAZ+0sEKVGPSxZ01lD2W8X6b/DrizkoPD4zNha
         WiKpPZ9kTkf3DTXhAx5E+DiuScjiChQ1DJ0DAosj+KsrDo6bI/b6YVBHC9JwHTVJ5Cgb
         1GlsNTchg9chPlZtOtbvuTqtLmc51D0XVHEYrno3v/S/0o/doHJjmU5lqjQgH0tNI8cN
         oKyjhOzwTd5z7RrPfKPW3wSlPLJl4dj8hOXotZsmUlSCEfocYFHClQje5PKDRM8yBIU1
         ycqA==
X-Forwarded-Encrypted: i=1; AJvYcCXhSJhvVi3YDhXx2j6BuKBk1KP7hN8/GiCH9kAshXVqtrRGyaZk7Z8WgrzG9zgiSmOkLVj0gOe14muY2Q1nh9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEPPiZO1/XPYMxvh3kkRheHTJKwybXUBt5qpoymxNHnphSy+bk
	fyWGs9fAO8tvnKOxVe4HcdkkpShrI/C3Wvx265rEyOtvlwN0Rn7AnD3CoJeVFohamnhibr7v/PY
	li//Ey6s=
X-Gm-Gg: ASbGncu2T0dK5GLac8P2ou0PdO24YzaVKbDImHemRTtOFa4vs/Fp/D1SFMriRtJV2YR
	CvpcK0L3zCeBwPbQmxSxlwmJnRRpDRaRntTTvmsfWpq7Y0gMjhF9bDvJyCQhjDuAandlBoaNn45
	XZgiN9+n8GTDsue51nsftJ4ccTYOAxsbDTFllj6Fm2OYVo4vejzBzoRXI0yJLcYMpAlX39G/WSF
	b4r7KCgKQrbRLiOSGCpphtwafJJzYTaeja2yoBb2dE9g7rN3b4erfz83NVB9xk7F51dcHd+8TO+
	AbElhVEi9Q4ZCVg5HKSUi9ktrgax1Ie1p4jhOrFsUolefcPd0z0pI5zqaLowA/xQheqXJdnHlyW
	25AUEgqyKUWEH0yVQuVWUrKCix8qVBlm9tdVxSOrkO/Cp6pE53NMZlMFuRKXhFzmaFDo5H4UbXV
	PRc0YAgFDc6Z1TlmzEYmFEx9QYF4MD+Tw1n8ANKjsJmgNuapa21YlKqmWyJnea
X-Google-Smtp-Source: AGHT+IFV6YoB8cvBGFTfG+RJC7zI9D6JO2O9TtlbeK8v2qebYfjTOAuMBCAmbamvthxv6YGPA22uLg==
X-Received: by 2002:a17:907:3f8e:b0:b72:7e7c:e848 with SMTP id a640c23a62f3a-b7657287a65mr1949692666b.17.1764034423051;
        Mon, 24 Nov 2025 17:33:43 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4fc4sm1457213066b.43.2025.11.24.17.33.41
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 17:33:42 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b73a9592fb8so490527366b.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 17:33:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKLEP1+Kx3Umklu1vUW78iY9XTh5bZdAibFhx7+CR0qTkruhx/sFhnV45hEjx12CkpfYq63YePW6VnsFxDstQ=@vger.kernel.org
X-Received: by 2002:a17:906:f20b:b0:b76:b791:b58f with SMTP id
 a640c23a62f3a-b76b791b623mr277396466b.0.1764033941841; Mon, 24 Nov 2025
 17:25:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122014258.do.018-kees@kernel.org> <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
 <202511241119.C547DEF80@keescook> <CAHk-=wikqnc16e7yUTJuqnc5f4rL+y_-JpRzCLRu9WPnt3nmiQ@mail.gmail.com>
 <202511241612.6CF90E9@keescook>
In-Reply-To: <202511241612.6CF90E9@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Nov 2025 17:25:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh7jG7vUqY2JjkJmjxOYzXR+iUARN6W908pCVfmyprSvg@mail.gmail.com>
X-Gm-Features: AWmQ_bmW9etMzrFCL9DwpEr0x6CUkdioyCuxtdBlodJu1UMrkK3czrKtVUGlZJ8
Message-ID: <CAHk-=wh7jG7vUqY2JjkJmjxOYzXR+iUARN6W908pCVfmyprSvg@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] slab: Introduce kmalloc_obj() and family
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Marco Elver <elver@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
	Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vegard Nossum <vegard.nossum@oracle.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	Tony Ambardar <tony.ambardar@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Nov 2025 at 16:29, Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Nov 24, 2025 at 01:35:12PM -0800, Linus Torvalds wrote:
> > Those macros are illegible. And 99% of all users DO NOT WANT ANY OF
> > THAT COMPLEXITY.
>
> Okay, I think you're saying "I don't want the common helpers to include
> the infrastructure for supporting the ..._sz() variants"?

I don't want the macros to expand the code more than necessary,
because that just makes everything worse (including very much my build
times - which have gotten worse over the years, but historically my
build environment got faster at an even higher rate - that is no
longer true).

I also want the macros to be somewhat understandable.

Yes, we have some macros that are works of art because they are *so*
obscure and are fundamentally hard to understand because they play
games with really really subtle language semantics.

And then I enjoy them and appreciate the insanity of them. I still
think our __is_constexpr() macro is truly a wonder, but we do have 40
lines of comment (!) for that one strange macro.

But this was not *that* kind of hard-to-understand macro. This was
just overly complicated.

> Fair enough. Looking at the treewide change I prepared[1], it's less
> than 1% of those mechanical replacements:

Yeah, I did some numbers on my simple version, and just the three
simple ones were the majority of cases by far.

I also believe that when we're doing more complicated size
calculations (ie the whole "struct_size()" patterns), then the
advantage of merging them with the allocation itself is questionable,
simply because it takes two different pieces and makes them one
*compilcated* piece.

Doing

        size = struct_size(ptr, flex_member, count);
        ptr = kmalloc(size, gfp);

is basically two fairly straightforward things and easy to understand.
You can *scan* that code, and each piece is simple enough that it
makes intuitive sense.

No, 'struct_size()' isn't exactly a very intuitive thing, but written
that way it's also not very surprising or complicated to parse at a
glance.

In contrast,

        ptr = kmalloc_flex_sz(*ptr, flex_member, count, gfp, &size);

does *not* make intuitive sense, I believe. Now you have five
different arguments, and it's actually somewhat hard to parse, and
there are odd semantics.

In contrast, the simple versions that take

        ptr = kmalloc(sizeof(*ptr), gfp);

and turn it into

        ptr = kmalloc_obj(*ptr, gfp);

actually become *simpler* to read and understand.

Yes, there are some other advantages to the combined version (ie that
whole thing where 'kmalloc_obj()' now returns a proper _type_ - type
safety is always good, and avoiding void pointers is a real thing),
but I do think that the major advantage is "simpler to read".

Because in the end, simple code that does what you intuitively expect
it to do, is good code, and hopefully less buggy.

             Linus
