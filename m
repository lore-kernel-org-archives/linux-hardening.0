Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E347022EED
	for <linux-hardening@vger.kernel.org>; Mon,  5 Feb 2024 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138665; cv=none; b=ZxRHLpmHn0gEt6irDyvs2hHxPofZzmvifTrCS5DPpirXPX+Pcg92bVW2PVGJXvKDLvEbSoytLChGrq93Sl5bCCbp+lKCPYcscJE9wgtp/CbNsUmFkBiElujXJEDKxHxY4Ajdw+3Hks2aRvzhubLfcIu9FrMCj5w9WjSYrPQPdZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138665; c=relaxed/simple;
	bh=8xEKAj/aIXoAnef6WCYeb1etalNTieAd05i+DkQi20o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UINsD6bdmsLTejNWZLNMyDcQhzezemkGcqaF9SDZZGEODEur0CZ0piJ1eZkj9j7KeiRN8fX0NHjILrogpxWT6QSWiGZ5KIGa+1lbQiHAto0VyIRUWe2klNfULn4i3zxT9Wx3E2VCAwCzkf7LvE+R9Id4/RuWcoPjPy/WGZB1rSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bBdQmjDS; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBdQmjDS"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-7d5bfdd2366so1505853241.3
        for <linux-hardening@vger.kernel.org>; Mon, 05 Feb 2024 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707138663; x=1707743463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgO66v67ga2hZ/fa1VFxPxUYTn/f70qrUJZfQyHF9yA=;
        b=bBdQmjDSnnkWD5f1QtQfnNPLrvNXSidpvjrE8+RIApgvH2HKizXXrMUh00mjc8DvCt
         0uWD3IiASEdE+OaouQPasLRBYGy7GPQS4VFIulh9aa7qBIGAlYT0lhbkaztXGVQmoi95
         nH3VQDKDQ45KtC9Q0GoNsinbGjpAIOT5KLcUVQTUSynRcODRAvBReUkh5EfK0isEGbC0
         ss1WFU3SRdB3YxF2LjxnnAbHp9a9cThGow+xNeDPZHBohqIHlQq8Ix0wlQdzjhzGOzsW
         dUSMCivz48FGXUHIAKWnF87ayITJSgWEyzxtoJwacYBDZZhKUvjPFWVpWfewdGzsh6qt
         BZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707138663; x=1707743463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgO66v67ga2hZ/fa1VFxPxUYTn/f70qrUJZfQyHF9yA=;
        b=rwMesnsVUQUWulRnXQFeAX9CKLDJKL9ffcchNA5V2MSki00WYuC5KhIufb04Cvk3uA
         40kTSflqmiMd47urabfabsDZjR1on/T7FPLnS/2JfBIijT8+pj0sqXf9TIr0w6BvLh3Q
         bhkGMUvlY9YhSVURYJqkR2OWWRyKfZ4KZRGtOyt9tKiTgxR4iR+IMCYTsNE6ufCYNRQe
         8StBuTbjRTM54jx/ae4vpNn57QXsv46RXKNtRTwN6Sxga7sIJopnG9n5swuO50XoE2wg
         E+pEYftpFB0dHPRVDdq1TWPmVgejfbHiglKmvYTo0raQea6LiF6WfgMLfdrIYXDa1tE2
         URqQ==
X-Gm-Message-State: AOJu0Yxy8VETpl2AB4vuXzH/UOHadjHp/02wmxir/+QDi4iHkR3CCuie
	2q0HShapzPTNkVebADo8cDLbutltY1opoIm7e/Ej/ZDev7aqFiTXEDzqE7q6eCX9ud3fx1Fo3Wz
	o82JGDHZzZ3X1ypE0/JHy/BWdCF6j5GS0leY5
X-Google-Smtp-Source: AGHT+IGvWhOgVq5Sybn9CKaxdFweO8fp2yqczsb5Bclf6Z7TT13n+R/qBMPNOqS9yiUPSbnFy6IPYHjqSKy05FWL5Oc=
X-Received: by 2002:a05:6122:4d14:b0:4c0:1cc8:8819 with SMTP id
 fi20-20020a0561224d1400b004c01cc88819mr2759261vkb.5.1707138662522; Mon, 05
 Feb 2024 05:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205093725.make.582-kees@kernel.org> <67a842ad-b900-4c63-afcb-63455934f727@gmail.com>
 <202402050457.0B4D90B1A@keescook>
In-Reply-To: <202402050457.0B4D90B1A@keescook>
From: Marco Elver <elver@google.com>
Date: Mon, 5 Feb 2024 14:10:26 +0100
Message-ID: <CANpmjNMiMuUPPPeOvL76V9O-amx9uyKZYtOf5Q2b73v8O_xHWw@mail.gmail.com>
Subject: Re: [PATCH v3] ubsan: Reintroduce signed overflow sanitizer
To: Kees Cook <keescook@chromium.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Hao Luo <haoluo@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Nick Desaulniers <ndesaulniers@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 13:59, Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Feb 05, 2024 at 01:54:24PM +0100, Andrey Ryabinin wrote:
> >
> >
> > On 2/5/24 10:37, Kees Cook wrote:
> >
> > > ---
> > >  include/linux/compiler_types.h |  9 ++++-
> > >  lib/Kconfig.ubsan              | 14 +++++++
> > >  lib/test_ubsan.c               | 37 ++++++++++++++++++
> > >  lib/ubsan.c                    | 68 ++++++++++++++++++++++++++++++++++
> > >  lib/ubsan.h                    |  4 ++
> > >  scripts/Makefile.lib           |  3 ++
> > >  scripts/Makefile.ubsan         |  3 ++
> > >  7 files changed, 137 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > > index 6f1ca49306d2..ee9d272008a5 100644
> > > --- a/include/linux/compiler_types.h
> > > +++ b/include/linux/compiler_types.h
> > > @@ -282,11 +282,18 @@ struct ftrace_likely_data {
> > >  #define __no_sanitize_or_inline __always_inline
> > >  #endif
> > >
> > > +/* Do not trap wrapping arithmetic within an annotated function. */
> > > +#ifdef CONFIG_UBSAN_SIGNED_WRAP
> > > +# define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
> > > +#else
> > > +# define __signed_wrap
> > > +#endif
> > > +
> > >  /* Section for code which can't be instrumented at all */
> > >  #define __noinstr_section(section)                                 \
> > >     noinline notrace __attribute((__section__(section)))            \
> > >     __no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage \
> > > -   __no_sanitize_memory
> > > +   __no_sanitize_memory __signed_wrap
> > >
> >
> > Given this disables all kinds of code instrumentations,
> > shouldn't we just add __no_sanitize_undefined here?
>
> Yeah, that's a very good point.
>
> > I suspect that ubsan's instrumentation usually doesn't cause problems
> > because it calls __ubsan_* functions with all heavy stuff (printk, locks etc)
> > only if code has an UB. So the answer to the question above depends on
> > whether we want to ignore UBs in "noinstr" code or to get some weird side effect,
> > possibly without proper UBSAN report in dmesg.
>
> I think my preference would be to fail safe (i.e. leave in the
> instrumentation), but the intent of noinstr is pretty clear. :P I wonder
> if, instead, we could adjust objtool to yell about cases where calls are
> made in noinstr functions (like it does for UACCESS)... maybe it already
> does?

It already does, see CONFIG_NOINSTR_VALIDATION (yes by default on x86).
