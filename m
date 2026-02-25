Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D48315D30
	for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008421; cv=pass; b=ZNpOzrHVAuX+81DQaz5nuAGcFMGVpPEl0ovpFT58EarN+8etNlCs/1UuN14/vBZ5KJlgCASIa9YpEHIytZZ4kB7kPCbDZwSCpY6SPsXTZFwscQLew/SXoLHsv6ZoXqNs1I0q4LxcTm9Sacx98rXngfUfK2+GSfbEZK9nrQ9Qm7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008421; c=relaxed/simple;
	bh=xOPvCBqvKXLtLIbEsSWku6SXn76+HzJfJxq9bc+YqJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mDwFsRBNqnCMBGdcw6jxhqzcYr8a6B1FSMjnX5QLiuZSk85kByp0BlM17Vro632GPk458h/9y6P5xba0JJgbB/YYZGz+mOHnxyNuNSbgj+Evy8QrFm95PoNGen+ElQYjhtiYlWkXCJL2gNy8f44zwamTgwO8MeYrR2SOdO+q1Bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nsFaV6Pi; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nsFaV6Pi"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a355aedfso350911cf.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Feb 2026 00:33:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772008419; cv=none;
        d=google.com; s=arc-20240605;
        b=RaFogZ2QwUbCuwIUE5MwVIwbMr7cBttIoU3nPsgr+AptW9TTGT1qkaUvNSbs27OalF
         0CgYWwJWERufz/MytkPoFBhkOcRn3Tn37nLtLa4ZR9jnuAcZqsqLw7h3DJp5eZ4UXCJC
         T/K5wvUwPQ1zMmqqNgTL8weovVhdt8KiovnyaIpid+3yTeI3MXPVoLP58M1LkVH0ZiMU
         Ped0k+2LuKzlLhYpEfcr5jLAHgWet9h1lw3YsRl5FhENTn2jq6xzI/NG5h5ET+kd4P9W
         v0LrSfgmfpcrAztlqqpT25b7U0xTblMZ1dBZ6z3AMBsWO87liXI4vW+QJHzp+0xhr+bB
         HKaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KuUGD52tmgp00EJPRCLO5P8J7plz1YlMr/CaLd9RqDs=;
        fh=OON6KelwhPvL5FDiuGXBj7Bni0+8ggrEdcCrbVNkdig=;
        b=UaPwwhVVty8gYEaF8Pv5eeTulIbO7Nrr/vYNIfwEfpC1Gu6CvC9/26DC81mn6DR1C8
         6EPLqGnGleQuX01D5cEabay8O+VDquGTOtXZs7esqUWAieIbaKIM5QT3Byz0M13DvCO1
         EdZtqjhmnL0zPCxGkHYzikUzbyU8PXj3Bir1LAlRhEfhhYZ+ZUX7lSEOeFNRBsH0CCvp
         uQkn76s+97fZbCsJfclKHL2iRZpEawP4Nahwd/iut+gc1WexVg+90emVgdJrNv/9G+uY
         L8cJbWEFmzMpU1uVBAf0U5xoVsvA/a23S4Uik3AekhNro/FjMKAyATOXcDoC3vpixLbw
         rfgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772008419; x=1772613219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KuUGD52tmgp00EJPRCLO5P8J7plz1YlMr/CaLd9RqDs=;
        b=nsFaV6PiqbnP73hKUPe4BJB0d1ypKhOZ5rQVsANFmL6YOLHcabwzWgvnWtd1X/+jRo
         RMRmqmONZH+J7dLdXei5kAAGzwMC+Z3m69O3eCoSwM9Hee9H0jB6yHP7Vsnf56dFq89G
         9aWw5OdVXPBB7OWu57fhUaTjoYJMhaNDcWHgR0i0CPoHx9REAzwRXBZkXi2CiPROdJPx
         IdEqQ4X+yBsmzuIdu8IXn89NjeOhwe6i8aI039c/IqgF0fe/8998y1WpIsCnP21dtsEL
         bUpE2F3sxH8yJ48hxcBsQ/t7c7ZDoE1wkTF53Vm72nt+ORHX73zk1TN4rovjqD8/4hqS
         tgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772008419; x=1772613219;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuUGD52tmgp00EJPRCLO5P8J7plz1YlMr/CaLd9RqDs=;
        b=iZYNGYshAHRfbTVJiZkZaboI73XMA7IQUFS9z/oC0dmuVpWse50nil3no5doOKa+0Y
         A/5sGqQKF3B9KdnEHdvhl2py3UGHRMYC3hFWOvtxhqoAhV9phNLPpgehhmPCi/IpA2Sk
         TdIbtF5ixBz97R20kWt17vvhhWFcdK39GxcscViQmf/Tp5pwBcJHXavhV1Fl/Cq5zbcL
         HOB5dVUtuQn14W2kg0Q1yRo2EdrelnzVpV4PJE3ERNsuC//lxpo6l5y1SOw0c9VfXQks
         n/lW+uI81RU5SPPypa99Ohl2b6riTc+qadqYR/T+tLPVfZ/A2lYKf8GsgLIucllK3pcQ
         cSIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnm6TEmA/MkmgVFTAVcey+btJjAzadQIvvLE+zrwAxJu3UTFDHr9E3kBwORkzPPFl4aZmlF1ou4FoT39GWJhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpiZjAU10qyX5BZ+0iMer6LnwTaAg7UJ2ZIOxUT5L8oJbNRiQg
	RFU0w/uhLqTjee39MfWCqV50kgal3dAw29YiItDy0//J7kQQOigBWeqq0L+Pb9vyya2Uu4Q4S/q
	lWQziNFb0c1i81El9NJE0HSLwhttnlLWo3eUeTobX
X-Gm-Gg: ATEYQzz4GlXuvIwOJZw5l4efzcvbzPfr0Za/MQwHHzCqaoJWaV/V3PxetQSwu4qgE3r
	Le/2yr1OnXbQ1wC+xCfOF3L5CfBoqDHAgtCtqT8cYZ7bGJJUScWyCtVa695lMsWyLssiSG3SA3t
	JYJyqN50F1gpEsRf7I3Ux0bBpz9BZIjVfoSijaj+NWg9mX3wiRJT3C1s7885ZiqsPh7/jI/O1JT
	fV9BhRBII4IIcZWTMrKSBC6AO86hLnZLOeAU1oXlwvR1eCI9wdkOu0B+PEwSAW6riZU+KEb62Hp
	YdJfORd+
X-Received: by 2002:ac8:5854:0:b0:501:5180:3c90 with SMTP id
 d75a77b69052e-5073a358678mr4741841cf.15.1772008418844; Wed, 25 Feb 2026
 00:33:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224170427.2296592-1-tabba@google.com> <aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
 <CA+EHjTxgX8RpVxdf1rrri8m_=oG-0_KpYzhEKaZXXOr2UXWegQ@mail.gmail.com> <20260224230637.38f93836@pumpkin>
In-Reply-To: <20260224230637.38f93836@pumpkin>
From: Fuad Tabba <tabba@google.com>
Date: Wed, 25 Feb 2026 08:33:01 +0000
X-Gm-Features: AaiRm52EEoLmaJmufX5ScYf36GQRaHjggC4UtrWOv7oUnQSdNjaXWhkcy2j5INQ
Message-ID: <CA+EHjTyWtdwQe3_pyrrC0jfhX30jHwYVNQkgNE7UoeJG0O=NLA@mail.gmail.com>
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in sized_strscpy
To: David Laight <david.laight.linux@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

On Tue, 24 Feb 2026 at 23:06, David Laight <david.laight.linux@gmail.com> wrote:
>
> On Tue, 24 Feb 2026 17:54:07 +0000
> Fuad Tabba <tabba@google.com> wrote:
>
> > Hi Andy,
> >
> > On Tue, 24 Feb 2026 at 17:21, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > >
> > > On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:
> > > > sized_strscpy() performs word-at-a-time writes to the destination
> > > > buffer. If the destination buffer is not aligned to unsigned long,
> > > > direct assignment causes UBSAN misaligned-access errors.
> > > >
> > > > Use put_unaligned() to safely write the words to the destination.
> > >
> > > Have you measured the performance impact?
> >
> > Not directly. I verified the disassembly for both x86_64 and aarch64.
> > On x86_64, both the raw pointer cast and put_unaligned() compile down
> > to mov %rdi,(%rsi). On aarch64, both compile to str x0, [x1].
>
> What happens on cpu that trap misaligned accesses (eg sparc64)?
> put_unaligned() exists because it can be horrid.

To be honest, I hadn't considered this until now. But looking at it, I
believe that the existing guards in sized_strscpy() already protect
architectures like sparc from the unaligned paths you are concerned
about. Looking at the code and configs, these do not select
CONFIG_DCACHE_WORD_ACCESS nor CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS.
Because of this, they fall into the #else block early in
sized_strscpy():

#ifndef CONFIG_DCACHE_WORD_ACCESS
#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
        ...
#else
        /* If src or dest is unaligned, don't do word-at-a-time. */
        if (((long) dest | (long) src) & (sizeof(long) - 1))
                max = 0;
#endif
#endif

If either dest or src is unaligned, max is set to 0. This bypasses the
loop with put_unaligned(). I checked by compiling this for sparc: if
aligned, the compiler sees that, and optimizes it into an 8-byte store
(stx %i0, [%i1]), identical to the raw pointer cast.

So this patch shouldn't introduce memcpy fallback penalties on sparc,
but it still fixes the UB on architectures like x86 and arm64.

Cheers,
/fuad

>         David
>
> >
> > > Have you read the comment near to
> > >
> > >         if (IS_ENABLED(CONFIG_KMSAN))
> >
> > Not until now to be honest. However, are you asking whether
> > put_unaligned() breaks KMSAN? I don't think it does, max is set to 0
> > when KMSAN is enabled, this entire while loop is bypassed.
> >
> > Thanks,
> > /fuad
> >
> > > ?
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> > >
> >
>
