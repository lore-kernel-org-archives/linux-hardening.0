Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F05924E4C6
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801457; cv=none; b=Fx7IgEfoCOhBy3ungS5Tk8B08BPsPOnSDyoeVQcZds5Iq16Jw68870pTaawT4xc7CSUCZoDYWgQuCQIKcfxmdekIs666PkMBNK0Y2dULBSdaZa2P/db6+SD7gsWrnYJlFNQ+CSjJxDjdhaUbT5jl6xf9gAA1dR+4p46C5aW7vPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801457; c=relaxed/simple;
	bh=n6e5YMX04O/JDtNJa3RHjPmW98hpzsfbV6oqvnzid/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq3iZtGzBSfPAgmf2zRPfy/9aXpcJ3/unu6FFPEUfYMHhWAMLCs1eJ33BorOg9/e37u/PJHVqX0GM9OA0Xn6lFTLmLYcwTqgna3xtLUASoxz4BNdTcql7SDy8tv5s7Q+nDu5mqUltIeGe8BBN1CzIngMFH2AgXJDAyrf9KND/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ik30zYwS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ik30zYwS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154D01F0155A
	for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779801456;
	bh=flib1lT9XACw/dOlXrdz0j3tL1RxjfVbN+h8oDjWYwQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ik30zYwSbyOlgfIKiCrnatW9FCRjQf91DbnyOZ7BMieUicoNGhHlLQWlkJfpo8G1C
	 4sABbHGLRZtm28bLle6cFnLCimT0AvzhpdikQfkiBL50FxnpJZzuc6z1MtMHtq+MLh
	 3xAxStio1aD36S7A6+oxhw8kD8PpYyHeJ1gwpZA62ak+GjkqqqqckT4JHMiYFoouJ7
	 GzZsW//OJl/s13+XgN33EyZjp/McvvQwsfuogxXev38mjZbgtldNSyR/p1EJryhlhR
	 9NlzVu68DFp61L2tvcCerO0V4iIYyjjIIqG5KwTOJEvqR99G83LAcOnBMHQ1BqEcp3
	 P43abPhJii5ag==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a995ab70d1so12744919e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 26 May 2026 06:17:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YwLk607M0XWV7MtsqpSad9FZQijOyLHB8lnxra6TqzJLgWIOXWS
	K/EH+Ttckg1vBlBAWdxe7IL2GsGTdV8ChunWn+ydSW3y/qZ/Khr+ixpv5SLX6gCc83wfVrGN2PZ
	JW7Y/QGBTHCgFSLEUmzpb5u0yVXU/dYw=
X-Received: by 2002:a05:6512:1094:b0:5a8:8222:7fc9 with SMTP id
 2adb3069b0e04-5aa323ab2e4mr7005025e87.13.1779801454669; Tue, 26 May 2026
 06:17:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526-kpkeys-v8-0-eaaacdacc67c@arm.com> <20260526-kpkeys-v8-1-eaaacdacc67c@arm.com>
In-Reply-To: <20260526-kpkeys-v8-1-eaaacdacc67c@arm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 26 May 2026 15:17:22 +0200
X-Gmail-Original-Message-ID: <CAD++jLnURXzgAgkWCcYX0dLOLqHQw+gn96V1dzDa_0Aoi3430Q@mail.gmail.com>
X-Gm-Features: AVHnY4Kbg2Xadd_3XEw9WMChJMsoQ29BSR2ziaqWgbvf-NftOZWEkP4UGbMFG7w
Message-ID: <CAD++jLnURXzgAgkWCcYX0dLOLqHQw+gn96V1dzDa_0Aoi3430Q@mail.gmail.com>
Subject: Re: [PATCH RFC v8 01/24] mm: Introduce kpkeys
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Ira Weiny <ira.weiny@intel.com>, Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>, 
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Pierre Langlois <pierre.langlois@arm.com>, 
	Quentin Perret <qperret@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, 
	Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kevin,

here is just a few drive-by review comments pertaining to the
API which will be used for all architectures wanting to use
pkeys.

On Tue, May 26, 2026 at 1:17=E2=80=AFPM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:

> kpkeys is a simple framework to enable the use of protection keys
> (pkeys) to harden the kernel itself. This patch introduces the basic
> API in <linux/kpkeys.h>: a couple of functions to set and restore
> the pkey register and macros to define guard objects.

It=C3=A4s a nice idea to use guards for this!

> kpkeys introduces a new concept on top of pkeys: the kpkeys context.
> Each context is associated to a set of permissions for the pkeys
> managed by the kpkeys framework. kpkeys_set_context(ctx) sets those
> permissions according to ctx, and returns the original pkey
> register, to be later restored by kpkeys_restore_pkey_reg(). To
> start with, only KPKEYS_CTX_DEFAULT is available, which is meant to
> grant RW access to KPKEYS_PKEY_DEFAULT (i.e. all memory since this
> is the only available pkey for now).

OK!

> Because each architecture implementing pkeys uses a different
> representation for the pkey register, and may reserve certain pkeys
> for specific uses, support for kpkeys must be explicitly indicated
> by selecting ARCH_HAS_KPKEYS and defining the following functions in
> <asm/kpkeys.h>, in addition to the macros provided in
> <asm-generic/kpkeys.h>:
>
> - arch_kpkeys_set_context()
> - arch_kpkeys_restore_pkey_reg()
> - arch_supports_kpkeys()
>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>

I'm following so far.

Is there no need for something like

ctx =3D arch_kpkeys_request_context(KEY_TYPE) ?

I'm just thinking of the scenario that e.g. two architectures want
to request the same type of key for some generic resource, but
the underlying implementation is vastly different for the two
architectures, so relying on hard-coded arch-specific constants
may not work. I'm also thinking about archs supporting different
versions/types of kpkeys in a multi-platform executable kernel
that may execute on several different silicon with the same ISA.

Maybe this is too much upfront design, I understand it needs to
be kept simple.

> +#ifndef KPKEYS_PKEY_DEFAULT
> +#define KPKEYS_PKEY_DEFAULT    0
> +#endif
(...)
> +#define KPKEYS_CTX_DEFAULT     0
> +
> +#define KPKEYS_CTX_MIN         KPKEYS_CTX_DEFAULT
> +#define KPKEYS_CTX_MAX         KPKEYS_CTX_DEFAULT

I was thinking an enum:

enum kpkey_type {
    KPKEY_DEFAULT =3D 0,
    KPKEY_MMU_TABLE =3D 1,
   ....
};

since this is what is used later.

> +/**
> + * kpkeys_set_context() - switch kpkeys context
> + * @ctx: the context to switch to
> + *
> + * Switches to specified kpkeys context. @ctx must be a compile-time
> + * constant. The arch-specific pkey register will be updated accordingly=
, and
> + * the original value returned.
> + *
> + * Return: the original pkey register value if the register was written =
to, or
> + *         KPKEYS_PKEY_REG_INVAL otherwise (no write to the register was
> + *         required).
> + */
> +static __always_inline u64 kpkeys_set_context(int ctx)

Should ctx be unsigned here? I'm nor sure what a negativ context
would mean.
kpkeys_set_context(unsigned int ctx)

And then I was thinking:

unsigned int kpkeys_request_context(enum kpkey_type type) {}...

+ arch_ -prefixed version of the same.

unsigned int ctx;
ctx =3D kpkeys_request_context(KPKEY_MMU_TABLE);
(...)

Constant sinking in the compiler will optimize the arch
function to a constant in the object code so it will still
be fast just a bit more talkative in source form.

Yours,
Linus Walleij
