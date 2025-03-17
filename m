Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A91CDFD5
	for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235291; cv=none; b=YvBYsFgO4YMFIkZSxweXhvA53RcOsWo7MTw2wm18XgmLjmoi1TSs2n5Q5PLd+dplWCzoWntUBoQOsNI694g9MImOWPXkDeKBXQkyhhfgVkGA+vdKfeuqEX8i6L6VYn7Vyrkz51n0VVWn7tB8VLNxubBSpRm00P+0vHf9Nab5bg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235291; c=relaxed/simple;
	bh=z0RJ2vq5BFM+TwAdCAzQmXT2Np1rybm8jXQU+12aXh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXnJDmWVVZFv1XjKSAWcu2arWUP6BkhDC3dWk+31k9ISDvlumNSmEsk7LtEc47IMpTFblliS25sgf1R505sPBp756EBusnzVlG+3YRcwAjemx8nqPuNijMqedV+cmft568J9F7Cq9vUPtlyVFI+pwXharfhroONN1FH/0HPqAR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DrKnPnNw; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DrKnPnNw"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6000f9179f8so586026eaf.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Mar 2025 11:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742235287; x=1742840087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6G5kH1/17mAckBVSQ+0GeycayRC8uYE+FPvjcc3V28=;
        b=DrKnPnNw6/5qrQxbLZ7qLlGGMQxtRAEWTTGT773nUELhAxyKiy5aGvqAbezOJdVjhT
         QD80epzImVS47Jc/u72zg60tdNBgTg1k7GzQOknWZJNF/j5kuKEHLC+4Uqoqfe5fJW2W
         0X76TAkyPgirzxBFM8AK33+dk/dEIyIhyQjYw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235287; x=1742840087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d6G5kH1/17mAckBVSQ+0GeycayRC8uYE+FPvjcc3V28=;
        b=Q6gHOZm3qEt6kOq5bP6v7Sa6HkEXLvASn2PX/haDiw0FwLKk2v24mKxPSYVVnEbz03
         KvqvJtNydwEEvIAYAOOiiFZvOHOhi5l7VfYD1QudUEvqolheSFY0oBVHO3X5/YEzSc3G
         L8Sbx2kej0aNls2fBvM2r/uDd+YxegwyYme6GlmXONM1k3JmgJijTd+xKOzSlU2m+nx/
         1b4Mx2rl8/FbSYWUfuvPB806ILiqJI7b9i/SlHTWbkmaZHF9UzsQ782UofzxiQQ2PxLO
         stHvRrEA78h6FFWj1UjyB1LsqV1eq3TVuSa7k0p//BCl4DFRKSjblI/2fYv9avpJMyA1
         sdEA==
X-Forwarded-Encrypted: i=1; AJvYcCUxanSOAPNqP7WnpvjndXhQ8eZavZyRF+Ygml74GbKGshbP+NVugoYMo5KkjFVyiWE1HR3YHBH33wFXiKCUu6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyowc2jAw6Qttmp60vcizvFxHv0tnekg6Wv1SMt3jOx+vBT8eFm
	R+YP1lPK/R23I8iuCLZDEgScMrxJtEzDFuwL43+AEQ1fssG7u5eRNBwv/q6JzyYAddiTvtgXPJO
	RU7IX2y34OSS+6rKDCS+BdiETgqeNv/HH9Ife
X-Gm-Gg: ASbGncttm3WlfzyYyf79eKp7dup2TYTEeoIMH2krTlazKddfegvUlYxyVnE4/RNqzoU
	UF6b9HbJ4xBhXXXrjA78E4egMzG1ix9UFDSI1qf4ZeqOvRau5ofrV/XFRuzyLxA/YQQ5abqVMpn
	JcaA7G1NAmGfwpAD1/ucOvcMW0R0UJXV0N7NcN4Y7TeAigbOWBsvaCPIN73BReFtMBTw==
X-Google-Smtp-Source: AGHT+IEIdIYyMphC9KIRv92mrEbk+JX8VcCMwxxmGXlhbHWC4pSDXwXa/exE7SgnK3ZFiIrx1hS6WPeWtb5d+k0lU44=
X-Received: by 2002:a05:6871:723:b0:296:c3e9:507c with SMTP id
 586e51a60fabf-2c691117825mr2878352fac.10.1742235287446; Mon, 17 Mar 2025
 11:14:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313000623.3192896-1-jeffxu@google.com> <1bbce89c-1efe-40cf-9085-ec4ec16f7996@lucifer.local>
 <CABi2SkVKxyX0uDabg+wHiq_vTBFbUST-nRdur7cCPB2myhCWhg@mail.gmail.com> <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWLjX-OavON-rj50kZyvV5+Pf0x34WJbcdKsCgAQA7TwQ@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 17 Mar 2025 11:14:36 -0700
X-Gm-Features: AQ5f1Jr_ytqLHdovq4sBSX1pY1QSS_G7YR5AiuDQM9up-FcK9NgtAti-NP6kOSg
Message-ID: <CABi2SkWU6orm-wBFKVt9rsSpYURHPb7fjHRzkOiPGd=Lh-DdkA@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	gor@linux.ibm.com, hca@linux.ibm.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, svens@linux.ibm.com, thomas.weissschuh@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:41=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Thu, 13 Mar 2025 at 23:26, Jeff Xu <jeffxu@chromium.org> wrote:
> > On Wed, Mar 12, 2025 at 10:21=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > On Thu, Mar 13, 2025 at 12:06:23AM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > > Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > > >
> > > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Thanks for your patch!
>
> > > > --- /dev/null
> > > > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.t=
xt
> > > > @@ -0,0 +1,30 @@
> > > > +#
> > > > +# Feature name:          mseal-system-mappings
> > > > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > > > +#         description:   arch supports mseal system mappings
> > > > +#
> > > > +    -----------------------
> > > > +    |         arch |status|
> > > > +    -----------------------
> > > > +    |       alpha: | TODO |
> > > > +    |         arc: | TODO |
> > > > +    |         arm: |  N/A |
> > > > +    |       arm64: |  ok  |
> > > > +    |        csky: | TODO |
> > > > +    |     hexagon: | TODO |
> > > > +    |   loongarch: | TODO |
> > > > +    |        m68k: | TODO |
> > > > +    |  microblaze: | TODO |
> > > > +    |        mips: | TODO |
> > > > +    |       nios2: | TODO |
> > > > +    |    openrisc: | TODO |
> > > > +    |      parisc: | TODO |
> > > > +    |     powerpc: | TODO |
> > > > +    |       riscv: | TODO |
> > > > +    |        s390: |  ok  |
> > > > +    |          sh: | TODO |
> > > > +    |       sparc: | TODO |
> > > > +    |          um: | TODO |
> > > > +    |         x86: |  ok  |
> > > > +    |      xtensa: | TODO |
> > > > +    -----------------------
>
> > > Plus I feel this need expansion a bit 'N/A' is because of being non-6=
4 bit
> > > right?
> > >
> > Below is the definition of N/A in Documentation/features/arch-support.t=
xt
> >    | N/A|  # feature doesn't apply to the architecture
> >
> > It fits the arm case because mseal is not supported in 32 bit.
>
> IIUIC, you can already s@TODO@N/A@ for all other 32-bit architectures,
> so we don't accidentally spend time on looking into adding the support?
>
Sure, my architecture knowledge is limited.

I just checked this, it seems to me that csky, m68k, nios2, sh, xtensa
doesn't have 64 bits support, the rest have 64 bits. Is this correct ?

Thanks
-Jeff



> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
