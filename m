Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F323BB678
	for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2026 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967117; cv=none; b=HSGq8oAb3vAm1sUYAgs30sdhxMtB6nsY5y5LbCVwgIw/lv2cJYCO7Rmya3R9I48rHNjuoi4aXYnSatZPpDEiIMh5GAqmJgB/fZODQfaiXgHpTVWF9Iq+R1vlUScpf85mDh+FWF7clUdBIRR0UIArUrPV6V/KPB04skfBsNyzUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967117; c=relaxed/simple;
	bh=z5nIZYok1fhLZRQ7QC3TZVSMxWJtY/Swhyul/D70q5M=;
	h=MIME-Version:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:Content-Type; b=m2iOqVdsfWHd5jz6j72jHxpYKrEmWnk8UVnsTW8PARNkfVYtAsyAY0NTiNsODg0+7W//ZKbXNiKh+yj2cg9xp8GUIcQe6NPg3R5Wmmwqo2fVirtHVdi2Z6iiBKtvSy1nNzdcIGAY2XqniHL2FfzM3AyFxF1EvbqSg1/rx1+A8AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iriv70T4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iriv70T4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790967115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sFsvLQiLKfq21A28GjN0uk1v82NHBHz0YcGin5ZMxfw=;
	b=iriv70T4Hq/HhXWV3bQIsmHvoGCCYJpQsKpjnKmMX0IGsyctfD0ZlPmhIPJ3e7Jdq57IJv
	pJAY8CpuIMPVcLonTqMWCKkh8uoVXp2XTKbzbGetyIOz9mkpgdXPB8EYgMv1l19a837NWk
	lK7tT/q651LFFhrtmjcLcJghTQnGZaM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-jRBSZT2cP7O55YEpNGJXWg-1; Fri, 02 Oct 2026 14:51:54 -0400
X-MC-Unique: jRBSZT2cP7O55YEpNGJXWg-1
X-Mimecast-MFC-AGG-ID: jRBSZT2cP7O55YEpNGJXWg_1790967114
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cb7f9bb86so445557285a.2
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2026 11:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790967114; x=1791571914;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sFsvLQiLKfq21A28GjN0uk1v82NHBHz0YcGin5ZMxfw=;
        b=QR07EXP3zd4+EbRCwDqCFzupc64BrkYs/mVgIupZRIyfnRhmJ485Womnr8SavO8qQn
         /SHiRMWN5I7S5WuKzRKzYbe+N5Wtgxomucm/RxsR9Qv5Nf6fkyLK4X+fisFnbEJt0hyP
         N7TpJwgNjFsr2Pfbz2gLezjf2ozthT4c0SDwk58oefpuT59b3ffpBClVKW5QlcnASh6C
         pu/oakAopd61zO9KqqhiYr8juZKivBmvcm3F8DKK3yrIC/CIPC22S5+v7JxyUy5A4o0d
         +r5n9Z0P7VggpRD2ba3PMKy4ZUnDFf3bORz5NH8iD63oarIUaH5cVQSX85MuBeK859q7
         0Yhg==
X-Forwarded-Encrypted: i=1; AKwUvBxjEQLVPPeIahp8tE3EZBUcKV3AxKFuBArgb93rBWDETKQQdfCb31VMrUi9+VXrtQdB0KAMZIwKhYz6q2/eJsg=@vger.kernel.org
X-Gm-Message-State: AFuF++lMo/f+Pf7t3lzg9t1xz8+9U8B/nk4w+KKFqVqXQ5Uku+giW2yM
	apsoAwASjN6LadNj7XYlrFDal3ODXZ0uRCrCHrug+J+ZLxiKsD1914aQ5sjbgcCr1/hTkFemB2m
	BodRncMLugKhTYzh1wwgcMFanZLjZoVrof9ItslNC/YlgvY8mh+RJHbCegKBCanG0x3jlDg==
X-Gm-Gg: AYBFou3fSyXGRI2jLHrrsw53kCmBI03ByR5c3adXH/+bSVa0WbxzaLFxXo1W7F331W+
	XToAV+RnTgHnHAAwhZaEa3UGBHtlHqlu4BUB809JRsMBSJPj30Uwb4+eRTSTWoslQpBuNupcPUY
	zYk7VVl+oPnlne/3FcwHFIb7DC+WGzSzKeTsp3XKYxV11iPhUE0mNazn85l8Jxs9MhEsDdwT+41
	5zZ2Qa5SFi9xqouyBEPY4eRZTWNkk50lp4PlEIZh0WCbniIuSv0gN36XmFeJuXCxR6I3SJSAc+c
	MRzNA4BA3GXlccwYsy6uB87xiN2dOqXiJl4jCs6HpupM8EjfuO37uj0HAdk96PKhxSyJNlpoFYW
	sI21YwrS+i4SBhQ==
X-Received: by 2002:a05:620a:1984:b0:93b:d7a0:d9dc with SMTP id af79cd13be357-93cf189c270mr681524085a.54.1790967113613;
        Fri, 02 Oct 2026 11:51:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1984:b0:93b:d7a0:d9dc with SMTP id af79cd13be357-93cf189c270mr681517785a.54.1790967112966;
        Fri, 02 Oct 2026 11:51:52 -0700 (PDT)
Received: from bmasney-x1.rmtuswv.csb ([2600:382:7723:4eba:66b1:961f:1a2d:af55])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca03a1bbsm290352485a.1.2026.10.02.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:51:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 10/23] clk: starfive: Add JHB100 System-2 clock
 generator driver
From: Brian Masney <bmasney@redhat.com>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Brian Masney <bmasney@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Emil Renner Berthing <kernel@esmil.dk>, 
 Kees Cook <kees@kernel.org>, 
 "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-hardening@vger.kernel.org, 
 netdev@vger.kernel.org, Hal Feng <hal.feng@starfivetech.com>
In-Reply-To: <20260930124317.5648-11-changhuang.liang@starfivetech.com>
References: <20260930124317.5648-1-changhuang.liang@starfivetech.com>
 <20260930124317.5648-11-changhuang.liang@starfivetech.com>
Date: Fri, 02 Oct 2026 14:51:13 -0400
Message-Id: <179096707365.821688.712584426844385414.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3217; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=z5nIZYok1fhLZRQ7QC3TZVSMxWJtY/Swhyul/D70q5M=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL2/7XmcHX65ip36MSC8m+bH/Q2KG5etNSV+ef2F7bvy
 u7EOFlP7ShlYRDjYpAVU2RZkmtUEJG6yvbeHU0WmDmsTCBDGLg4BWAiWvEM/wuePzdyPLAh2H83
 d0Jandj25LP1dgoer/dF3uqZr6C9axojw2meCs535p3fj//U/hfPvWHpVNPKItOIU/u3X/rCZ6D
 myQ0A
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RhRm-Ga9zJNurPD1ewQwABuqAZM6rpeA_ICp2eQC06E_1790967114
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi Changhuang,

> Add support for JHB100 System-2 clock generator (SYS2CRG).
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
>
> diff --git a/drivers/clk/starfive/Kconfig b/drivers/clk/starfive/Kconfig
> index 11da8bcc4046..cfaac934a8e0 100644
> --- a/drivers/clk/starfive/Kconfig
> +++ b/drivers/clk/starfive/Kconfig
> @@ -92,3 +92,13 @@ config CLK_STARFIVE_JHB100_SYS1
>  	help
>  	  Say yes here to support the system-1 clock controller on the
>  	  StarFive JHB100 SoC.
> +
> +config CLK_STARFIVE_JHB100_SYS2
> +	bool "StarFive JHB100 system-2 clock support"
> +	depends on ARCH_STARFIVE || COMPILE_TEST
> +	select CLK_STARFIVE_JH71X0
> +	select RESET_STARFIVE_JHB100 if RESET_CONTROLLER
> +	default ARCH_STARFIVE
> +	help
> +	  Say yes here to support the system-2 clock controller on the
> +	  StarFive JHB100 SoC.
> diff --git a/drivers/clk/starfive/Makefile b/drivers/clk/starfive/Makefile
> index 0061550e0f7e..29cdef20575e 100644
> --- a/drivers/clk/starfive/Makefile
> +++ b/drivers/clk/starfive/Makefile
> @@ -13,3 +13,4 @@ obj-$(CONFIG_CLK_STARFIVE_JH7110_VOUT)	+= clk-starfive-jh7110-vout.o
>  
>  obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS0)		+= clk-starfive-jhb100-sys0.o
>  obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS1)		+= clk-starfive-jhb100-sys1.o
> +obj-$(CONFIG_CLK_STARFIVE_JHB100_SYS2)		+= clk-starfive-jhb100-sys2.o
> diff --git a/drivers/clk/starfive/clk-starfive-jhb100-sys2.c b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
> new file mode 100644
> index 000000000000..a2c7e8eba9b6
> --- /dev/null
> +++ b/drivers/clk/starfive/clk-starfive-jhb100-sys2.c
> @@ -0,0 +1,129 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * StarFive JHB100 System-2 Clock Driver
> + *
> + * Copyright (C) 2024 StarFive Technology Co., Ltd.
> + *
> + * Author: Changhuang Liang <changhuang.liang@starfivetech.com>
> + *
> + */
> +
> +#include <dt-bindings/clock/starfive,jhb100-crg.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +
> +#include "clk-starfive-jh71x0.h"
> +
> +#define JHB100_SYS2CLK_NUM_CLKS			(JHB100_SYS2CLK_MAIN_ICG_EN_JTAG1 + 1)
> +
> +/* external clocks */
> +#define JHB100_SYS2CLK_OSC			(JHB100_SYS2CLK_NUM_CLKS + 0)
> +#define JHB100_SYS2CLK_PLL1			(JHB100_SYS2CLK_NUM_CLKS + 1)
> +#define JHB100_SYS2CLK_GPU0_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 2)
> +#define JHB100_SYS2CLK_GPU1_NCNOC_INIT		(JHB100_SYS2CLK_NUM_CLKS + 3)
> +
> +static const char * const jhb100_sys2_ext_clk[] = {
> +	"osc",
> +	"pll1",
> +	"gpu0_ncnoc_init",
> +	"gpu1_ncnoc_init",
> +};
> +
> +static const struct jh71x0_clk_data jhb100_sys2crg_clk_data[] = {
> +	/* jtag mst*/
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_HCLK, "jtagm0_hclk", 6,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_HCLK, "jtagm1_hclk", 6,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM0_ATPG, "jtagm0_ATPG", 12,
> +		    JHB100_SYS2CLK_PLL1),
> +	JH71X0__DIV(JHB100_SYS2CLK_JTAGM1_ATPG, "jtagm1_ATPG", 12,
> +		    JHB100_SYS2CLK_PLL1),

The ATPG portion of the clock name is uppercase. Can this be lowercase
for consistency?

Brian

-- 
Brian Masney <bmasney@redhat.com>

