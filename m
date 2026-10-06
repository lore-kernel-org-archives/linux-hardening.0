Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC13B47D5
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 09:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278618; cv=pass; b=lUgRGE0VO8Enzg0umpew63zi4bXAoCfZjCN+Pmo7XNHiMw3Rvwweegy9fHZa93HCJxMhTjj5THMtQ/8miv0gDhsSKk7cs1vVWewnf6IvR6zaxwdxuzEYNDMWDfmIbaoRubHrQz4sKntNVT060D6b5UcRoyrwRs3K/DIegA41HDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278618; c=relaxed/simple;
	bh=XrDbxp9D5a6x31fsBexXhmb5Tdb4LYGgG402LfoyXuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iDGoT1Fv2ezpnC8bEpd7Wa6vFyRp2UdkxWArFznm3at0JH706GtUeCgZSWvTLhSksiVd/cJp3PSoXtMxuhPx/qZr6/RzlE6E3hP8GyvGwmZPEIJy96A94dTSYcWoC9wciXUzgxylNVeCVNkPJnESdXKEwF3/K7RuNx2W17xTs1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0SwVZYH; arc=pass smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0SwVZYH"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-98c887ba689so534973241.0
        for <linux-hardening@vger.kernel.org>; Tue, 06 Oct 2026 02:23:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791278614; cv=none;
        d=google.com; s=arc-20260327;
        b=I9xiCadZjLDoRACFcoZVESqraN3ZrirQEs3LvtHc5wCkvzOHaNWEyy+WIyH5HaGdYO
         67wO/4bqw76n40HwYgzeXDth4LZpD31yDLCU49koYHw1+35WM43tyryRx9cAuRv873Tx
         OarGOkpM/u5FQvMpsV86Nuli/l/uUoOiTOi3d/YIhTUY294wHNRBY4UJrMr7E1bU+CJu
         2oj/rp/l0cVoYa8cXUvXuIl9O/CXRNd8tGhPJiaWKIahLvdW3QQxcBzQkvc7eHSI4b5S
         8HG5k9I2jjeXyY60tZXfQ52F/WtyxcELlpVXb/mjc55FKdQg/47pSqWbWRtKf9L3lBaJ
         FCaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m9BaGNIm8DyjVQqQtGOe52rBvNqGEalGiaaxbuRoj4Q=;
        fh=DuUpB06brJwqMe0okC5IWHHigJp9WTODZEcKmOp+D8g=;
        b=OLI2XJ15Q4Cfo0+eKyl8GHkyYClGcPqxoSh9HvoGFuWRucN0oxs2OY6+sAolBlNlvz
         /cXHhnps97xlyLwPPBRyp53FHvzInIObf3WA+u+Px/uYZ/GdUd/PxeQmC4wzEV56sC3H
         Gb/REBecjjh8aIpMJekNOuCmacBMR/xHg/Ly/nM+KBUTs4z18LbreLSquLKXhmExaW9W
         JR5eLd3duB5rg1qI6HYbdlrjLoZmnyd/36U3pllnU8oaPl1w5mQIzTFs4BisvKhmVHyD
         /e/Cc6XhCyocFs4oDK1sQ8+Dh5eHF9hwu6We8Gx4HJNkhT2Auu4DmbII4OgDkfmcmfp+
         aorQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791278614; x=1791883414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m9BaGNIm8DyjVQqQtGOe52rBvNqGEalGiaaxbuRoj4Q=;
        b=a0SwVZYHRf4wWvqrliLx2fgblB7TG0OQQnfFZgvYrxKBN6E/QbEfAYQacdFmwlJq2O
         25qp2j4n1WDwCR9ENtS/l6Xy85HtKNvC9k0QzwEnNYc1x4o/gODQvBtLnFb5vArII3i1
         J0f419d0FxO9FjmeDdY+rE5emlK/kvYBl8TFlAeimHs//fwa0dGAqddw+U7NGvZPx99k
         SXog1OqtOKVwdPP3yl+VGMU7VXVvb217I+LZFd9LJ5O63p4pI1qO6a5f2RegJl3vMcT7
         yz856PrU0LKS+TFZgy+rMGJNkYTBuR/lIZGfFUJYrWVY53z+Y+R2yosjQDGpiiQ9F09u
         nynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791278614; x=1791883414;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m9BaGNIm8DyjVQqQtGOe52rBvNqGEalGiaaxbuRoj4Q=;
        b=dGnZouD38CEkzTKxsffk3D89swsJNFU2KV12UBxTuN7+Kt7UrLtOtb1XiEuBPGKOle
         yXF/vE/fMVNMO6Djo7AsrPxot4RCXqcVBOOHECxNWtMyTxeR1j6ZRirvTFk6cg0+UVru
         nn/CXhEs0LUhqI2XveKyycNc3Jov8YCnna0H81GF/8fltVcJMjU/w3gvtDl73lfsafyn
         ctJs9kTi3guNI/1QUFjYoQSrB4Cg0/Eu2OtgBZCDOsvcalIOFSvRJ8oGqCHLE8nkV/wg
         5efwcj40XKdQS5rV13sPhw8I8pUaKfvWkdf2ne6wFNYe9u2P0NXHTD6JMleMzrHa0SFO
         VhxQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGwRmoOZIq0RrY/BECL9WFfo7Z4dnRlpXtYuK4IRcL9ZSTJwgExZZcVPYFcCfxJ/FNHRrdTEvVHYZV6bQ11Mg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyZXA9qTq3cQjfEvDwtKuAryGqS8nzWslq+0mG/QJVV8yDQkhq
	PH3tYmVcDHd/T/OO1/c013mlxDBFWMNQSD80Hc8pjvqzD9CHJqgtdk3dcJDgiS/3279/VifVD5g
	4yvGS6ZcG4RoBb0qooGdZ93ZccWobXF6drxgCq4I=
X-Gm-Gg: AYBFou3ul40WItT//ewqX15V7UCMNcxPO7m3wC3kXGueBYq+2BpZ74XrC7pxwBr5t8e
	RoC8NSYxeEybGQNxOfUs5r1xVM/K03o0oqxmXn4+oirZ+13+3Se62Wv015uYZNW16QanlECaCzw
	lUZNpQP/goi01HFsDTJW0KzRJ3IUENXervHKUPxkuQQNykp0pTX7/YwU0NuCkvJ7x5K2lOAs5JY
	teML7hmo7MwaZdVnGp1MoyQHjP5R2blBnnHvYKfL9t08P1XqSku1zyHqKx35MBXbP9K8j7yGh1I
	+Cm09GWbo1RJmXoFIu10m8kmNfqLcT06c0yRmI9UkabvzBYFSXhEqSGIEQHkkZxcuq9Tbc9k1br
	PUgvo0Vh/xPDMGA+lLHVdJfBCk71EXpQ=
X-Received: by 2002:a05:6102:a54:b0:79d:a035:b6e6 with SMTP id
 ada2fe7eead31-7c87a0038c6mr115746137.3.1791278613354; Tue, 06 Oct 2026
 02:23:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com> <20261005192052.2589382-1-morbo@google.com>
 <3176a197-baf8-4e5f-96a0-8c79d32a168c@app.fastmail.com> <CAFhGd8q3Hs9r6ezCA5bFATcZcq7AZyC7Cai8muk5o-AwOMLW7w@mail.gmail.com>
 <e9e04143-22ff-4396-9b33-333231366f64@app.fastmail.com>
In-Reply-To: <e9e04143-22ff-4396-9b33-333231366f64@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Tue, 6 Oct 2026 02:23:17 -0700
X-Gm-Features: AclHuK9qkbH2EI0TJCoQEjGmE8OJ4mfVOULY_WNEwFYu4N8Ri6mQFkkdEf41th4
Message-ID: <CAGG=3QXsdkEEQcfU-QyTW4VA6TsJTScMkidcekrtDtU6H3ubOA@mail.gmail.com>
Subject: Re: [PATCH v3] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Mark Brown <broonie@kernel.org>, 
	Marco Elver <elver@google.com>, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 1:08=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
> On Tue, 6 Oct 2026, at 09:30, Justin Stitt wrote:
> > Hi,
> >
> > On Mon, Oct 5, 2026 at 2:25=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org>=
 wrote:
> >>
> >>
> >>
> >> On Mon, 5 Oct 2026, at 21:20, Bill Wendling wrote:
> >> > Code that runs outside the kernel proper, such as the EFI stub, gets
> >> > nothing out of the counted_by annotations: the bounds checks they fe=
ed
> >> > (FORTIFY_SOURCE, UBSAN_BOUNDS) are already disabled there.
> >> >
> >> > The annotations can also break the build. A __counted_by_ptr() that
> >> > names a member declared after the pointer needs Clang's
> >> > '-fexperimental-late-parse-attributes', which the top-level Makefile
> >> > adds to 'KBUILD_CFLAGS'. The x86 EFI stub builds its own cflags and =
does
> >> > not get that flag, so it fails as soon as such a struct is pulled in
> >> > through a common header.
> >> >
> >> > Overriding the __counted_by_ptr macro from a Makefile doesn't work:
> >> > 'compiler_types.h' is pulled in with '-include', which is processed
> >> > after all -D/-U options, so it re-establishes the definitions. Follo=
w
> >> > the '__NO_FORTIFY' precedent instead: let a build define
> >> > '__NO_COUNTED_BY_PTR' to turn the corresponding annotation into a no=
-op.
> >> >
> >> > Assisted-by: LLM
> >> > Signed-off-by: Bill Wendling <morbo@google.com>
> >> > ---
> >> > v2: Only specify __NO_COUNTED_BY_PTR. Leave __NO_COUNTED_BY until we=
 need it.
> >> > v3: Add the version to the Subject line.
> >> > ---
> >> >  include/linux/compiler_types.h | 7 ++++++-
> >> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/include/linux/compiler_types.h
> >> > b/include/linux/compiler_types.h
> >> > index c5921f139007..8bde6798b4ec 100644
> >> > --- a/include/linux/compiler_types.h
> >> > +++ b/include/linux/compiler_types.h
> >> > @@ -387,8 +387,13 @@ struct ftrace_likely_data {
> >> >   *
> >> >   *   gcc:
> >> > https://gcc.gnu.org/pipermail/gcc-patches/2025-April/681727.html
> >> >   * clang:
> >> > https://clang.llvm.org/docs/AttributeReference.html#counted-by-count=
ed-by-or-null-sized-by-sized-by-or-null
> >> > + *
> >> > + * Code that runs outside the kernel proper (e.g. the EFI stub) can
> >> > define
> >> > + * __NO_COUNTED_BY_PTR to drop the annotation. Such code may also l=
ack
> >> > the flag
> >> > + * Clang needs to parse a reference to a later-declared member
> >> > + * (-fexperimental-late-parse-attributes).
> >> >   */
> >> > -#ifdef CONFIG_CC_HAS_COUNTED_BY_PTR
> >> > +#if defined(CONFIG_CC_HAS_COUNTED_BY_PTR) &&
> >> > !defined(__NO_COUNTED_BY_PTR)
> >> >  #define
> >> > __counted_by_ptr(member)      __attribute__((__counted_by__(member))=
)
> >> >  #else
> >> >  #define __counted_by_ptr(member)
> >>
> >> Apologies, I may have been unclear.
> >>
> >> What I would like to see here is something like
> >>
> >> #ifndef __NO_COUNTED_BY
> >> #define __counted_by(member)  __attribute__((....))
> >> #define __counted_by_ptr(member)  __attribute__((....))
> >> #else
> >> #define __counted_by(member)
> >> #define __counted_by_ptr(member)
> >> #endif
> >
> > FWIW, Bill's original patch had this explanation
> >
> > "The two are kept separate but parallel so they
> > can be folded together once all supported compilers handle
> > '__counted_by' on pointers."
> >
>
> When opting out of this, whether or not the compiler supports
> all variants of counted_by() is irrelevant. The same #define
> should just opt out of all of them.
>
> If the need arises to be more granular here, we can always add
> that later but I don't want to have to add
>
> -D__NO_COUNTED_BY -D__NO_COUNTED_BY_PTR
>
> everywhere today, and go back and remove the second part once
> all compilers have caught up.
>
It would reduce churn in the code base once we no longer need a
separate '__counted_by_ptr' macro. However, we should specify that
__NO_COUNTED_BY should be used sparingly, as there are other, better
ways to "opt out" of the __counted_by family of attributes. Basically,
it should only be used if the Makefile doesn't inherit its KCFLAGS
from the root Makefile.

-bw
