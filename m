Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB157C43217
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96154610E8
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 13:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhJRN6z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 09:58:55 -0400
Received: from foss.arm.com ([217.140.110.172]:38522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232380AbhJRN4h (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 09:56:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8A1101E;
        Mon, 18 Oct 2021 06:54:25 -0700 (PDT)
Received: from bogus (unknown [10.57.25.56])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E356D3F73D;
        Mon, 18 Oct 2021 06:54:23 -0700 (PDT)
Date:   Mon, 18 Oct 2021 14:54:21 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        jing yangyang <cgel.zte@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH linux-next] firmware/psci: fix application of sizeof to
 pointer
Message-ID: <20211018135421.gnjbkuvrmjep2odz@bogus>
References: <61d3cc7e5cd4a819381fcb22e1853d6f48a0c927.1629212319.git.jing.yangyang@zte.com.cn>
 <20210824105824.GC96738@C02TD0UTHF1T.local>
 <20211016181003.GA1193402@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016181003.GA1193402@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 16, 2021 at 01:10:03PM -0500, Gustavo A. R. Silva wrote:
> On Tue, Aug 24, 2021 at 11:58:24AM +0100, Mark Rutland wrote:
> > On Thu, Aug 19, 2021 at 07:30:16PM -0700, jing yangyang wrote:
> > > sizeof when applied to a pointer typed expression gives the size of
> > > the pointer.
> > > 
> > > ./drivers/firmware/psci/psci_checker.c:158:41-47: ERROR application of sizeof to pointer
> > > 
> > > This issue was detected with the help of Coccinelle.
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> > 
> > >From looking at the git history, we should add:
> > 
> >   Fixes: 7401056de5f8d4ea ("drivers/firmware: psci_checker: stash and use topology_core_cpumask for hotplug tests)"
> > 
> > With that:
> > 
> >   Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Lorenzo, how do we normally direct these patches?
> 
> It seems that these patches are consistently being ignored[1][2][3]. So,

Sorry for that. Sometime it does happen. Anyways thanks for reminding about
it.

> I'll take this in my -next tree[4] before it gets lost again.

Mark has already acked it, so you can take it via your tree if you are OK.

We generally ask the author to post to soc@kernel.org for one of patches
like this when we don't have any plans to send PR to SoC team so that they
can apply the patch directly.

So it should be fine if you prefer to pick up and send to SoC team or we
can resend the patch to them and ask to apply. Let us know.

-- 
Regards,
Sudeep
