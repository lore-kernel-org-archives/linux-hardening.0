Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A15EC433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Jan 2022 16:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377172AbiATQ6B (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Jan 2022 11:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377136AbiATQ6A (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Jan 2022 11:58:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF19C061574
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 08:58:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7B805B81DBB
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 16:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435CFC36AE3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642697877;
        bh=4kdoLnA6yO7BYKZ/ZP3FjjKyP8Ci1r8fzAx/7XTZXfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WPMVBNNAxZsJMnroCJVrFLZgtL3vHdmJOdn+gCtmuiuNdAyYsMmW/9SAzblx/7eQY
         WnZGz/8jihreLC6Y/ObZpIRZs6CV/XGM7+zyund5x9T8GmySV4rs/POLRbCU0T25/y
         7MIECOYJa81UTyUJcGE/8UVA4qvg3dhwlnjNyYN3r+UdywvWlbMkOkJRteQp7EDTlj
         /Dt5X5A6BzgNBhNz7RgR5BEx0Csslt5GXoJ/YwlICT3dZIO8n0gbebo5QwLUVZzUCY
         n1GT6FebI6jOSCtP0f5e/7TqGGyVLffWIMEVw8T66NChH3DJ4Ca7we7Lq2UQHjztL8
         TcdKwHBBcyYGg==
Received: by mail-wm1-f52.google.com with SMTP id r7-20020a1c4407000000b0034e043aaac7so1022714wma.5
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 08:57:57 -0800 (PST)
X-Gm-Message-State: AOAM531P3mEFkGqe95i6796FoS9M2s1rhljmaqwsEf+qugD8qle2gdTu
        k/Uswb+yo+Xf8GKQoZumcie3u2vXQx+lA5e1gq8=
X-Google-Smtp-Source: ABdhPJz1ZaUqXq/XRoRhC+1lX9DGYrG1Zairq+gHqPTO3/Bn5EN4ooyCHJCfWc7fGBHyuYiDzZiyo6O/snd3HHBjY2c=
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr10057805wmj.56.1642697875600;
 Thu, 20 Jan 2022 08:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20211115180410.5272-1-ardb@kernel.org> <20211115180410.5272-2-ardb@kernel.org>
 <PAXPR08MB6926FE903EA44E733D82CE6493599@PAXPR08MB6926.eurprd08.prod.outlook.com>
 <CAMj1kXGPCbaeYKoxOYpPzAftiE1sUBzAevupN2N5G47B2KwWbg@mail.gmail.com>
In-Reply-To: <CAMj1kXGPCbaeYKoxOYpPzAftiE1sUBzAevupN2N5G47B2KwWbg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 20 Jan 2022 17:57:44 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFi45wrXjUD6g83iVY8R02fZ=UOGdYvL9Pr9bvOFDB4GQ@mail.gmail.com>
Message-ID: <CAMj1kXFi45wrXjUD6g83iVY8R02fZ=UOGdYvL9Pr9bvOFDB4GQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
 protector canary access
To:     Kyrylo Tkachov <Kyrylo.Tkachov@arm.com>
Cc:     "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Richard Sandiford <Richard.Sandiford@arm.com>,
        "thomas.preudhomme@celest.fr" <thomas.preudhomme@celest.fr>,
        Keith Packard <keithpac@amazon.com>,
        Kyrylo Tkachov <kyryo.tkachov@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 19 Jan 2022 at 18:02, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 19 Jan 2022 at 17:54, Kyrylo Tkachov <Kyrylo.Tkachov@arm.com> wrote:
> >
> > Hi Ard,
> >
> > > -----Original Message-----
> > > From: Gcc-patches <gcc-patches-
> > > bounces+kyrylo.tkachov=arm.com@gcc.gnu.org> On Behalf Of Ard
> > > Biesheuvel via Gcc-patches
> > > Sent: Monday, November 15, 2021 6:04 PM
> > > To: linux-hardening@vger.kernel.org
> > > Cc: Richard Sandiford <Richard.Sandiford@arm.com>;
> > > thomas.preudhomme@celest.fr; Keith Packard <keithpac@amazon.com>;
> > > gcc-patches@gcc.gnu.org; Kyrylo Tkachov <kyryo.tkachov@arm.com>; Ard
> > > Biesheuvel <ardb@kernel.org>
> > > Subject: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
> > > protector canary access
> > >
> > > Add support for accessing the stack canary value via the TLS register,
> > > so that multiple threads running in the same address space can use
> > > distinct canary values. This is intended for the Linux kernel running in
> > > SMP mode, where processes entering the kernel are essentially threads
> > > running the same program concurrently: using a global variable for the
> > > canary in that context is problematic because it can never be rotated,
> > > and so the OS is forced to use the same value as long as it remains up.
> > >
> > > Using the TLS register to index the stack canary helps with this, as it
> > > allows each CPU to context switch the TLS register along with the rest
> > > of the process, permitting each process to use its own value for the
> > > stack canary.
> >
> > I've tested this patch on an arm-none-linux-gnueabihf target and the results look clean.
> > Have you tested this patch with a kernel build as well? (since the functionality is intended for that use).
>
> Of course.
>
> > If so, the patch is okay but please rebase it and repost so that we can commit it taking into account....
> >
>
> Will do.

I have sent out my v6 - please let me know if there is anything else I
need to do to get this landed.

Thanks,
Ard.
