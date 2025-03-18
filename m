Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162B2063D3
	for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742334114; cv=none; b=iM4Zd2Aygx5aNCbtV6byZ6QvDxkOnZluueQyZtjAIY3/7CSLxhO8sJn8kGS/8UzQzckCUZGx7IWSp+t1rN13OUw1CcHNTs7aRuhBt2d/D1V6/ThkxqAzVVh4gTPfB7KoeHKGfGqdJw/EsZWaq1+qslInXSIE2c1fYN8ILf9eMJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742334114; c=relaxed/simple;
	bh=H257vBUGFgZallMqQK8Sv95gmOBmQfu53ct0C021Sc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lw9Zmoxmh0g4RBgR5GrwjGAqu+REPMVaD/lW7M0JBTLvBTSPJ+G+fv9Szh+il3LDuGQKtKmhMzjxcPH9MlswCQRffO0QUq22xtzuq7+I0R2RvAQVBlMVXw0xQk5W+AEVJ33oxIhHCDqRQhInvdSDYaL/G/MFOws0KfUUGGMpOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piSHUsvM; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piSHUsvM"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso1475a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Mar 2025 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742334111; x=1742938911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huRWnbUSFIOrYn2QxkW4BG9y2bRatI4h8QE+NxAGfCE=;
        b=piSHUsvM5H/mSHb8x1PkAH9/jM3Jcioj5pb8vT3Bo9r7dypkEGJtpFMieOXKtTesM8
         A53HXrxO21yJ5vxX/XAOh7hcV1h/4esABT2nwcvr2JZJgck46HHkdqdp5QjTvrIC6Zgd
         vCC1mOcWa2+oolmd3750k1s5PYSuBShXbB61OCL+1gpOERzR0CGWBitv+nrtwPH0a8NF
         zJU5BdiHdKOSXCtq3FVPlQ1kS7nm/GY+uJtgV3sCEX1LqVwMWuU6hX1bAr5xpaZVEaBk
         I/NzrTiB75q4Q5E3JmJ1/JCp7U2hdEEhiWeg7FgY3kkRx4R8GEVPQqXrMV6cm02dpre8
         nUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742334111; x=1742938911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huRWnbUSFIOrYn2QxkW4BG9y2bRatI4h8QE+NxAGfCE=;
        b=Ag6rkSUwjwb71gE9/fR33wqhwqQ8zr7q22x6xekHsCaNbPozNa6YS88uPsV5J7/ziQ
         QAE1Gf4x/uPReiO/pNDCZSlPBkSYj7dqt/rSvQAUEauN3KfxBfDBBt317Bl6hQaaxV1o
         o53wRHuEX9IKtZJN793KTLkpt9hoFnpRuFwxYAeneAoUqR3jctK0+aSdAdSox80Xudfq
         PhWPL5gKpvX0DPj2CvHKm5toGMhmfiDPEdJvm8d/L7Adsh4WSrLXvYcdtzmFjDOQbCCq
         UsZrfp5mxVnGiqPY6HrfuWLuVJEoclnQw4VPFg7Gubj/U4Mk3ccK/ZaTHrudwXusngNn
         W0Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXbTRt/p6E17+XnO+x7HOR/jtQMBna6smQ6kAgkbpr0EyhT1UL6Rbg+KTSbJn0NkeRJhWFJEzWZIu2WFjG7paY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvrzey2k7WFd4k1OAJQXHJyF/EOB6Co025zHpNfKCDnzZ+MIkG
	TVyLI/+vY66G4EDH3+Jur0tTASQI7auTV8ccm15MErvI4YPHk/qw2Fr9VQCgJqnvKnPF7ZGWG18
	iTrgIG8s0pfWDe8uIBgzxaWYUwklCDR9PJ1Bf
X-Gm-Gg: ASbGncvY1kY5FaVIUfCeR2ExjGLcpmiOEmwma3YmLi1h/RbhBZCdFLsStMoYXOuIFPn
	gmDgFItlyUngT4M9Pb02Xav8+nRjxzezAJGvwPu6oXOfRwqxGR4mdDOmOCqr8VOltne+VQyBFAm
	LcW7RukrLFJYDmfAn7y9OfXtOQ23ctc7xhGGMJ1wX/jSpRqZWdLIbEkK4=
X-Google-Smtp-Source: AGHT+IEE7SnidIPRfD/tsQUEwB4S5fYvYHXaK7pjnnRSY2/bfQtUnICoMM+NMzU+Q4G5iu99RUJkJd34epkaV7xV8uM=
X-Received: by 2002:a05:6402:2072:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-5eb81ca377cmr5954a12.7.1742334110577; Tue, 18 Mar 2025 14:41:50
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308023314.3981455-1-pcc@google.com> <202503071927.1A795821A@keescook>
 <Z88jbhobIz2yWBbJ@arm.com>
In-Reply-To: <Z88jbhobIz2yWBbJ@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Tue, 18 Mar 2025 14:41:39 -0700
X-Gm-Features: AQ5f1JoCSww36ZPRvbJPagyRsMZce1-_UGQToveMTebIsOSwVuNrh895PUcBWPA
Message-ID: <CAMn1gO6Zy1W0M_JsHcX6pcOp8cb7=uWUScf3WGxKTRm=AjXKKA@mail.gmail.com>
Subject: Re: [PATCH] string: Disable read_word_at_a_time() optimizations if
 kernel MTE is enabled
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 10:37=E2=80=AFAM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Mar 07, 2025 at 07:36:31PM -0800, Kees Cook wrote:
> > On Fri, Mar 07, 2025 at 06:33:13PM -0800, Peter Collingbourne wrote:
> > > The optimized strscpy() and dentry_string_cmp() routines will read 8
> > > unaligned bytes at a time via the function read_word_at_a_time(), but
> > > this is incompatible with MTE which will fault on a partially invalid
> > > read. The attributes on read_word_at_a_time() that disable KASAN are
> > > invisible to the CPU so they have no effect on MTE. Let's fix the
> > > bug for now by disabling the optimizations if the kernel is built
> > > with HW tag-based KASAN and consider improvements for followup change=
s.
> >
> > Why is faulting on a partially invalid read a problem? It's still
> > invalid, so ... it should fault, yes? What am I missing?
>
> read_word_at_a_time() is used to read 8 bytes, potentially unaligned and
> beyond the end of string. The has_zero() function is then used to check
> where the string ends. For this uses, I think we can go with
> load_unaligned_zeropad() which handles a potential fault and pads the
> rest with zeroes.

Agreed, strscpy() should be using load_unaligned_zeropad() if
available. We can also disable the code that checks for page
boundaries if load_unaligned_zeropad() is available.

The only other use of read_word_at_a_time() is the one in
dentry_string_cmp(). At the time that I sent the patch I hadn't
noticed the comment in dentry_string_cmp() stating that its argument
to read_word_at_a_time() is aligned. Since calling
read_word_at_a_time() is fine if the pointer is aligned but partially
invalid (not possible with MTE but it is possible with SW KASAN which
uses a 1:1 shadow mapping), I left this user as-is. In other words, I
didn't make read_word_at_a_time() arch-specific as in Vincenzo's
series.

I sent a v2 with my patch to switch strscpy() over to using
load_unaligned_zeropad() if available, as well as the patch adding
tests from Vincenzo's series (which had some issues that I fixed).

Peter

> > > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > > Link: https://linux-review.googlesource.com/id/If4b22e43b5a4ca49726b4=
bf98ada827fdf755548
> > > Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> > > Cc: stable@vger.kernel.org
> > > ---
> > >  fs/dcache.c  | 2 +-
> > >  lib/string.c | 3 ++-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > Why are DCACHE_WORD_ACCESS and HAVE_EFFICIENT_UNALIGNED_ACCESS separate
> > things? I can see at least one place where it's directly tied:
> >
> > arch/arm/Kconfig:58:    select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNA=
LIGNED_ACCESS
>
> DCACHE_WORD_ACCESS requires load_unaligned_zeropad() which handles the
> faults. For some reason, read_word_at_a_time() doesn't expect to fault
> and it is only used with HAVE_EFFICIENT_UNALIGNED_ACCESS. I guess arm32
> only enabled load_unaligned_zeropad() on hardware that supports
> efficient unaligned accesses (v6 onwards), hence the dependency.
>
> > Would it make sense to sort this out so that KASAN_HW_TAGS can be taken
> > into account at the Kconfig level instead?
>
> I don't think we should play with config options but rather sort out the
> fault path (load_unaligned_zeropad) or disable MTE temporarily. I'd go
> with the former as long as read_word_at_a_time() is only used for
> strings in conjunction with has_zero(). I haven't checked.
>
> --
> Catalin
