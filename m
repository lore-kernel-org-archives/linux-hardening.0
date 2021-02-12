Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127CEC433E0
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Feb 2021 15:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C8364E6C
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Feb 2021 15:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBLPD0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 12 Feb 2021 10:03:26 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:43619 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbhBLPDZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 12 Feb 2021 10:03:25 -0500
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id EF5CA3E5C67
        for <linux-hardening@vger.kernel.org>; Fri, 12 Feb 2021 14:51:41 +0000 (UTC)
X-Originating-IP: 90.89.99.36
Received: from xps13 (lfbn-tou-1-1536-36.w90-89.abo.wanadoo.fr [90.89.99.36])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B10384000E;
        Fri, 12 Feb 2021 14:50:32 +0000 (UTC)
Date:   Fri, 12 Feb 2021 15:50:31 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: physmap: physmap-bt1-rom: Fix unintentional stack
 access
Message-ID: <20210212155031.08ad8742@xps13>
In-Reply-To: <d4f2385d-bd4f-1af8-60c9-48657d046d5f@embeddedor.com>
References: <20210212104022.GA242669@embeddedor>
        <20210212151216.31a09ad1@xps13>
        <d4f2385d-bd4f-1af8-60c9-48657d046d5f@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Fri, 12 Feb
2021 08:45:33 -0600:

> On 2/12/21 08:12, Miquel Raynal wrote:
> > Hi Gustavo,
> > 
> > "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote on Fri, 12 Feb 2021
> > 04:40:22 -0600:
> >   
> >> Cast &data to (char *) in order to avoid unintentionally accessing
> >> the stack.
> >>
> >> Notice that data is of type u32, so any increment to &data
> >> will be in the order of 4-byte chunks, and this piece of code
> >> is actually intended to be a byte offset.  
> > 
> > I don't have the same reading. I don't say that Coverity report is
> > wrong, but let's discuss this a bit further.
> > 
> > Given that &data is of type u32 *, you say that "&data + shift"
> > produces increments of 4-bytes, ie. we would access "&data + 4 *
> > shift"? Because I don't think this is the case (again, I may be wrong).  
> 
> Yep; this is pointer arithmetic. If you have an object ptr of type u32 *:
> 
> u32 *ptr;
> 
> and let's say it points to address 100. If you increment it by one:
> 
> ptr++
> 
> ptr will now point to address 104, not to 101.
> 
> Now, if instead, you first cast ptr to 'char *' and increment it by 1,
> then it will point to address 101.

Yep, I got confused with the proper addition compared to dereferencing.

Patch looks legitimate.

Thanks,
Miquèl
