Return-Path: <SRS0=98sU=D4=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7544EC2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 23:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0783A24171
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Oct 2020 23:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ye5ZUzA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507285AbgJUXq1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Oct 2020 19:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507284AbgJUXq1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Oct 2020 19:46:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0FEC0613CF
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2020 16:46:25 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so2434597pgb.10
        for <linux-hardening@vger.kernel.org>; Wed, 21 Oct 2020 16:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TmQP6v1B8+/tLLxrFpMrrvi5YYx2Cgo1Q1V8lX9wCpg=;
        b=Ye5ZUzA8ULWh7+72dKcjo021B5wfIpPIjBZHf4T0IlWzexHh9IGpIgEfgYKUycsN++
         OMRXTVifteoX9sHYgJYrE9BfueoTgC5tye2p0qA9yNlMTwCGySXvzoqDMRKOPvbEWOPa
         P8btVLBF8pHER7y6ATLlAXQQdMVcIHgYa/kgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TmQP6v1B8+/tLLxrFpMrrvi5YYx2Cgo1Q1V8lX9wCpg=;
        b=ZGNCDF7jGGmyNlnZP363bdNA7pMmHgB9BTX2gVpEil2k1kzTczwTRqCFlmmPRdouS4
         QezCoU5QYlAZi19XJGL7DIwIhvZfmwpH4AvLWYF3XifM6C1POn1JvLM7zJTT4YE2uY13
         cwpHi0Of76tqyAtWRtmAJcKO9IOQCRqZgRmEtJ1dEsdS7w0krm14EYVZufIzTOs0alBM
         kGsPbrsqzpkaFRrM7IGaxx4UXP3JTYZywkgBP0QCU6Gc3SeZOHXaGEzGop04pktcEp0b
         fHDfnvKz0/sTGGCxD6y/hXFuga4mMzK9LPv0oa2bzFatkyHOcSbG9MVdJq8z6vr3USFx
         p+fw==
X-Gm-Message-State: AOAM5311ni7DAlacPKeiR/lrmSt45DuKDibrbGNtMIbVTSYG3j16bzDU
        9U9F2hQHH7wNd7woXYUNN5L3OA==
X-Google-Smtp-Source: ABdhPJzfmxGcecuNR/Int5rEj8keHJDgbQujEogTC7Raf5VSD+STg8stH24xHynfrW1Pt0KwpZuYiQ==
X-Received: by 2002:a65:4483:: with SMTP id l3mr51203pgq.96.1603323985144;
        Wed, 21 Oct 2020 16:46:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w17sm3314764pga.16.2020.10.21.16.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 16:46:24 -0700 (PDT)
Date:   Wed, 21 Oct 2020 16:46:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, kuba@kernel.org
Subject: Re: [RFC][PATCH v3 1/3] Fix unefficient call to memset before memcpu
 in nla_strlcpy.
Message-ID: <202010211646.28D4C5642@keescook>
References: <20201020164707.30402-1-laniel_francis@privacyrequired.com>
 <20201020164707.30402-2-laniel_francis@privacyrequired.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020164707.30402-2-laniel_francis@privacyrequired.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 20, 2020 at 06:47:05PM +0200, laniel_francis@privacyrequired.com wrote:
> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> Before this commit, nla_strlcpy first memseted dst to 0 then wrote src into it.
> This is inefficient because bytes whom number is less than src length are written
> twice.
> 
> This patch solves this issue by first writing src into dst then fill dst with
> 0's.
> Note that, in the case where src length is higher than dst, only 0 is written.
> Otherwise there are as many 0's written to fill dst.
> 
> For example, if src is "foo\0" and dst is 5 bytes long, the result will be:
> 1. "fooGG" after memcpy (G means garbage).
> 2. "foo\0\0" after memset.
> 
> Signed-off-by: Francis Laniel <laniel_francis@privacyrequired.com>

Looks good! (If there are future versions of this series, I think you
can drop the RFC part...)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
