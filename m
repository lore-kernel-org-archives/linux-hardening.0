Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CA3C9897
	for <linux-hardening@vger.kernel.org>; Wed, 13 May 2026 23:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778713844; cv=pass; b=id2HWvs2lsWsa0OMTrMqlowtyTFRT947FxLZDdB1kde8RzCdeTX6JV7JSmqgmBvhSslyP+J+1lErNnoUeeyb2Vv809DwjXxo8aX0gzD4qnsDYy6s9eHMHTJxKrH8Y5ZTapzR0ezY/yUfoCuJVoFnz1cPuU40wcVldn5mZnZmLVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778713844; c=relaxed/simple;
	bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+32k3MnBQTrnmYHgmkNFwj2PPsIxX9uoegiPIvOEDF41NXQ38CQAcBqSAWNEzM2mo1eriIjgmYJmhJGyjlNgrzHGYG85mHS1FlyezZJlPgnjeAV/C1qaLlNVBDW5VJJnV+aVSqO9stNYOWr6aW2PgPCG3XHjJKe/FzdD/mWKIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sG+6nyqe; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG+6nyqe"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bb91b426e40so1219696166b.0
        for <linux-hardening@vger.kernel.org>; Wed, 13 May 2026 16:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778713842; cv=none;
        d=google.com; s=arc-20240605;
        b=Fm6kLCe6QAHrvHas53W8upczovQExw+KXOHSq9UxI2Oe8/vgpeL0FKtoVaqubkwcC6
         JZpKLHLtB6XUQ7QyhQY7ZGL7eSLZF/OSjOD17Iu+Oxno2tU7VaSW4cJ24Hfddr7ppWm6
         l/oVCdUXqCSk1gLqo2CLA25aCtYyoze7w6lAvx/INIVdQPGbUYSZaUIYQooM0jcyU6GO
         dZDmauvshQJ4R1vyVerOcGczmxNkmNyAK9UowSyG9d8FDeYD18aWBLM/p0eY1+lPT/eR
         asnTYu16NKQvfkTiaw2zaTSR+wjOzWi3Q3ccZjs1rKVV3sp4fLe/I3y8GS/OsGwg3pdS
         WQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
        fh=YNeCwpLAJR3gejCkuMrMi/sjiQCGnBrLjklyzDhy9Z4=;
        b=PvvJ7vCvoICRTqveGszxrND8JWsc9u2hzKGpzyjOrmyYNeeiF0Ld9vZCZNvyPBZdaZ
         hRYUtJvhlJwKfBzn7zxIIVEIaTiog9KIwyk+Xg6IDdKCQINP5YWAj3Dqc7QC1pdR0woQ
         e8RppfUMli994IpbLC8PIPrMsd4LjbZGkjYGiFt03Kb4pkYLMkRYx7ReU0izd/vGipVW
         Mu+vrrvBdef+rizRsz4HWMIeWvgho/e5iu3ou6rPPGbd307ZTr80JzLzxcCLd13ZLN49
         Q7YxpZ0ooE4NN5PL2Dsa/l/0TEJAwjkEOnvz2BNqxNif5zuwRHXoLfDT4kYUjnpEe56P
         7oqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778713842; x=1779318642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
        b=sG+6nyqe9AqcKNszmQEXuS7Ow52nGH6vn2Bxbt4uW4NZEjJVI37JEGvIhYEaT4Oag4
         1Ifm3YoYC4t7YpMJ3ILK1mTiJz7AzI7PpcHsBlKYloex8FA3FAskCrREZr57TTdO+tOu
         r4osiL3jmzvq9tsw6sM/k0JsKFBNL8zkbguGVqkoL0KK9M4qjf1V22Y1aS74DfEd+2Ky
         qxfuP8x0UFwTtvXV61ND4mySlW5k2l8HKS7pYGy+Sg9IKr1K1e6+5t7GLWs0eBSqbOxZ
         UCUxoZPcj8EIlsUZNaECcwdS7H89coDkbon5vJpPrmzYdZ/BMAA67scdqfy7RwFKw5Di
         X2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778713842; x=1779318642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWmj7O1/4wld3D387Jz2Aj3uxUINmZx2w1RQME/BuHI=;
        b=swbuVryAxFwq7GtIAotRUasl26LB3shEUYIH1EFslcsIiBQIK2J4NHLTfWwNNUe2mU
         JeSfih4aTBLM2fpkUBuGwB0v3iTyEo75LQmF2jShekSmxHzQIqdy9qzb2cxHecF8Y2JG
         tm8l4LO6JTwJTKSIRt8qXOmBl+oY5UnOdZXA1be1Ku0J0mz2LJkB4QEiT66GUyvBlsxC
         Iw7+5KYT/AoDKm4xd5gSrWUTEcScfS1nXkygGjwFrm2gBKdJgpIkQf69vsromnIoFTLQ
         CyNBo1ZJ6s07sP8omuZX0+DoT9aU8cOvNDjpcLGSmB245EAW4Sbem2m6875qeIztUQ/j
         /Fvw==
X-Forwarded-Encrypted: i=1; AFNElJ83kF0iiKdeKJhs5SpN7Gq5TLvB5Il/zJl1M+C9hRoEyUejZgXRgV6IAF04Sr56Qe9SnijRs3pAG4iUPnxC4YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWu6i3H2xO3rK7yY22zqCLsfDyzXFCVzjrV4+v8FZIZfTh8YCF
	Z+aQqTXNKmn8ePmCjCD1be5qf2rwEUN9mYuhxgMO2oWgPOmXOO41S7D6vNlFIQIHERAc3bWk6+M
	v0mBpinJqwSlIYKbqYRmKtc2CiDpXyvk=
X-Gm-Gg: Acq92OHj7He8oKv6RY4Nwdbc4cYKL9v2TzGmENG+7CUPLPF8jjbbT60hjzOi5owfTaF
	dbrdvgAj5woH9wLnJjsVazJ3BlzOYCkHoZoAHqGW6hZNJqIMtJ+PPX2Y8JhVfnUtGrcbljEtS6Q
	C4X6WrcNV57AyxIdl4nyBpG80Miq20acU0DkchcxdStzva2oq/wLLSw0yxPllZbtn6SScbE7Ocy
	AJRbUXm0OBEl3SwFkobo4WggD8wvc7WOvO1KOI4Ul/bOFZzyRGYJTAFZROQ12jVrPBi9yqo51C1
	/CtFTGmtyiBS0N6s9D6zUeDgQo5VB5Y=
X-Received: by 2002:a17:907:9704:b0:bce:267f:19cf with SMTP id
 a640c23a62f3a-bd3dfd64271mr315423266b.12.1778713841538; Wed, 13 May 2026
 16:10:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHbLzkrXXe7r3n3jXgDKtwZhRqj=jDx9E6dLOULohnhBguvi9A@mail.gmail.com>
 <20260513021148.17588-1-lance.yang@linux.dev>
In-Reply-To: <20260513021148.17588-1-lance.yang@linux.dev>
From: Yang Shi <shy828301@gmail.com>
Date: Wed, 13 May 2026 16:10:30 -0700
X-Gm-Features: AVHnY4IN0dYyc8FrioEWxy6x33mBpShrHTtaMmtJuX5Tb81bKkEuJTZaPlb8x7g
Message-ID: <CAHbLzkpBB2ia4pUG1khZy1w5G_sq6DD+9OnqjrJ6Yu0KxPAe=A@mail.gmail.com>
Subject: Re: [PATCH] mm: make zeropage read-only
To: Lance Yang <lance.yang@linux.dev>
Cc: jannh@google.com, rppt@kernel.org, akpm@linux-foundation.org, 
	arnd@arndb.de, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ardb@kernel.org, sethjenkins@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 7:12=E2=80=AFPM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
> On Tue, May 12, 2026 at 10:14:01AM -0700, Yang Shi wrote:
> >On Tue, May 12, 2026 at 6:48=E2=80=AFAM Jann Horn <jannh@google.com> wro=
te:
> >>
> >> On Tue, May 12, 2026 at 4:31=E2=80=AFAM Lance Yang <lance.yang@linux.d=
ev> wrote:
> >> > Would it makes sense to apply a similar treatment to huge_zero_folio
> >> > as well?
> >> >
> >> > with CONFIG_PERSISTENT_HUGE_ZERO_FOLIO=3Dy, it is allocated at boot =
and
> >> > never freed, so it should never be written after initialization eith=
er :)
> >>
> >> Oh, neat, I didn't realize that that feature exists.
> >>
> >> I guess there are two aspects of making the huge zero folio RO that
> >> could be problematic:
> >>
> >> 1. If the huge zero folio comes from the page allocator, making it
> >> read-only might require splitting a huge PUD, which could have
> >> performance implications.
> >> 2. I vaguely remember arm64 has rules about how PUD/PMD entries in the
> >> linear mapping can't be split at runtime at all depending on hardware
> >> capabilities, meaning the entire linear mapping may need to be mapped
> >> without any huge PUD/PMD entries - IDK if thp_shrinker_init() runs
> >> early enough to be excepted from that. See can_set_direct_map() and
> >> force_pte_mapping() in arch/arm64/.
> >
> >Yes. First of all, this relies rodata mode. If rodata=3Don (used to be
> >called full), the linear mapping may be mapped by PUD/PMD if the
> >hardware can support BBML2_NOABORT, otherwise it is mapped at PTE
> >level all the time. But how huge zero folio is mapped in linear
> >mapping should not matter, you just need to change the linear mapping
> >permission to RO anyway.
> >
> >If the rodata mode is off or noalias (used to be called on), the
> >linear mapping may be mapped by PUD/PMD, but basically changing linear
> >mapping permission is not expected by kernel.
>
> Ah, right. So for huge_zero_folio the hard part is not just making the
> backing memory read-only, but also whether we can change the linear
> mapping permission for that range. That depends on the arm64 rodata mode
> / direct-map setup.

An alternative is you can allocate huge zero folio in the early stage
of boot before linear mapping is set up. Then when setting up linear
mapping, you can just make that PMD RO. It should work regardless of
rodata mode.

Thanks,
Yang

>
> Thanks Jann and Yang for the explanations!
> Lance
>
> >Thanks,
> >Yang
> >
> >>
> >> So making the huge zero folio RO in the linear map would probably
> >> require adding a new config flag, connecting that to
> >> ARCH_HAS_SET_DIRECT_MAP, and changing one or two places in arm64
> >> memory management.
> >>
> >
