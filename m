Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FC3B777C
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791271864; cv=pass; b=d3s3Bl32ep4ZHonr2oJbF76rOgrZ5zEB9QImQ4dsoRAXPd+xZBQdl+SpxMi6Ds1RTVrkvLzJXUSVfj96HYSpun0og2scOc2VhLzWs/ZtLq1O/3CRAhVxTBKydiRYvzO5NcCncmk7APIufiCTcf0eU2uBM8D9m7ZgzlwVdxiI/oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791271864; c=relaxed/simple;
	bh=HqbDUpGwmU9Vj6DEnJhTzo5Q/I2Bb7O52TujIr0QQg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6aJnSPx1M19oh950tWJ2WCIjyLdVpFpIwHiTWZSbqF2BVIwpcmlwjfLYkthTea7al6SHEgG+1HlgJLrfkrV9ETWuxzlOC33KZmMPcMMfRk2bc4N7v4XPay1OFpVhxHhHY/NEGQ4TSA95flBUZzL9LuMfp9hFiV3nijyiWg1+40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/5F2VPh; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/5F2VPh"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-98b2f32e67fso32108241.2
        for <linux-hardening@vger.kernel.org>; Tue, 06 Oct 2026 00:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791271859; cv=none;
        d=google.com; s=arc-20260327;
        b=JWIHPOVaCyuan+byWV68ODh1eOeN4IHjS91xNIgfVTVWOIW4IcW71X0RnWI1C59bWO
         bDpG1CTc8Hpt/4pqnZFP7Hnuo+XpYj/20bSPmxF3/dmVTCdqdBoSMKMI2eq0tzN6IicV
         KphG6R83+6iv3NLj1LE9+SxCXGV+diubT9XtUe4AYsNuUkf+dvSDnWkWc7nEIDw2YtnS
         Ni6lRdsebmu43XhR1aNh4P5rYe+qUQ65seqMNYhnWEIjVAcj0hywt7OLOLUEfMKCM68x
         lojTsNz7jhBGa3KN8+tu9djlEXxle+92uzL8Mv97/IomtoaY7m9+StxOPAyEb9GUmftZ
         WS0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rAhKUuZ8ftg1KrkRjMOJWoz5mwV32k7ntU16rIZRc+k=;
        fh=iVKhXtmv9BNo9kQ62EvHleVOS0+H24lG00AfUT2Av3w=;
        b=JYR0D1etpl67Anbli3bcpoXJFI7zz2Vftyx2VmgQdBYj+oMS9l+XbTbMzFNJQCUpRR
         XPHdogJebi0YNi1jZiC9dTn6w3iPXfnopY4EX/1SGMI4KXIlqB5Jy9DPwcczY3c7ApgJ
         lOFQ3SADEzfqk1QK1Jjp8XznoHEhdfQ3F+zI3oCqZP1fQwHstotaLjjnSHjfjePCbnSW
         zh/oqYV9KrmppHyJM6T3NsYuFvKc1yVbiMtqx92ixCq8DrKkcSc/7pqF/6rdxB9vSqW9
         6Elcew+SLJueiwLalysPbHTPFYwW40rmU1mZ0mOOx6FnfSxHGEY4eW0WR7ESLoNtprDj
         gShA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791271859; x=1791876659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rAhKUuZ8ftg1KrkRjMOJWoz5mwV32k7ntU16rIZRc+k=;
        b=g/5F2VPhZ24v+CoCHMb6TJl8dncnMdjA86Y+FYOHf1M0c2AqA7IKbRR/v/DJamqusy
         hBiqnxvEfABzCetCOWBIG7FKY68gC14KSvCTPUCt++r8bYCWjINftlIbaCD1q0n4z9ZA
         LdIQDcY50i4Q+VvdeT4Y/EmJKV704vlTeyff5zV/mOLsxnUtTg0mkK2SEXxXWDsgFn+Y
         X7kUuKKbDOYEwI/Fnvh5SN/0C68+FIUXzMTRBWQCXBtXpXSZ391hh9ZrhL+UgO98vHlD
         AYP/pCkH0myh5PWXB0ziROg+3uwQ+iCkGZIbE1pIQekWK9/PBwpy/OGc/FsxG7RTfAfR
         m7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791271859; x=1791876659;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rAhKUuZ8ftg1KrkRjMOJWoz5mwV32k7ntU16rIZRc+k=;
        b=dLZhSqDktlRTpOoz/tW5XCpDC1e4d42mFViz9evEmPE6TtU8MP4gHG6jk340X3NE/8
         gLkWZj+WDKZU6hTBsWhzVxl6JLRBIwlczbedCYN3YA+dkJoSREfkZWCI6isudoPG3FqA
         B9Llc5dVrvit1RlWnMqc/WqRUxmXgmlDF/XaFRIULPl4z28PTZy5rJDmTwN3MmxzO8YZ
         NmVtCqDiHPKBJvq6hyiUdXrwBQI7Uus6HGIqHpfKxW4qhfLzzGXAfXH52Nq5TKWpILS8
         cFCgVJXGGpk7M2kTBt1FS30qr7qFc8iGM46u0zoqPTyXAY5/LZtVdzjFrsmcTJbFve+T
         CbPw==
X-Forwarded-Encrypted: i=1; AKwUvByhUYCIRaEh30wCi2P9VFC6bDDscQr0GartX4jOOOPZY0qGZwNlWCf3aIEa2SMJDWIpTYZF++cr3689dhFDRQA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHMR9Ff9zLWhzPC4ACNI8V1PgRYtOZtOM1a/82yWYh6h4wGb45
	Lk+6bis44XGekt5rWFLfumD/WnMtOlD2gB3jd6Ey4x2dfr1Wj3Q5n6MpJy9espGUwskZv0TDRb0
	UMTXSp5rsR6xq1IPkfI27WcBe6w4R6KErITT4K6B/
X-Gm-Gg: AYBFou0kKteppbLAizNdY9vanR9upBUb0NEPk7NpcHY/DKTzZGxX8eDRyeIPoobHzdO
	RA71X2rQ6fkV7kbK/fZPwsJOEhVO/ufv6wrvLgwPIxM0FVWL3RIotrGrLOMKVmtCVxP6VQwCSaR
	weANFH9pFnzluiRYBNmtyV5NbPTz8/LbnE5XDPKghuCRPlWt3/ySYtFu7uVYi0NzR9Xa8x8XyYf
	QKzaOyOGQfcJb2BfkA8SQEtI9H8gh39O5yaJkkaKmMRYNlU2/jQ3ys3YZ8APWUjy/ymK6VBWnGw
	7l2s8BKuI5175en4zjeGEorgQ+9npsW4pZfn7zgEeY8br3nCs1J2UQ==
X-Received: by 2002:a05:6102:4191:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-7c86b7a1657mr86691137.0.1791271857877; Tue, 06 Oct 2026
 00:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com> <20261005192052.2589382-1-morbo@google.com>
 <3176a197-baf8-4e5f-96a0-8c79d32a168c@app.fastmail.com>
In-Reply-To: <3176a197-baf8-4e5f-96a0-8c79d32a168c@app.fastmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 6 Oct 2026 00:30:45 -0700
X-Gm-Features: AclHuK_GelE_trg9Ql7tfs3Unb-Kel9TbJ-CeAIIKNqsPgvqmn4941q8qguKUSU
Message-ID: <CAFhGd8q3Hs9r6ezCA5bFATcZcq7AZyC7Cai8muk5o-AwOMLW7w@mail.gmail.com>
Subject: Re: [PATCH v3] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Mark Brown <broonie@kernel.org>, 
	Marco Elver <elver@google.com>, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 5, 2026 at 2:25=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
>
>
> On Mon, 5 Oct 2026, at 21:20, Bill Wendling wrote:
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
> > Overriding the __counted_by_ptr macro from a Makefile doesn't work:
> > 'compiler_types.h' is pulled in with '-include', which is processed
> > after all -D/-U options, so it re-establishes the definitions. Follow
> > the '__NO_FORTIFY' precedent instead: let a build define
> > '__NO_COUNTED_BY_PTR' to turn the corresponding annotation into a no-op=
.
> >
> > Assisted-by: LLM
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we ne=
ed it.
> > v3: Add the version to the Subject line.
> > ---
> >  include/linux/compiler_types.h | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler_types.h
> > b/include/linux/compiler_types.h
> > index c5921f139007..8bde6798b4ec 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -387,8 +387,13 @@ struct ftrace_likely_data {
> >   *
> >   *   gcc:
> > https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
> >   * clang:
> > https://clang.llvm.org/docs/AttributeReference.html#counted-by-counted-=
by-or-null-sized-by-sized-by-or-null
> > + *
> > + * Code that runs outside the kernel proper (e.g. the EFI stub) can
> > define
> > + * __NO_COUNTED_BY_PTR to drop the annotation. Such code may also lack
> > the flag
> > + * Clang needs to parse a reference to a later-declared member
> > + * (-fexperimental-late-parse-attributes).
> >   */
> > -#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> > +#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) &&
> > !defined(__NO_COUNTED_BY_PTR)
> >  #define
> > __counted_by_ptr(member)      __attribute__((__counted_by__(member)))
> >  #else
> >  #define __counted_by_ptr(member)
>
> Apologies, I may have been unclear.
>
> What I would like to see here is something like
>
> #ifndef __NO_COUNTED_BY
> #define __counted_by(member)  __attribute__((....))
> #define __counted_by_ptr(member)  __attribute__((....))
> #else
> #define __counted_by(member)
> #define __counted_by_ptr(member)
> #endif

FWIW, Bill's original patch had this explanation

"The two are kept separate but parallel so they
can be folded together once all supported compilers handle
'__counted_by' on pointers."

Justin
