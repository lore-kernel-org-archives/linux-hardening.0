Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E25C4338F
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 22:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0DB6101A
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Aug 2021 22:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbhHRWaj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 18 Aug 2021 18:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhHRWai (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 18 Aug 2021 18:30:38 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA8EC0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 15:30:03 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id e15so2747269plh.8
        for <linux-hardening@vger.kernel.org>; Wed, 18 Aug 2021 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DUTuMfsQqxqX+3pR2oz9dVJNWsHg80kq142ck8zdj0s=;
        b=HXqi8rpNQlqRCRobulkOlcaA4+c6J/4aW1kHG07w5z+LW3VAsPY7L3ovHbYLAvr6BW
         z8PYA40q5a4/E1aSSd1f0X7nRnd2FNDMsOqvNHCn+M7iSwPw+3HB842oCYFV1odUjD4+
         aowm4n1LLC28ISLDG0efepefjXmirvRMkeWhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DUTuMfsQqxqX+3pR2oz9dVJNWsHg80kq142ck8zdj0s=;
        b=k/BBZmltbtXJyg8pcB7IvKaKm6ITbP84lNvkfjfhcHuj13zAdbUfoxCe0epvDO0mYO
         LfWSbUjs9ZCEuwlYcIg73OwRDA1EyrHh/ug5ZhzUdwlB2DtTumR5we8nfIyX4bA/Z4MZ
         RIy3ft2I6jUYty1UWnnWP5CNQ66cUbj3hlGfH/ftTDxGW17Q7kLjtZjfvnLuQ7pGiPKg
         s6st9qtBA2hIjdGop5TwPq+uLsuz6sM6dfagTAs6lbtjpCiHUHSrYjunc8TPEZ3a12Vq
         YWYx0c9tRteVeTluOdU+yOp7Ti1gYHkpwZL0QFy7kwhG6b6nwoqwNPU7TW70OOrpSvSN
         7D7Q==
X-Gm-Message-State: AOAM531dQ+moBRg9jqOSNzwZUPmsnniJ++osTXgNqF9cCExbakNumrDU
        G8dfKp5p37dEoEyBk7bH3sU2o/2RTdqghw==
X-Google-Smtp-Source: ABdhPJwejqek+pQNgEJHoUL+LD8id8sswOa0BezZLWGyCwRRYJ3BmiAhJE1bgJAMyKte9lbr8NDHRw==
X-Received: by 2002:a17:90a:a581:: with SMTP id b1mr1663300pjq.153.1629325803017;
        Wed, 18 Aug 2021 15:30:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n185sm862325pfn.171.2021.08.18.15.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:30:02 -0700 (PDT)
Date:   Wed, 18 Aug 2021 15:30:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wang Wensheng <wangwensheng4@huawei.com>,
        linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        linux-block@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        clang-built-linux@googlegroups.com, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 61/63] powerpc: Split memset() to avoid multi-field
 overflow
Message-ID: <202108181528.9CDB56FEC@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-62-keescook@chromium.org>
 <7630b0bc-4389-6283-d8b9-c532df916d60@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7630b0bc-4389-6283-d8b9-c532df916d60@csgroup.eu>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Aug 18, 2021 at 08:42:18AM +0200, Christophe Leroy wrote:
> 
> 
> Le 18/08/2021 à 08:05, Kees Cook a écrit :
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> > 
> > Instead of writing across a field boundary with memset(), move the call
> > to just the array, and an explicit zeroing of the prior field.
> > 
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Qinglang Miao <miaoqinglang@huawei.com>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Hulk Robot <hulkci@huawei.com>
> > Cc: Wang Wensheng <wangwensheng4@huawei.com>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> > Link: https://lore.kernel.org/lkml/87czqsnmw9.fsf@mpe.ellerman.id.au
> > ---
> >   drivers/macintosh/smu.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
> > index 94fb63a7b357..59ce431da7ef 100644
> > --- a/drivers/macintosh/smu.c
> > +++ b/drivers/macintosh/smu.c
> > @@ -848,7 +848,8 @@ int smu_queue_i2c(struct smu_i2c_cmd *cmd)
> >   	cmd->read = cmd->info.devaddr & 0x01;
> >   	switch(cmd->info.type) {
> >   	case SMU_I2C_TRANSFER_SIMPLE:
> > -		memset(&cmd->info.sublen, 0, 4);
> > +		cmd->info.sublen = 0;
> > +		memset(&cmd->info.subaddr, 0, 3);
> 
> subaddr[] is a table, should the & be avoided ?

It results in the same thing, but it's better form to not have the &; I
will fix this.

> And while at it, why not use sizeof(subaddr) instead of 3 ?

Agreed. :)

Thanks!

-- 
Kees Cook
