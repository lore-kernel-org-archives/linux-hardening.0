Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F3DC6379F
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61C6206D8
	for <linux-hardening@archiver.kernel.org>; Mon, 23 Nov 2020 22:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcZg+7L4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgKWWyg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:52032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730934AbgKWWyg (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 23 Nov 2020 17:54:36 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E32206D8;
        Mon, 23 Nov 2020 22:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606172075;
        bh=3xeuRllFdKbVkuvJ2rjHsYqvTLpWBewG4Alj5QKFZ1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mcZg+7L4M9iEZ3LUalRC87VtpTcU0Z/tIUkcD08sQ4eeqBdxhWTnIfRucVjiuK8mv
         lpIvfU/Ne0wT0xPkyhDMXmyrIyeRPo0qk9d27hVfHXzxoEj3J0weFGPBcIGIabejTA
         6wtJEW4WrpRz6I72B3n6caLNkDzEdC4KWX4OVWS8=
Date:   Mon, 23 Nov 2020 16:54:49 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 060/141] habanalabs: Fix fall-through warnings for Clang
Message-ID: <20201123225449.GQ21644@embeddedor>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <34c177585dfd5c6dc3e101ec8f11e4733b7fd11a.1605896059.git.gustavoars@kernel.org>
 <CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11izHF=g1mGry1fE5kvFFFrxzhPSM6qKAO8gxSp=Kr_CQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Nov 21, 2020 at 02:34:23PM +0200, Oded Gabbay wrote:
> On Fri, Nov 20, 2020 at 8:33 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a fallthrough pseudo-keyword instead of letting the
> > code fall through to the next case.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/misc/habanalabs/gaudi/gaudi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> > index 2519a34e25b7..eab4c0dc65c5 100644
> > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > @@ -5436,6 +5436,7 @@ static void gaudi_handle_ecc_event(struct hl_device *hdev, u16 event_type,
> >                 params.num_memories = 33;
> >                 params.derr = true;
> >                 params.disable_clock_gating = true;
> > +               fallthrough;
> >         default:
> >                 return;
> >         }
> > --
> > 2.27.0
> >
> Hi Gustavo,
> So this is actually an error in the code, there shouldn't be a
> fallthrough there.
> So NAK for this patch, I'll have to send a fix for that.
> Thanks for catching this :)

Awesome. Glad this helped to catch a bug. :)

Thanks
--
Gustavo
