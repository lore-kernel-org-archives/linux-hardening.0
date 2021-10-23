Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF65C433F5
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Oct 2021 20:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1266060F6F
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Oct 2021 20:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhJWUMM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 23 Oct 2021 16:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhJWUML (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 23 Oct 2021 16:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF86D60F8F;
        Sat, 23 Oct 2021 20:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635019792;
        bh=Z2UnwJI+9oAgRIyuriM6ZijPMHqaj6ZBWEKOVaGHMWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MI+Ep3nBT4owULahLaCWGl9KL8jzCcBz/ZEosBSx7FLahUdwTcQNw3Wu4g5YhLNtz
         V3KzXIiGsv61oCtvhyWPNGUyGxhlDRycHGnafuUibektssYpNCNqihcJUuG8QbU7Bh
         D6TYdVMecKhdz90iTBabrAv/Fmztee4QjsE9G35wFA5rmeRjiELxwH9nhfa9TyiHKg
         3CdQVNgKWekds4RqZSoSq25DI3eiDyh7G3N8HNZe5zlnn4Oo2iUAcys2cdm2RtrYGK
         QaboQ9+tbgRb9U5glvxoLoryoksyEEjsq6Y4gk3dZc6RHA+gNcCMfpUg2NO4bZUnON
         NssDCtkbzUIDQ==
Date:   Sat, 23 Oct 2021 15:14:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer struct_size over open coded arithmetic
Message-ID: <20211023201438.GA1405616@embeddedor>
References: <20211017095650.3718-1-len.baker@gmx.com>
 <20211017172357.GA1214270@embeddedor>
 <20211023112838.GB4145@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211023112838.GB4145@titan>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Oct 23, 2021 at 01:28:38PM +0200, Len Baker wrote:
> Hi Gustavo,
> 
> first of all, thanks for this review (and all others reviews as
> well) ;)

No problem. :)

> I think that it is better to use the dynamic allocation since in the
> future the struct size could be dynamic.

Yep; that seems sensible.

> it's not one single element. The "sizeof(struct nvme_ana_group_desc)" is
> multiplied by "ctrl->nanagrpid" and then added "ctrl->max_namespaces * sizeof(__le32)".

You're right. The whole expression got me a bit confused.

> > drivers/nvme/target/admin-cmd.c:267:    return sizeof(struct nvme_ana_group_desc) + count * sizeof(__le32);
> 
> Ok. I forgot it. Apologies.

No apologies. Thanks for your patches. 

> Again, thanks for your time and advises,

Anytime.

Thanks
--
Gustavo
