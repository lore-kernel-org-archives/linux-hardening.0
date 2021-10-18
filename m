Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F24C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 21:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254206112D
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Oct 2021 21:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhJRVXt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJRVXt (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Oct 2021 17:23:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08D676113D;
        Mon, 18 Oct 2021 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634592097;
        bh=r+U+HRVQuA0YbQnhsffBIKTPjNzgnGyVqS2dVQNn2D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jkM+1QBLNmmr2PR2zw2SC8iGjREGbYOVerrkSYv8jxLrqA9IIHJg+L/VcMTBqG8hh
         huAmTTF47wai2Ksr+eiVkQgaVJXGZASCP0F/JIkO4EM9DVuXLchxXbF41zo1naYbNx
         JXYUgmJ4QuUfYnGD1HBMdVuKulpF4MuJYhKj+SnFw6F5O7dycf75FOu5OcnxlFnQa6
         X6UGocjlHew9R39KPk3JbWDddBMFKJjbBmWHhC3MtkXTIaOFGvkPtDXgZtmY5vsV3D
         tdZyp1/wtkTwabinzQahybxs1JiXRYZCtYO/3jbIGJPAk5B/pbC/dw+sGQSlhMVzB0
         rj/96f25tNgvA==
Date:   Mon, 18 Oct 2021 16:26:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Haren Myneni <haren@linux.ibm.com>,
        linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] powerpc/vas: Fix potential NULL pointer dereference
Message-ID: <20211018212612.GA1237121@embeddedor>
References: <20211015050345.GA1161918@embeddedor>
 <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c42e43-15b9-5db6-d460-dbb16f31954d@linux.ibm.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 18, 2021 at 02:09:31PM -0700, Tyrel Datwyler wrote:
> On 10/14/21 10:03 PM, Gustavo A. R. Silva wrote:
> > (!ptr && !ptr->foo) strikes again. :)
> > 
> > The expression (!ptr && !ptr->foo) is bogus and in case ptr is NULL,
> > it leads to a NULL pointer dereference: ptr->foo.
> > 
> > Fix this by converting && to ||
> > 
> > This issue was detected with the help of Coccinelle, and audited and
> > fixed manually.
> > 
> > Fixes: 1a0d0d5ed5e3 ("powerpc/vas: Add platform specific user window operations")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> Looking at the usage pattern it is obvious that if we determine !ptr attempting
> to also confirm !ptr->ops is going to blow up.
> 
> LGTM.
> 
> Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>

Thanks, Tyrel.
--
Gustavo

> 
> > ---
> >  arch/powerpc/platforms/book3s/vas-api.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
> > index 30172e52e16b..4d82c92ddd52 100644
> > --- a/arch/powerpc/platforms/book3s/vas-api.c
> > +++ b/arch/powerpc/platforms/book3s/vas-api.c
> > @@ -303,7 +303,7 @@ static int coproc_ioc_tx_win_open(struct file *fp, unsigned long arg)
> >  		return -EINVAL;
> >  	}
> > 
> > -	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->open_win) {
> > +	if (!cp_inst->coproc->vops || !cp_inst->coproc->vops->open_win) {
> >  		pr_err("VAS API is not registered\n");
> >  		return -EACCES;
> >  	}
> > @@ -373,7 +373,7 @@ static int coproc_mmap(struct file *fp, struct vm_area_struct *vma)
> >  		return -EINVAL;
> >  	}
> > 
> > -	if (!cp_inst->coproc->vops && !cp_inst->coproc->vops->paste_addr) {
> > +	if (!cp_inst->coproc->vops || !cp_inst->coproc->vops->paste_addr) {
> >  		pr_err("%s(): VAS API is not registered\n", __func__);
> >  		return -EACCES;
> >  	}
> > 
> 
