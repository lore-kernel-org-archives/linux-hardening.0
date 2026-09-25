Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0524CC267
	for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 15:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349996; cv=none; b=VVKx2Ps4bGy/pT40fexFhE2hfQK8xmzLmBg5RMelyTOJpBWVv11gsbwXbDc9X2G2Unn1tBV5uWMqOwebIVdCb9lHS0TFmkrwr+pMhlvuIuHDJpe6FNCo0Aey+p6kGL7+6UUPUFHcS+Wjjv0KXwFaoaks8nfkxwiECaCAZg1twP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349996; c=relaxed/simple;
	bh=wk49+cAl8PXGjwTyGFaDmBGtdgnuazbb8rirbbNIRgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tPbzfNGm+gIjM962HEthW8c9F3qqmnXl4U1eTAUCp4CCAqX7nLT0KpJsLkG2fr5iZfx3Y/4yC1XsRN58OfWgqyrA2VJQgWHxmya2ULVrYGAI/d9QPYSBZbyZhsXiHOB/d+cQmoVm/crqdTSmlY/D9xruovJdCXJVeeONma5aruc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=BvQNEnfD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="BvQNEnfD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d391aso7575205e9.2
        for <linux-hardening@vger.kernel.org>; Fri, 25 Sep 2026 08:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790349990; x=1790954790; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vaDR7gLTMcuaZYjvT6IfS3NURHPj6dBBuLJSgRQzTEY=;
        b=BvQNEnfD958U/VGOXwd3y7faYpQeCuhQW/3OcpIgXPi2W8Pt4+jzGYd5A0VHOt7Uix
         tpzB8iHuQMfoW1VLJt7IGysa94C2Nh4ux75RhlRYiKmoh0F3aI4AvgBOFDeyVPGxqrPo
         hbvZ9smUbHjA5YM1YmaBkiOtzwD/s1P4AdLPlVQ47IEmYSNOQHsuJk9A46CEoKMTwCmg
         g9Vcw7daIhY9hVhEPw1EDYOm84MS079ANDTlvso3GqozEJ/RI2cevPddy7criCss4wcO
         zxmauucEe3aQ6irTvri0+SzmkCBIvyM43b2JdukeFDvUg/3VNGTZu1BM+0HsU0LUduLC
         Wa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790349990; x=1790954790;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vaDR7gLTMcuaZYjvT6IfS3NURHPj6dBBuLJSgRQzTEY=;
        b=Gi0m+CysLoEB2JfApcGgJNj4RFk6SteIBKd6eL0Huj5kJr6R/q2uTgXMp/4f1QftAi
         cSIci7vWl2H9dn80J65g0jG2dRqd7hFAJ4K/fSNfmPCOOzWD850veKMxfwFn7yboOir9
         EFRJ9pObmp46pNBR5iJnmIsCrKu5eRRroqr/yDIWQAmzu/riVUFQv/SqhSV10mBRDyMn
         E1CGEVP+Uy+XESh9Ri1/fyAllVISA4OFZj2y55mOufn3zA7qvZXhEc2PgF9wVVbBiQ29
         pCHiz3Lc/2u/e5NVyyLpxHJVbs1pnB9maPfdHOJoK6Q/C69V7yy/g/2gNpI2uAjfyK26
         vW+w==
X-Forwarded-Encrypted: i=1; AKwUvByJR7rOf7WJ8WZJ14EkmeL/dv3gUYltmbWUWKzUg1hPM5Yiqg3Ps6ed9Uw2Mw1nLJw8KVzDSayrKTKxxqvk+aA=@vger.kernel.org
X-Gm-Message-State: AFuF++mRFQkcDz+7MDzergnUAGlfhDMtWsyDLjzMSYZYR8TqL6i7bUh5
	vyoQibbLnlWA3k6Fqu6etz7nfShQ/pLqpIc3bqydlhTOI7kiPue+UIulmA+5UkRoP0Q=
X-Gm-Gg: AYBFou2IgDHRGW6tmgmK6Gx48zAjRnr/56K7FTytcaK6Eb0c2m6D8CNPuzrxUOqOgaV
	Qr61aoIh45GmwAXoS7IxejTcD/adygqkW0QNGd9qsK1LYcBtOeWqfZuLAJHPfmdF7qgo4ZCNLc7
	2wDwsllOa8zAsThl/pMnKiPl0hc4C+LxwF7gMXgP4/28BJh5vB5E17GoYzpXqsz97WMrwsdIlvg
	UGY8gi5OfnYmOKAqIFuFW4upA0iyLpV9xWLAGXuFmjHz0fny5oYmSOm3UOlGV4iGSsxan65TNOA
	D8TeJvnhLUHoP7ogtdarythzjwevCi8mE9I/2+ltF10fQ0iRhg2VC0ncyKvRmnlGg/XoqCL8kb4
	ZXL6YmJBBf6MedRXoXR8O7Mr6uPPUfPSRtzTRMWDOrgp21v0OMVLbsIYygtIuccR9gBzw5Wx7w0
	H5KEQG5wKi579ZP4e4+e3l4LhHotDBxeUUboEerxHCZ6Rj+aRkJ6JnhLWLqSDMFx8mnMK1IgiQJ
	kvXnYP8H+z9t6A3zw==
X-Received: by 2002:a05:600c:8b26:b0:499:8ff5:8ecc with SMTP id 5b1f17b1804b1-49fe66d83camr120484355e9.15.1790349990326;
        Fri, 25 Sep 2026 08:26:30 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0f1f2e3sm109952885e9.0.2026.09.25.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:26:29 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Brian Masney <bmasney@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel
 <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Kees
 Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org, Hal Feng
 <hal.feng@starfivetech.com>, Changhuang Liang
 <changhuang.liang@starfivetech.com>
Subject: Re: [PATCH v4 03/22] clk: starfive: Rename file name "jh71x0" to
 "common"
In-Reply-To: <20260920120044.194901-4-changhuang.liang@starfivetech.com>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
 <20260920120044.194901-4-changhuang.liang@starfivetech.com>
Date: Fri, 25 Sep 2026 17:26:28 +0200
Message-ID: <1jqzih73ob.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On dim. 20 sept. 2026 at 05:00, Changhuang Liang <changhuang.liang@starfivetech.com> wrote:

> From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>
> StarFive JHB100 shares a similar clock and reset design with JH7110.
> To facilitate the reuse of the file and its functionalities, files
> containing the "jh71x0" naming convention are renamed to use the
> "common" wording.

Is this really necessary ? Rename are generally not recommended.
Do we really care if your new soc use something named after the older
one ?

You are naming it common now but how long is it going to stay "common" ?
If your next SoC does not use this anymore it won't be common for long ...

>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  drivers/clk/starfive/Kconfig                              | 8 ++++----
>  drivers/clk/starfive/Makefile                             | 2 +-
>  .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
>  .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
>  drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
>  drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
>  drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
>  7 files changed, 12 insertions(+), 12 deletions(-)
>  rename drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c} (99%)
>  rename drivers/clk/starfive/{clk-starfive-jh71x0.h => clk-starfive-common.h} (98%)
>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index bd29358ffeec..ff8eace36e64 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -1,12 +1,12 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -config CLK_STARFIVE_JH71X0
> +config CLK_STARFIVE_COMMON
>  	bool
>  
>  config CLK_STARFIVE_JH7100
>  	bool "StarFive JH7100 clock support"
>  	depends on ARCH_STARFIVE || COMPILE_TEST
> -	select CLK_STARFIVE_JH71X0
> +	select CLK_STARFIVE_COMMON
>  	default ARCH_STARFIVE
>  	help
>  	  Say yes here to support the clock controller on the StarFive JH7100
> @@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100
>  config CLK_STARFIVE_JH7100_AUDIO
>  	tristate "StarFive JH7100 audio clock support"
>  	depends on CLK_STARFIVE_JH7100
> -	select CLK_STARFIVE_JH71X0
> +	select CLK_STARFIVE_COMMON
>  	default m if ARCH_STARFIVE
>  	help
>  	  Say Y or M here to support the audio clocks on the StarFive JH7100
> @@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
>  	bool "StarFive JH7110 system clock support"
>  	depends on ARCH_STARFIVE || COMPILE_TEST
>  	select AUXILIARY_BUS
> -	select CLK_STARFIVE_JH71X0
> +	select CLK_STARFIVE_COMMON
>  	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
>  	select CLK_STARFIVE_JH7110_PLL
>  	default ARCH_STARFIVE
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 199ac0f37a2f..012f7ee83f8e 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
> +obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
>  
>  obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
>  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+= clk-starfive-jh7100-audio.o
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c b/drivers/clk/starfive/clk-starfive-common.c
> similarity index 99%
> rename from drivers/clk/starfive/clk-starfive-jh71x0.c
> rename to drivers/clk/starfive/clk-starfive-common.c
> index 80e9157347eb..4aecb65e9fd7 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
> +++ b/drivers/clk/starfive/clk-starfive-common.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * StarFive JH71X0 Clock Generator Driver
> + * StarFive Clock Generator Driver
>   *
>   * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
>   */
> @@ -10,7 +10,7 @@
>  #include <linux/device.h>
>  #include <linux/io.h>
>  
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>  
>  static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)
>  {
> diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.h b/drivers/clk/starfive/clk-starfive-common.h
> similarity index 98%
> rename from drivers/clk/starfive/clk-starfive-jh71x0.h
> rename to drivers/clk/starfive/clk-starfive-common.h
> index 9d5dec1d5cd1..f634c62c196a 100644
> --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
> +++ b/drivers/clk/starfive/clk-starfive-common.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __CLK_STARFIVE_JH71X0_H
> -#define __CLK_STARFIVE_JH71X0_H
> +#ifndef __CLK_STARFIVE_COMMON_H
> +#define __CLK_STARFIVE_COMMON_H
>  
>  #include <linux/bits.h>
>  #include <linux/clk-provider.h>
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> index de1cf717e391..0e363b971e9d 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
> @@ -14,7 +14,7 @@
>  
>  #include <dt-bindings/clock/starfive-jh7100-audio.h>
>  
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>  
>  /* external clocks */
>  #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END + 0)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c b/drivers/clk/starfive/clk-starfive-jh7100.c
> index 761e46ed0ffd..ca81ccb5af94 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7100.c
> +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
> @@ -14,7 +14,7 @@
>  
>  #include <dt-bindings/clock/starfive-jh7100.h>
>  
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>  
>  /* external clocks */
>  #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
> diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h b/drivers/clk/starfive/clk-starfive-jh7110.h
> index 0659adae4d76..6b1bdf860f00 100644
> --- a/drivers/clk/starfive/clk-starfive-jh7110.h
> +++ b/drivers/clk/starfive/clk-starfive-jh7110.h
> @@ -2,7 +2,7 @@
>  #ifndef __CLK_STARFIVE_JH7110_H
>  #define __CLK_STARFIVE_JH7110_H
>  
> -#include "clk-starfive-jh71x0.h"
> +#include "clk-starfive-common.h"
>  
>  /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */
>  struct jh7110_top_sysclk {
> -- 
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Jerome
