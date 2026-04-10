Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3133B4EA1
	for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812248; cv=pass; b=MRqs03LNShvH85rStNfoCFZoDxD5m5X1270fA/nvBWlIN9L/qUhkzsI036Yc3DAIRbjZD/NJl+w9nMeo5cnQZmCeJtd3hEPsEAqJtnLDZitzumIur0Yhrunu9wOeIkD6AphYc4UwVrj1b5MIkY5cQeeGX7XXd3ot2FC3GcsyI6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812248; c=relaxed/simple;
	bh=naitCC6swSoBy1VNvSZ66ZypJ+ORfAmYMB1nrf5YPCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ult3bkedHicWl0ZeMat3pjxrtMbm14Dkw632LWvMiJgst8vMQD7xn3lZkB/lPwM3Fn5Ilvy2VuYxAENetqy9nr2qQiqMSnGbLf7uS2lbI7WaqpvM5INIEEF1/SG7Cm2QVENWxyYknQNwOEm1Ro3v+qtnyMEge7BNxt4YeKY21fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htlGF32J; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htlGF32J"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-128e4d0cc48so9136864c88.1
        for <linux-hardening@vger.kernel.org>; Fri, 10 Apr 2026 02:10:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775812246; cv=none;
        d=google.com; s=arc-20240605;
        b=Ko2G1PVng7VRwqop2WlGQNHTq58Z7wW5j+iyrFRYKAmBfMA16Jzp+Hapbl2gUW7mqy
         c5DKNyDuyUdunPF6KDXn+POF2TlOrVTdcXZUN8x0EjuQjlgYfQyJ/FGf59cMvbXhxXVd
         ikPVZytO6spFPu+VI9kQ8aCjYYYiQ0JwWg2RMx1EWgRATqPnmWWQB33IHeJ7xMvhDc2s
         acYy/cAyOK9gMD0YUKpElmXkHP9dA4omeGzzSE6FzmGY5THexHgzvn7PqfxTQX7bKtVC
         hPEjkqYKWsEhEbWUWf1E1du1wIcnazCWgv9DQOBBcUasMDn1cEIx2WaOPCz8Vi+i941e
         qmXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=naitCC6swSoBy1VNvSZ66ZypJ+ORfAmYMB1nrf5YPCM=;
        fh=7GNDHRTDsg2IeF7ZU9zWQUjy5vSho7kiHQreXoVi5I4=;
        b=OEmIlgQJ/OJaGNeEo9f192JvR08VIiNphUpQ5UsRBb6YeuZBE8rfCGuzI5PTYAdiXz
         sebA1ZpgrTUwomrXFOMMXds5Zs7JQqMzzbKUgjCEskovf0ZVRGdQgFCQoSl/ojhWtS/N
         RhyZz7wLEa9E135+QCA9claXz/YmK3RseSPA8PkAT9Pachh+qgzLzDVmvxAcPtzDtzYI
         Rg7nlsyUF7ZN0Xg3WhqYI+EHt9Kk9g2gtACtzWdB9OCHTwbQMZZ+/hR/t2/WYB9Mx3LR
         5IHtzYIPCeTypT/8PX2zEgvoT8NzI5ftl3J1MJpFrn5iaygnlN+5uzzrvtCxu8tG82vp
         FxjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775812246; x=1776417046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=naitCC6swSoBy1VNvSZ66ZypJ+ORfAmYMB1nrf5YPCM=;
        b=htlGF32JX2zK1Ccmz/uteTE4Kfs8dCDPYOKTBYEwg8ni1oTg5i95fuFmRuTplFxKj6
         caWvaI1hbm3VQx/f4tJNRgl89j8u5cTA9G4f1Lf61J0LNVqONJLM2GhUljpiTWYDCMJ1
         0GrmTbryz7PpDCjQH/3rYomcy/wp9a/+sd6Di4o8V9K8nasCtFxTrwhuLxzM6u/gOPCX
         g0+WjjwH47PHAETgt+jdAeFNmdivVyP/CUOs8pgl6TMmeMNXH9Ob5RFd5ZY89nzuuX2r
         OIbSMueF69s2p17HLSPYnHF19+HZK2mhnyRAAACfRz/PRlJpfnjmFnBl6vBvd3ybd0JG
         DF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775812246; x=1776417046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naitCC6swSoBy1VNvSZ66ZypJ+ORfAmYMB1nrf5YPCM=;
        b=KIoq6HKOtsYtKwNpCgNP7KKLCdWPmAePblZKuAQu2zKc/wgrESY1I8XkrXsAUEoZiZ
         8UpKT9PX26DMYtgqVyG6lcI882uhuQJethqT3bq6U+nfMgtm5Aj19nz0WPcXCrsUf8cS
         qJBkG8jxfvjY17yOkLV8Sn8BiN+oQmL64z5TSyYmTRj8BmJtESfdUzmEhwHsJhth0zfD
         NAYwuMSZiDXEyKSnFgPfpsSvLEHZUZTVs2mS/YrNcSVMDPHf7Ls+B7TriFBFpQi4KpCV
         5+CgJMcXqxdG0oShljAmEErprdfYFMO3KeoqCqYJQDWAdL44NwX5uMA2GCR0In39v3vl
         o51Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4FqL0QsFWezZ0m6j7rRr+PhRNN4Nz7N8wjoGinxTk9LiXOkiXhrjZp92J4wiyN+U+cUuVb5qTnLLRTPZcqvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuc3tJ1Ysvt/j4844VrdLQic8pX00CTz5S9UNT3PPD5fKori/j
	rW/d6KmWQwlAkbStDeMa8l4qejRzvNQeIufuBffmuAFTRqBWtGHdbHeNzGvCpHtPK99NMw//Vns
	e7vjTa05b2BXkMzyd7nMSjlGvZpLQ3A/XKAvpIBYZ
X-Gm-Gg: AeBDievL1QMHcD71L+jErFvCOoNO4ZsE0UIzE82ByuJkIPOchZ/O55wItmoV2N0Ub4g
	9D4RMR6mFc1PLuu01qUOXo7c7KUpYkLqzdx20b3XRmc/87j7HwuMdDwPETeNXjfP/sfyIC0rK2a
	BgTvr6nHmYnbFyu0U5qgsGltXVLb0t5Xvu+PGHIUtyZnxLxWEtHl4TTfgPUa0mBtOeJyHzKrFiR
	/DNSM7eCIBf4Tb1pEL3uvF2WnCMAgmoKPn+Nw84Z36eJA41Hz14V8O2rN7q+2a1RT8j8X6A/1vz
	W04Mv17Irjpa4iQGH0ClKGF48//h4Afnj6vJ4svocOdPN9Pe
X-Received: by 2002:a05:7022:250d:b0:11b:b3a1:714a with SMTP id
 a92af1059eb24-12c34e8f8a4mr1549057c88.12.1775812245709; Fri, 10 Apr 2026
 02:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331111240.153913-1-elver@google.com> <ac9d5O5XehnXRc5A@hyeyoo>
 <d0fe363c-2e8f-44a4-9b64-3fa3ba9a5773@kernel.org> <adM2XVZf1DekahlY@hyeyoo>
 <CANpmjNMeaWWuDMAj_n38U9XRqgZQz30ca82Vy10Bg=NoDfZ5ng@mail.gmail.com>
 <adT-gkVmVDDXR1h_@hyeyoo> <CANpmjNO1aNm3mKphDGWasK_NUfVY8q4K9GCjyREZFqrOu9WLcw@mail.gmail.com>
 <adhcKZGytWdaLxJu@hyeyoo>
In-Reply-To: <adhcKZGytWdaLxJu@hyeyoo>
From: Marco Elver <elver@google.com>
Date: Fri, 10 Apr 2026 11:10:07 +0200
X-Gm-Features: AQROBzC2BBHkcPy4ngHl5oxQazFqhMF2xdQ6OJLOxqq2BaVLmQUNSpLtUA2DJOM
Message-ID: <CANpmjNODn64zxhs8eQM5t_y6GUCbvBK+feAAM6GVDX3-Z8aTGg@mail.gmail.com>
Subject: Re: [PATCH v1] slab: support for compiler-assisted type-based slab
 cache partitioning
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Hao Li <hao.li@linux.dev>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Apr 2026 at 04:10, Harry Yoo (Oracle) <harry@kernel.org> wrote:
[...]
> > Which is sad, because that means we need the macro workaround.
> >
> > Do you want to be credited with Co-authored-by
>
> I'd appreciate that. (I guess you meant Co-developed-by)

Thanks (and yes).

> > - in which case I need your Signed-off-by.
>
> Signed-off-by: Harry Yoo (Oracle) <harry@kernel.org>
>
> > > Not sure if it's safe to do that for exported functions though (since
> > > modules can be built w/ a different compiler).
> >
> > Kernel modules built with a different config (implicit if different
> > compiler) are not supported, and never have been. If it works, it's
> > just luck (I know people do this, but it's just a disaster waiting to
> > happen).
>
> And if GCC folks somehow fix this at some point, even kernel modules
> built with a different version of GCC might not be supported?

Yes, and different compiler version also implies different compiler
(so even GCC A.B != GCC X.Y), because newer compiler versions may
activate different codegen options (some of which we auto-enable if
available).
