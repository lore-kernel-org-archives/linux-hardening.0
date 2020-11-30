Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F13FC71156
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Nov 2020 16:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D379220825
	for <linux-hardening@archiver.kernel.org>; Mon, 30 Nov 2020 16:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zye/yjDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbgK3Qvz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Nov 2020 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgK3Qvy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Nov 2020 11:51:54 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB68C0613D4
        for <linux-hardening@vger.kernel.org>; Mon, 30 Nov 2020 08:51:14 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so17052631edq.11
        for <linux-hardening@vger.kernel.org>; Mon, 30 Nov 2020 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyKkRZI14CL09cIKqCrg3tRF0u0hWmZ7H+6Vrc8e5Uo=;
        b=Zye/yjDqWPYGyg/QE0koGvl0I2eHLXcxFBm4sXkIAKcAllxFfCM8VhOKsbeI3vqS5q
         WJynbjNDVCg5tCp8TZzl46m0pdFE+emZQsOSzDR3n1Z9O0Z4KzEyprZ2N56f/VKa6qr5
         FxAkySIInHUZpy3Si5S8ztkqnlIwnnl+7xiwCRvLeHgnaLPxJaYJ4vcca1DoiMXyqK/e
         qhM+eiUXY5aMq6kr4DSF2ghhgxdJzkPPQLxsiONl3BEctySuXBtUjKggjYyyOimhxKRn
         Li7SFb8adwSPzQ9upKTgl2WnnSLw93Bq7Z3az1xpjsh+zZ0Zb2d3xY18mLqPe+ZUtDFR
         SMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyKkRZI14CL09cIKqCrg3tRF0u0hWmZ7H+6Vrc8e5Uo=;
        b=DJLlHOcqvMWmVRRVqX/2V2uADs4+93wYEaLJ5vzDQ7uR52OvYHC+9dHH0JBnfADDJN
         jfb5R03rhIiMLycSxVy0AiADp+XVwTOaby5O060LzeJehswiL3A2L6VQt0S538HL+KP7
         Ojr8kUK6j1Nzah4Y8/DX/swK/gdHg4JILVi/Iy9E8Y8W47p2eFPfZwAB17dB88suXPfx
         0tKEimnjkseJ2NNx6fr1K3K+FS2pOtcz2ziJqO84sbvozsYFgEV7UF8DKUEQFakcPQAO
         AK+MR5m7eiWzMwbjRD4n8587geVOYep0s+T/w1U3QjCmHGhJqijnB/rrFW3PKkTdcaqi
         6ypg==
X-Gm-Message-State: AOAM531X5Bfrkw5/MhaTpcUeBD6X9IC/BX0WRpGWpmpvDS3lXB77mKMT
        3/w42QWpYes4GlxWS//nEtTfYo3CcYOk+TZNo8TyeQ==
X-Google-Smtp-Source: ABdhPJyOKnMrgBQxB4k8Qm92X/QZ93uux4mg7bXxBB+nV6g8s1tY4J8qFCSFmU/yEs/ngBHyxDuQrTMnx9skThFF/XI=
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr15528179edx.59.1606755073013;
 Mon, 30 Nov 2020 08:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor> <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
In-Reply-To: <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 30 Nov 2020 17:51:02 +0100
Message-ID: <CAMpxmJWq0_ZXsPsWhgWC_93egDm9y2A5P3GiCQ4YTcdGrGTSZQ@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 19, 2020 at 7:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 7:08 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-acpi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index 6cc5f91bfe2e..e37a57d0a2f0 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
> >                 default:
> >                         break;
> >                 }
> > +               break;
> >         default:
> >                 break;
> >         }
> > --
> > 2.27.0
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko

Are you taking it through your tree?

Bartosz
