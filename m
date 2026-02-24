Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055EF346A0C
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 22:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972824; cv=pass; b=H1CsECDRYi99ob0fqrniNDG/8MhdGkSyPCNIHm06YRvOx6UpF8KjvftLdVtuiPIilo2CSIgsGihDpl/D6uwdF1NQ+GYG2B7wh8BqLZ8Jz+qiMGBFhByJPGP9yTstldECUTuC7rjHSNfNcBQDfoLm5CTxj94AL/leSdx7V5iKrco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972824; c=relaxed/simple;
	bh=SkILc1fWNjyku5FnGkr+vLpxFU49iJkLQyg5HXcu9OY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwEibpRXRR1hlZbxw0R1wfWnKfeD8XikQMAW1FyqqIhH+VTv2yNBQimLHMgOE//eK+f2a9KHzjNhv5qhfBKeSBUpaR7Zea0gZBTS3icI6O7ABx5Z5jHUDFH960uRCYRmGedxuaI+9te8bYEuOG/HZ25LbmvsMtqOgQjTSMhF8DI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0KNNW2NK; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0KNNW2NK"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12732e6a123so1654520c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 14:40:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771972822; cv=none;
        d=google.com; s=arc-20240605;
        b=PxYHttI83EMFPQsw6lKuv0Qi/ItbL8HpacPYksCaJfdY17G5H/wplO5WZEqZ8u7xE0
         UcSOojB99oNDJiqhiztGekmE9pVseqbRV4hFfNMXfsUDUulhJ5vJI+vXqZzJ+WFFm1G3
         dt/sz7QScL8rgRcpo6nf/Bt8pQrbOYR1566lWoHp/Z5Hj8bXQEBgMCvGPGBQWP/VBaEd
         p0Q5YYKKFwXGsChJeyDqOVjP370LpxTTL6Z2QskbDwqA+KBpo/2arM7pfnG0cwSRPB+4
         8mL1VkeMofvPpnEWeRHAEZYkgiQg6gH7DtzQVTjWyWvENG1OL6e96OzCv+i6oP3dzxps
         7odQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hUh9Lv4xtoNIyHW53JRACIrki0EBGvCTbDJ/9IDMIbU=;
        fh=zvyegZv8SU8qwtl69WlTNQRrfK56kyNto/hnawRhNzE=;
        b=fKAkZnSjLyGznVgFlpAsQ4V6FRCqr8qayr1hY9VXcH3q7mrOUTeq+wc8a2Ri9hiuGs
         S/tiHAYhv6/AKpl69j9xquKmMKeDLAf8Id9Xe7lOObrkp4RZzUvKiHzAeXjjtIiRkMPT
         KyGJ1AEZf1sL3MUhoOYhAaU+luH2pI5VZ+RdhCQzlPUNZdLF5b6o9Owqirv63mpKmlk5
         5KQ8NPc5igNX0+Oe7wwDu4mfj9OpKUCVmjG+dgt5xPrsV9lBlhns/+p8VcNI+tioZa31
         740oNfuwnh3PfANIz6NjOS1qLfzMeHtFQwf6FlNhav0YJD7EW2rMeGy2Hd85QpVp1o1o
         1qXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771972822; x=1772577622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUh9Lv4xtoNIyHW53JRACIrki0EBGvCTbDJ/9IDMIbU=;
        b=0KNNW2NK/wMJUms4KY984GsA6don8wOj9qItuAbmmHHDG+PR72AK03ZoUnzocTqhoO
         bDU4dzyHTH80F46k6W15An7RCS50TlhMK78CeGiYEM99BRcwLni1mVHbH+MIisrWi3iy
         4CPVGQWQ7g/RDYhzpu+7DWjMSWAXziwb8aPULStFLeIoMl5C0faxXqDFDz1I7NKX3THX
         FCh8q8ig9BC2tbux/B3lQ2yNaF982oEohbewUDajK+fHb/8OftQ0mxbw0RPNxpZa/ZR1
         CJt/LK0oPTRzfhxi6dtJX+pqml+2pHc0wcqMaMO5vYnihYj1qB6/9vbwKLF5i2AZDcur
         XtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771972822; x=1772577622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hUh9Lv4xtoNIyHW53JRACIrki0EBGvCTbDJ/9IDMIbU=;
        b=qql//oikTqsKENEUhtvxb4uXLIn6ZQksVtmFmN37wTGjOyh0NXDF3EjQvqI3PPwaRz
         1q80szS01jdyXMe96Z29sXivcrqZQ+1EQRdERq2/Xo6zfyR/djA5sozgJxjFrU+LITDl
         xzTG5fxi8gyLC6mbZZRk9nmxUxnA/Mg25atZ7MK5sxoWJFlTD5bgam1YA0eZsCb8cDzn
         EbVUMWFGuCzt9Zfy29GW1l6HpvWiQdHiGN5MawFgX44GpxUYL2A35845DcbOoPOuTI+F
         Ruqk5pbb8UV6KtTK9Poh21pHUIEFI7C9tTEdPnLvv13hs5zd6XyUVwG0heStCNn4fUf0
         lhYA==
X-Forwarded-Encrypted: i=1; AJvYcCW735gVrtmDvnG8fci8nEGblqMz/pOxWwiaG3+FYkwpLqxOY4IP8s8Iy9fD8johEdBcS9cid11/bnGXA23k3c0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+cQF7M5X2hatEBhrl8pPKQYUbNhECh+JPDZecSj16ws/QytOn
	bJYb7875l4IKLWGoRTTel/mXq7rlXFUpKJS6OIeWjUX5OZVwiGT+ybnKcAT6fq76Is78P8oDi4T
	nZ13dQsGvB9iHlu8Ka4fzPrqiDaVx05fQRIlybdWa
X-Gm-Gg: ATEYQzypAD+73wy7WhVzWSMJX0YA17fHszPlldj8PLd3pfvE4P00p9d/A7JVNKWTC3O
	G2Q5NchGXIUXgW3sArQeGrqCdFJLdQbwwbQkl0x2MdYgn9CEot2lWj2S56m8Yj/QHtPKpvD59ry
	JHZYyMrD9DQmMt/7vWMHYmCXgYRW5cPjAZB1BUsH0+1AK6bMhSDhCDSsEFDaikCj/1yEW9YnUve
	8OntCTeW66yKRKrpl9KOdYGaH5SP/HUXeFIMeUT2q9WF1yz7LDATHXdSTmhe8ls74GVyPhogMIE
	YM3EvWsOjlpBeDm8f02Jr42yv1tLoI96l528Cg==
X-Received: by 2002:a05:7022:2521:b0:11b:9386:a3c8 with SMTP id
 a92af1059eb24-1276ad8bb87mr6685867c88.41.1771972821528; Tue, 24 Feb 2026
 14:40:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223222226.work.188-kees@kernel.org> <CANpmjNOpXe7tCP7tyR04Hm+a8zdiBWWQdK=US-qTL31mm+Yzkw@mail.gmail.com>
 <202602241316.CFFF256ED6@keescook>
In-Reply-To: <202602241316.CFFF256ED6@keescook>
From: Marco Elver <elver@google.com>
Date: Tue, 24 Feb 2026 23:39:45 +0100
X-Gm-Features: AaiRm52Rk4WC1mpHA3KMq--1fMPzNw3GORR0v5jUwxnBm9gKp2Me32yZwyap6qc
Message-ID: <CANpmjNNZ-U4hT8LaW=V+q+NRPHb=fsxai86CBb1VdV8Pyo_xNA@mail.gmail.com>
Subject: Re: [PATCH] kcsan: test: Adjust "expect" allocation type for kmalloc_obj
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Feb 2026 at 22:48, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 24, 2026 at 11:09:44AM +0100, Marco Elver wrote:
> > On Mon, 23 Feb 2026 at 23:22, Kees Cook <kees@kernel.org> wrote:
> > >
> > > Instead of depending on the implicit case between a pointer to pointers
> > > and pointer to arrays, use the assigned variable type for the allocation
> > > type so they correctly match. Solves the following build error:
> > >
> > > ../kernel/kcsan/kcsan_test.c: In function '__report_matches':
> > > ../kernel/kcsan/kcsan_test.c:171:16: error: assignment to 'char (*)[512]' from incompatible pointer type 'char (*)[3][512]'
> > > [-Wincompatible-pointer-types]
> > >   171 |         expect = kmalloc_obj(observed.lines);
> > >       |                ^
> > >
> > > Tested with:
> > >
> > > $ ./tools/testing/kunit/kunit.py run \
> > >         --kconfig_add CONFIG_DEBUG_KERNEL=y \
> > >         --kconfig_add CONFIG_KCSAN=y \
> > >         --kconfig_add CONFIG_KCSAN_KUNIT_TEST=y \
> > >         --arch=x86_64 --qemu_args '-smp 2' kcsan
> > >
> > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > > Cc: Marco Elver <elver@google.com>
> > > Cc: Dmitry Vyukov <dvyukov@google.com>
> > > Cc: <kasan-dev@googlegroups.com>
> > > ---
> > >  kernel/kcsan/kcsan_test.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> > > index 79e655ea4ca1..056fa859ad9a 100644
> > > --- a/kernel/kcsan/kcsan_test.c
> > > +++ b/kernel/kcsan/kcsan_test.c
> > > @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
> > >         if (!report_available())
> > >                 return false;
> > >
> > > -       expect = kmalloc_obj(observed.lines);
> > > +       expect = kmalloc_obj(*expect);
> >
> > This is wrong. Instead of allocating 3x512 bytes it's now only
> > allocating 512 bytes, so we get OOB below with this change. 'expect'
> > is a pointer to a 3-dimensional array of 512-char arrays (matching
> > observed.lines).
>
> Why did running the kunit test not trip over this? :(
>
> Hmpf, getting arrays allocated without an explicit cast seems to be
> impossible. How about this:
>
>
> diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
> index 056fa859ad9a..ae758150ccb9 100644
> --- a/kernel/kcsan/kcsan_test.c
> +++ b/kernel/kcsan/kcsan_test.c
> @@ -168,7 +168,7 @@ static bool __report_matches(const struct expect_report *r)
>         if (!report_available())
>                 return false;
>
> -       expect = kmalloc_obj(*expect);
> +       expect = (typeof(expect))kmalloc_obj(observed.lines);

That works - or why not revert it back to normal kmalloc? There's
marginal benefit for kmalloc_obj() in this case, and this really is
just a bunch of char buffers - not a complex object. If there's still
a benefit to be had from kmalloc_obj() here, I'm fine with the typeof
cast.

Thanks,
-- Marco
