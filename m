Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B62FE057
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782855679; cv=pass; b=bM/rVzkfvFKujtQqgFOozZyHezn8dgwlb2QSzKvT4JNgfNMG/e/3/EsbCREA1stKy4uj6kYnDz27FQtU1cv6LqGKxZ4ktPwCKlcmQjjrGU1u0uH4+rgggWmcMtti4W7mQnsVEm1SUsOGiY5vKrPzi0vVUBh7v6grgc5hYRRRMpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782855679; c=relaxed/simple;
	bh=Uzn++0kdxMg5vQxNCiRzdSWC67pSa/NGAlugPVo7XiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1Xa1UdkO6yl0s8uk4Jx9Yqhuf7wqePzs3wr2mKZcjtpymdCa5XK/95neriwkzT2jMq/ZXSikft5tDWDX9ts1NMhrNKwKDXUmR+hIjasj18CcYKgjZs8YDs3AOERZ2yB4XW+lUUWkii2BkfbSHs7QAgThRTTbzpebQbXXaeS7dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hWyBHjOJ; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hWyBHjOJ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36b9d265355so11541a91.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jun 2026 14:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782855677; cv=none;
        d=google.com; s=arc-20260327;
        b=INdJZLBwzhKM0rBXTJxyoZldDedAy7UbcTkxlj+XUDFUkw+Q1iQV0gu8/Nu4THLuv1
         ayCicEARIwltn/q7x21cMRz/vzlGKOib8ivnqXl4PAedvNYyAvqmEH5ZVEtgSN5M/9we
         6XsFitQfjFXTU0TN8tGPg/0YUKhdVhIEYpNaTsZW+WKtCl3LVThKVYzzQlBf5tFHAhNy
         P3/fyBFZSmO3imNB+5MB9IWrw338omcbvlAQFnea24T0d2F0w8ELN/1OVs4oEIWsVoe7
         CHfTPOU/1aIBzC94xsAFgbOj0464IVt6eHlscMO09Ji3FFaYRpEDOI6RRPlc1OerV4Eq
         oDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G1qIjvFuUzRw2lOnNAlRyfIkKS+2a6T+brJ0gOzzX3g=;
        fh=xJWNpIjKyDpMuSRrwg73Yq1H4Rg2Y7cZ1cqtfbhln00=;
        b=sq03MnaBU3BkdY8Lqai5sjBd0+2iRDRyhlnhCGLo7jaLwwIHs4VQzwTuacsQybPl4B
         jP28n3k7de8tsSYuLX5qs6z2UPj441XfTB7aQveV7b7khOtFsXYmjRXv3dXjBR9YweC5
         J8d7xYXLf3vEkHcHS88U9kcdhT9qmzCP+WusT/LBJAGF8F8ICOSNA1VbzQYcKYhyJUms
         3CHz41sQEHMHrVP8S+Bf8ZpFObX3C0N2+jTAWe9zTD3PTAy9EWkPFjB+dg2JW2Kn3DFz
         /dGDqLpNUxsmG9KT02TMbm5r8CPnGhuSY0R7TJiH3xSXs1zMJwwrh3d4+UaTIorQJaTa
         8kYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782855677; x=1783460477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G1qIjvFuUzRw2lOnNAlRyfIkKS+2a6T+brJ0gOzzX3g=;
        b=hWyBHjOJ3DZ+9rJ1XT1jPgqrPiasm/sS853CzvJoIFZ6uwWv8XZUdUsbBKIroFedxl
         V7BRnP5HAn+cZY7/TdDT0uBNV8abbW2A8YTmgvzQu+gexSLrk8wcsdxCdA2daiH78jOC
         6ooGdYFHBPa5YCFkk5FU/trHBzpJH+/P0hBtowt4H1LpWWNgAYYxN9IyLoF0OTjgJ4b4
         TdGiEFRvZpZVlvoL3OFQMyntaBerf6/qJVPwFWwqr277CiUZcEKNrk8vPETKVoISqt3w
         6NXMl2GjHfXAJ5wdDvPTe2QSI87HMKtbMpQ8AGDblScoX7H67cqDuTXpoLNuwmOjzo0u
         YeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782855677; x=1783460477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G1qIjvFuUzRw2lOnNAlRyfIkKS+2a6T+brJ0gOzzX3g=;
        b=JaStr0gJykjfUGBRt7ARDp/dbQJAfgAaiWivxD7mIZgqBxXW83MXmGqvx1AYNV0xYT
         IHmq9uJGIsVPIw/I4120+zLP3KKLI3gDBOPpGP4KCQIo5/5FL6IUNMNVxW0swdePcQoC
         oK78LPG3ncBuv4y3DJgkguTWPJJAXJqjcTdMVLIc7ozPtw8fhAscbtJZhEb5WGuFVVqR
         T4YWVZz3HjMDTi+g30svADrpqxNtDBSxmwBNwqrzX8yx7OFdb5WYRSHvrJdG0fxlxMfn
         Eceo4oQokd3fnT68aMmYrDGO3zuzg49btwmPDj8gEGEdhRjPaXMt8IEiB7doELXLHWy8
         eEEw==
X-Forwarded-Encrypted: i=1; AHgh+RrVKefVi8IAGjrHRrxS6Dv7yVPtFo1PaB9xOvJuty982YL8cSjdDn4jFTJ7aAr8K/UPJsj5Nwv6w5ozVrDjVuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzvRxyx32SByKhZAHzGdsro52btL3FkY1CVgjzUcpZc9e0dC/v
	CpM5QOs7NCsQSSDe2GZrS5za3c70YX8j465H4jexnam+Djf3B/RRkbVwQjTCMq33NsBsikUxt7u
	yjyaWMljydssJ8VBqErlQzdfx17Y5AgxZp2rPxNKA
X-Gm-Gg: AfdE7ckafligpObBM8vcAL9zm96Ty1dG5DFzTgAQ/xEG6o4Db2ZKaPq2vWYhuJ710vS
	heqegpSR+bYUChXpJp6lUM0slM6kskabYiTEI6XDJsuCBVo2Pc9+9ojECm6qdyaGoXJM2RfkmAY
	fyoqGhsRH4lrCN8oX6QsCSa6ElqZzCit4xUDQ4fy8R0sWMxT8cro0Z8Sm+i244vt5Nr1Y2OmB1c
	URANkf1F/Y53HVYb9kclmMh8IDf7ZclUovCd7T2CzmNcTzMPOP3D3tk5EI/Fbj8pPlA/gzq9Jq6
	boU8LTICtf6s6zN6+AthJamckdx/
X-Received: by 2002:a17:90b:3503:b0:380:97d8:902f with SMTP id
 98e67ed59e1d1-38097d8be89mr743202a91.9.1782855677625; Tue, 30 Jun 2026
 14:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com>
 <CAPpSM+QTiwgPk3KNmWbjSk_SS8LLL5XDfikWC1A98vetom3yeg@mail.gmail.com> <akPT82jDvPwlaNuo@pedro-suse.lan>
In-Reply-To: <akPT82jDvPwlaNuo@pedro-suse.lan>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 30 Jun 2026 14:41:06 -0700
X-Gm-Features: AVVi8CfJxFJJeFwklcHtZSwf2CBofagh0lCv7AsQMF7Dwy0qHcKAX115Py8RIJE
Message-ID: <CAPpSM+Sz4TOfvh9os_SDvaETS-CDSq9evY9vcDupXwrP1pM9pA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: Pedro Falcato <pfalcato@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, 
	Ruoyu Wang <fishw@asu.edu>, Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, 
	Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 7:40=E2=80=AFAM Pedro Falcato <pfalcato@suse.de> wr=
ote:
>
> Just as a quick FYI, it's good LKML ettiquette to keep people who engaged=
 with
> the previous threads on CC for new versions :)
>
Thanks so much for the tip. I'll remember that.
> On Mon, Jun 29, 2026 at 04:28:19PM -0700, Xiang Mei wrote:
> > On Mon, Jun 29, 2026 at 3:29=E2=80=AFPM Dave Hansen <dave.hansen@intel.=
com> wrote:
> > >
> > > On 6/29/26 14:47, Xiang Mei wrote:
> > > > With CONFIG_VMAP_STACK, kernel stacks are allocated in the vmalloc =
area,
> > > > which an unprivileged user can surround with attacker-controlled da=
ta by
> > > > spraying vmap allocations adjacent to a target stack (for example v=
ia
> > > > XDP_UMEM_REG, though other vmalloc spray paths work too). Today eac=
h
> > > > guarded vmalloc allocation is followed by a single unmapped guard p=
age.
> ...snip...
> > > To even be considered, this series needs to be refactored properly.
> > > Making this VMAP_GUARD_PAGES a separate patch is the bare minimum.
> > >
> > Good suggestion, I will do it in v3:
> >
> >     1/3 - introduce VMAP_GUARD_PAGES
> >     2/3 - mark percpu vmap areas VM_NO_GUARD
>
> I would suggest you create a VMAP_STACK flag and condition these guard re=
gions
> bsaed on that. Otherwise it's a bit arbitrary as to what callers get 0x11=
 guard
> pages, and which don't.

Good point. That would make the structure cleaner.
>
> (you can find the concrete stack allocation functions in kernel/fork.c)
>
> --
> Pedro
