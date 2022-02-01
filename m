Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEAFC433F5
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Feb 2022 07:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiBAHSK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Feb 2022 02:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbiBAHSJ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Feb 2022 02:18:09 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFBC061714
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 23:18:09 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id e81so31607239oia.6
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 23:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lKyqxkenuu4lEk7N2blnmdlgrFNdHIdWW8OswnT5f+c=;
        b=vD6+asnQyzqP0zi8uuwpzS4eiyV7Qgg4fSIVpQ8L6J3qVvAL10rtsl785FSlYdFvx8
         aFApyAvtTnPXLVTrwL3ZhezpqO3gPicL7N3NeVOlk1Iep7TcM+j/hO26gJe0IcpiVGlT
         3fQgny/Oew3TgrEGX7ynX1XKC0VGwW+fbawxmccD4K7mLQRg2Ru7l7BsxpqH/fh4KAxD
         X6ZmnpDBERavs7a4Fbp05IjnBO0zjdEv3Kiw7nCmnbb49+JFhAQoRSbwmhbTKVkGwa16
         QDR3L2iw1uVFArv1VjWeHcNk2Dx455RCEzAtUvbCJ7fANStsiL1pOWDmu5KABjmdbJia
         yBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lKyqxkenuu4lEk7N2blnmdlgrFNdHIdWW8OswnT5f+c=;
        b=s9Gex2p3e9PYGhWSR7vWdXbNDQFOZ/hp0sm4nYfq1aDYMZKsEjaEDS/kVCytVvhBY9
         K2i1Af6XTyJ1UW6qWZhAMEzAvkrsyDLbNhWN7pVXLB0VQpmC/xrByoI3V/1RUk9gmrPI
         ZvvZpViNWyUqcyn77QQU28PAvSMjgRo+p0ZjGkMs1WHJPyW6BhrxXxlLBTh7kD60q7z+
         Rs1qDUJV+hq69XqtufHqo+BfJ6Gi1jK9TDs35v+ARngDakp5JrnFDAi0U8N+HDVTv66l
         i/j+BARG3Oh9j/k021LwJphSPROPWWbYzTkW0xUlkyh6jqgEA2A6Ac07R/e0Nu12fF5M
         spYA==
X-Gm-Message-State: AOAM531N4Z0DYgzPT3bknEnlWcUx3iH+Pq9P7g/4H6DZPYZ6gl7kL3tW
        ZoIjFmiUtu8WvV1aX569cuaeW0UQ/QASPZPTXG0=
X-Google-Smtp-Source: ABdhPJxsGv5YK5KR+24WtL/4AoinywjHOjDAsSOvKODD6shsyog1fgpSrqFzxws6uKFF4t8Dt8E/bw==
X-Received: by 2002:a05:6808:181c:: with SMTP id bh28mr359563oib.203.1643699888334;
        Mon, 31 Jan 2022 23:18:08 -0800 (PST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com. [209.85.210.47])
        by smtp.gmail.com with ESMTPSA id l19sm9369962ooa.7.2022.01.31.23.18.07
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 23:18:07 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so2605686otc.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 23:18:07 -0800 (PST)
X-Received: by 2002:a9d:73da:: with SMTP id m26mr13971206otk.72.1643699887243;
 Mon, 31 Jan 2022 23:18:07 -0800 (PST)
MIME-Version: 1.0
References: <809699127.18214.1643504444637@jenkins.jenkins> <202201311410.EA1999F5@keescook>
In-Reply-To: <202201311410.EA1999F5@keescook>
From:   Arnd Bergmann <arnd@linaro.org>
Date:   Tue, 1 Feb 2022 08:17:50 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1CT+-3J7Ufv9TQwRiV4i_+FF=-+phwSjWafyGuPfG+AA@mail.gmail.com>
Message-ID: <CAK8P3a1CT+-3J7Ufv9TQwRiV4i_+FF=-+phwSjWafyGuPfG+AA@mail.gmail.com>
Subject: Re: [TCWG CI] Regression caused by linux: Makefile: Enable -Warray-bounds
To:     Kees Cook <keescook@chromium.org>
Cc:     ci_notify@linaro.org,
        Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 31, 2022 at 11:30 PM Kees Cook <keescook@chromium.org> wrote:
> On Sun, Jan 30, 2022 at 01:00:43AM +0000, ci_notify@linaro.org wrote:
>
> For example, extracting from the build log, I can see more:
>
> > 00:00:53 In file included from ./include/linux/io.h:13,
> > 00:00:53                  from arch/arm/mach-cns3xxx/pm.c:8:
> > 00:00:53 In function =E2=80=98__raw_readl=E2=80=99,
> > 00:00:53     inlined from =E2=80=98cns3xxx_pwr_clk_en=E2=80=99 at arch/=
arm/mach-cns3xxx/pm.c:17:12:
> > 00:00:53 ./arch/arm/include/asm/io.h:113:9: error: array subscript 0 is=
 outside array bounds of =E2=80=98const volatile void[0]=E2=80=99 [-Werror=
=3Darray-bounds]
> > 00:00:53   113 |         asm volatile("ldr %0, %1"
> > 00:00:53       |         ^~~
>
> Looks like something sees a "void" type... this smells like a compiler
> bug. I haven't been able to reproduce this warning yet.

I suspect this is a variation of
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99578

When gcc sees a pointer dereference of a literal address like *(int
*)(void *)0x1234000,
this is sometimes interpreted as a NULL pointer with an offset, which
in turn is
assumed to have zero bytes that can be dereferenced.

        Arnd
