Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004DC433F5
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Jan 2022 19:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbiARTje (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Jan 2022 14:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343619AbiARTje (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Jan 2022 14:39:34 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0366C06173E
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 11:39:33 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id j85so237766qke.2
        for <linux-hardening@vger.kernel.org>; Tue, 18 Jan 2022 11:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tLdog0n5L37y3MRWMAFNB4F/ux6HarIU0b+GSL5AL8I=;
        b=JxuUbd1edEtbcMjCPSHSeTD/CMYEQdKqj/JLXxnkn+Bkc6GbozsOmUxwYRcTFsY47V
         WslujJVSY9vZtdXObppzaJQ0XtxjM0/O6BcKQE/zLqUnX0H8LSFwCeWeCMv6fVoWagiZ
         UtOtlLdGXjCLwzJlFu1FXI8C5OfuzJPVSSbieu+2VLq4ZVapGXxYrJTLJFqeMIFy9d2Z
         k0/ON6VVV5+yE9VVVEWmaWQlbwRu5BN60dy3Gg3kukxXeKDIhZdFxFaEc4FoJa1LtbHS
         Uv158qvrSco6aI/Rx+lCeqczh5qvcETHy05zvS+uAImu/AEx1laINzofgC3XGJBKWFzn
         RXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tLdog0n5L37y3MRWMAFNB4F/ux6HarIU0b+GSL5AL8I=;
        b=2R6e90FROutfGGydu3xjiuLGf2454XfsdltzY8w2uKmzFepFHeimAFw9eYcSAZWKBy
         KWZetuwdBhmCIL70JtXBQYY8I/U5khEJZdE/90ydhb67WgkjeCe1G+R6+PFLCCsx+5tX
         Qz9sl3zN8MWyYbot9YAdX7WrFSI2ZxMvBcVxzJl8Bq7JCgWvJwkjj6azga4byicloNAe
         eiOo/kL55aqWNHoABzghAlj7a2N/rPKVa7unr7WkmAa7Nx593Nwfr//KJHDfLCvjxOhJ
         PKjtruZkTr1vDJOq2WApHgZwRI7wGBcIMuKFhf4bNa5MqKm+PhqrZ57ZY9DlzxJe9Vwz
         hlrQ==
X-Gm-Message-State: AOAM531r1DAKia2FSqJm1QdwJP4YkedhWVFlUmUSBmQOCDtBduhOHNUf
        60UrbsrbmVLQ3CNPIytHd4uWSg==
X-Google-Smtp-Source: ABdhPJyv+GW0Uxig4OgnmrE0B7ffqMZTGZmT4aK6Hb5mU/4+tpZB5vTRrUzdANLkG2L924vH1W5P2A==
X-Received: by 2002:a37:de09:: with SMTP id h9mr18417793qkj.764.1642534772953;
        Tue, 18 Jan 2022 11:39:32 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a19sm431977qtx.7.2022.01.18.11.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 11:39:32 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n9uKJ-0012sn-OS; Tue, 18 Jan 2022 15:39:31 -0400
Date:   Tue, 18 Jan 2022 15:39:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tpm: vtpm_proxy: Double-check to avoid buffer overflow
Message-ID: <20220118193931.GH8034@ziepe.ca>
References: <20220118183650.3386989-1-keescook@chromium.org>
 <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez00FFW-n_Pi=+ya1xY5QuB3q2mPr8++scVe3h3ROeF_mg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jan 18, 2022 at 08:32:43PM +0100, Jann Horn wrote:
> On Tue, Jan 18, 2022 at 7:37 PM Kees Cook <keescook@chromium.org> wrote:
> > When building with -Warray-bounds, this warning was emitted:
> >
> > In function 'memset',
> >     inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
> > ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
> > [-Warray-bounds]
> >    43 | #define __underlying_memset     __builtin_memset
> >       |                                 ^
> 
> Can you explain what that compiler warning actually means, and which
> compiler it is from? Is this from a 32-bit or a 64-bit architecture?
> 
> It sounds like the compiler (GCC?) is hallucinating a codepath on
> which "len" is guaranteed to be >=2147483648, right? Why is it doing
> that? Is this some kinda side effect from the fortify code?

I agree, this looks bogus, or at least the commit message neeeds alot
more explaining.

static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)

        if (count > sizeof(proxy_dev->buffer))
            [...]
        proxy_dev->req_len = count;

Not clear how req_len can be larger than sizeof(buffer)?

Jason
