Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66363BED46
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791294392; cv=pass; b=dJ5KJAzNVerycJ9O2gN59K3X8pBkLl66iYJHMLiiHIgrgRAdPn45QPCfQWjCf0oE2yAi2t0N9gauQ6rn17ysesmfeQP4P0C+PDXSfwDb1vf8xBP9a+Cetsefk4n/gpICpr0LdpqygpKiaiWmi65Xbh0KOW+ZBEexXo1V2JsVRQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791294392; c=relaxed/simple;
	bh=C4ZK4y5jqDlopKlvsMqwakPYMQHAT0xpUCwWJwaY68c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5EE+RBENM2UQdmksdj6IWGzLiWPAIHACQsh3PkUVE+oW09pBvn4fcNXFYAxQdigd/PMPrtL8W2vEX2TO1NJ8X1HCgME+Rq6/w4dGaA2OuKuRxqDyQqpIWhim4VEdIYDo8TUhc+uyvdOPg8KzKqhFyLXjtPaDiAXXeAedXrq6aM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHxHZPbm; arc=pass smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHxHZPbm"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5ce65316337so2149319e0c.3
        for <linux-hardening@vger.kernel.org>; Tue, 06 Oct 2026 06:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791294390; cv=none;
        d=google.com; s=arc-20260327;
        b=B6dTsNSmBq8NQAd7MQmfiBQp2oKXaQuJX4ZC2XzasKzcQkRUIl1nprvlhHHuGNxG/Q
         RMr8dmeigIryOXJlbJJl+fa8RBx/KPZQ8XOYPeEgpFdWmCMIwtsdDXrOWrdun8DgKtBF
         msQ81z79AR2KTwEx9XyKlglUZaBmnFBotry5jG3mYbnQHC6b7EDsXkCBHxkOUpZbw7jH
         PWe/qSZKR/ACptJuT49PEgnWkWe3gUtPAKQYNHpJ19h0vll5+iwYHhqNmD8QwDRVFJ3k
         VVEA6gBkAq2rwdBOTSbNDyIRN7COG15zfCkcAleZGqlHThL1wLT/C2JQjQnmPMVnLvvy
         Cf4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Pm8zUZvlBkdi0wY1ju+p+rWxMJ6Dlo5Q1LwsdfKGfK8=;
        fh=0lUfI0AyVwkCz/KaNqw4V1tRRd55EshAdtharMW1EV4=;
        b=bfougu0rKkSDSIbkKWF3WJ3Hbt4E4mgwBFGjRVHEDPoqj1Cq+fUx7EsOK0XIkgCG6d
         c0G5S6bt15V17+S6XM/VTZ5Ks8sQZ3T8CSbFff0HjUzYORIVQZzl7BttZI12gUTzgbPL
         LVcQjp0Hl6Gk0KVHspvUsNYr7/lJ0QaBd+l+jAoqx6kzGwVzdszh7Wd1PTKRyJ28LycJ
         k8sL3zVrd83zaAp///l/8N8+FEof44zdSVhHcFSAfHY2Sw2pH31zcsvTXIF1DC+NcCa2
         vtD6k5+yq2b6LIVp4iZkvgEoDyF6NzKTp4hpYpGaeBC0QzpVQKsEwADxLOCQhkiq6zgC
         fXPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791294390; x=1791899190; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Pm8zUZvlBkdi0wY1ju+p+rWxMJ6Dlo5Q1LwsdfKGfK8=;
        b=CHxHZPbmjK81Eem7IAvOyaGw6CHBxZvKKRqctPDVWViClwCdND2OXzb7XsxGMizNtv
         gBur4WcSSCiVtcdIfbPPx1HiFbV/3XZIQSDi0eJyshewFfXBIw29IUcDoQIrQvO4qAt0
         Nou6T8FumIVonVsoN/SYveogMPZeu7oKk5ONZProGhTznQ6UUFYl1LsoaGeDCE/vtL1M
         px8h8yP8de7hxNLEuCeVj9c3Rd2Nj3uisdGN4mubCXae2DR/0yhSxt1MBfgxlKK7ttxH
         LfsgE4RnUZuC6RZI0/GhfAtog6S85sjArAZf1zjXzxdxOcbm1z4OcOZ6aqGxbnnGn8HK
         zTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791294390; x=1791899190;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pm8zUZvlBkdi0wY1ju+p+rWxMJ6Dlo5Q1LwsdfKGfK8=;
        b=JJNLplHObnghzh+33ufKpnTvJC6dt0cmGOfGiB/j53Qmemy1TTDGDeH3ODiRhHOUZ5
         qojlfUzgWF/L2bs5sjkiCfEGMxEahwBzLlJzJjkynsyOztDI2+cwpdfK4kHqa5/c2C7a
         Xde9yvykPjkEu75uYW2AehrntD7QySIWQ/eU23Cm6hSUKemjsf5R4lI1KObeMMY4ZnMi
         /cmmOccVu85yttgPg27C6dUCWqGTOxsLv6TqAL2e5EPYy7vx+H7JlMTtXeE8f4mQR8eQ
         lxgBf2NwsUgkJDrRUqJw1rwCicnG9CbAceorv44OOlIAkqYmzVirqluWvLU2egT7mzyw
         HvMw==
X-Forwarded-Encrypted: i=1; AKwUvBwwA1NXlOpLMlL1/THuOThdDlsRYDsWxlCnncPQ0iSBtyJn5Qc4jxcplDziTq/rShuhGlhKt7CS7PQVgLF/8sI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6CnUGR09XVUGZ1R71Ym98ieKS3jp8JBtAN0v+eQM9xGLEnWaL
	96jcDG1X1lH5CIotsVqeLyc935eG9UFnpmz3b/GO5YS4DzaytusZuxGjeCTajp+ZVyi5V7/4gJz
	NfenwjSoCg3kSgHjGpMpzDeug9xgODNknVDLP+VM=
X-Gm-Gg: AYBFou0d46OUjMfFL1YkogzYN8mvmcK9DOzpcVIgMfbFp7stpx7BWOlBeDGqs9rPicN
	flxgGgRU4LW5kmrXgRp6Us6f6xbGNn7IkI23qPn0FUHW7U+5L8jktSugXnG/n/iDqrP/wuRxacn
	m/P+2nKewGzuYXYExyiUo5MX/a7FZd3smlJ3j+jKxMrBGd0HCFNDeWl5u1MEhKgaeUCoqTMmAQ7
	KaU/7Hu1Q3oBY2qIO5kR68dSIyWj7z3bHERqgrtQ9drWF1sDqjvdnDitA+XBY4wmbEmenVSYKzD
	npdpfiEUnIu50b6mxsKJHLnadMpnlJTD++VNigMjmoziOXSe5PMDg3v6C1cqGD8xh1quKy6bULc
	FMeLXU0aOjxWZSwRz1+rl
X-Received: by 2002:a05:6122:d22:b0:5c9:c60e:5cf6 with SMTP id
 71dfb90a1353d-5de6d6ad882mr3678253e0c.20.1791294388970; Tue, 06 Oct 2026
 06:46:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com> <20261006094358.2948476-1-morbo@google.com>
 <3cd11b18-30da-4dc1-9585-1112778aba38@app.fastmail.com>
In-Reply-To: <3cd11b18-30da-4dc1-9585-1112778aba38@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Tue, 6 Oct 2026 06:46:12 -0700
X-Gm-Features: AclHuK-xrMb5bRM8C1f3tnWgdVCw-4GPt92q5ifPXVanSRIoA_ArhDjbqKs1NeA
Message-ID: <CAGG=3QWxG9m1gde+RVwqEfDHSizfNP_hOV5UpQUdA5aTbx_8Eg@mail.gmail.com>
Subject: Re: [PATCH v4] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, Mark Brown <broonie@kernel.org>, 
	Marco Elver <elver@google.com>, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 3:09=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
>
>
> On Tue, 6 Oct 2026, at 11:43, Bill Wendling wrote:
> > Code that runs outside the kernel proper, such as the EFI stub, gets
> > nothing out of the counted_by annotations: the bounds checks they feed
> > (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
> >
> > The annotations can also break the build. A __counted_by_ptr() that
> > names a member declared after the pointer needs Clang's
> > '-fexperimental-late-parse-attributes', which the top-level Makefile
> > adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and doe=
s
> > not get that flag, so it fails as soon as such a struct is pulled in
> > through a common header.
> >
> > Overriding the macros from a Makefile doesn't work:
> > 'compiler_types.h' is pulled in with '-include', which is processed
> > after all -D/-U options, so it re-establishes the definitions. Follow
> > the '__NO_FORTIFY' precedent instead: let a build define
> > '__NO_COUNTED_BY' to turn the corresponding annotation into a no-op.
> >
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we ne=
ed it.
> > v3: Add the version to the Subject line.
> > v4: Use __NO_COUNTED_BY to reduce churn later on.
> > ---
> >  include/linux/compiler_types.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_ty=
pes.h
> > index c5921f139007..05e2b637f1cd 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -371,8 +371,13 @@ struct ftrace_likely_data {
> >   *
> >   * __bdos on clang < 19.1.3 can be off by 4:
> >   * https://github.com/llvm/llvm-project/pull/112636
> > + *
> > + * Code that runs outside the kernel proper (e.g. the EFI stub) can de=
fine
> > + * __NO_COUNTED_BY to drop the annotation, since it gains nothing from=
 the
> > + * bounds checks. __NO_COUNTED_BY should be used sparingly, because th=
ere are
> > + * better options for opting out of bounds checking.
> >   */
> > -#ifdef CONFIG_CC_HAS_COUNTED_BY
> > +#if defined(CONFIG_CC_HAS_COUNTED_BY) && !defined(__NO_COUNTED_BY)
> >  # define __counted_by(member)                __attribute__((__counted_=
by__(member)))
> >  #else
> >  # define __counted_by(member)
>
>
> What happened to counted_by_ptr() now? __NO_COUNTED_BY should disable tha=
t too.
>
I realized that just now. *sigh* I'd take up basketweaving, but I'd
probably get splinters that would fester and I'd lose fingers.

Fixed in v5.

-bw
