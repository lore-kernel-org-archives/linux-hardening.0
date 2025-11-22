Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD464285CB4
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763844902; cv=none; b=dBn6ZAJbylVkLmd78O1c7vvjRaOdMcuTQOA5h2eSMvV9LlbFoamsSXXDx9OswcSaT89aPCAqy0lJAZu9pDYO0gigHR5KWNWDnFsQCnE+VYVlpAlll3g5Z+PdX0Mg6tSc3g/dg/Mu8F7cWCc61FpmyFQ6MdCHCuUtLWVoRsZFTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763844902; c=relaxed/simple;
	bh=ib193E5ulCM5VsBOwNwbaiGEUjWWX9ZaUyLWHVcJxYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltXYldPkRJFee38M1j0FhX3h4wOcBRjEI4cJAF07anbjr2gkB4zyafIQGChFUtnsM8ZRhnjIhNfXQR4kBUElLfQ5EBJbv5Em/ClbA7n0hGuw/Gus1omFiIj1u9UrZPNw8KiFwfUpoChvKvKlQfnoitb3CsgGLy+mgnlB7L2cl5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bxxtQPXg; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bxxtQPXg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b72b495aa81so375345266b.2
        for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 12:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763844899; x=1764449699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jQGcvOhJEN1J1/uUViuAgWsDBHc/YH/i6gYOyi8rm/I=;
        b=bxxtQPXgF82MkLRKYc54P9Eug1eH47ZY0yOw69hxW8OJOXMwAbZ6siNv2MHhxa+uyb
         i25wb7eOSQyajSALv8RJabwBDGzcS0P5v7fp6PXdwpaeTttr24SdQ3JrOiCty24ueO8u
         lQElm+/bXHXZis+QzFWPRw9LQhJltWDKZziDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763844899; x=1764449699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQGcvOhJEN1J1/uUViuAgWsDBHc/YH/i6gYOyi8rm/I=;
        b=r5NOXcalD3d8fSH4FDUQEeJZi4qO5EQGmhiMgB+QBwAeAMGz5AWCL+wcee9rhi7lan
         lfSkzJ3jt05XY2j3/f0LN95VwTJR/09wxKQjJrj9u54REw3b4w0+Znl0gwPY9OZ+lP9b
         wK5zlQOIKkDqR6izn0dDz66icUqvYCdC7KHVnBnKV6dMJv9fo0iBtgCkq+5ho3ee2fLS
         65IxwPFaO1BqCr1zlzWbbikwCh3LmhrgLyqIOUR+ycDaBlxyMLFHS/lKlR2ZsIht0AT/
         AOSQg1ELGSkNEX6hk/g39XNdVf/kml4biXAfyyIfpnGVJ++KUoV2T8L95I4i6eMTZsy/
         Y4mA==
X-Forwarded-Encrypted: i=1; AJvYcCXjCw+N24Cvgj42VQ1vuv8pYtSj6iKICRyC83/yaTtzzvdbMfsfDaO+Ep9Nt8yNkHi656nohoQ5b+tnhGh6Na4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4K28QtleA0E1XNJXMeRcuYuyB/DavSbTDIqRDHyiv533cu0q0
	voZfeAKJ0yJa0QCQEuCyLfwMtdzeLbBfY0Mp9p7BU/+nj5aNRw8TaFnoe+9c1qu9V2YgbUu/q63
	g9eug79QfeA==
X-Gm-Gg: ASbGncvMjT29wia5g0XxZ+4hXQ7r0a1H8gh9AJdHRA/GyOoXp1SdT6B5k0j6zLrSbU7
	lw/zyGBpDQtAWART4s4ma46F/Z1upQmsb812Ytk+cR+YRhsnD00XGpL5lr6A80c8Jie0KNcnzN4
	Ip0fYCOMxlwhwuGZ+IaT07p1g1LGLprPHPx79Q1twsrLpZTAcE9u1dlj9szsnaZK9M9hdMtkmP6
	+9fMp0wPqoFlufAtAOKB3G6OXjFU1Cf4VJdfOfs5empHyTTj+cZwsnyYR7h0fLajG0o3e/dU1nV
	hnjt/vsG/KdKn2zk11FGJ9y0Dk7NoB7am17+i4w0HwxfOE2ASkGDxojYUCvcR+HB7FUQId7ZI+e
	yOiOm4mnLL5EhaJGS1V/FoReRo6JXj0+5VLpM1NrWojQpg0yund1Z9XAIqv3cwhQYPRc7bYn4J1
	A43U/SvHwCcsDI/XOoXt5hlaXy0W1VPzVZvltjWiQCxIvGIrfkcmYyelHLj8iM
X-Google-Smtp-Source: AGHT+IHBLMehM5/KQ2+FzFyZkSGmCRUJArVXbw4l3tC4URTmnMEhBEuFO4RhhvCd2WvesRBu6hHEpQ==
X-Received: by 2002:a17:907:d28:b0:b73:5131:c45b with SMTP id a640c23a62f3a-b767156938dmr742427566b.22.1763844898805;
        Sat, 22 Nov 2025 12:54:58 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d54cf2sm814076966b.18.2025.11.22.12.54.56
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Nov 2025 12:54:56 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640860f97b5so4444021a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 12:54:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpeIZzlkYsCyN1azjAJAF+ovIaUuk9xpBRWw+lPSD+UQGOrdZC8QdcIwIXlRqXI1sAmB12EIoYV/qb0lOTPRg=@vger.kernel.org
X-Received: by 2002:a17:907:6e8d:b0:b70:7cd8:9098 with SMTP id
 a640c23a62f3a-b76719d4d02mr618930666b.61.1763844895821; Sat, 22 Nov 2025
 12:54:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122014258.do.018-kees@kernel.org> <20251122014304.3417954-2-kees@kernel.org>
 <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
In-Reply-To: <CAHk-=wiNnECns4B3qxRsCykkHwzovT+3wG738fUhq5E+3Lxxbg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Nov 2025 12:54:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjxj---dy5haOvNXjg_Xz-mDQciGL7OnJnpJpjYD9Moog@mail.gmail.com>
X-Gm-Features: AWmQ_bnv84PkVSmG-NV-hwB1C2eg-gsEJfo3JVaH66sxShWKO-Vcyq708ZlrB18
Message-ID: <CAHk-=wjxj---dy5haOvNXjg_Xz-mDQciGL7OnJnpJpjYD9Moog@mail.gmail.com>
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

Btw, I realize that we don't have a good way to do the alignment with
the current kmalloc() interface (we do for some of the vmalloc
interfaces).

So for now, it should just have some static build-time warning if the
type of the object we allocate has a bigger alignment than the
guaranteed slab allocation alignment (ARCH_KMALLOC_MINALIGN or
whatever).

And I really think the first version should do the minimal thing that
actually matters, and strive to deal with the simple cases. The main
things that matter are

 - the return type should be a proper pointer type (so that you get
warnings for mis-uses, but also so that you can use automatic typing)

 - making the 'sizeof()' match the type

so honestly, I think 99% of the gain would come from something fairly
simple like

    #define kmalloc_verify(type) \
        BUILD_BUG_ON_ZERO(__alignof__(type) > ARCH_KMALLOC_MINALIGN)

    #define kmalloc_size(type) \
        (sizeof(type) + kmalloc_verify(type))

    #define allocator(name, type, size, ...) \
        (typeof(type) *)name(size, __VA_ARGS__)

    #define kmalloc_obj(type, gfp) \
        allocator(kmalloc, type, kmalloc_size(type), gfp)
    #define kzalloc_obj(type, gfp) \
        allocator(kzalloc, type, kmalloc_size(type), gfp)
    #define kzalloc_struct(type, member, count, gfp) \
        allocator(kzalloc, type, struct_size_t(typeof(type), member,
count), gfp)

The above macros are entirely untested. But they are simple enough
that even if they are buggy and I miscounted the parentheses or used
the wrong name somewhere, I think the idea is clear. No?

(And I made that "allocator()" macro use __VA_ARGS__ because
kzalloc_node() and friends would want that, but I think it's starting
to hit diminishing returns at that point)

Hmm?

               Linus
