Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C18D45D906
	for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 08:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755639; cv=none; b=bGMlOKEtEgwe/XTZBBGKYQLV8AdK8rPAGP06r6je6QkFlrwGdbHIWGwGzhXLBJhM5LMJzADPWUxU9uS1d0vStdWvLKpbyvmpqKVdFaxhjP0AfOr2gP3lclvVMg/8jGrb8WMn/M3V8nYnRTeC5a7ic9ts1ro+fofHhpoEGOyznTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755639; c=relaxed/simple;
	bh=sgRHL4cRyFoz0iUc5GBtv9Nss+laGnmGI8TZWvOA21U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SQLfthGKj7D7rlIoYa+jePyoEFwDxs686iWUjnnzGrTod0D5nuHiXoDjrASZtw6lbSLkxSB7ZvJeMSr9QNG5TRJMjn7C563c8DR0m9at+I4Z6ZoD03eLAid7b74iDsRrCKQ2h7fPHOqIb8VF5Biu7XJmtYXzGxdxTC+aWv9x+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=XiJ3FfuE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="XiJ3FfuE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e8185e037so28628955e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Sep 2026 01:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790755634; x=1791360434; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9Z12L+fXWCFDTbxFKxbwYJjVd8WMY/ksKqgATnsUOk=;
        b=XiJ3FfuESS3alwck6UVTxa6SPofS0r91m/yp59B0e0ym/eH+0RR1uQm9FwO9atKelf
         nqJKfOWY7Rqrru1/bF4o/s1EpXLD4YsD8b24wKMqqsIDTqOXoa2noR2grEe6N7IUX1Dn
         vekPuCOe3rV2UhgzO/nD0wweg3h1XxzO+/0Bbx57e0moKqSXIfVVWY7FQ8xU3e3r+aZa
         W327uMr3Qzlt+7oAqAxqKYdZimJQrnZ5xYKt6aR3tssY7aqze10hFs1MBJYRCGAkmZTp
         Xf1VdVOQcrQ7WWrrsa7qmFLlURDG6rghTItgf5rb8cF/cUS15lFHX/5Iirpkc3fqwjr8
         /JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790755634; x=1791360434;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R9Z12L+fXWCFDTbxFKxbwYJjVd8WMY/ksKqgATnsUOk=;
        b=DP2FEP3qEUqgQU7d5ksedJOpgFkycI/XiLyZ4NOUDTO0Y6SVcDA9/8DvwNH2WqOHCq
         rG/5rqUKHwaVbX++XBHxRovZSHw9eZp8F8Xpty4SOJpO0hY0cxd4aFaBJwAGAmEaAkxN
         HyzWwdS5D0icf+6RVwQW6/zP/dBlVNggrnee1GoOYrnahfpGWn1RO8TprEAOOGgllGjq
         CgLvqLhf0RiYwo7u3L+8edTyebu1L6m4eC93+D+F9FqxgIwZCinop5IoMlyJq5HI1V7X
         WqTgVg+ephIur3WV6GaLQHSCfu4wooKrP/NHRDZ5cjinm3o7c8S8TE7J7ZGcbw2o6DtT
         qBhg==
X-Forwarded-Encrypted: i=1; AKwUvByHx3RLneIkPgBp4rwCdoR4UQ+JR+iQ1cXyo5ZB9XHbA+/+OnRojPbgxVb7Wy+QR+SwNyWwLGoKO+HuEz6zIao=@vger.kernel.org
X-Gm-Message-State: AFuF++kZeN1TT1F9pazmSzRof08+Df5L8RBWmSUoavr20Cj0k14lnRMI
	CDAe1FV8cOyEfv8BB4aOaBmQmmwvGn3sRVZAKxURnif2KR6edd54bnIGC/bRmK41D/M=
X-Gm-Gg: AYBFou3KkPvcNfbsQ1G/jFVYwyavxvswyrTGHCOTIKTNZpX2cgJOB2phMRBGKV0QwRN
	FrGV4nyWKqfylsoJwPEXoUKsJUR8giXJzIBa0em6C97h+QnBW+rcg3aHUjTmr4qy4yh9+1whscz
	n4IJKq35A8cjYKeuWK5kOaNC83mAtL8bDpdhN/yfNNCbWFaeUDbMIFqOvZTWHCB9Wvh77Dao13u
	MeJxsKNsYCpxPCXrfJ/KpmuVgxFOvgy4EYxKtSd+Pns6a5G5pU+t3r6uelcdXuPxSCXKZYRYR3Q
	8xYpn97YNUNOAiiz3O184b8XoaDBgczQB1BmDemHLa/5s6dqv3c/XLpN6dw1xVbIFGfH8HfYuMp
	1l3pIqrZpdW9p1lEK1vLpRATz+/KImhaaI9Tad4ppQt16+Uk8bdBdG8MuqR+rglNUs78QmELpgv
	HlmExZofshAmlwxyabQnM18hCCNWbfCJKhoWs7+RRy3zU3GcdG2iSHo6YoFr7gsT1U9txQCY4Jw
	2rbDo/PaQSK0bOyI50QK5MYv0cf
X-Received: by 2002:a05:600c:3486:b0:49e:7c7e:274c with SMTP id 5b1f17b1804b1-4a01afec552mr8494615e9.14.1790755634409;
        Wed, 30 Sep 2026 01:07:14 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01751613dsm33464255e9.3.2026.09.30.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 01:07:13 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Michael Turquette
 <mturquette@baylibre.com>, Brian Masney <bmasney@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Philipp Zabel
 <p.zabel@pengutronix.de>, Emil Renner Berthing <kernel@esmil.dk>, Kees
 Cook <kees@kernel.org>, "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 Richard
 Cochran <richardcochran@gmail.com>
Cc: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Hal Feng
 <hal.feng@starfivetech.com>
Subject: Re: [PATCH v4 03/22] clk: starfive: Rename file name "jh71x0" to
 "common"
In-Reply-To: <ZQ4PR01MB12022FD5940DAA1AC1279B8FF28D2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
References: <20260920120044.194901-1-changhuang.liang@starfivetech.com>
 <20260920120044.194901-4-changhuang.liang@starfivetech.com>
 <1jqzih73ob.fsf@starbuckisacylon.baylibre.com>
 <ZQ4PR01MB12022FD5940DAA1AC1279B8FF28D2@ZQ4PR01MB1202.CHNPR01.prod.partner.outlook.cn>
Date: Wed, 30 Sep 2026 10:07:11 +0200
Message-ID: <1jtsn72mds.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On lun. 28 sept. 2026 at 11:10, Changhuang Liang <changhuang.liang@starfivetech.com> wrote:

> Hi, Jerome
>
> Thanks for the review.
>
>> On dim. 20 sept. 2026 at 05:00, Changhuang Liang
>> <changhuang.liang@starfivetech.com> wrote:
>> 
>> > From: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>> >
>> > StarFive JHB100 shares a similar clock and reset design with JH7110.
>> > To facilitate the reuse of the file and its functionalities, files
>> > containing the "jh71x0" naming convention are renamed to use the
>> > "common" wording.
>> 
>> Is this really necessary ? Rename are generally not recommended.
>> Do we really care if your new soc use something named after the older one ?
>> 
>> You are naming it common now but how long is it going to stay "common" ?
>> If your next SoC does not use this anymore it won't be common for long ...
>> 
>
> Okay, I will drop the current PATCH 1/2/3/4 and directly reuse the current JH71x0-related interfaces.
>

Please make sure your series applies on clk-next next time around.
This one failed to apply when it was sent.

>> >
>> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
>> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
>> > Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
>> > Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>> > ---
>> >  drivers/clk/starfive/Kconfig                              | 8
>> ++++----
>> >  drivers/clk/starfive/Makefile                             | 2 +-
>> >  .../{clk-starfive-jh71x0.c => clk-starfive-common.c}      | 4 ++--
>> >  .../{clk-starfive-jh71x0.h => clk-starfive-common.h}      | 4 ++--
>> >  drivers/clk/starfive/clk-starfive-jh7100-audio.c          | 2 +-
>> >  drivers/clk/starfive/clk-starfive-jh7100.c                | 2 +-
>> >  drivers/clk/starfive/clk-starfive-jh7110.h                | 2 +-
>> >  7 files changed, 12 insertions(+), 12 deletions(-)  rename
>> > drivers/clk/starfive/{clk-starfive-jh71x0.c => clk-starfive-common.c}
>> > (99%)  rename drivers/clk/starfive/{clk-starfive-jh71x0.h =>
>> > clk-starfive-common.h} (98%)
>> >
>> > diff --git a/drivers/clk/starfive/Kconfig
>> > b/drivers/clk/starfive/Kconfig index bd29358ffeec..ff8eace36e64 100644
>> > --- a/drivers/clk/starfive/Kconfig
>> > +++ b/drivers/clk/starfive/Kconfig
>> > @@ -1,12 +1,12 @@
>> >  # SPDX-License-Identifier: GPL-2.0
>> >
>> > -config CLK_STARFIVE_JH71X0
>> > +config CLK_STARFIVE_COMMON
>> >  	bool
>> >
>> >  config CLK_STARFIVE_JH7100
>> >  	bool "StarFive JH7100 clock support"
>> >  	depends on ARCH_STARFIVE || COMPILE_TEST
>> > -	select CLK_STARFIVE_JH71X0
>> > +	select CLK_STARFIVE_COMMON
>> >  	default ARCH_STARFIVE
>> >  	help
>> >  	  Say yes here to support the clock controller on the StarFive
>> > JH7100 @@ -15,7 +15,7 @@ config CLK_STARFIVE_JH7100  config
>> > CLK_STARFIVE_JH7100_AUDIO
>> >  	tristate "StarFive JH7100 audio clock support"
>> >  	depends on CLK_STARFIVE_JH7100
>> > -	select CLK_STARFIVE_JH71X0
>> > +	select CLK_STARFIVE_COMMON
>> >  	default m if ARCH_STARFIVE
>> >  	help
>> >  	  Say Y or M here to support the audio clocks on the StarFive JH7100
>> > @@ -33,7 +33,7 @@ config CLK_STARFIVE_JH7110_SYS
>> >  	bool "StarFive JH7110 system clock support"
>> >  	depends on ARCH_STARFIVE || COMPILE_TEST
>> >  	select AUXILIARY_BUS
>> > -	select CLK_STARFIVE_JH71X0
>> > +	select CLK_STARFIVE_COMMON
>> >  	select RESET_STARFIVE_JH7110 if RESET_CONTROLLER
>> >  	select CLK_STARFIVE_JH7110_PLL
>> >  	default ARCH_STARFIVE
>> > diff --git a/drivers/clk/starfive/Makefile
>> > b/drivers/clk/starfive/Makefile index 199ac0f37a2f..012f7ee83f8e
>> > 100644
>> > --- a/drivers/clk/starfive/Makefile
>> > +++ b/drivers/clk/starfive/Makefile
>> > @@ -1,5 +1,5 @@
>> >  # SPDX-License-Identifier: GPL-2.0
>> > -obj-$(CONFIG_CLK_STARFIVE_JH71X0)	+= clk-starfive-jh71x0.o
>> > +obj-$(CONFIG_CLK_STARFIVE_COMMON)	+= clk-starfive-common.o
>> >
>> >  obj-$(CONFIG_CLK_STARFIVE_JH7100)	+= clk-starfive-jh7100.o
>> >  obj-$(CONFIG_CLK_STARFIVE_JH7100_AUDIO)	+=
>> clk-starfive-jh7100-audio.o
>> > diff --git a/drivers/clk/starfive/clk-starfive-jh71x0.c
>> > b/drivers/clk/starfive/clk-starfive-common.c
>> > similarity index 99%
>> > rename from drivers/clk/starfive/clk-starfive-jh71x0.c
>> > rename to drivers/clk/starfive/clk-starfive-common.c
>> > index 80e9157347eb..4aecb65e9fd7 100644
>> > --- a/drivers/clk/starfive/clk-starfive-jh71x0.c
>> > +++ b/drivers/clk/starfive/clk-starfive-common.c
>> > @@ -1,6 +1,6 @@
>> >  // SPDX-License-Identifier: GPL-2.0
>> >  /*
>> > - * StarFive JH71X0 Clock Generator Driver
>> > + * StarFive Clock Generator Driver
>> >   *
>> >   * Copyright (C) 2021-2022 Emil Renner Berthing <kernel@esmil.dk>
>> >   */
>> > @@ -10,7 +10,7 @@
>> >  #include <linux/device.h>
>> >  #include <linux/io.h>
>> >
>> > -#include "clk-starfive-jh71x0.h"
>> > +#include "clk-starfive-common.h"
>> >
>> >  static struct jh71x0_clk *jh71x0_clk_from(struct clk_hw *hw)  { diff
>> > --git a/drivers/clk/starfive/clk-starfive-jh71x0.h
>> > b/drivers/clk/starfive/clk-starfive-common.h
>> > similarity index 98%
>> > rename from drivers/clk/starfive/clk-starfive-jh71x0.h
>> > rename to drivers/clk/starfive/clk-starfive-common.h
>> > index 9d5dec1d5cd1..f634c62c196a 100644
>> > --- a/drivers/clk/starfive/clk-starfive-jh71x0.h
>> > +++ b/drivers/clk/starfive/clk-starfive-common.h
>> > @@ -1,6 +1,6 @@
>> >  /* SPDX-License-Identifier: GPL-2.0 */ -#ifndef
>> > __CLK_STARFIVE_JH71X0_H -#define __CLK_STARFIVE_JH71X0_H
>> > +#ifndef __CLK_STARFIVE_COMMON_H
>> > +#define __CLK_STARFIVE_COMMON_H
>> >
>> >  #include <linux/bits.h>
>> >  #include <linux/clk-provider.h>
>> > diff --git a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
>> > b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
>> > index de1cf717e391..0e363b971e9d 100644
>> > --- a/drivers/clk/starfive/clk-starfive-jh7100-audio.c
>> > +++ b/drivers/clk/starfive/clk-starfive-jh7100-audio.c
>> > @@ -14,7 +14,7 @@
>> >
>> >  #include <dt-bindings/clock/starfive-jh7100-audio.h>
>> >
>> > -#include "clk-starfive-jh71x0.h"
>> > +#include "clk-starfive-common.h"
>> >
>> >  /* external clocks */
>> >  #define JH7100_AUDCLK_AUDIO_SRC			(JH7100_AUDCLK_END
>> + 0)
>> > diff --git a/drivers/clk/starfive/clk-starfive-jh7100.c
>> > b/drivers/clk/starfive/clk-starfive-jh7100.c
>> > index 761e46ed0ffd..ca81ccb5af94 100644
>> > --- a/drivers/clk/starfive/clk-starfive-jh7100.c
>> > +++ b/drivers/clk/starfive/clk-starfive-jh7100.c
>> > @@ -14,7 +14,7 @@
>> >
>> >  #include <dt-bindings/clock/starfive-jh7100.h>
>> >
>> > -#include "clk-starfive-jh71x0.h"
>> > +#include "clk-starfive-common.h"
>> >
>> >  /* external clocks */
>> >  #define JH7100_CLK_OSC_SYS		(JH7100_CLK_END + 0)
>> > diff --git a/drivers/clk/starfive/clk-starfive-jh7110.h
>> > b/drivers/clk/starfive/clk-starfive-jh7110.h
>> > index 0659adae4d76..6b1bdf860f00 100644
>> > --- a/drivers/clk/starfive/clk-starfive-jh7110.h
>> > +++ b/drivers/clk/starfive/clk-starfive-jh7110.h
>> > @@ -2,7 +2,7 @@
>> >  #ifndef __CLK_STARFIVE_JH7110_H
>> >  #define __CLK_STARFIVE_JH7110_H
>> >
>> > -#include "clk-starfive-jh71x0.h"
>> > +#include "clk-starfive-common.h"
>> >
>> >  /* top clocks of ISP/VOUT domain from JH7110 SYSCRG */  struct
>> > jh7110_top_sysclk {
>> > --
>> > 2.25.1
>> >
>> >
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>> 
>> --
>
> Best Regards
> Changhuang
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Jerome
