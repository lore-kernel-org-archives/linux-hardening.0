Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A9BC38A2D
	for <linux-hardening@archiver.kernel.org>; Sat, 22 Oct 2022 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiJVCG3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Oct 2022 22:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJVCG3 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Oct 2022 22:06:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357C229E9B7
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 19:06:28 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso1786729pjc.0
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TiUp4piOdBE0maAv9D6j0EmLO5rQgO8m+x9nCI9z2U4=;
        b=PD/UGksFkaEjjFdUVP6cQJdDtfIUa1SAjIa3OtMSoP0WdQKcPjGO4ZS3lMnyE5e5jR
         gHCjntt2Pb8yo17eqJh1+kPLAT3UYAlcdOkL+mHEo+xNgpgDB2p+6I9uQVC6KwBVua95
         ECg0oGVmL6lNc/JCFRTDllWlcfu2E2oSgaOeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiUp4piOdBE0maAv9D6j0EmLO5rQgO8m+x9nCI9z2U4=;
        b=LNXYgHQ8xPS98GOogzy7koUzcLeFF9hSagy/nWohjnN6ZUS5NxWwmvUJk/NYaaH+b8
         pdDIFRolViJAajl8OYTczhgYDMKVtmKT/4oxw5jz9wcObtW7KUcLqALSgNl9+2UY3EBv
         8rFvR0S9pLyIG/QbYpuMuLLntNHYhLNKranBwoaRbyjLUK/pZmrz0xEsZyGkWq/cdoJP
         Ua85T95GBcYAOBc4QndCMS7vZghuSAddqnX1E4LWelE20riUuHfzu+10x4yxtvuBz0ik
         CEwhK5Wmsq/wyTQfmzVrDwtZLNHJ+h/dPZPa+9//QWGllOszFVgyuN7mAoxySsPQyGJc
         I7TQ==
X-Gm-Message-State: ACrzQf1o/DhtFAZBKfw6+M0hjSFAbtYumVr4gZXMtWA6jhVco9gupFa9
        ABj3h6BVbaSqPtG/tFxgLsswFeP4aoGfkQ==
X-Google-Smtp-Source: AMsMyM74+HSsSGycWSt36x33weY8oc9gA/0sU5ilwCgdlRRmLo/cBpSnJmMHYpOgVqwyf+1EjpM2Rg==
X-Received: by 2002:a17:90b:4d08:b0:20a:6861:352c with SMTP id mw8-20020a17090b4d0800b0020a6861352cmr25403550pjb.225.1666404387745;
        Fri, 21 Oct 2022 19:06:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z11-20020a170903018b00b00172ea8ff334sm15500193plg.7.2022.10.21.19.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 19:06:27 -0700 (PDT)
Date:   Fri, 21 Oct 2022 19:06:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bnx2: Pass allocation size to build_skb()
Message-ID: <202210211853.99AE1276A4@keescook>
References: <20221018085911.never.761-kees@kernel.org>
 <20221019170255.100f41c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019170255.100f41c7@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 19, 2022 at 05:02:55PM -0700, Jakub Kicinski wrote:
> On Tue, 18 Oct 2022 01:59:29 -0700 Kees Cook wrote:
> > In preparation for requiring that build_skb() have a non-zero size
> > argument, pass the actual data allocation size explicitly into
> > build_skb().
> 
> build_skb(, 0) has the special meaning of "head buf has been kmalloc'd",
> rather than alloc_page(). Was this changed and I missed it?

Hm, I'm not clear on it. I see ksize() being called, but I guess that
works for alloc_page() allocations too?

build_skb
	__build_skb:
		__build_skb_around:
		        unsigned int size = frag_size ? : ksize(data);

So I guess in this case, this patch is wrong, and should instead be this
to match the ksize() used in build_skb():

diff --git a/drivers/net/ethernet/broadcom/bnx2.c
b/drivers/net/ethernet/broadcom/bnx2.c
index fec57f1982c8..dbe310144780 100644
--- a/drivers/net/ethernet/broadcom/bnx2.c
+++ b/drivers/net/ethernet/broadcom/bnx2.c
@@ -5415,8 +5415,9 @@ bnx2_set_rx_ring_size(struct bnx2 *bp, u32 size)
 
        bp->rx_buf_use_size = rx_size;
        /* hw alignment + build_skb() overhead*/
-       bp->rx_buf_size = SKB_DATA_ALIGN(bp->rx_buf_use_size + BNX2_RX_ALIGN) +
-               NET_SKB_PAD + SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+       bp->rx_buf_size = kmalloc_size_roundup(
+               SKB_DATA_ALIGN(bp->rx_buf_use_size + BNX2_RX_ALIGN) +
+               NET_SKB_PAD + SKB_DATA_ALIGN(sizeof(struct skb_shared_info)));
        bp->rx_jumbo_thresh = rx_size - BNX2_RX_OFFSET;
        bp->rx_ring_size = size;
        bp->rx_max_ring = bnx2_find_max_ring(size, BNX2_MAX_RX_RINGS);


-- 
Kees Cook
