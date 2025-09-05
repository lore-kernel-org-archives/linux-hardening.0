Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A85028000F;
	Fri,  5 Sep 2025 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757107126; cv=none; b=F+FGxbGJb2+RgGeWlNex2NhYfkm7V9EsVU9VqCtngi6ubpzAJLVJsIiO7aKU//6Y/EyQGEsybYl49hy+7WznOViwoet/ffJUJba1ztmaK/SGXHRD4GbNkI8LNB0e+afMlcfAzubuOEfvcslTOadkoTsAuX0U423kMbJQPhu2MeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757107126; c=relaxed/simple;
	bh=+ir+mQtnfx/4sLdud4ghKsNSgiyx0xtDI7KlyJXyioY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrpsqY+f2VprdyhIj1r+BSDhH6xujGIEbLWBu9xsL8SM/LA78pag2L8vrsIMD9UOHjdBLkSSL9vVxeTaxWdz5s84CQghLZCpij0q5Girl3EQo0neK9CfwJrEryUP+PnONvSYi85TGFERRD69TdBAgNjBfSkdxvMp/qhV5nT6oe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QE6DnSny; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QE6DnSny"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso22685125e9.2;
        Fri, 05 Sep 2025 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757107123; x=1757711923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ir+mQtnfx/4sLdud4ghKsNSgiyx0xtDI7KlyJXyioY=;
        b=QE6DnSnys76cWZnMeua0PhnnFKQuE0qEjzez43zPyGc/hkUwKAqBj+ymTwUe/UnFLL
         i/aLuUhQRxGfyAybHdPwV62RwghAKt5ZIkQuKMwqDSZfD528gXD4PRUd7JTz2Vl845Sm
         iYPgncjE8J0B8qSoYJJTtiaLivJh/d5BeNMKgtFJQ23jrwaoH9ch3SIwRbkRxoUlmDwa
         fm+148lkEX2XJt1Bgn4p7s3fSx++Vj3n9HMpPgktzMZfSsrF7O0Mn1GSNuvybZGpKUjj
         +Gb6WPF0JntZs8R38vK/rrVcXzB7MWROKc+ue51EWeHdP7GM1DGEzb0KMg6xyxVhDVQ+
         vpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757107123; x=1757711923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ir+mQtnfx/4sLdud4ghKsNSgiyx0xtDI7KlyJXyioY=;
        b=K07H9Ogv06yrORvuyK2ZDEyv/46oKo9v5JpN8EJApFD6jXzuzLIo2iAIZ1Nu1iHbKX
         6W2QTn/4gEBMm3gUluP0S9hhyQ7TNFRJ4gEEtK6+5rLboR3LVHly0CrZg/jzAqWil3qO
         pdj19ekTtfB2pXFkw53U0BM9yIP1GclH11G5ZZwZaRtTjdD8WYBUT3DRE8Uzdsjx043E
         CroGsHuG3YMViwS4DskgCCA6YeFuDkj26MiH5P22S03ph84+nFYeIbeHGzh5wSpzcwa7
         XABdRNkHnz/8zvmwitTFJBKX3ONY/D8dXBDchi2f+ot7BKBIw4vSErWYW7PX2ZQhmnPu
         8t4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgBbOFoJmHR1c5lPv6ioy1hbNpEZIb9f/K8DLB1O4qXTywvzRbXYrvncNr1Z0in710d9oHLpKWEj+PQ6Vdi2U=@vger.kernel.org, AJvYcCXESp7PMlpgnGxx8o+PYNioZlPVIxzP5yQeYXQTf1k0ArR8oDHv/0mdlD2F+SS89AZ4VCsz0H/4iiV72Qxi@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1cGWJBIUk/N0NmcPB0Iy8Nz5pEWE7sSulKiABi2QavGawk59H
	4IsphyE3OfDtJ2sofsFAL7DyALmfUTYZtncXtMwd++X/FRHyBF/qdFbyR78oolzlknI+9RWetkm
	FqepM1H6Fe2IS7sRGilQciS7qWotHFQA=
X-Gm-Gg: ASbGnctUOKPWOjKScbcvPT3Vd0/t5LCUWDaUTPjwNrt6aHRHj5+Y7d9QMDmf6imqMjA
	8qp2Fb0vJ9E9hBXmw8Vqz1LKgQgX2VRgEGA/cZZZKkmiNtUDq75e1phSScd/AQtV8qg5bRFUyil
	TVh5dOIUvXdB69ZzqVJeaYcFxt/4R6jf3ER54UjkrDB1BBNesZxRqCeUcE7vSmC4DJdRxiRbNU2
	noECXRLmJIxZFZ8mQ==
X-Google-Smtp-Source: AGHT+IEgWv1D91zWSgoImbXrRcPy5ZV2Wu02ODmTl/zI9yjh7DlAkMQ9aVhZ7KPIK1OuKkXW8SeulTgQeggx/M7V3rI=
X-Received: by 2002:a05:600c:1987:b0:458:b01c:8f with SMTP id
 5b1f17b1804b1-45ddde8a55cmr3274575e9.8.1757107123278; Fri, 05 Sep 2025
 14:18:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01d9ec74-27bb-4e41-9676-12ce028c503f@linux.com>
In-Reply-To: <01d9ec74-27bb-4e41-9676-12ce028c503f@linux.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 5 Sep 2025 23:18:32 +0200
X-Gm-Features: Ac12FXxfwzu8wekZMUNPG1-5QkyVVlkCYMyrLtAYUduk-8PvduVEITzaspdDKck
Message-ID: <CA+fCnZdQDDwkcd153qexNDP-61VAbB4iAJrj02UVtoL8KN2Vjw@mail.gmail.com>
Subject: Re: Slab allocator hardening and cross-cache attacks
To: alex.popov@linux.com
Cc: "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, linux-hardening@vger.kernel.org, 
	kasan-dev <kasan-dev@googlegroups.com>, Kees Cook <keescook@chromium.org>, 
	Kees Cook <kees@kernel.org>, Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>, 
	Matteo Rizzo <matteorizzo@google.com>, Florent Revest <revest@google.com>, 
	GONG Ruiqi <gongruiqi1@huawei.com>, Harry Yoo <harry.yoo@oracle.com>, 
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 10:11=E2=80=AFPM Alexander Popov <alex.popov@linux.c=
om> wrote:
>
> After experimenting with kernel-hack-drill on Ubuntu Server 24.04, I foun=
d that
> CONFIG_RANDOM_KMALLOC_CACHES and CONFIG_SLAB_BUCKETS block naive UAF
> exploitation, yet they also make my cross-cache attacks completely stable=
. It
> looks like these allocator features give an attacker better control over =
the
> slab with vulnerable objects and reduce the noise from other objects. Wou=
ld you
> agree?
>
> It seems that, without a mitigation such as SLAB_VIRTUAL, the Linux kerne=
l
> remains wide-open to cross-cache attacks.

I'd second the notion that without SLAB_VIRTUAL, the attempts to
deterministically separate objects into different caches based on the
code location or the type (as also with the TYPED_KMALLOC_CACHES
series proposed by Marco [1]) aid exploitation more than prevent it.

Many kernel exploits nowadays rely on cross-cache attacks due to the
high portability of the post-cross-cache techniques for getting code
execution or escalating privileges. And with these object separation
features, the amount of unrelated-to-the-exploit allocation noise for
a specific slab cache gets significantly reduced or completely
removed. Which makes cross-cache attacks very stable.

The only negative effect these separation features have on cross-cache
attacks is that the attacker has to use the objects coming from the
affected slab cache (i.e. the cache from where the object affected by
the exploited vulnerability is allocated) for the slab shaping during
the cross-cache attack (filling up the slab, overflowing the partial
list, etc.). In practice, this is usually not a problem: the attacker
can often allocate as many objects as they want from the affected
cache (by using the same code path as the one required to allocate the
vulnerable object) and only trigger the vulnerability for one of them.

Having said that, I think it's still worth working on these separation
features with the hope that SLAB_VIRTUAL will at some point end up in
the kernel and be affordable enough to be enabled in production.

[1] https://lore.kernel.org/all/20250825154505.1558444-1-elver@google.com/
