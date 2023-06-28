Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E070EB64DA
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 08:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbjF1IGN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbjF1IBv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 04:01:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A840030D5;
        Wed, 28 Jun 2023 00:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2160F6125F;
        Wed, 28 Jun 2023 05:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25476C433C0;
        Wed, 28 Jun 2023 05:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687930220;
        bh=ah8x13f4zofFMx5nsLEc6qs3jvoPHfNuOeEvmo9e0nY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eJofu9sV4aO9R5qfMoxcHszIoHkwd1dpN97CpkjTQHw47hcmonzjNcarLO5y/kgQN
         qKsR200mYoOHYjRD48YozrqWPywN1JBWKbQnZha58QeS8pk/Xti6yqfTBsm8ZfTEfF
         TaN8tzL9tOYeo1C0Dcicx6hQWQ5brcBEH/GIQ3Qc=
Date:   Wed, 28 Jun 2023 07:30:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yuxiao Zhang <yuxiaozhang@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "'Guilherme G . Piccoli'" <gpiccoli@igalia.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        wak@google.com
Subject: Re: [PATCH] pstore: ramoops: support pmsg size larger than kmalloc
 limitation
Message-ID: <2023062832-barrier-strenuous-9499@gregkh>
References: <20230627202540.881909-2-yuxiaozhang@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627202540.881909-2-yuxiaozhang@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 27, 2023 at 01:25:41PM -0700, Yuxiao Zhang wrote:
> Current pmsg implementation is using kmalloc for pmsg record buffer,
> which has max size limits based on page size.

What is that max size?

> Currently even we
> allocate enough space with pmsg-size, pmsg will still fail if the
> file size is larger than what kmalloc allowed.
> 
> Since we don't need physical contiguous memory for pmsg buffer
> , we can use kvmalloc to avoid such limitation.

Odd placement of the ',' character :)

Anyway, thanks for getting this sent out.

But, what in-kernel user is hitting this in the pstore implementation?
How big of a buffer is it trying to create?  Is this a bug in older
kernels with the in-kernel drivers as well?  If so, should it go to
stable releases and how far back?

thanks,

greg k-h
