Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3FC433F5
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Oct 2021 07:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC16D610FB
	for <linux-hardening@archiver.kernel.org>; Thu,  7 Oct 2021 07:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhJGHP4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 7 Oct 2021 03:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240232AbhJGHPy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 7 Oct 2021 03:15:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2812C061746;
        Thu,  7 Oct 2021 00:14:00 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id g10so18897613edj.1;
        Thu, 07 Oct 2021 00:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zU9vVGfgwfclx0P9kgofxt67V29qFzN+kIDgX9LtHew=;
        b=K8/QWGXzaodYr8Z9EaUfd5S6mUHZipd/xkPVLjzhCUl7fNX967e4RyaRp14nhUpXh7
         SkqFRjsNd38w7qp5bEKgNu0GQPHtsNyyDLQvqFunrrc3JR8TTna75EscjSQ3WBvEZR1p
         QlJoBvr2NPJqEtVY13fNXBAd85f9IrY2hmgPMKWdKTYhJb2gQyf6NSmJQ3FM03ZANFq0
         yySBqMPYgATtogT/NMFHKxe4HbrHQ5L0T+0qu46MUGpzT0w9Ey0JIGMdE7e8FzbSsYCo
         8a3UxxHtL5ZsvjpkVLLCWGPV64uvCbivv5fhb0K82KdOSIlD24buzXt91zDA6MTWZSeV
         poUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zU9vVGfgwfclx0P9kgofxt67V29qFzN+kIDgX9LtHew=;
        b=u7Rwr1hzLBzTgXOsHEZqUXeARJfYKLRlI1cr5THTqZS1LJVmXaO0r9FP8GEwLL5jJ/
         PQgN7q2JIFHOCdSMQQwbkjNRQLIAvSOnpazTjkNkph4dK4HI0CYRxRIZBvVGCtRQx4Ld
         mBq90ifbSguMWC7OzXwru7spQqHy8E4huoptVdOsKA7C4RhKNxWIWX9aC33E6QeKtJ6E
         VfOfUly/TWgTms/BLvYITm3mBy52vfpin+c5pVEguj/AZbNHEMgaQ+Dea6arJaseiA4s
         XrKSZ2Yj7EQEYiB4L9vjf/Hb31BDkY51PpWmRhfVSCAgnXxzsksASIOvlPApkBNX8v3X
         g2uw==
X-Gm-Message-State: AOAM531Of/utpTamyA43z9lCmWX0wMKGY58HMT3/Blx2KvfpF7QPKTjO
        iNtzr648Xklg6AlKhZ2lqzKEiiP41hrb25Ds31Q=
X-Google-Smtp-Source: ABdhPJwII0eh9lNLPvP+5FATHOW7a8R9n2MzMHyNMYNTdqZUaZ2ZQHRWCS/Po1DiwzfXzgbMwGiTFdA3qzZIa8Zf188=
X-Received: by 2002:a50:e142:: with SMTP id i2mr3939626edl.107.1633590839529;
 Thu, 07 Oct 2021 00:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211006180810.GA913370@embeddedor>
In-Reply-To: <20211006180810.GA913370@embeddedor>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 10:13:23 +0300
Message-ID: <CAHp75VeZHEm2eXS-FJEuaAge1kPuS3acNYnJocXzN3TmF0+=nQ@mail.gmail.com>
Subject: Re: [PATCH][next] ASoC: q6asm: use kcalloc() instead of kzalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 6, 2021 at 9:04 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Use 2-factor multiplication argument form kcalloc() instead
> of kzalloc().

You probably need to elaborate why. E.g. refer to overflow.h and its
idea behind.

-- 
With Best Regards,
Andy Shevchenko
