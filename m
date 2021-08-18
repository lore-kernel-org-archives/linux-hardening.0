Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EBC4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 15:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC24E604D7
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 15:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHRPDC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:03:02 -0400
Received: from netrider.rowland.org ([192.131.102.5]:50069 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S239042AbhHRPDC (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 11:03:02 -0400
Received: (qmail 196618 invoked by uid 1000); 18 Aug 2021 11:02:27 -0400
Date:   Wed, 18 Aug 2021 11:02:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Al Cooper <alcooperx@gmail.com>,
        linux-usb@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] USB: EHCI: Add register array bounds to HCS ports
Message-ID: <20210818150227.GE193695@rowland.harvard.edu>
References: <20210818043035.1308062-1-keescook@chromium.org>
 <20210818043035.1308062-2-keescook@chromium.org>
 <CAHp75VdE3akTqmJ6VE4+Q4F959JscvZpiJok4=2JmjDjubtuxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdE3akTqmJ6VE4+Q4F959JscvZpiJok4=2JmjDjubtuxw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 12:48:17PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 18, 2021 at 7:30 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > The original EHCI register struct used a trailing 0-element array for
> > addressing the N_PORTS-many available registers. However, after
> > commit a46af4ebf9ff ("USB: EHCI: define extension registers like normal ones")
> > the 0-element array started to overlap the USBMODE extension register.
> >
> > To avoid future compile-time warnings about accessing indexes within a
> > 0-element array, rearrange the struct to actually describe the expected
> > layout (max 15 registers) with a union. All offsets remain the same, and
> > bounds checking becomes possible on accesses to port_status and hostpc.
> 
> ...
> 
> >         /* HOSTPC: offset 0x84 */
> > -       u32             hostpc[0];      /* HOSTPC extension */
> > +       u32             hostpc[HCS_N_PORTS_MAX];
> >  #define HOSTPC_PHCD    (1<<22)         /* Phy clock disable */
> >  #define HOSTPC_PSPD    (3<<25)         /* Port speed detection */
> >
> > -       u32             reserved5[17];
> > +       u32             reserved5[2];
> 
> Shouldn't it be rather [17 - PORT_MAX]? for accuracy?
> Or also a union approach?

It's okay to use [2] here.  The only purpose is to ensure that the 
following usbmode_ex field is allocated at offset 0xc8; there's no 
special intrinsic meaning to that 17 value.

Alan Stern
