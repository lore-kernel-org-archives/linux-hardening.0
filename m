Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C6C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 09:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7676101A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 09:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhHRJt3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbhHRJt2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 05:49:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3866AC061764;
        Wed, 18 Aug 2021 02:48:54 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oa17so2286702pjb.1;
        Wed, 18 Aug 2021 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqJQyuJFyTHwC9lyEFRttsDj7WqwK+8wkKgjyNUmasw=;
        b=s4PJI2LtSPf9JBsLqPOqwY7ZDNzcn6GxgcoPUAEpUYSY2YPA7LJ1N7JCM3ctruJ/Gz
         3fwBZqvg6vwpWXBYfHrBkgvGSVJrlBVQd3vIQF2kWmF7CRyyJnSagRw+lY1LlNdg87M6
         +io9VTot8Cy7HKJ1eP4f0jAn2ocpkFQAbb6yndtdYwfqeN9Ofj0HxWzjin3jZko3RAOG
         GzkGmq4QjLus6VxIweqFNfksArEZSeGBNqrLDCJKmLguXoJjenTIXfFn4gDRatW9oXoV
         HQYLPfSO0mKo4xfECgBiyiZPDxUNa8rr5R5KMpZHXJJBGLEXRuYINWrgWnfY9lJuAuQb
         hm5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqJQyuJFyTHwC9lyEFRttsDj7WqwK+8wkKgjyNUmasw=;
        b=CcnflJ8KduFyh+9mXjPjbB0IjgZowxuMUM9Jlrw/Tc9ZWLfZ/OYf5aSI9anigH/F6b
         nHwaC1J7TXhVxhYLnEVsW1fUycKPtxkvrqyFHRnaHS7k4R/X7GvfvtCOp42lswqSnjnf
         3zGTg+gIzAxZqwfBzPCrBr5d6CaX37tg2d30oR7ytceAT3Rwo5rv3VKvgOnKyhZUWzuv
         Q0vfP2r4rhaar0xr6gWjC+o0hFYm3KY0ew56RTUpn4YMjDxqdDXr8pW1iZGEWWL/a45f
         Cz8uUL5ImL5TM04LL3fakMiiwYLGgRaeP+Zb1kmRT4oJj7xgakHgo5mbNyPy7XtWD1Js
         2IoQ==
X-Gm-Message-State: AOAM530pXRu6Rg7TwNMAgo1PPsTf4wtBj57DCzjuFU/qZlz8mVGJpt9/
        T4MuRwImCRZ2Ns3mTeRbmBbb/F6GRCf3byiAyQk=
X-Google-Smtp-Source: ABdhPJwAiERleQGo81GSbIcTJzaQap2TocUupq2Hr3zIpigH+DkeSLSAfQ4KewCwkRYw3NH9uaUbqJ+C0zRiH8ymfh8=
X-Received: by 2002:a17:902:e786:b029:12d:2a7:365f with SMTP id
 cp6-20020a170902e786b029012d02a7365fmr6531086plb.21.1629280133698; Wed, 18
 Aug 2021 02:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210818043035.1308062-1-keescook@chromium.org> <20210818043035.1308062-2-keescook@chromium.org>
In-Reply-To: <20210818043035.1308062-2-keescook@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Aug 2021 12:48:17 +0300
Message-ID: <CAHp75VdE3akTqmJ6VE4+Q4F959JscvZpiJok4=2JmjDjubtuxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] USB: EHCI: Add register array bounds to HCS ports
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 7:30 AM Kees Cook <keescook@chromium.org> wrote:
>
> The original EHCI register struct used a trailing 0-element array for
> addressing the N_PORTS-many available registers. However, after
> commit a46af4ebf9ff ("USB: EHCI: define extension registers like normal ones")
> the 0-element array started to overlap the USBMODE extension register.
>
> To avoid future compile-time warnings about accessing indexes within a
> 0-element array, rearrange the struct to actually describe the expected
> layout (max 15 registers) with a union. All offsets remain the same, and
> bounds checking becomes possible on accesses to port_status and hostpc.

...

>         /* HOSTPC: offset 0x84 */
> -       u32             hostpc[0];      /* HOSTPC extension */
> +       u32             hostpc[HCS_N_PORTS_MAX];
>  #define HOSTPC_PHCD    (1<<22)         /* Phy clock disable */
>  #define HOSTPC_PSPD    (3<<25)         /* Port speed detection */
>
> -       u32             reserved5[17];
> +       u32             reserved5[2];

Shouldn't it be rather [17 - PORT_MAX]? for accuracy?
Or also a union approach?

-- 
With Best Regards,
Andy Shevchenko
