Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51986C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Jan 2022 17:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbiASRCo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Jan 2022 12:02:44 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40058 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354529AbiASRCo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Jan 2022 12:02:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8BD6EB81A65
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 17:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4209FC340E5
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 17:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642611762;
        bh=AGqr/EyUywtOiV76cPjpbddbU4xEZcCJmJgZsMX7zEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gfqD7OI1t5MaVgTZP2XZvO0iYjfXSmhOVKFezg4kzrIhg0f95h8FKhC3EdJxGnVax
         gzssstlTzXe/k/iHB9neE94BqlxZTMSN5ZCDGJa0xggoQ3BwEJXnVt1BLmA9qHKEv2
         DSxefP0phekm8asl0zMl+R12Pv4FspXvb+lY+jUpz8oS3vbZwv/6DR9yugqXsA2Owa
         y6lMIc9bBO7PKgMQxU+roZkq2njc3gtdxQwYWqqkFT0dlr+k+y53H4DrTZxeYPNd7U
         HrWuh3qHpqUWG73Ayg4vaRmQ0L4C1Gh6AzvN8mUBiuXUPuzNTwsdYFpBlgV3ItYbcc
         kHg7eTMUdX1FQ==
Received: by mail-wm1-f52.google.com with SMTP id ay14-20020a05600c1e0e00b0034d7bef1b5dso8925845wmb.3
        for <linux-hardening@vger.kernel.org>; Wed, 19 Jan 2022 09:02:42 -0800 (PST)
X-Gm-Message-State: AOAM532zGMU3ortV076Pw8MeFtv9yoSg3mlRDYg8zbx5vUneAuLVrlXq
        G/qLRxm2ndWJLZ/vQEzlIk7RtELUfkr9Gi2dVEI=
X-Google-Smtp-Source: ABdhPJzaT5LCv+9GQliTtWz4lhR/919tKIQ3RjJVpJJA9cb6kdjxi1sLuhQ9yYSPWUGcXzsImEh5mmdZEHZ7UQd4cqI=
X-Received: by 2002:a1c:1b8d:: with SMTP id b135mr4430106wmb.106.1642611760539;
 Wed, 19 Jan 2022 09:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20211115180410.5272-1-ardb@kernel.org> <20211115180410.5272-2-ardb@kernel.org>
 <PAXPR08MB6926FE903EA44E733D82CE6493599@PAXPR08MB6926.eurprd08.prod.outlook.com>
In-Reply-To: <PAXPR08MB6926FE903EA44E733D82CE6493599@PAXPR08MB6926.eurprd08.prod.outlook.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 19 Jan 2022 18:02:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGPCbaeYKoxOYpPzAftiE1sUBzAevupN2N5G47B2KwWbg@mail.gmail.com>
Message-ID: <CAMj1kXGPCbaeYKoxOYpPzAftiE1sUBzAevupN2N5G47B2KwWbg@mail.gmail.com>
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

On Wed, 19 Jan 2022 at 17:54, Kyrylo Tkachov <Kyrylo.Tkachov@arm.com> wrote:
>
> Hi Ard,
>
> > -----Original Message-----
> > From: Gcc-patches <gcc-patches-
> > bounces+kyrylo.tkachov=arm.com@gcc.gnu.org> On Behalf Of Ard
> > Biesheuvel via Gcc-patches
> > Sent: Monday, November 15, 2021 6:04 PM
> > To: linux-hardening@vger.kernel.org
> > Cc: Richard Sandiford <Richard.Sandiford@arm.com>;
> > thomas.preudhomme@celest.fr; Keith Packard <keithpac@amazon.com>;
> > gcc-patches@gcc.gnu.org; Kyrylo Tkachov <kyryo.tkachov@arm.com>; Ard
> > Biesheuvel <ardb@kernel.org>
> > Subject: [PATCH v5 1/1] [ARM] Add support for TLS register based stack
> > protector canary access
> >
> > Add support for accessing the stack canary value via the TLS register,
> > so that multiple threads running in the same address space can use
> > distinct canary values. This is intended for the Linux kernel running in
> > SMP mode, where processes entering the kernel are essentially threads
> > running the same program concurrently: using a global variable for the
> > canary in that context is problematic because it can never be rotated,
> > and so the OS is forced to use the same value as long as it remains up.
> >
> > Using the TLS register to index the stack canary helps with this, as it
> > allows each CPU to context switch the TLS register along with the rest
> > of the process, permitting each process to use its own value for the
> > stack canary.
>
> I've tested this patch on an arm-none-linux-gnueabihf target and the results look clean.
> Have you tested this patch with a kernel build as well? (since the functionality is intended for that use).

Of course.

> If so, the patch is okay but please rebase it and repost so that we can commit it taking into account....
>

Will do.
