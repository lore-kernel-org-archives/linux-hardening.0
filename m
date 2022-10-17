Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39565C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 17 Oct 2022 15:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiJQPZT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 11:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiJQPZR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 11:25:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2252EF1C
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 08:25:15 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a3so19091799wrt.0
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZYVsksDtqwMhKI9pLO96NsNwXlR/Zc6fECSUWcfYvM=;
        b=loV8pcQ0VH7CSJZBQKJNUBD5gUGjphK138G2Vr0pUFl2hnQjhDNQsmcxOUMHVjZdNS
         kp6rLFoXEEZlMKcL018jlO+y3l2Mrp4Jhboi4EwUkUsib0YhBEusEvf31v2voSd90j+x
         RYCnGy22RpUw88J+/P4j1A3vSyzTwga/FtH7lyNU6PFMxuzP0uh72hQArEJhDcPYUk75
         g/QrFG7tmLmllRJWp+2XmsxP1vTIZnVcRfYFlA2ohe9A9yslYIZj8ov0iOUjBcQBm2Fk
         s3j+P9ur4/2ZezPhxzHUzydUoBxp+6dkJf7E9SAzCDI90tNzZBsNH759pk976J2xfQlq
         Tvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZYVsksDtqwMhKI9pLO96NsNwXlR/Zc6fECSUWcfYvM=;
        b=mWQyNduh7B7WQsJuWn+1Cz0Nh/prZTrVzLYHjeQcs5Y8l4l2V/CFWZfgpBbZpngtF2
         aFJt9tZ1gxLM7yNR9F6z+CizND0fN/Km+cYWGGYjcNTOuA+gIgZInqybYYy5YROSPV7U
         tI7J3qNmoId6sQQBnqNuYD/VHybRa0IMKgeiFL89GRX8AF42GoIU9XoE57fI2acXqGFF
         FVA9hCXPLlC90Wlp2PjOJ4uzMYNDxnhFEeVJjq1IiM138iYD5IML6Gd0RVNziCISlIu2
         VfgyOErHBmH2j0hErgxG+4izLEaTilXHEyH5+NRctmgNFUegX38LciUzSwHSld+XTgPw
         UX1w==
X-Gm-Message-State: ACrzQf1C/zxWE3uZfLlMig9I3l31O3obPi1sbcDmCsWKP1Buc3srf0T2
        JGAy2ddbeF5AA1ApN9M4RUzsaDepPpdx+FMx
X-Google-Smtp-Source: AMsMyM77wWshVlky9KSI5+U5hfTIhi0l0mEFqE4J649NfP0lv0covsJc7zie3crYcrA5ylJ0MK860A==
X-Received: by 2002:adf:fc10:0:b0:22e:55e5:9bb5 with SMTP id i16-20020adffc10000000b0022e55e59bb5mr6540090wrr.112.1666020313851;
        Mon, 17 Oct 2022 08:25:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id g2-20020a05600c000200b003c5571c27a1sm12894977wmc.32.2022.10.17.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 08:25:13 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
In-Reply-To: <20221012185234.never.936-kees@kernel.org>
References: <20221012185234.never.936-kees@kernel.org>
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Message-Id: <166602031304.3572695.12870664862275915316.b4-ty@linaro.org>
Date:   Mon, 17 Oct 2022 17:25:13 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.1
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

On Wed, 12 Oct 2022 11:53:16 -0700, Kees Cook wrote:
> Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
> Sparse:
> 
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/drivers)

[1/1] firmware: meson_sm: Fix memcpy vs iomem type warnings
      https://git.kernel.org/amlogic/c/7dc69c7d073e6004a281db8f7f15cf6ebf702ea0

These changes has been applied on the intermediate git tree [1].

The v6.2/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
