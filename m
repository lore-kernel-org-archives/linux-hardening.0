Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7636C4332F
	for <linux-hardening@archiver.kernel.org>; Sat, 10 Dec 2022 04:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLJEOH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 9 Dec 2022 23:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiLJEN7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 9 Dec 2022 23:13:59 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20062FBF8
        for <linux-hardening@vger.kernel.org>; Fri,  9 Dec 2022 20:13:56 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3b5d9050e48so76844847b3.2
        for <linux-hardening@vger.kernel.org>; Fri, 09 Dec 2022 20:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ulh9++McEWHTOB6P5Ka9efyv+3TP8QPl365askkEGq0=;
        b=mvrQxKIdQOElepQpJg4WS4ziBVtlbOrqfbO4vOBulo9R1mBEsanZDv0fE32SVgrfkS
         2rE22wEBnTwI/hCNIj9UF3eIEZ648J4344ps9vRQYcO6Nv01JmEibNn1PJ8gRH4ZBYYe
         rVX4sVNuPaqB4S9Pb+DDF1aahut0DIf9+pcbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ulh9++McEWHTOB6P5Ka9efyv+3TP8QPl365askkEGq0=;
        b=tb6B8YQ0XyQgBe0JbGomuJSc9uA9rjr/m0AsQ2BB9znDYRQ6lgYxPK6KJ1K4r4GvG/
         rTOjZL7GBFEnBX450iw+Tmk9gTB2AbhwwZjQ/m+ByUR4uq03YVuqbL1gQL8+d90WchiS
         hVh0yriaRjtfcMYNeReMJOcQi9owSK3K0SVLYXKkp9DN0aEt2cu0Asx+BAXRq3J1NUcJ
         FkQiC8wqG1KKru+A5TY5DZlz6anadDBVwZXbNMnj9LxAvLoue4YPa9TwESgq3XJGvKDe
         Du4agfPBuDDJSIqIZvhJ7XWz8J/JEbbXvbOruQhFeUwtHHftRL9ERlDTAieXZGgRaNMy
         l6IQ==
X-Gm-Message-State: ANoB5pk3TU3zFWF7sLsTz4T0w4TOtrUB3nVX/so38TGPGGT/jMrIFsBU
        Atpni7ZbLFO78JfKAuvaRMgLmfChhBD9q+OVvWCZ1w==
X-Google-Smtp-Source: AA0mqf7dx5jjunaFJZjtrPR2XLjbxLbkIeL3qmdNqILQwcA/YZNLbCMwbWD2LXY2kj/nq4/AC3BtcFd5bvgudEYX2/E=
X-Received: by 2002:a0d:d988:0:b0:3eb:447b:6840 with SMTP id
 b130-20020a0dd988000000b003eb447b6840mr17744763ywe.307.1670645636141; Fri, 09
 Dec 2022 20:13:56 -0800 (PST)
MIME-Version: 1.0
References: <20221202184525.gonna.423-kees@kernel.org>
In-Reply-To: <20221202184525.gonna.423-kees@kernel.org>
From:   Daniel Palmer <daniel@thingy.jp>
Date:   Sat, 10 Dec 2022 13:13:45 +0900
Message-ID: <CAFr9PXngqDMYNOsNSLNEq=sRY0JDhAn5H5vuMVZD2o1=W1iU_Q@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: msc313: Fix function prototype mismatch in msc313_rtc_probe()
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        kernel test robot <lkp@intel.com>,
        Romain Perier <romain.perier@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

On Sat, 3 Dec 2022 at 03:45, Kees Cook <keescook@chromium.org> wrote:
> msc313_rtc_probe() was passing clk_disable_unprepare() directly, which
> did not have matching prototypes for devm_add_action_or_reset()'s
> callback argument. Refactor to use devm_clk_get_enabled() instead.

I didn't know devm_clk_get_enabled() existed. Learned something new. :)
Really nice that it fixes an issue and gets rid of a bunch of lines.

Anyhow, the change looks good to me, I build, boot and "does RTC still
work?" tested this so:

Reviewed-by: Daniel Palmer <daniel@thingy.jp>
Tested-by: Daniel Palmer <daniel@thingy.jp>

Cheers,

Daniel
