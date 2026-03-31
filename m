Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB24330659
	for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976993; cv=pass; b=PtuKf2ovlI4z3yz3A61mvxzEv7H/+uFt4+Y2d13PknRa5t3CHGV9z5s+/jdDTwG7GgQaQnC/cnYkcMzJ9px3UIC4M0FDxypC0E9VO1rOMKRiPphVNZSevEQOoeHsNv6a1z0EAoq8i1ZeGb9sgRfJKjcPcO08jyfl68AQVL4C4ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976993; c=relaxed/simple;
	bh=8EmbocqF6Vdb3h0BM5UKxGb7Zum+nJE7yig8zb0/EBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cHJWtT1bIxWu4CGzz7OMSNyKL6vJReBeCdzo7vGx5wvuTVLauEvGmbXuzwXJoQeq7o9s9OdK7Ld8ADCBCdy5XMTV6OqhkLQYS9o1O/5nef9IfCtcpCwI766J8VMOZij0jXhAVwvdrFcq2BGiN7RtvFak+uidDD9tqsZ8QSAOHtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFkadLKq; arc=pass smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFkadLKq"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ff05af29b4so2168759137.1
        for <linux-hardening@vger.kernel.org>; Tue, 31 Mar 2026 10:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774976989; cv=none;
        d=google.com; s=arc-20240605;
        b=hDfP2/JUUhgOcPfSbaxGIHthxJaTb3fKVRoB7s0K/n05gxtIkwu3eqRWMYNIwXPWis
         STZBO8kEF5/wMCG5eo5xTGx9hQAR5zDjCiyl6aIjz/iyYTUhuOldjNnJPdRoU3kzhTbu
         pH2mjCFPMLp4mkEheGVDG3+jpa4qYMHGJSNb3AXm+LqVddXDLWkksDsCKwrN1JN8MVHn
         m28we26FzlIgob/b9PddGqfkP0VxaMI2gy24K7945WX6SJnaODzcQWQDeYF/PKbcPqNL
         7AwUXiQ9+mUmufTOCkBrmhq2LiluHhm2P4DzeclRs2M14a0uIZ7SP3n+Mpl/KzDiHZbY
         cTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N69dcykYCh53+bqwu3dyzBFgXRPQQLJXWFG4whULut8=;
        fh=OKgKvGzETfNE8JtJNCZvSg6SqXm9kXA+nRd2T/iBksw=;
        b=OJgKtfvcAwJ9iqbjys7jrGeDW8TbtQVpoUqLMpNeM1kVzKGEir8RJsg4rQ9EOr7Y90
         H+okyUtXDdjRFeOd9VNhL1BsqpNhHXYJxyXMdNPp7/6kVsUVxtNYlMtGtg37Cj8NQlve
         Ec/9xz5qF23HXqU4Fd8boDlVM45Ars0PYd7ej8Ww5dHT+0QTy6PTak1ny5VAF0dYP+Qt
         HUU1umWZeowgKkj2ITDCIv1wD0jLBMuRr7GqydFUUn/fqCBkETKALVMtit+xp+6adNvR
         cr9ufOIarWGTWtPh5XiIDx0FDHjEH0PDWbk8Z1LFD7JkL4kXngGTAtb42THT+AA36fzp
         9KOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774976989; x=1775581789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N69dcykYCh53+bqwu3dyzBFgXRPQQLJXWFG4whULut8=;
        b=iFkadLKq1pS4QupJXOa/Imzta0eZsCTW0JK03BTQNDWVNGQk5f1E3aLicFBJ7vm3Zi
         R9aMG8ZNLTyeurFSOSdmBYVI6NiH30ON5PxFn94iWbxXHiwD+bh1dzptHrw2z2OhocXM
         8qHHRESb2fNkHjZaTHucK8BN3HeH1nVZfYJJStlW87UaoWUhpuNvqhXYo7psKN+RPTHf
         xgs4zxVm7splpRYoVUUoZFzMLPfUl8lju8jlhBQONe9wFFFoCIZBV1NRsVMjqZ0ooq1y
         K/CtQ8TKqiHEgzSbnvvWATuQ71YeHkw0FIPf/TgGfJyV+RjjnODpbGEmBpaqiSTi212U
         7/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774976989; x=1775581789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N69dcykYCh53+bqwu3dyzBFgXRPQQLJXWFG4whULut8=;
        b=gWOLupFPvemx61Ai5hO3+GX0y44NSB5xv08iyS19mzWERJ/+hrWdPPD3clOsKw5nkb
         w7Gu/b8LbA/647PQgsrUfD/5dsHHCyY+Mhj5rna7DG6qyGsfr+g/UQJ6+Lc2+r2jeFHq
         9xEuXW6fWm/oyP2OMTQvoMypQKQv+7zc3E3ozgMN25KhuK1oWNETLK7lbuK7bE+IhGUW
         hJvmH2OxGdejn6n9UtW3VUlM87C8Lhuc+A/j9uwBeaVQWHA14hLh4Uw+4SEsm/zBFABh
         mQxm5DlsvGzVRXqhIUqygb+MVbcXM+RmANW5UAAY3bvlGru7qkZQMzIJgPa4DXIaahT1
         J01g==
X-Forwarded-Encrypted: i=1; AJvYcCW1fR9qQV3J474Xj7ggpgZQ17dIgZqh3nzTX/1IhI0+zV3vNH4rYRslNKvi+C2ujRxIIUSq3d01tWbmbe8XIdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDdlbumxVFqs1oiOxbrmv1EaRlmsTUFQ1YRl1ausv5mDmtwGlN
	9ie5F6pUNPInodR1ulF88LA6wqlqgVx0+YWO1TvIhYsDXPk4o/hpaqW9cap3FTCSmfgXlwbMJa+
	Wo+GsASOGMpC4XLltksJ+V65WdzR0GVTnQ5a0WuD5
X-Gm-Gg: ATEYQzyBVLmS/3MgmhQjG6WwWXdOeHv6KH0+Mnlm5A2Ry0AapfqR6MPWQ7DUtSEyeHt
	l3DdggvwCNQOqB/4D2RXH15rX4Vhcxa00LRRJiAawlXLGLKPQ31zqSQi2hZDV7pcII8oeJ/LIdQ
	cI0XUJqVLuIinthva3m8y33K2Y8S8KQG677mVIJJUvGJDgLLLEo68SpQTBbaL1a9bBfMtegdDmr
	BRtK67IJm9OB5qQ8zTJ7r6ksOYVwPdW7qc2JSVcdeywxWsOqQSPN1t/ESawMrQw1WDQa7EFEG81
	Byw6iqc=
X-Received: by 2002:a05:6102:c92:b0:5db:dd12:3d16 with SMTP id
 ada2fe7eead31-60567cf5e34mr47219137.6.1774976985230; Tue, 31 Mar 2026
 10:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331163716.work.696-kees@kernel.org> <20260331163725.2765789-3-kees@kernel.org>
 <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
In-Reply-To: <CANiq72mK9fz6Spmgt4js3hScqhqvZb2YP2T7tDfR0fHPDFWJ7g@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 31 Mar 2026 10:09:33 -0700
X-Gm-Features: AQROBzCWRSbSGajmdyoAKTTcnG8_jXsUZoBJguhEnhg_UEbHXmjODVo4uOcztkk
Message-ID: <CAFhGd8paijFboDVr8rJDjScob047q+zgYAs038WuVozOG0aYaQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] compiler_attributes: Add overflow_behavior macros
 __ob_trap and __ob_wrap
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	llvm@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>, 
	Nicolas Schier <nsc@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 31, 2026 at 10:02=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Mar 31, 2026 at 6:37=E2=80=AFPM Kees Cook <kees@kernel.org> wrote=
:
> >
> > +/*
> > + * Optional: only supported by Clang with -Xclang -experimental-foverf=
low-behavior-types
> > + * passed via CONFIG_OVERFLOW_BEHAVIOR_TYPES. When not available, defi=
ne empty macros for
> > + * the trap/wrap annotations.
> > + *
> > + * clang: https://clang.llvm.org/docs/OverflowBehaviorTypes.html
> > + */
> > +#if !__has_attribute(overflow_behavior) || !defined(OVERFLOW_BEHAVIOR_=
TYPES)
> > +# define __ob_trap
> > +# define __ob_wrap
> > +#endif
>
> Should that have `CONFIG_*`? i.e.
>
>      !defined(CONFIG_OVERFLOW_BEHAVIOR_TYPES)
>
> In addition, since this depends on a `CONFIG_`, with the current setup
> we would put them elsewhere instead of `compiler_attributes.h` until
> they are promoted to be "unconditional" (i.e. without the compiler
> flag):
>
>      * Any other "attributes" (i.e. those that depend on a configuration =
option,
>      * on a compiler, on an architecture, on plugins, on other attributes=
...)
>      * should be defined elsewhere (e.g. compiler_types.h or compiler-*.h=
).
>      * The intention is to keep this file as simple as possible, as well =
as
>      * compiler- and version-agnostic (e.g. avoiding GCC_VERSION checks).
>
> However, thinking about it, why is the config needed?
>
> i.e. if the compiler is not passed that flag, shouldn't the
> `__has_attribute` simply return false?
>
> Also, I am a bit confused -- does the compiler flag automatically
> recognize the names like `__ob_trap`? i.e. I see the docs mention
> using the attribute,
>
>     typedef unsigned int __attribute__((overflow_behavior(trap))) safe_ui=
nt;
>     typedef unsigned int __attribute__((overflow_behavior(wrap))) wrappin=
g_uint;
>
> But then we don't actually use it?

__ob_trap and __ob_wrap are defined by the compiler.

There are some examples within the documentation additions of this patch.

Kees, is it possible to make it more clear about what we expect of
kernel developers in terms of style? Should they use keyword
spellings? attribute spellings? only use custom types?

>
> Or should this just be like the rest of the attributes, i.e. we
> actually define them here?
>
> Thanks!
>
> Cheers,
> Miguel

Justin
