Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10B4C10C0
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215590; cv=pass; b=l9IZ1711x4LIaEC4J2JKHMiWVXo0lD7Z4/UwWMwQLFQ3m04zaiA+GWBHuya8pw0eXohEfwhXje5rr83WYo0yDGYYmPB5mIKxjP1J2UbWeAI9JGVBtn/GV2VGci90rBfX0IvYoX8MJ3mE+DS1yCEt04ViVxQzy6GoWOKzIN4Dd8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215590; c=relaxed/simple;
	bh=+fhE2wZv1FEvlLdfLhyZ2/HtD26fmXx/IX4kZxtllpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCV/2kgSvWJMXgJZ1WHL0m6kRUlaAbzYvEF/+TwWVS54ueMijse/ciiFWe10nWD/LW79pD75b2zKRsFx1UntNMvB1nkE/NbK1dtUHDn8dJ9BjhETgMp+BXxapdOArI00SwdJtJ6OkmxO3tft9P+HgGzEv6rAEGuipvVcyZON4YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XyoKBQu/; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XyoKBQu/"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7c4818e4165so36469137.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2026 08:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791215587; cv=none;
        d=google.com; s=arc-20260327;
        b=s3Rk6YxOeLFkkyvLqsCIIh4vd3iT/IlFYWH/cHAdFWIEQzv6pcTlflCkgG6Yuew37e
         zbM6EPMt+OIic4Uo4S0PpriQbfDzqMQ4BbWDJQsK4PuaBFpwWsSU4VmQ/1W7EN9a8/OA
         sfWB3tIqJX3N5xE7Qs3aFLdI6xjJJw9I8CABo2rbCmrDZC0pmiG/RA4krU08RqiEO63U
         77EfMjqr2t/DChKVUAysHJIkz0vH3DHydi72lUc0/n2KDPfZ0oTFMwzbL4vPyd0T8CpW
         53z87h5ZrmfoCXxZElsgggDxus3bJ9e4ucyBsmDr+oFjR1JyAIWsjiNjyrl5avaPRLwI
         mTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GD9Mu7WM6+mJJxlJEE231dGqw01YMMCu766c9NA+OTM=;
        fh=bAIylUmr1kpSXmyKDkIV4nfyDMDDS24ZL0zSY0zKfiQ=;
        b=ZVOS4nS76aocHPmt6Cg+lAvrtgvsuZU7GSF8JcVqfztDccoi8+oD8CEQGs3NaFauMa
         Ywvq+XjeIr8i4JyzEbB3rKLOT1J3BoLbdbrDzJSC78gFbKxMkxoGFb+54VenVyYt8/vN
         oM4CGsiRtQzWraMmHD5QnNCHlcK0cU9hdqNhtdYBoT0Tmx/dWgVDqKjBtN7NA2Jlj7TU
         pun3o+ZLA+tZqkPttBDGDy/fMhKGLwrJFpSImVcolR4gRzOx5kHX8c2CNt5zNTX3EIJo
         LyaCAGXFoCSUgoiybl3b7OXGK3lUt7dW3hr9rYTRHHx56FJBDkQx2///fHsJ6m12Vlhm
         vl6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791215587; x=1791820387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GD9Mu7WM6+mJJxlJEE231dGqw01YMMCu766c9NA+OTM=;
        b=XyoKBQu/QKOnUMbBIROdqh1d6n92HEpTmUrZHlfbprmroozdlHtcVMDkOO2eikyyS4
         kuT+HqoeEmw+aWvPlE1x5ulrp/Og1ZNz/GjsXvJVdBpRaEkJNk3jWWlMFpsIZhHTJzVL
         Mv9Fwef4kKCVrjtB73Jjvp77pnpz6PmNBv9SD6edpSHV25hUZzkR70sSfNhj8hSkjwO0
         vfv6hHx9ieMmzZFybmaUFNCPrHocjtw5saPkil4NQrRkik28iN3RShfQmQyDMbo6uNeK
         kw5J5ysvB30EZ3ntaChEXOj+6Kfg1bf554fJK26CiZCT9bxGm5GXWDH+zn9Dn1BAb/aE
         /5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791215587; x=1791820387;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GD9Mu7WM6+mJJxlJEE231dGqw01YMMCu766c9NA+OTM=;
        b=hvFGesIZWHGTTIiXBBGiNNh0Q4DwUMdJuaPF4Tnha+5S0nNoY9UnOagYRepiui9M7v
         NhVKzIQJQnHag/mNsTqWsEVOdcBzJ9RzuN+anUfO+VMbyBjo0JBY8nwuza63gofJqMWy
         2E3OTX5jqRb2QhL+eMr24bLkS9YNUQ+bR1VFNshngp9/HLbrbzFcRs2x3mTDmF78Fh24
         3Vv61JziwSNmKvc3n/5hBANRmg/TEJFHnvMyzmCc7oARkgmZaM/asu4bR0H5y5qKaXCj
         dORlvQOthYAqlHd9AMn8Aokqxj2vf7/fO1rzhG7KbROw8joqUDqqFybADfoDndOlVq91
         57ww==
X-Forwarded-Encrypted: i=1; AKwUvBxJGH9nNYqXYrvKcfvw+ojZXSasMERtwoCtUA13ScEzAMJRXCuuk8lVIdc3MYVY9Oc7YxJolcqjmBFJXJdVfXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5jR0dZuATm7WLkNBoaWys55ZEEMlUFE8FgV17flLoKr/+K2PN
	JGm1LRP8x63vO2ABr4wqxVs0NmAKL/C1yQV6SEYmfLk4qEVBdzvXlnEwGsIEfjSJcEqicmU2b+o
	VmPrQmrlc3NqB5onE51Gk24EAeWHOG9sEDb2wcNQ=
X-Gm-Gg: AYBFou0iFzWRl4JEz/sJUxkQz8ihJBQARlma+8mf42rZFKPAJg/NOUyGVMPh08hfgFV
	fJQQX8qEdwtZoPuob8cMQlGPutTZi5BLiM5/KXUyQICg8IysWITiunFfT8Qfx9DP+dRf4l5Dteg
	Uc3ri98byBmcTswp1Isqpi6Qyvm9Lz4FNmKc2q0AyOJHIPlABkRYYlXLkTPNBAHw93jqA11rZbe
	1Y86aiz6LN7yssVnm85ZZw3KIC2oXEgEcvre+nv4FruXDFj5Tflai77aeHkSwSdBaGlVr07FTwZ
	CJqa60A0TrLexBuut0bdEeI+Da3NZTbxNqWc6tD5RpA1/uAIh4FlyEvAx4DbROLbAgNiuSPrV9B
	0465tKaV3iSHlR+j/IxF1
X-Received: by 2002:a05:6102:318a:b0:7bf:d09:8f65 with SMTP id
 ada2fe7eead31-7c7e0cd91aamr7307137.13.1791215586222; Mon, 05 Oct 2026
 08:53:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005102518.2400984-1-morbo@google.com> <ea6e022d-e04b-42e7-b526-ac96559b3633@app.fastmail.com>
In-Reply-To: <ea6e022d-e04b-42e7-b526-ac96559b3633@app.fastmail.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 5 Oct 2026 08:52:49 -0700
X-Gm-Features: AclHuK_Gfowy8Y-I0Ooc088gxc8QVe3LPtj8zIs2qHUBLzmWW-HnmUT4ck7UGKI
Message-ID: <CAGG=3QV+PmsOZnM7+ss-6K71nKyRLzpJirBmFQSo3vuLMqDjLQ@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Allow opting out of __counted_by and __counted_by_ptr
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, Mark Brown <broonie@kernel.org>, 
	Marco Elver <elver@google.com>, alan.maguire@oracle.com, namjain@linux.microsoft.com, 
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 3:54=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> Hi Bill,
>
> On Mon, 5 Oct 2026, at 12:25, Bill Wendling wrote:
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
> > '__NO_COUNTED_BY' or '__NO_COUNTED_BY_PTR' to turn the corresponding
> > annotation into a no-op.  The two are kept separate but parallel so the=
y
> > can be folded together once all supported compilers handle
> > '__counted_by' on pointers.
> >
>
> I'd prefer a single macro here - if there is ever a case where we need to
> turn off one but not the other, we can revisit.
>
> Otherwise, this looks good to me - thanks.

Hi Ard,

I wanted to do it this way because the two attributes rely upon
compiler versions, and this gives us more flexibility. Eventually,
there will be Only One(tm), once the minimal compiler version supports
both __counted_by and __counted_by_ptr.

But it's a small issue. I can resend with just the __NO_COUNTED_BY_PTR part=
.

-bw
