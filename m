Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4B2E3366
	for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828008; cv=none; b=a+8fI3+bS9PsNWY+GytTus2Ajir8r1E4V6CK/Kpi7541r/6Bg5u2qQsIFDHCm8/jHKjc4OVua10plIxSsmIMMLkWTV/A5nZ5R7gZvL4N95sWEn48MejDyB9Y8tjIWMCLW2YRe5uELkn3rOn1EMXsyG0S2sFn49tg3FS+zknLOUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828008; c=relaxed/simple;
	bh=fSYzfzwBGJuhSvnM/JJDU5Js2NwwoHLN3rPSCQutl50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwYf7UUTs0Zx8JfBZ6jN7WGIQQuNqx7j0/JxLfNRjRcP+jHnYSVxI4tWMEYJtDuHx7OtA96dt24QRzsT58hAsabWt6L6IBqzWcibRu7WprSahX7kRNLhsTY4lP9XRHvnVdjnnpSGvFS2ql+p1YDH7E6CXQ/gc5CDnnygHdyJGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AsMdWie0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AsMdWie0"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3fec32a766eso48149b6e.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Mar 2025 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742828006; x=1743432806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLSbZsyFsudAbghWPIsTb3HkPd3QHoIGTjeEhasFfwU=;
        b=AsMdWie0MQXIBxkHMgrLsFJkTBkAP9I3tk+VS0z0TrXS+xHOlI017ZzxTUvhY3iH0x
         xoyq6r5K9sV5ekoFGG+Y3Lw8IW/z6JfZQzIXbXYy6HLYL9E0T4SKh4HkzlZSy7uIZr83
         BF24NtECcVFMxE0i76Y5x8eweLHMjslD/V4V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742828006; x=1743432806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLSbZsyFsudAbghWPIsTb3HkPd3QHoIGTjeEhasFfwU=;
        b=qnSE+q7MHe3me3+S1610BMi3bkSckGpWnRcf2lJrdAQxPDB7ICE64zE/DnA+aRhK4N
         HwbAIolFtnPZqdlLFDjOpsjszvFraKu3CXzkWZ1ZElUsiV497khKkYpYjCfPYcClh2HK
         4e6vPONo42SnYNGE49to/p7kcPFsbL1hClcgZP7a2KjjVYprWaacSLMi5x79e1zcN+at
         0Z4S0s45l9rn4h1ajmGFn8hm0WIw7M/p8CqQwtSw2sync6nhsTy6x+R8Tvx/nG0+5bfc
         rOkZzpDVC3dnfEaZ/jVjmfYRlYumhzGvghEdHg2P5K3BOZnTfOWXcK6aKBZMhFVCFbsh
         ECfg==
X-Forwarded-Encrypted: i=1; AJvYcCU0FJWHk/R81ZHFJ6B8Ce3nrCywHyNtlgDakHNJV6is5imB4JESMXvSDAFMwxPQWWlqEXbRcmeOfRTNP8LagII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4+QWZkKNMpv3JTURaLmnFV3LM0n3toblPTrrGh5lTqSZY+89Z
	HbW+N99jJHftKRGh5whIaDtSTwnuWNWiL2ujiosz6gwhCk/bEKu0VnwQTs9mmiJslccgTbo5PzD
	CVOylNBtLKuiGCJF2dPZk1VJdBRbDftwsVc4d
X-Gm-Gg: ASbGnct7Gxj53SGL/e3yd1RagHZbzq+dZ3Ha31dXZdxAwbk+EDs/cyKfefv4gSiaeS7
	xD+UqehFljaOiHRL+wvpjiv6C6MjvrtpwtYt8825dB6EB50McjyrhEkxHB+SKliPmTNVSa9ED8T
	lHaIClT3edNYgYD9xJbSypfDe/ydPUDsLrowK4Vdc6BZD/tCZ082mTYRU=
X-Google-Smtp-Source: AGHT+IHBWyPFsx3QeUc6IdoeHIYFTrIvYvef70j14jedqTuNmPWl2CL7e6SqnTvD3LR9P4A95or3uELGCPRHdEcd3Ho=
X-Received: by 2002:a05:6808:320c:b0:3fe:aedb:7a1e with SMTP id
 5614622812f47-3febf79a9c0mr3078021b6e.4.1742828006273; Mon, 24 Mar 2025
 07:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321032627.4147562-1-jeffxu@google.com> <20250321032627.4147562-2-jeffxu@google.com>
 <CAMuHMdWDrByGrgcTK9dRKRJyQ3ecQwadJjCcW=Nd0SjUeEukpg@mail.gmail.com>
In-Reply-To: <CAMuHMdWDrByGrgcTK9dRKRJyQ3ecQwadJjCcW=Nd0SjUeEukpg@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Mar 2025 07:53:14 -0700
X-Gm-Features: AQ5f1Jq3gf--eO0JAHMaBIJnqixFJiGbf1XCTFaxigbe-ZoS9oaIhAP6xq7hHEc
Message-ID: <CABi2SkUGLRb=WZMzDhY-8-hcTN_Rc4gxmGmksD2kQtqVcB8eRw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mseal sysmap: add arch-support txt
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Liam.Howlett@oracle.com, agordeev@linux.ibm.com, akpm@linux-foundation.org, 
	borntraeger@linux.ibm.com, edumazet@google.com, gor@linux.ibm.com, 
	guoweikang.kernel@gmail.com, hca@linux.ibm.com, kees@kernel.org, 
	kevin.brodsky@arm.com, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	m-malladi@ti.com, svens@linux.ibm.com, thomas.weissschuh@linutronix.de, 
	zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert

On Mon, Mar 24, 2025 at 2:03=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Jeff,
>
> On Fri, 21 Mar 2025 at 04:26, <jeffxu@chromium.org> wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Add Documentation/features/core/mseal_sys_mappings/arch-support.txt
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/features/core/mseal_sys_mappings/arch-support.txt
> > @@ -0,0 +1,30 @@
> > +#
> > +# Feature name:          mseal-system-mappings
> > +#         Kconfig:       ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
> > +#         description:   arch supports mseal system mappings
> > +#
> > +    -----------------------
> > +    |         arch |status|
> > +    -----------------------
> > +    |       alpha: | TODO |
> > +    |         arc: | TODO |
>
> N/A (32-bit only)
>
> > +    |         arm: |  N/A |
> > +    |       arm64: |  ok  |
> > +    |        csky: | TODO |
>
> N/A (32-bit only)
>
> > +    |     hexagon: |  N/A |
> > +    |   loongarch: | TODO |
> > +    |        m68k: | TODO |
>
> N/A (32-bit only)
>
> > +    |  microblaze: |  N/A |
> > +    |        mips: | TODO |
> > +    |       nios2: | TODO |
>
> N/A (32-bit only)
>
> > +    |    openrisc: |  N/A |
> > +    |      parisc: | TODO |
> > +    |     powerpc: | TODO |
> > +    |       riscv: | TODO |
> > +    |        s390: |  ok  |
> > +    |          sh: |  N/A |
> > +    |       sparc: | TODO |
> > +    |          um: | TODO |
> > +    |         x86: |  ok  |
> > +    |      xtensa: | TODO |
>
> N/A (32-bit only)
>
> > +    -----------------------
> > --
> > 2.49.0.395.g12beb8f557-goog
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
Thanks for your expertise! I'll send V3 .

-Jeff


> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
