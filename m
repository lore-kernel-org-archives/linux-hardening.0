Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECDB61FD6;
	Wed,  5 Jun 2024 03:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717557396; cv=none; b=CwyCkLKnibylpZNoxJUgYU83t/4I+z14QqmUTrykh44txiD45EDtjUkWclf3FHS1CL1DyDE+ljgoa1SZmRsT6Vv01GLT+73jbbjcbthj/Yrb0jsYKn4reIlNoZ/A60ZPfVnJq7abKxDqkykItd2v4JiyRlKeEWaMI/go5HpmS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717557396; c=relaxed/simple;
	bh=v7bqHyIO4iVfIbMVo+iH1Ip0qC3Cf0C2y0KTaHyA00s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pCYRjHMEnwUuCHgwGfb1xbY2wpSsImSSfahivPsNEMhpiaA/yEy3gxSasOm1DS64qx3MlQGN4uCE9DnFmuN/fZyYJ67uEnWB5Ibs14ayva2ZY4yptdLYhxy6hn4A1VUFh9U7Lw6KoUIgtti4fSqRxXY1XtEW4kCOFWohtPfQuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmNEdt4k; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmNEdt4k"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-250671a1bc7so2390200fac.3;
        Tue, 04 Jun 2024 20:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717557394; x=1718162194; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JqWWhco0dPRwv8s9y+uizWbrW3o5dwpgbW/xuzuerC0=;
        b=cmNEdt4kEsuUA6mErsmB4tHHI5otb7eDFPhHKzozNByspCo4MTz+5/qJJmvLVwjO1Q
         LLs9o+8aJ1JWdENSH0AM4z5U7WWCdNf/m5EooMsuM61SOvtdHABoPSOgVxHmMh+RuY/3
         E20TTN2Z3BJV5AzPugibiCANerJUxZP/IYrqqY4sDK679mrnzE2amf46u2d97PotV0yp
         q5DkyBEX2CDAj80xR4cxm4g0Ow/N58ovt83JUaz/d+uq6wY/T9MAmd1J0r7xdW9D31LN
         kAo5PETiENk4apA2c+z2wv5zbUjLqIgII7/3SRSFtqUi0J5vOYVSvupTS//N3YVVjhuo
         KPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717557394; x=1718162194;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JqWWhco0dPRwv8s9y+uizWbrW3o5dwpgbW/xuzuerC0=;
        b=RxMbpZjFHC7mwf2zgWxyupVzYcFym3T8a+fAGIldECWWS4SJII0lyfmb6f2Kf3kUZf
         evr52VYtpkBlaBLstZXH1iMgiDO7/MM/xbVEKfoKxMVS/4bxvYhGRC885KlWTlTiNkjN
         s/1bX/YqGboA1rdA+ujiI5gHBSyij6ONzu8ReAeXN7jVgNMKCOYnvbKX7SPQrfYQ4AJJ
         v7AyQnIqcTC2WVVH9JAdWy8ZT7/KIPy1GVeEAMQLaRD01YdZ6XxPFx6bDDrF+UFYn0UM
         vetKaVzXvF+LRKRHUFMG9sMji2y6VxJ5sfOjTw4zMZLQfgdtrEztbUiTku/s7jGVr9Rz
         M8WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcP51Vrp19QzMqi+GvdniCj8/tM80/YCMKsO5BnOJrtLQ8a8b667YsIoEjvqMSLA8LRHmE61yUAkpSoWc9UtVSJrwBEXP2lLvOjr8NqArCcA9wy34J4x93yhnDGuL+yKLzD6Kgc27PAGXCYdN6
X-Gm-Message-State: AOJu0YxIAOJ8+SfoH5iLJfVYlbAwZtDlBvEWRVm0r0AVC9Q7DjqCqL5Q
	I7bvJxaNWFf2XKEYFBIGgxWgcuSViBhHncLbIMHTLv2xOpA6U3wodb5ji3rW3gOW2CECEeyRZrz
	eo+7HyEhvV94JmV1WI2OmQSkM1OMVLlRUC8W+yEqpfM0=
X-Google-Smtp-Source: AGHT+IEHL9qjg96yTYs5We9NBxT8bnCI7iGbvahqXdWMGzraqAlM+xrRYh96re2aL4desQqMc+FeHrpWBEGRYXtaJ78=
X-Received: by 2002:a05:6870:a446:b0:24f:c715:a4d4 with SMTP id
 586e51a60fabf-25121fec152mr1756596fac.40.1717557394043; Tue, 04 Jun 2024
 20:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYSPR04MB708410A11D944F4553DB55A08AEB2@TYSPR04MB7084.apcprd04.prod.outlook.com>
In-Reply-To: <TYSPR04MB708410A11D944F4553DB55A08AEB2@TYSPR04MB7084.apcprd04.prod.outlook.com>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 5 Jun 2024 11:15:59 +0800
Message-ID: <CAAfSe-tDX-2VTJJFpZ8fF+BLbbiOCdHX1+6A9c224KwVaGC_CA@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/sprd: Enable register for timer
 counter from 32 bit to 64 bit
To: Enlin Mu <enlin.mu@outlook.com>
Cc: orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de, 
	enlin.mu@unisoc.com, enlinmu@gmail.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Enlin,

On Wed, 22 May 2024 at 16:15, Enlin Mu <enlin.mu@outlook.com> wrote:
>
> From: Enlin Mu <enlin.mu@unisoc.com>
>
> Using 32 bit for suspend compensation, the max compensation time is 36
> hours(working clock is 32k).In some IOT devices, the suspend time may
> be long, even exceeding 36 hours. Therefore, a 64 bit timer counter
> is needed for counting.
>
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> ---
>  drivers/clocksource/timer-sprd.c | 29 ++++++++++++++++++++---------
>  1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/clocksource/timer-sprd.c b/drivers/clocksource/timer-sprd.c
> index 430cb99d8d79..936691e27f8b 100644
> --- a/drivers/clocksource/timer-sprd.c
> +++ b/drivers/clocksource/timer-sprd.c
> @@ -30,6 +30,7 @@
>  #define TIMER_VALUE_SHDW_HI    0x1c
>
>  #define TIMER_VALUE_LO_MASK    GENMASK(31, 0)
> +#define TIMER_VALUE_HI_MASK    GENMASK(31, 0)
>
>  static void sprd_timer_enable(void __iomem *base, u32 flag)
>  {
> @@ -57,10 +58,11 @@ static void sprd_timer_disable(void __iomem *base)
>         writel_relaxed(val, base + TIMER_CTL);
>  }
>
> -static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles)
> +static void sprd_timer_update_counter(void __iomem *base, unsigned long cycles_lo,
> +                                       unsigned long cycles_hi)

I would suggest using u64 rather than adding a new parameter. In this
way we can avoid some of the changes below.
>  {
> -       writel_relaxed(cycles & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
> -       writel_relaxed(0, base + TIMER_LOAD_HI);
> +       writel_relaxed(cycles_lo & TIMER_VALUE_LO_MASK, base + TIMER_LOAD_LO);
> +       writel_relaxed(cycles_hi, base + TIMER_LOAD_HI);
>  }
>
>  static void sprd_timer_enable_interrupt(void __iomem *base)
> @@ -82,7 +84,8 @@ static int sprd_timer_set_next_event(unsigned long cycles,
>         struct timer_of *to = to_timer_of(ce);
>
>         sprd_timer_disable(timer_of_base(to));
> -       sprd_timer_update_counter(timer_of_base(to), cycles);
> +       sprd_timer_update_counter(timer_of_base(to), cycles,
> +                               (u64)cycles >> 32);

On 32-bit systems, TIMER_LOAD_HI is still 0.

>         sprd_timer_enable(timer_of_base(to), 0);
>
>         return 0;
> @@ -93,7 +96,8 @@ static int sprd_timer_set_periodic(struct clock_event_device *ce)
>         struct timer_of *to = to_timer_of(ce);
>
>         sprd_timer_disable(timer_of_base(to));
> -       sprd_timer_update_counter(timer_of_base(to), timer_of_period(to));
> +       sprd_timer_update_counter(timer_of_base(to), timer_of_period(to),
> +                               (u64)timer_of_period(to) >> 32);

Same here, so do you need to consider 32-bit systems?

>         sprd_timer_enable(timer_of_base(to), TIMER_CTL_PERIOD_MODE);
>
>         return 0;
> @@ -162,14 +166,21 @@ static struct timer_of suspend_to = {
>
>  static u64 sprd_suspend_timer_read(struct clocksource *cs)
>  {
> -       return ~(u64)readl_relaxed(timer_of_base(&suspend_to) +
> -                                  TIMER_VALUE_SHDW_LO) & cs->mask;
> +       u32 hi, lo;
> +
> +       lo = readl_relaxed(timer_of_base(&suspend_to) +
> +                                  TIMER_VALUE_SHDW_LO);
> +       hi = readl_relaxed(timer_of_base(&suspend_to) +
> +                                  TIMER_VALUE_SHDW_HI);
> +
> +       return ~((u64)hi << 32 | lo);
>  }
>
>  static int sprd_suspend_timer_enable(struct clocksource *cs)
>  {
>         sprd_timer_update_counter(timer_of_base(&suspend_to),
> -                                 TIMER_VALUE_LO_MASK);
> +                                 TIMER_VALUE_LO_MASK,
> +                                 TIMER_VALUE_HI_MASK);

Like I suggested above, not add a new parameter, then pass
CLOCKSOURCE_MASK(64) as the cycles, that would avoid wrongly setting
TIMER_LOAD_HI for 32-bit systems based on the current implementations.

Thanks,
Chunyan

>         sprd_timer_enable(timer_of_base(&suspend_to), TIMER_CTL_PERIOD_MODE);
>
>         return 0;
> @@ -186,7 +197,7 @@ static struct clocksource suspend_clocksource = {
>         .read   = sprd_suspend_timer_read,
>         .enable = sprd_suspend_timer_enable,
>         .disable = sprd_suspend_timer_disable,
> -       .mask   = CLOCKSOURCE_MASK(32),
> +       .mask   = CLOCKSOURCE_MASK(64),
>         .flags  = CLOCK_SOURCE_IS_CONTINUOUS | CLOCK_SOURCE_SUSPEND_NONSTOP,
>  };
>
> --
> 2.39.2
>
