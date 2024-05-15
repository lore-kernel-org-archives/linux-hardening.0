Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C02E3FBA7
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 06:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755134; cv=none; b=nVM8/GhralGaozkrQI1L6mjTz/9YxdzST7bjvdIjDAgckNyLnONuEI1JRbm+DJKDKnEyxziYreyjPnuuYBqZNxLVWYIGGVdKvzYVjDE9dBMFnt1U72lJkOPEjd48lo+4P1jA9Ytuo3/V/nJaAiZsPJc+qzd4t07zm77X0U1UFMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755134; c=relaxed/simple;
	bh=/91xzwAz9XhKkTyx5CbnWsRTqhWtMw8FNJq7CLNA+4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3wvQsqwNOBsvx8jj/H9b0BF6yCVIIgafADxBDBHsVrEkzb44ZXswF6suWYgwWRD8k/PwNif7gPKkDHSST2WdknxlbTXqsp5tePxK2kaODi/Mz499gNi+gfJN8AdD5Zt5Y24ja9nvFapb2eE00zniQ5hdobbpeq2NLhifV/sifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d15GYD9R; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d15GYD9R"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4df4016b3c9so2206453e0c.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715755132; x=1716359932; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vVNSHkVmQ2QEQ7lf4BbvPSzpubRsxHLfx4PuD65Mr2w=;
        b=d15GYD9RRquwJ290ZkQd1/Gg9ImS/XORhQbxNp6SA3G6yagwZVAW8lBenRo1DMpx//
         zgs5vJ0ZLAMcOu1Yi/EQiIYEOvEt5i+Lbj5Y/FjyBFWeMHL0Td8wF4yh2ncUQdU0w+4F
         Eh9R8/aiBc8gHAaEyfbXDzg6whTUr4t5qoTjVWhIpxko/QE1OTmv8U0WZ+vJAo1Ysmf6
         SG2FQPXB0/5KQJzcU/4CyHRVLpWxPIaMAbIAig8nZ5xSDFacqamiHbQH0SC7mN8Ag/Ip
         wYvVIQ6Jm7oGtL5Z7igwuw0gjSSLx3aL0IIccqgajw7T2umeQqmUIISbY5sEVs4XNpDZ
         f4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715755132; x=1716359932;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vVNSHkVmQ2QEQ7lf4BbvPSzpubRsxHLfx4PuD65Mr2w=;
        b=c0YuGotzqQFPnKHCcX1shtNeV3KlXyvim4NXECjftYorcP10xsEdFLAbmW/lc+6cHP
         UdpRzYKLZtGvXEamVZqmgYSj1WVRtlaTO9HcEZfNKTGbOS7kTuENJRSVrvk/43bwJ3+Z
         de4wG/8UVpIiXBDpHbueRzPYGpahH6GtV61bv32p1IeB2MgvhfeWMAlK6V1XZz/roY4c
         2aslt8/NeBtRgJxhBb0HG2CXp1BnGZyp5IWrBx3Er3RGIl65xugsaEwHLbcgLd2zDk2M
         gYD9qbO9cE5100Z9rKZoMQpi1a4ztXrJ534ZCEEfnfD+9kigjoHqfP4CPxF8Lcy0VR1Q
         O4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUElF27Tgrm/aQ885eBHMBdj/+LKRgxjVA+wy7EFjvX99AWyxEfYRxBQTFf2ZhBcfpHZkOSmERIzzNJfRxPOWaeeiJ6mi5sjaRDxyGD8pmE
X-Gm-Message-State: AOJu0Yz/Dc12zDY/wfsU5vqRJ+Ael8XpW27ckj/rCh7jATXQ8sQmZiCO
	/L8ijqJieyKl5Pdv5pfuifL9CPoT6d6+jxyZvBcGei/+nJwnjVB0vs6ecmO6wiBVyzcjjd5bgBZ
	QcCfGtjhRiQgXQidV9IGbIBWLy+jPjpBo/Q1g
X-Google-Smtp-Source: AGHT+IHr4wm/sYb1pP/OT+0B+sF0lgunYepCEA+ITnor8B7krDEe5caV2Crh9QZWDnDZn/Yo7donssWP2m/DPvJo4P4=
X-Received: by 2002:a05:6122:4698:b0:4df:315a:adab with SMTP id
 71dfb90a1353d-4df882c2956mr13577261e0c.5.1715755131816; Tue, 14 May 2024
 23:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514233747.work.441-kees@kernel.org>
In-Reply-To: <20240514233747.work.441-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Wed, 15 May 2024 08:38:15 +0200
Message-ID: <CANpmjNMmNvW41j8RfqZr8asW5BeRXLFkmW_MTO_DX=xEtQNgFg@mail.gmail.com>
Subject: Re: [PATCH] ubsan: Restore dependency on ARCH_HAS_UBSAN
To: Kees Cook <keescook@chromium.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 01:38, Kees Cook <keescook@chromium.org> wrote:
>
> While removing CONFIG_UBSAN_SANITIZE_ALL, ARCH_HAS_UBSAN wasn't correctly
> depended on. Restore this, as we do not want to attempt UBSAN builds
> unless it's actually been tested on a given architecture.
>
> Reported-by: Masahiro Yamada <masahiroy@kernel.org>
> Closes: https://lore.kernel.org/all/20240514095427.541201-1-masahiroy@kernel.org
> Fixes: 918327e9b7ff ("ubsan: Remove CONFIG_UBSAN_SANITIZE_ALL")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> ---
>  lib/Kconfig.ubsan | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index e81e1ac4a919..bdda600f8dfb 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -4,6 +4,7 @@ config ARCH_HAS_UBSAN
>
>  menuconfig UBSAN
>         bool "Undefined behaviour sanity checker"
> +       depends on ARCH_HAS_UBSAN
>         help
>           This option enables the Undefined Behaviour sanity checker.
>           Compile-time instrumentation is used to detect various undefined
> --
> 2.34.1
>
