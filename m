Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B5E385D95
	for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 17:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778606055; cv=pass; b=IySlYDAeJQrvU9ymwz6Qlw7jSZsnv+nNaf+//Efw/aXjPJvvpdVbWCVxB/+IGSS25FQkCmUlCAdwH9RAj2wrklz/3Z7SV/h96Qg6OHUO9lI/5WmFKVM0vuO8f0osWFdqCyGsv6wFTlWnl4w6nmgX0OiAJK+Q0x1x+vE/+uXfyE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778606055; c=relaxed/simple;
	bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XWRAFoq2rXZlv434tqEKzaFX3J2R6pz3b7HeT4hP2yN7sC+hVL6UoX5Dy/2XSKh+8qMqkSK14t4HpkRCaf/s/GhFG5iXo0wrz4Z8IJX/JGHiEGuBxsnZw5wSoEUPY70BHubl3YItBjp8fLQuv2Jn6UKxZm+gkBp+BrRTa6+roBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGppsbak; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGppsbak"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso8518763a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 12 May 2026 10:14:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778606053; cv=none;
        d=google.com; s=arc-20240605;
        b=FneAUw1SmcPaQ+44wIdFSGNPWfxx6489KXrfFb117HE+1e4RQxWN27tFOHWKfbuPpG
         Na0uj9lzolyULhx67FnyO4G9zcsMloXkObeGva8BE74LZGBc9xO3tw07dC3ijfUkc3HY
         CdXZF+JyltwQTaDcgj+MiuuenPfdpUflCnPa/OwIAVdWJA445hXF1rc3hlCRGhx4+RJj
         ecUeSGbo6MSB58Cpud2Bn5ApLWXhHfC6BnCOHj7pF0gJZoXOWMcQghTmF8uoxnve4iZd
         aoTG9BeVEP3e7h6skXr9qhAbFsOlkdcNjPYz9qtRhUNdMcM8AuzfSiF+mCGeR8sxvpdh
         McoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
        fh=Dpq3psCG3gUc3AKVnQKp24VWCL9KTs8ueDWzv/OlxTc=;
        b=VXtJ3xIouXQM9i51P33btBWYjrc0I8pBlj9sL2lTQ9C9ju/vuvJ5zNRpKITdjVnC0N
         jeFyKrybWVcp7vXidJ/Xa+DF9FT/ngdNx1m7D+YWkwVRMg2b4uCVSzM3S30hKMRDELVK
         LUtlkdfS6sefFj4+fsZ8oWtLk6lvBp0DFrW6uCCltsjAxS6LKaMi2pZ4qAMne2yOBo0h
         /TOpLSIcLfRdnwt7r9senTRCb4F04cN5V7M7VViAHPD2Rd3a8rn1mReSesl7E1VB3SHG
         gFGfGh/wNHLWaaBFNZ0LzJctybRMwIPjQD1QbMSgFPOpoZhG0yYD8QYtvbt+AHhlyQCd
         lkWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778606053; x=1779210853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
        b=NGppsbakCAtsYSpY/QXVRFgbGAAlbijcE6L0bXKeaTNkicJA5rSu42bolfzXt/LrwI
         OAXgLd27HhZi1xTiDAD7TBTBcDMPFdu5FCjacxL95HajNWgdlEL+Ej1hHBp1cI1WOhmE
         zFHIoN1K+Qq91X9oTTqUsuAs/gwExlhfZddSU4lTzPwC24LZrjHn2elyN/FxjpeLs8+L
         2ne5S85mzFGPFdqVxe6/Q846l4gHd4VmwjGu+DRXHC4oNyAqxQ7klkva1TF55nU47lmj
         w0qxK7Zh4PO4Pff/nXI/peg3R2GI6LG6M9FFdav30/UVNrV/JKbTEzs/O/xyfNACVlvV
         H3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778606053; x=1779210853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YO8UEa79yuXhPeuCXmMbzlsDI56cE8B63Go0mISNV9A=;
        b=PsdFwMb6MLwsh6dP042621x/oC97Qx74kfww4Ez3HfH/5EDlKq5hpmoH8NWkchbpfM
         gE3ZHkcDwBkfibw1i0jC12sbZgloYysq4BmdmQRgD0e3RGlgx5Y5IE1xo46DtGQxiXZJ
         R+FiWhQKt3qlmZkkf2KGerr6yyi8JMxImgAeoGdwVCpOSpm/4a3D3DWKGsYss1AIsIhN
         +lIAe0Rup8vRQ6JcWuf+FKGvtBe47JpbXYbTSPxG4U1tADIZ0wiyvc31LzZhVk5XHMlk
         DT7MDzbgpvv9cA/hNRvTv22wVmSNLODsygw5+SagUiCg0whshJBO7hOI/dPKh8eiV+iQ
         RN2g==
X-Forwarded-Encrypted: i=1; AFNElJ9FDP1rPpzdS2TZnKu4js/RVKwHPDQpx4zPzOhf1QBaLitqdQ78lvjQLqmnjjfpXaJr7+kyAib8Bc1GDnELKZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8yKxeIsQc6PCRe0UbGIkuE72UH6n95SiKsuqYFhlmJ2fjMXC9
	ABPlRJnE9o6Ah+bfL3ZDs0gadFSLDFw7Z+TTpC1Ffjf+rWGUbdp5LzzsXxbiouNdn4vHnGPGTKS
	kWmBJ0ln7k8dOSaQCAv1+ow+jf8dDm50=
X-Gm-Gg: Acq92OGaIReMEO6B4FI5daFja+KqvYhXgx70o4K66vYZ15AJwxcxgbS6JawDF8SfVOk
	Vf2eVcbFYPxMmjyRSQ313aLuJDAcfcuNPHT6sf1tabVj330gAaIiV8wjHdoHcUXnqxuT4RSbfWr
	OPSjwGGZ4vrSFAxV1z+BF+eUkNoIAOXLmmVpHUGlbgTMLRgbVg26t8RnydTYzr0nhfjMisWdcUu
	E6Xey5ORQPNzc9AO5el7juV5tA4L0VjSK1LDN5C6NlzIX44/tg9J2cNIZysfzQPbFtqa03qFyF1
	S8I=
X-Received: by 2002:a05:6402:3817:b0:679:4b89:d348 with SMTP id
 4fb4d7f45d1cf-67f714ed4a4mr7111570a12.24.1778606052319; Tue, 12 May 2026
 10:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2ed44M=-qsZO7gwcz5L2njdRdk54d47jEg48MhWTkaew@mail.gmail.com>
 <20260512023129.44966-1-lance.yang@linux.dev> <CAG48ez1xdO1wkqS+eAcnAV9QJ25=t1o0-Qz4qTZdg1Mo+en2QA@mail.gmail.com>
In-Reply-To: <CAG48ez1xdO1wkqS+eAcnAV9QJ25=t1o0-Qz4qTZdg1Mo+en2QA@mail.gmail.com>
From: Yang Shi <shy828301@gmail.com>
Date: Tue, 12 May 2026 10:14:01 -0700
X-Gm-Features: AVHnY4JPV4nvI-vVDAMS4jJQpRRQJB_SbZAL6xKOyji_fdKj1jAiWLxEmrrsjQc
Message-ID: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Jann Horn <jannh@google.com>
Cc: Lance Yang <lance.yang@linux.dev>, rppt@kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ardb@kernel.org, sethjenkins@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:48=E2=80=AFAM Jann Horn <jannh@google.com> wrote:
>
> On Tue, May 12, 2026 at 4:31=E2=80=AFAM Lance Yang <lance.yang@linux.dev>=
 wrote:
> > Would it makes sense to apply a similar treatment to huge_zero_folio
> > as well?
> >
> > with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=3Dy, it is allocated at boot and
> > never freed, so it should never be written after initialization either =
:)
>
> Oh, neat, I didn't realize that that feature exists.
>
> I guess there are two aspects of making the huge zero folio RO that
> could be problematic:
>
> 1. If the huge zero folio comes from the page allocator, making it
> read-only might require splitting a huge PUD, which could have
> performance implications.
> 2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
> linear mapping can't be split at runtime at all depending on hardware
> capabilities, meaning the entire linear mapping may need to be mapped
> without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
> early enough to be excepted from that. See can_set_direct_map() and
> force_pte_mapping() in arch/arm64/.

Yes. First of all, this relies rodata mode. If rodata=3Don (used to be
called full), the linear mapping may be mapped by PUD/PMD if the
hardware can support BBML2_NOABORT, otherwise it is mapped at PTE
level all the time. But how huge zero folio is mapped in linear
mapping should not matter, you just need to change the linear mapping
permission to RO anyway.

If the rodata mode is off or noalias (used to be called on), the
linear mapping may be mapped by PUD/PMD, but basically changing linear
mapping permission is not expected by kernel.

Thanks,
Yang

>
> So making the huge zero folio RO in the linear map would probably
> require adding a new config flag, connecting that to
> ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
> memory management.
>
