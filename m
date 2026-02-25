Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D03101B1
	for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006954; cv=pass; b=AKWaOgsIA1C4autvUst/e0bfNqYN3/fqgS/Goaz8pyMfOe5H0zeehfDYAsTcyasjlNZBUu2w55obREOxZ+Qq1Sb0pO7oJ1yL7yA1gM4n02gF42S1uVI6jmGfTJRQpwmJMlWkB3aKJJMnJYDnV4cRqsoMtGYTs27jeO9McAItp4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006954; c=relaxed/simple;
	bh=xjHhlGTyaFi03r+eXKhlQIWfZD55R9BujbPY6G6Kqhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ji2WyFg3kX1URmO48YzH0IipnokjFGVo8BvLpCjFhZYuapLdpI9b/rNrpBUrsrc6hL1CnkiO0aP9or9QT6QdP0Y1PqMEoML1ufcIjZqOjpfeKRZvZT/ysd5JZdjcbidvA+C7EdzJEF47r60QCqEKd5ItFcUOGrqpn5k0/uOuffk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uv2QXCvb; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uv2QXCvb"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-505d3baf1a7so314851cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 00:09:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772006952; cv=none;
        d=google.com; s=arc-20240605;
        b=HEEHPaCSfZv9wvuNJDDZ6yDGQeQmvb4TH0V3jBORnI+JQBpDbYJGPuGrG14R3VevoD
         YWuIGV83i8DK+qUfDMdDI6+DaPEwcSfK/xlVkxAUMCbt1WpBXVbg5S4+NbbP4arR/U4X
         xfHTkfOJShMBuQG1vVgybwA6ixBcaEqThm5w1Z20w7O2BvKlPX7SWa9ARKym5wq/k6Ji
         FYF6p+Cufzu+AhngDURuFhzxbY3cDrjNDNwZVw89mlGCsbQ5JbPT0rrpdqXJPsqm8YBZ
         kh1WlsvFZqJjK8ELpGUI96GDvbeRMFP1xVch4/HtC5zGAPIV+A3salZtYrlqfw1l/Cm0
         Wy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=L6YIQnz9NraUuZS2chdHSCaITGbxkd/TJLEVJpvgau8=;
        fh=iK0/O9/4cTrczVwz3Mm6dnKxwZvxC2n+QksmPQ/3dWo=;
        b=AHqdH2C/CjEpYnl79JZ0UGWtns4l9gZrZymoWKsQphWsUknF8IAzEAccww62jagvrB
         xuvCaMgDyqHi3DTi232keKXRkK1CKo/WhR87LHreybJ7NOg8HNyIcGtOJdjVMBrnbX9A
         K+4KGWCoZJwHp/oT2A8mHLR5Uh2pgBgKQ3z7tS1MZb8a1yu2kMJJcMDDwGHab9FF2l6D
         hSt3VBgjpVDBgSu2v3PZkcKXL0eEt6pmDn+cLXxaWqsiE6et1Tk3jKItvqvRL8VcBBlS
         6+nWukp4L528bf7WDKs4MUJWuLE3JK1x64bhaxHPTeefOt+Rq6IG0pOpMcznN607c190
         i00A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772006952; x=1772611752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L6YIQnz9NraUuZS2chdHSCaITGbxkd/TJLEVJpvgau8=;
        b=uv2QXCvbzhm+iL3IzEyB5Sl4wkymwKZCgvSKFfuGA7AJ6wo/OmaEcKmsLvGeow+GPb
         bZ1o4WrJG6y96InIAD485RlJIRnUGk95eBMsboTaESjOvlUE2z5G9LCxCdvTMxwjUvOg
         lmzOTnOafacP9AQWDYamQTFhVndHvFJyODwyAHeBYRBBnkK2EUr41fJIrmQl/s3jpyNe
         AylbcxPyHUU1fIY9ACYyl8ytvLEANPHPYX8U+1RkpVwFHWwmfBgKRpmQ84ViNW1QJ/cG
         2Bc65S1mGIIYMVXb8Pms+nB/LoOX7NwBfxYMe3WnZN0ycexWJKLtDd+rPPoXizTY+iDk
         9pDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772006952; x=1772611752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6YIQnz9NraUuZS2chdHSCaITGbxkd/TJLEVJpvgau8=;
        b=wnT+ZJpOL7cfrPy8+reH7jzF93VfhDmojmFxqMZukuTYNnin947N5IA6w0uith5FZE
         Te1VmpH73qu18kxPJKo8dK5/dr9xoNJSfHebma8mvaz54P8T3GRGmjy1uT5nGgu6c5mq
         tjFSbDfi/RTPvJ08gyXUih05xnggr2abittHxuyeRsG/fsawXMFP3Gu+JwV3M9zt3Rq/
         wpg914hm9tkaRsEc8Jwe5hex5gNSeJfRlaVBLCoehNP9E8wfkf0O3jlokub0qPKcb0Sn
         XfWgTIuXR0JsuaR1w2GnfBdqxqgueoE5tk9dX66bjxGINVsv2Vb7q+5ANZJIBHokG8Jg
         piGg==
X-Forwarded-Encrypted: i=1; AJvYcCWfHh9ai7SHsW+PxbFPNBLdimRTwWIme94F3Y1O68b4ZGpzefPdtaAS2Eu4ubgw3FoVNqs5Ukb81Nrq2Hq7nHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+luynzdRgDRk9SvKuyB6Qx+RBH062Yqls/gtF3tpHME/Rs92
	LgpUpO5jsT9EuOFo1Avo/+T20RnKqfHRPXKRpK343CL55w2eW4xUzLUGXBO3r6jDe+zggtegdA1
	HvmnGPS9KNd3GvT0qId4Zy8ADgGt5SkUIb34I8XKQ
X-Gm-Gg: ATEYQzw1lT68mP3aMX+v0K7SFPENU6CvYcQWfKqQGeDIhnzPCCgOuVAqHiwEoKqKJqC
	+RMO9m+rMO3HcorNOMz6RodsBH5xgbmMyb6cVUvj1pWCklLLMC76EPP5aEm/Jgmo/wn4DTpSqrc
	i69auwceo1k9ol5XGyhwVTIB6JuOh6U4vGsguwdXOrJIHnYF9hGfiyzXtTUdfSeKqiSG4X7rZDC
	dZ/Hll6P949N4gz94Um30Dcp5whRrINKCfJJUq8P/QSrJMwawAiAyNhOS8SB1PvvaOJfa4NbliN
	exwf7/Fe
X-Received: by 2002:a05:622a:410:b0:4ff:bfdd:3f46 with SMTP id
 d75a77b69052e-5073a352145mr7301271cf.15.1772006951256; Wed, 25 Feb 2026
 00:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224170427.2296592-1-tabba@google.com> <202602241302.75B565883@keescook>
In-Reply-To: <202602241302.75B565883@keescook>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 08:08:34 +0000
X-Gm-Features: AaiRm52D4gt4nBDcZIg9ovpOrbHjFp-HgeCwztF_KNCksRKg5fpAnRqEfbU-5Vk
Message-ID: <CA+EHjTzCFAecmjkX5iYJ99GqCsJhT6T5ONCSFMDh=khNG6MzTA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kees,

On Tue, 24 Feb 2026 at 21:07, Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:
> > sized_strscpy() performs word-at-a-time writes to the destination
> > buffer. If the destination buffer is not aligned to unsigned long,
> > direct assignment causes UBSAN misaligned-access errors.
>
> Is this via CONFIG_UBSAN_ALIGNMENT=y ? Note this in the Kconfig:
>
>           Enabling this option on architectures that support unaligned
>           accesses may produce a lot of false positives.
>
> which architecture are you checking this on?

This is with CONFIG_UBSAN_ALIGNMENT=y on arm64. Although the
architecture supports unaligned accesses, I was running the UBSAN
checks (including the alignment ones) the other day while debugging an
unrelated issue. That said, the alignment checks ensure C standard
compliance and prevent the compiler from optimizing unaligned UB casts
into alignment-strict instructions (like ldp/stp or vector
instructions on arm64, which cause hardware faults).

> > Use put_unaligned() to safely write the words to the destination.
>
> Also, I thought the word-at-a-time work in sized_strscpy() was
> specifically to take advantage of aligned word writes? This doesn't seem
> like the right solution, and I think we're already disabling the
> unaligned access by using "max=0" in the earlier checks.

The max=0 check is heavily guarded. Both x86 and arm64 select
CONFIG_DCACHE_WORD_ACCESS, bypassing it:

#ifndef CONFIG_DCACHE_WORD_ACCESS
// ... alignment checks that set max = 0 ...
#endif

I also noticed that the read path already expects and handles
unaligned addresses. If you look at load_unaligned_zeropad() (called
above the write), it explicitly loads an unaligned word and handles
potential page-crossing faults. The write path lacked the equivalent
put_unaligned() wrapper, leaving it exposed to UB.

I checked the disassembly on both x86 and aarch64: put_unaligned()
(via __builtin_memcpy) compiles to the same instructions (mov and
str), preserving the optimization while making the code UBSAN-clean.

> I think the bug may be that you got CONFIG_UBSAN_ALIGNMENT enabled for
> an arch that doesn't suffer from unaligned access problems. :) We should
> fix the Kconfig!

Does that reasoning make sense for keeping the fix here rather than in
the Kconfig?

Cheers,
/fuad

> -Kees
>
> >
> > Fixes: 30035e45753b7 ("string: provide strscpy()")
> > Signed-off-by: Fuad Tabba <tabba@google.com>
> > ---
> >  lib/string.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/string.c b/lib/string.c
> > index b632c71df1a5..a1697bf72078 100644
> > --- a/lib/string.c
> > +++ b/lib/string.c
> > @@ -157,16 +157,16 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
> >               if (has_zero(c, &data, &constants)) {
> >                       data = prep_zero_mask(c, data, &constants);
> >                       data = create_zero_mask(data);
> > -                     *(unsigned long *)(dest+res) = c & zero_bytemask(data);
> > +                     put_unaligned(c & zero_bytemask(data), (unsigned long *)(dest+res));
> >                       return res + find_zero(data);
> >               }
> >               count -= sizeof(unsigned long);
> >               if (unlikely(!count)) {
> >                       c &= ALLBUTLAST_BYTE_MASK;
> > -                     *(unsigned long *)(dest+res) = c;
> > +                     put_unaligned(c, (unsigned long *)(dest+res));
> >                       return -E2BIG;
> >               }
> > -             *(unsigned long *)(dest+res) = c;
> > +             put_unaligned(c, (unsigned long *)(dest+res));
> >               res += sizeof(unsigned long);
> >               max -= sizeof(unsigned long);
> >       }
> > --
> > 2.53.0.371.g1d285c8824-goog
> >
> >
>
> --
> Kees Cook
