Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10CC433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 16 Oct 2021 18:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E492361181
	for <linux-hardening@archiver.kernel.org>; Sat, 16 Oct 2021 18:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244488AbhJPSHn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 16 Oct 2021 14:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234167AbhJPSHm (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 16 Oct 2021 14:07:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C319D61152;
        Sat, 16 Oct 2021 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634407534;
        bh=pXmvpGnGkvZz3jdjF87zxFDCLAD5XPBvBSOagxWkGlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3bDKKx1Az+STi+APpA16lxxIDZL/bZnRM3bS2QupWWTlXAf8jYOjGboy6rT3n1mN
         FTWXJUvamV3FgxHwiAQJ23Rt/mgkTPX7lfuHv5o3nwMjK/jpbtXpFgT2OCUPwMtWYR
         W8uDxEebZpFEy3lEe85aPcBV+jzw8Qe0SkZO4RVEURCDCGTrgW+1rhCaD5PqV1cKjd
         x3OCllujqhmusolMkvyAKG6m/vBUETElNim+yUQ2IdPLIHYBCS7LdvyFEEK0js9P1T
         ZlIVAMMzCb19yvCQGNcZDVHseQKXI3KwPXHWvYwZYtv3o9UWjVcgD7G1aZsN1sQ2ew
         2cPCea0Ovj+5g==
Date:   Sat, 16 Oct 2021 13:10:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     jing yangyang <cgel.zte@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH linux-next] firmware/psci: fix application of sizeof to
 pointer
Message-ID: <20211016181003.GA1193402@embeddedor>
References: <61d3cc7e5cd4a819381fcb22e1853d6f48a0c927.1629212319.git.jing.yangyang@zte.com.cn>
 <20210824105824.GC96738@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824105824.GC96738@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Aug 24, 2021 at 11:58:24AM +0100, Mark Rutland wrote:
> On Thu, Aug 19, 2021 at 07:30:16PM -0700, jing yangyang wrote:
> > sizeof when applied to a pointer typed expression gives the size of
> > the pointer.
> > 
> > ./drivers/firmware/psci/psci_checker.c:158:41-47: ERROR application of sizeof to pointer
> > 
> > This issue was detected with the help of Coccinelle.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> 
> >From looking at the git history, we should add:
> 
>   Fixes: 7401056de5f8d4ea ("drivers/firmware: psci_checker: stash and use topology_core_cpumask for hotplug tests)"
> 
> With that:
> 
>   Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Lorenzo, how do we normally direct these patches?

It seems that these patches are consistently being ignored[1][2][3]. So,
I'll take this in my -next tree[4] before it gets lost again.

Thanks
--
Gustavo

[1] https://lore.kernel.org/lkml/20200917081353.2083241-1-liushixin2@huawei.com/
[2] https://lore.kernel.org/lkml/1606179525-63938-1-git-send-email-tiantao6@hisilicon.com/
[3] https://lore.kernel.org/lkml/20211012024229.180058-1-davidcomponentone@gmail.com/
[4] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp-misc-fixes

> 
> 
> > ---
> >  drivers/firmware/psci/psci_checker.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/psci/psci_checker.c b/drivers/firmware/psci/psci_checker.c
> > index 9a369a2..116eb46 100644
> > --- a/drivers/firmware/psci/psci_checker.c
> > +++ b/drivers/firmware/psci/psci_checker.c
> > @@ -155,7 +155,7 @@ static int alloc_init_cpu_groups(cpumask_var_t **pcpu_groups)
> >  	if (!alloc_cpumask_var(&tmp, GFP_KERNEL))
> >  		return -ENOMEM;
> >  
> > -	cpu_groups = kcalloc(nb_available_cpus, sizeof(cpu_groups),
> > +	cpu_groups = kcalloc(nb_available_cpus, sizeof(*cpu_groups),
> >  			     GFP_KERNEL);
> >  	if (!cpu_groups) {
> >  		free_cpumask_var(tmp);
> > -- 
> > 1.8.3.1
> > 
> > 
> 
> 
> 
