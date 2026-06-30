Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218B1A6814
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782863320; cv=pass; b=kje+rHp1ifVzqxXAoVVWqrvqWx3F4z3feRS4Ubp7MSXEvMc/fcXkg1OsBf0HRLt3l8WPNF+g6ejTk5RtpTXDVKjfnLsz8lFzPap5LzJRfmJIAAc/rPRc//awnykpSkTxkuoJdUKxCFhF5Eiq2BMSJp8nvhynn6ULfoCGKlHfMpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782863320; c=relaxed/simple;
	bh=Kt2DBulMpkq3yuN2l3tu6FacmANttLzW0MCd7Z/rlSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGExSiPko1DI3TKPjWRgkw3dLSU7G67FlXWa5T+HPKiAIXdcPacJboaxejjY6F+l41v0bddGvDp2hNhM8q+Zov3SfjRFlEINwx6ymRvq3AERmdj++jO9Kwh4U2J0tuK7qn57sx5L2gNRenubpuaxQ15dK1gX8bCiaNOZUub51a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=RyKFrPfY; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="RyKFrPfY"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-37ff8e0ad0fso37035a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 16:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782863318; cv=none;
        d=google.com; s=arc-20260327;
        b=eUneufC22lNbXEG2FTGPx83UPRy5VQSqCqu2oiQzldeQeCTMSanGYIkdOa/90IxnZo
         SHqyirSvimhW0W4pA8WTsmJjdCR+eSTYjOL2rW0IYZvATsZ5nMD9HsgSHGAZAZlbOibJ
         dwAGWVFc6/c/kMPj38ivO/ig4CUaO6KOH4cLbm+SsnhuOx8ZPO3my7yQY0eDNx0Z9hIE
         Khs05R/e3M3HujCi9ppWuNle3NuAbWhZMH+QkpNEe40wtoiKcE6UXlNeUVS2OOBFrXNw
         Zl4GmXAFXtlX9IDWreotwjCSCIJ9nv4HzObSk2LSkAXElHvOWPiAvUPgJT5SxckpDYAY
         PrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kt2DBulMpkq3yuN2l3tu6FacmANttLzW0MCd7Z/rlSg=;
        fh=o4500P5elAsGwvv97tw5pOnL5QCJo3gh9+T9VBOdvQM=;
        b=kctGOdM1qd0cqJxwthfjfnMP3mqAgaPPXHxIN0pm8/9MhFZW9rnev1lN2RAyMtAF5H
         FpvujEczYOhBmEda6obcjvoyM4NVYrNr9732K38wfkBeSDZJjWBimX7bOC7Q6ASw0G0k
         K+J+4SAIir9wiueBvyxRgjTF2fh4+KMsQi2sHonmYS5S3clnfRWH88OWSb+GCow5DUAQ
         T5gDhGZz+/eQu/1u0vMLHM91AyiKwyeB6iVd79r3tp5zq10UqIoA4fzI8qdttITg1dbD
         Gwdx8sL5cDh3pYcDW5pVvi/5jTvHdvgz5P0b+jNDmBCE26NdWmsSnED8/0toj961CTBA
         w3VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782863318; x=1783468118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kt2DBulMpkq3yuN2l3tu6FacmANttLzW0MCd7Z/rlSg=;
        b=RyKFrPfYN7X2JSl4+Ef7c7Ghv+QFw2fephvKawzmDYoI442zR9OAd4FxSJYW91iMFV
         zHBb+2ICjJjU1DonHtM7OBy1xLCeQryUR0OJdmhb5i5qb5M5hexmEyL3380Cfb2VDvT9
         zL+7ftI46S9mWZRav+ku7DR67M0GHHd1JTWBxQju3oV44OsoADK9Zi4BKVKnuy229GHz
         iRAIX9yyVVAUfw7yBmL+o3GvFc1uZbOXCXQyIHkPGw9kUdJR6LcMZ6igThtvXknuCksE
         KJ6mWXMEGTPxGrx4BuSXQWlzoWDAM+UGVv5nL/kivsbNJnhjn8b1/bXAtxGfdhbuq2rg
         nFlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782863318; x=1783468118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kt2DBulMpkq3yuN2l3tu6FacmANttLzW0MCd7Z/rlSg=;
        b=IXMFeO6MbkrvaUmCFtcxWMcYfZnXzZvMu84yryp+B296iWhR1ydF6wfITP5NYcvSad
         +cz9YFknAxhOmH9Cpd3OanO8NGguS2nmWGnVStCu7lFuIpv/ajR0oJCgG/ArFBWUX65f
         dLQoUcqrgJaWBLm5Z5lk2b2YmjeL4XVqS65HLowDkku5r3b/UJLM3pu9X/Fo719CqhIg
         VYfVJSp2EgmaUNgw/0A6v9jf9CwZ3UuveIzhHc/0mEOAgmr/agDMQd8RmUMNeEK8swv4
         e5vlGYzp96FdRANyj3Y5EL6j1GgT6dFosbzI/mFZpSjaeEk4b8ke4Ua/LAMVjoEqlm6r
         3Pow==
X-Forwarded-Encrypted: i=1; AHgh+RpyK0QTwLkOVBpcdhq6F7YiIBbRHDYLhChf/2byVVhijzPQuCIZMTjXXmHM8kJWKzC1oN1uozGcDDscVPcGA6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YypTkPMmZmfkHPra7O79iDXPkcs25Y9be596HNJb6XelDCiva6p
	5vKv02VXiKk0LFYgZsst6qjHr+A1uQ6zmyU/afFWDTxuawn4TXCbVsOPZiv8O5Ytv8Ki6gd6d0u
	bzA+yj8gNpXXVLoq9w5BFIIcWfrDK+kURNGpNhn3k
X-Gm-Gg: AfdE7ckcRtR66rjdybJaCNGz9qY+gUEgtDjGIMS3A8xsamAuB3XOW2Av4ArXx2UhzJ7
	jo0IetT7lnS4tyYcKKAldsnmgcWM2RTl6CSq3i+PaWPS8zyc4+xjo4j/XWtM/nk+k1MWW90pIDF
	bL5kZt97/FWeEdt6zHYyjJ2+dbZssMU2d6LsJCiEVxywg6NBk/B4ltF+S+J+DFe5RkN2KB91rSx
	mOKGfMZWoGyaQxmdMGehuYgUNE66TK9Q+vZYvXnUT29bR1OAcInTaYHzinUFVfTgz9hEl5y3WxE
	I6VDWEG8jMFfKT1ZyYEwYg1uuT2g
X-Received: by 2002:a17:90b:3909:b0:377:424b:59e3 with SMTP id
 98e67ed59e1d1-3808c0e139dmr2071252a91.24.1782863318168; Tue, 30 Jun 2026
 16:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com>
 <4e96acf4-25e7-4f30-8455-f9b3f49062be@intel.com> <CAPpSM+RhcW=xciX50W3G+2mUVNkmLfL1-BScPN_2TekMbzYVcg@mail.gmail.com>
 <c7c5d2c7-db83-404f-b40f-ee01ae8b9299@intel.com> <CAPpSM+QVOwhmwspjaUg+FqKsHjiEn7C+gYPEcpJ_UZA=JMj7zw@mail.gmail.com>
 <cb547653-0ed0-4fc5-b022-6f0b9691a4c7@intel.com> <86e805c9-ede0-473c-b8a4-8b20439eaa6b@zytor.com>
 <CAPpSM+TM6VL36XAoDMsoCr6u+c0feab8DzXuahjpNfVJQ7g2JA@mail.gmail.com> <9ac1d214-aa8a-42e5-8903-15f8eac5cddd@intel.com>
In-Reply-To: <9ac1d214-aa8a-42e5-8903-15f8eac5cddd@intel.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 16:48:26 -0700
X-Gm-Features: AVVi8Cf_WIqqKI8vqJ-7-zhFrDMx9ui8BwZRhh2LAk5C3DC2KmNyzSVaHSx24Vg
Message-ID: <CAPpSM+Qf-=cG1yw7vpTexh5F6+J+c18m-xGjR7H+GJV6fdx_kg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Dave Hansen <dave.hansen@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 4:40=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 6/30/26 15:47, Xiang Mei wrote:
> > On Tue, Jun 30, 2026 at 3:14=E2=80=AFPM H. Peter Anvin <hpa@zytor.com> =
wrote:
> >> On 2026-06-30 15:05, Dave Hansen wrote:
> >>> On 6/30/26 15:02, Xiang Mei wrote:
> >>>> Please feel free to ask any questions; I am glad to help.
> >>> How do the CET features: kernel IBT and the (theoretical for Linux)
> >>> kernel shadow stacks impact the situation?
> >> CET should prevent this from being the target of a JOP attack.
> >>
> > You are right; CET breaks the assumption that this technique needs a
> > CFH primitive.
>
> I'm not sure what you're saying.
>
> Are you saying that this ENTER-based technique is worthless if IBT is in
> play, so the new stack gap is a worthless mitigation too?

IBT makes it hard to use a CFH primitive(including ENTER gadgets,
which are a subset of CFH gadgets).
Currently, it's worthless to enlarge the guard area for Fine-IBT/kCFI
protected targets.

Xiang
