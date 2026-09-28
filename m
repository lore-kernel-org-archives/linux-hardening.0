Received: from mail-ej2-f18.google.com (mail-ej2-f18.google.com [74.125.228.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DB34F5DFA
	for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 20:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.146
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626105; cv=pass; b=mXbgPoYdwOZTeR38RZ/cS4utwosWGNw/3gr+0v4fz8UUsmCfoJuQW6zmzT8psu1Ht0MSewwRf8g8eTtWBqlJ5RGjI+z+r9gulfDXsKQHGqJHfgaA+5UTAcwNQq/eaqYC0O3s8OL/KxTZOKtmP9vbxPZMziKVtlc2fQSu+paU558=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626105; c=relaxed/simple;
	bh=m350LjJY1jMyPBq9Hw+vpamww10TMqgLodWqNEeWjYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMvwhEDk2CxBSqC7AdpshuuHGQM+ZZCuCEkZN1z7IlHL+wcZYgwVCHsohDiwqGsHbfW9ysdu02/L6uWooVIF463lJhyLqwuIn/r0ebMSHk7LAm0rMtSWSnNvE6uNXxwHUzVhrDTWhSDql4LBMiGg2kWQ1Wov1bOZ4HGM56uSTZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAJYSs75; arc=pass smtp.client-ip=74.125.228.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAJYSs75"
Received: by mail-ej2-f18.google.com with SMTP id a640c23a62f3a-c2b40e4744eso323407066b.2
        for <linux-hardening@vger.kernel.org>; Mon, 28 Sep 2026 13:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790626100; cv=none;
        d=google.com; s=arc-20260327;
        b=UE+XJNSXOPsjyRLW0+WhtyqxkDMMjfzfGQOkV3U1LSZMCe+DkxHZ286ZU2U16Qbvwa
         2rvP5CcqQmB1uXPXju9/D1dOAoxVHuNXxvqLG6kSRg1OVGnFSJRm4ufMhEZPZj2VMzEY
         Uyj18d5pOo2CPOriU+K6SgShys3sxnbLyPcEk48efCwqRpIqsiPvGUKcy311TlMtuN/e
         B6dzYT8iZvFuqI7zo3OMxrUJRj8jyNMUCGEe7fDZahsnU+ZfRYdUi/rNuCd1n9lcYD7Y
         36wZUMTmuOnIGBdCiDcB9iUKQvPd3aBKZa1lORo43NpR4U0fxmN1TosA+I+hgb4oc1Ge
         f+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m350LjJY1jMyPBq9Hw+vpamww10TMqgLodWqNEeWjYM=;
        fh=NnKq/qyIM6Mmn96dxq2EhLTQYxVFEei3pvpI39k/udE=;
        b=sRovetNvOQYiHAoI8Hpg+PKpY7Lnh2pSTdeEbKGaunKqOJE3WfwS20bCeB2YGzZoo5
         wX73YL8nezA/9BmnV67N9m/ffQHFH3rKm/+lyVq/vv7BgdAVao0h5j0g4um5OPkCCmZh
         w8hNKtsgiL++CVCvBhEhbR/cVKVWNqTqsdKhYbisJCPeFRyr0KHS0qPsJPLVbmFgWaqW
         ybPIN7mZ3hjzz1C13IygZy02hPGulzFNSF8O+Mow7UYfwJQPNoC8g/u4jCols8vkqI+P
         Jsj0a4rafL0cWQSm5FRioZmFMpXdVNh7DACteyYjmX+4hyQAULFs9jZF47MB40KO9dHg
         7U0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626100; x=1791230900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=m350LjJY1jMyPBq9Hw+vpamww10TMqgLodWqNEeWjYM=;
        b=fAJYSs75iromDJD4CPUyHGgpigqiwDvYfHnt6nLap9gIvaKZhvZEGM6iPtAxsoWiU/
         w82KAJ9yfKDL2/DXhE5aNUlTn3a08g4cO18XSIMiWjn02ZuCTpFeBzcsfwU/RnEWrFkz
         7KRJCvSnDICCAW3+wv50G/ny9sgBRfYOOn5OcDBeLrAQYVZnHLTYrtP4VNQjT5ShJId1
         6uDll6qEG6cSFUVYO7jt2E0czwGy1I9yYUyCNtFdfdhnaaZGTU+9Xm4ySeDW05zEuyFN
         YEuXzl03sieSzVIkR6ePAs6rXuzgloy1AfGoDD1nsPp1KaJHIj4sDX7r0sQKPdcugnwL
         vEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626100; x=1791230900;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m350LjJY1jMyPBq9Hw+vpamww10TMqgLodWqNEeWjYM=;
        b=q2M1IEYhwyIxZGpztP3Nmn+DO6fSyDrORiCUD2t2CbQws14rfBhYUovKntmP11Pkfr
         2BmzcaYMTDC1f+sGOHeV2aypyxDaWY9YMeL6L4lF93a5uU6h3PVbQKQiQWyjxSgBjPVQ
         SsTyf0Ikx/7TJfbFZ2ug7druqzehq5Bmd0ktKZ4jwXXcfh2jD+utmwAe9CnhgI29FZzA
         PGDyJrItd/5ajpmc098pt6ghB08m4oexiM9qLL5Nl0dOuoXpEYXSRXOs71/z4YjY01bC
         xYwnPg0YHQclveeALJfo3zlDeRUvu+L5YZWrsClhvrIIxOVPBEVZIeT+R9n75bMJTJxZ
         hFFg==
X-Forwarded-Encrypted: i=1; AKwUvBz+6GIiA34ihJqayVD80I9n2KMkyZTN0Yt/R5iYw8Vs+V3Z9d23m/Hjj/ma4XI6WA/fz5mQAwPjFY+ajzzz7ng=@vger.kernel.org
X-Gm-Message-State: AFuF++nWtBJbXb9/AGsF/46BaP2/Y388+okeakUmvYRARgvx9CUI3Zfq
	BDh5dyGt7eb8Xfd9jQr2+M4Mi+Zy+D4+rAMqslI8XPOeQCRvvFmu8LUj1x9daye6yy8q+iTW7yd
	VENE2KhBD8PEr2k4ogDcjbE0bgkuN/vI=
X-Gm-Gg: AYBFou1RhrkY6cTHtAJtHmeWt0xotb9sMILG+uqoAJVatjwcB3JuT0HtEuwacfd1lxB
	OGzGZ0GgXzGYLivy35dItIEcnNaL4xw3u3j9NeMZ9uIlourvs7FIv0vaxAjTw0++dFYON1pjkoL
	e6qd6+fpLaJGT5r8EJsmNRAvaipyBaVdJEbAq+GpTttLBFtTjBcJNW6eYGb07LkHOBqBCqQizoD
	QO0Wsg21RKibTPmBlI9rgHhi/Lto3ekPsLpGx/5EPghwioMORMO62fuwgOVve5PgQ4rudmB57Ry
	5btGxSbskU4rm4QhzGigMdpPzSYjhndnceLius1defT0lFWVwCW2mJw5svYMFZ/xReaSVurHYqH
	6y1cwdPsw5mGukGHpOkoQOZMisPV7To2QupQw184=
X-Received: by 2002:a17:906:7947:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c2ac53c3f15mr1023459966b.35.1790626100273; Mon, 28 Sep 2026
 13:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926205708.384308-1-meatuni001@gmail.com> <CAHp75Vdj8qVY-hCoCxxd1Pg2JaaDjc+QgAK-G=w+Cb=FTYYJEQ@mail.gmail.com>
 <a2687bd9-8cf7-1d08-41fc-9d6e69b5ca17@linux.intel.com> <CAHp75VffMOx6q1JKHFz6-_rByiC=1xTqn8Aw47i1KvWPBLCPkw@mail.gmail.com>
In-Reply-To: <CAHp75VffMOx6q1JKHFz6-_rByiC=1xTqn8Aw47i1KvWPBLCPkw@mail.gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 29 Sep 2026 01:08:08 +0500
X-Gm-Features: AclHuK8Oh9UkHwUDmlyUtQldOGulqAb8nqp7O-XzzhJedDF5xraB1nxETnbeFgk
Message-ID: <CADqcGB=zbkRHHxPmMwi3y24NPH=fwBSELwUWE1b-CTLofuusMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] lib/string_helpers: add ESCAPE_BACKSLASH flag to string_escape_mem()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for review.

I've send v2.[1]

Link : https://lore.kernel.org/all/20260928200318.63383-1-meatuni001@gmail.=
com/
[1]

On Mon, Sep 28, 2026 at 6:39=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Sep 28, 2026 at 3:59=E2=80=AFPM Ilpo J=C3=A4rvinen
> <ilpo.jarvinen@linux.intel.com> wrote:
> > On Mon, 28 Sep 2026, Andy Shevchenko wrote:
> > > On Sat, Sep 26, 2026 at 11:57=E2=80=AFPM Muhammad Bilal <meatuni001@g=
mail.com> wrote:
>
> ...
>
> > > > Add ESCAPE_BACKSLASH, which escapes only '\\'. It can be combined w=
ith
> > > > ESCAPE_SPACE, or used on its own, without pulling in ESCAPE_SPECIAL=
's
> > > > quote and control-character handling.
> > >
> > > But why? I believe it can be done in the current implementation using
> > > the last argument @only (id est use the list of the characters you
> > > want to escape).
> >
> > Ah, that's my fault for suggesting this and not noticing there was way =
to
> > negatively filter them.
>
> No problem, not a big issue :-)
>
> I think here is the list of those 4 characters that we want to escape
> should be passed along with ESCAPE_SPACE | ESCAPE_SPECIAL. This will
> get exact code behaviour as of today. In current patch 2/2 AFAICS the
> additional SPACE-class characters might have also been escaped which
> was not in the original implementation (not sure if it's desired
> change or not).
>
> --
> With Best Regards,
> Andy Shevchenko
