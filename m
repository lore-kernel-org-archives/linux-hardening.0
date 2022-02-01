Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A479C433EF
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Feb 2022 09:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiBAJEC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Feb 2022 04:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbiBAJEC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Feb 2022 04:04:02 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB8C061714
        for <linux-hardening@vger.kernel.org>; Tue,  1 Feb 2022 01:04:02 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id x193so32110519oix.0
        for <linux-hardening@vger.kernel.org>; Tue, 01 Feb 2022 01:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LDw2WXA2ABy90zLc3s08GZVdgvpOJFt+7PwCMcuj2UU=;
        b=b9aF10sA6TrCOiuKcm8Kw/TGER8kZ1kY17kTsaR/SmG8piEF1C1dqDr1GVzrmtf1Xr
         cdl5CWs6qF/EmgN3jssqBJpy/rnV1XCkTVAVTFs5YLkC0G9U5IpHxuUFseYSbpsrHrYa
         DY9Lqh+tMNzVmRuKxFGP1vgSlBZTrNZeilrUbb8hVZP3WFyAFrd14m2Z6MPLHbqJxfqu
         PPxtGsWhaaJecxxe30InP/OaP/3kvp/Dhq/gFxW9XjUle7rtbm/PpawE4tGAPSq31aaU
         KzAiZ2DAhtUnT6I5VJZNzp+p5w58+XoLNdHqh1bPdTn17KvXWpolNArJyTd8HMfmedM+
         IRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LDw2WXA2ABy90zLc3s08GZVdgvpOJFt+7PwCMcuj2UU=;
        b=Bqoyc8BJLbYCRjBg3s+17KFhJDehlgygii2+8cH8ISYwOWIIpPOHyXf3vR1+CKH7ik
         XVF4XxTPXMnui1Lyv48mNzkTssuvloUJ4LjfQ2nOprszUOv/d1/HSyHnZqYvSmnVVqIQ
         r+5ZeUcp0qKrpc+rw2wwfJqviCndI1B7z1XigFLQkhbNqIHxIPc5rBHn+fxvOxD5uSzb
         vZk7pIJoifZ1wP66rqzYC9goJ4LUgPNKZXeUcbJvcrsM9D/XaWW4a0MIwsSKQRNZdRSG
         9YVRmGs3AOTev2gSE8tgxEgAD+MZY7AuDOGCQYD4Q70lWKI0m8h7U9WQMIBXcQ/8DCFE
         Jc+A==
X-Gm-Message-State: AOAM532JRXejr4qIWXLCuoQVEoeVTaU8S3ZrxI7TV9MNsuIFiiaTZFm7
        ij2k5R7yb+Ufdh8JRh3AdqzlMP7AJ+XxYxIg7TY=
X-Google-Smtp-Source: ABdhPJy7rVsWvtOH9qzbLhbAKOxhFPHBrbg62wOmUeKDI0cRa3+lQw3VrThsPWcBN2PobahR6qj6dQ==
X-Received: by 2002:a05:6808:21aa:: with SMTP id be42mr573312oib.87.1643706241359;
        Tue, 01 Feb 2022 01:04:01 -0800 (PST)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id g4sm15994280otl.1.2022.02.01.01.04.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 01:04:00 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id r27so9810424oiw.4
        for <linux-hardening@vger.kernel.org>; Tue, 01 Feb 2022 01:04:00 -0800 (PST)
X-Received: by 2002:aca:2b16:: with SMTP id i22mr516129oik.128.1643706240184;
 Tue, 01 Feb 2022 01:04:00 -0800 (PST)
MIME-Version: 1.0
References: <809699127.18214.1643504444637@jenkins.jenkins>
 <202201311410.EA1999F5@keescook> <CAK8P3a1CT+-3J7Ufv9TQwRiV4i_+FF=-+phwSjWafyGuPfG+AA@mail.gmail.com>
 <202201312351.915CAD5A5@keescook>
In-Reply-To: <202201312351.915CAD5A5@keescook>
From:   Arnd Bergmann <arnd@linaro.org>
Date:   Tue, 1 Feb 2022 10:03:44 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2MzjbMADtCUt2hwwnb9xTNhYe=hLQVNpwbgLfHfhEEKg@mail.gmail.com>
Message-ID: <CAK8P3a2MzjbMADtCUt2hwwnb9xTNhYe=hLQVNpwbgLfHfhEEKg@mail.gmail.com>
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

On Tue, Feb 1, 2022 at 8:52 AM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Feb 01, 2022 at 08:17:50AM +0100, Arnd Bergmann wrote:
> > On Mon, Jan 31, 2022 at 11:30 PM Kees Cook <keescook@chromium.org> wrot=
e:
> > > On Sun, Jan 30, 2022 at 01:00:43AM +0000, ci_notify@linaro.org wrote:
> > >
> > > For example, extracting from the build log, I can see more:
> > >
> > > > 00:00:53 In file included from ./include/linux/io.h:13,
> > > > 00:00:53                  from arch/arm/mach-cns3xxx/pm.c:8:
> > > > 00:00:53 In function =E2=80=98__raw_readl=E2=80=99,
> > > > 00:00:53     inlined from =E2=80=98cns3xxx_pwr_clk_en=E2=80=99 at a=
rch/arm/mach-cns3xxx/pm.c:17:12:
> > > > 00:00:53 ./arch/arm/include/asm/io.h:113:9: error: array subscript =
0 is outside array bounds of =E2=80=98const volatile void[0]=E2=80=99 [-Wer=
ror=3Darray-bounds]
> > > > 00:00:53   113 |         asm volatile("ldr %0, %1"
> > > > 00:00:53       |         ^~~
> > >
> > > Looks like something sees a "void" type... this smells like a compile=
r
> > > bug. I haven't been able to reproduce this warning yet.
> >
> > I suspect this is a variation of
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D99578
> >
> > When gcc sees a pointer dereference of a literal address like *(int
> > *)(void *)0x1234000,
> > this is sometimes interpreted as a NULL pointer with an offset, which
> > in turn is
> > assumed to have zero bytes that can be dereferenced.
>
> Eww.
>
> I still can't reproduce this error myself. Any hints on compiler
> versions?

The godbolt.org link in my report shows this as reproducible with any
gcc-11.x version but not gcc-10 or earlier.

       Arnd
