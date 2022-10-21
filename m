Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1EEFA373D
	for <linux-hardening@archiver.kernel.org>; Fri, 21 Oct 2022 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiJUQKc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiJUQK3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Oct 2022 12:10:29 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201101ABA2E
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 09:10:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l4so2761571plb.8
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDqnpfZF/Nba9iYmW6afwPV/BMJnF3T8pQZy3ug2lYs=;
        b=VhgDsydIsST92Z8iLWFT8d537teN8JdhwWV9Y5XaFP3t43g8INhBSMM4r2y9VtiyqJ
         KcVTFWIpbQ9V8f1FNT9bkfza/ITvG0mrZmI1U4ngEjEenk8ZvFon0Ny8Qj8gR2aheBFM
         PLhy3siwCWSHxwLVevJILDvYx1txt2fYHVIdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDqnpfZF/Nba9iYmW6afwPV/BMJnF3T8pQZy3ug2lYs=;
        b=3GPnwMMCCpJ7ksmomeIZLtYsdp5Q5nzT5T2I0mRbZgLMc8pHI/TcIoI+R/Sly6Zk+w
         lFuQzmG8xbqeFjvZTlFm10+NOGM9bbzzesPFvfUwA9OA5uSS/+djopMb3tjP02QU13VP
         tbIAGPgEEzySALc0zhZlwGOHyRQ4/7Yq+DF7pa1z+OynTXuZNeJ3HHG5KTfL+cmD7BJG
         3C5D6AA1TJfIIR5FfRRLZQ3dcphZVBe4E4Q+X6FhYalY2Ne/97NIaqieY0W1Ou6zP2aD
         IjLQz668zXm4TO7AbE29JXglKRxGO/6hwXYzOeC4fSVVEOBKZzUO1c0mKekEhW+lzKYg
         4U0Q==
X-Gm-Message-State: ACrzQf2hEAt8HNQePBYF8RMMHtwl8vEwfUpzQoREXrthLKYxq8Ui9kgf
        9swXDeJVXo6S0+rhSxrXOxY/iQ==
X-Google-Smtp-Source: AMsMyM6M95hLAa5MMJ+J4YgUSd5tsutQHFC5gF7615PbGgrbbJFxj0hfKDmnrgng3LBBSLDfIP/MKg==
X-Received: by 2002:a17:902:cf01:b0:186:810c:d994 with SMTP id i1-20020a170902cf0100b00186810cd994mr2366202plg.151.1666368622967;
        Fri, 21 Oct 2022 09:10:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o125-20020a62cd83000000b00561c179e17dsm15345794pfg.76.2022.10.21.09.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:10:22 -0700 (PDT)
Date:   Fri, 21 Oct 2022 09:10:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Menglong Dong <imagedong@tencent.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] skbuff: Proactively round up to kmalloc bucket
 size
Message-ID: <202210210909.76CDB7A2@keescook>
References: <20221018093005.give.246-kees@kernel.org>
 <0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea1fc165a6c6117f982f4f135093e69cb884930.camel@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 20, 2022 at 10:42:47AM +0200, Paolo Abeni wrote:
> >  	size = SKB_DATA_ALIGN(size);
> >  	size += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > -	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> > -	if (unlikely(!data))
> > -		goto nodata;
> 
> I'm sorry for not noticing the above in the previous iteration, but I
> think this revision will produce worse code than the V1, as
> kmalloc_reserve() now pollutes an additional register.
> 
> Why did you prefer adding an additional parameter to kmalloc_reserve()?
> I think computing the alloc_size in the caller is even more readable.
> 
> Additionally, as a matter of personal preference, I would not introduce
> an additional variable for alloc_size, just:
> 
> 	// ...
> 	size = kmalloc_size_roundup(size);
> 	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
> 
> The rationale is smaller diff, and consistent style with the existing
> code where 'size' is already adjusted multiple times icrementally.

Sure, I can do that. I will respin it. :)

-- 
Kees Cook
