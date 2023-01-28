Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3F8C27C76
	for <linux-hardening@archiver.kernel.org>; Sat, 28 Jan 2023 07:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjA1HWj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 28 Jan 2023 02:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbjA1HWj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 28 Jan 2023 02:22:39 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F67E6C4
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 23:22:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b10so6702498pjo.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 23:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=czFnnNgiMNwVHtOu8IgfTLKpLnKZzktc8ilaRgu2SLg=;
        b=rovDaWkwW8WlO27xY4VUiD/aZvHiRLwNMSkQgtqLrdciFxOgTcudSDnJsAHv8KkLxM
         IAnDuY/G7Zk2eBOcEwZ4dSSR4S7SqRNPhOXVIeuR2KuGxz3GPH11K80oa3m3sB9julDh
         0kVpWxN77OH8NZ+232r6NuT0rax30rlki9uthNbNhsPIXeXaPZwqdtm4M8Nzxf0NBo6q
         JvM4BmrYy2mCnE1IDOTRRGJdt32xNJm8EJAv71R9ziUdwMVViRonZ/CwNnwgSNh56sSe
         /b+abh0GK/ep1OZuWPvg+XpA3mn9UTYYA0Uy6+F2cwgMyZK5SaPHggOyfQQuAg40k0Sd
         ZzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czFnnNgiMNwVHtOu8IgfTLKpLnKZzktc8ilaRgu2SLg=;
        b=Hu2PRrap+JcDc/1NSj2/1Z59WqaYlKYhZsvZCJNKPf4K1OgqMv6spM9K6kE1iOFJYF
         voTBcEd0yVCfotE9XzJcfRtM2NczZ4VApUiS7nkz7NZU/wX/JMsEThxzgJ77gwa45rqg
         Bc97BubYq9p8NHqflSGnmId8b055CXfLBGSrqjewkCc/LaYilqGQvMGxhjnwzq19Ez3M
         ryVQ1ia2xd/xp1hTI65t7f1GadGIj3v8NwulNjRbiJTuOYdCIEymJ3sDskwS0wDiXXyv
         bROURJgkVbXIx767I3DCxHCpQuY0YdVQiV538RVvE48pNikrYJooyGilKtqX7EqmeCKO
         8I4Q==
X-Gm-Message-State: AO0yUKVU/wLABLDs/MM9V4DHHvcj/t2q4d1nuAX+jqrJsx+UldEM1416
        51f12KMwkqaMb/DnjKAKNRmtu4KBcGyAZxblvygkbg==
X-Google-Smtp-Source: AK7set+A9FRO1xMuryCPrO/4me6tixWO+0SFK14DctJNZ8/DouO/cwHk9Esb4rQBlA2SMC3R4VlaS3LaxZbOr1Eo4NM=
X-Received: by 2002:a17:90a:414a:b0:22c:1be3:1985 with SMTP id
 m10-20020a17090a414a00b0022c1be31985mr1312197pjg.192.1674890557793; Fri, 27
 Jan 2023 23:22:37 -0800 (PST)
MIME-Version: 1.0
References: <20230127225203.never.864-kees@kernel.org>
In-Reply-To: <20230127225203.never.864-kees@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Sat, 28 Jan 2023 08:22:26 +0100
Message-ID: <CABxcv=kKS8DW0SWL9FxzP6g4AVAis1P21H8d9JE1bAF7p=BugA@mail.gmail.com>
Subject: Re: [PATCH] regulator: max77802: Bounds check regulator id against opmode
To:     Kees Cook <keescook@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello Kees,

On Fri, Jan 27, 2023 at 11:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> Explicitly bounds-check the id before accessing the opmode array. Seen
> with GCC 13:
>
> ../drivers/regulator/max77802-regulator.c: In function 'max77802_enable':
> ../drivers/regulator/max77802-regulator.c:217:29: warning: array subscript [0, 41] is outside array bounds of 'unsigned int[42]' [-Warray-bounds=]
>   217 |         if (max77802->opmode[id] == MAX77802_OFF_PWRREQ)
>       |             ~~~~~~~~~~~~~~~~^~~~
> ../drivers/regulator/max77802-regulator.c:62:22: note: while referencing 'opmode'
>    62 |         unsigned int opmode[MAX77802_REG_MAX];
>       |                      ^~~~~~
>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/regulator/max77802-regulator.c | 34 ++++++++++++++++++--------

The patch looks good to me.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
Javier
