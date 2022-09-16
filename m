Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BAAC54EE9
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Sep 2022 13:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbiIPNbw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Sep 2022 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiIPNbu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Sep 2022 09:31:50 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894E872FC1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 06:31:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so16257799pjk.4
        for <linux-hardening@vger.kernel.org>; Fri, 16 Sep 2022 06:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KgBYor1Htf/vgvjRNDzZz0OSBXCS1g2qA2z8v/wMsdQ=;
        b=duV1RS8TM2EGZ6omH4ubcEo80bgH2kyZd5qyDXZXa3PhTBC8+KG+to4g1PhL106fEN
         2Ce5cVmi6xX3gbz38EE8qox07VoXA4Av+FZJ80wWOZ6UV6i5CZqldo0nA14gKiagdGWT
         bAcrvdodiN1cfiDHSyxQittJvsK3g6HcGnXF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KgBYor1Htf/vgvjRNDzZz0OSBXCS1g2qA2z8v/wMsdQ=;
        b=JTFL7/8lgLdSdFL2ikQcYeVt8dbGaFM8Su8IVgNaVk4KaKN+aJzwFAqTixFXxCT2jo
         +VqONxGBiPik/y5h2/3+tBkiR1sQwWPI8fIShzCFuSoTeZXGzzh1MgkelQw5QcGdaJS1
         DR0Q0+f+Xk1eECTWgtdgIMJh9lBTvEhQt8hXWh6NzfSon39DjlI7vojM+kfr2N+OQ41T
         iHIVbIYVhgXOxvqKW3zm6I+Em7TJGvxamgzKJ4QXiBOVjOgGYLD/rBsJQELqfS/YMxGZ
         8jpOKyQmVM4Kj6bNhcKz34/Dae9VrSXgO14m3D08+S5n4bEv7G06e7ATK0DB3Rk2HdBx
         L06Q==
X-Gm-Message-State: ACrzQf3+9JGukfKF88L7X3ib3X3qaSa5Iy0oTSa8tk8OTq/dAkZh9F9Q
        alPn52Lm63Oi6gm69v574JFxS3bi/cYAPH3q
X-Google-Smtp-Source: AMsMyM7bICOZH0WwwuU7fNoFf+LgOTWBrxWtoTyS+ATZwpycmOgrlRhY8fZfiOYOKBnDvxk46dEb3g==
X-Received: by 2002:a17:903:110f:b0:178:8756:6e5e with SMTP id n15-20020a170903110f00b0017887566e5emr938412plh.12.1663335108874;
        Fri, 16 Sep 2022 06:31:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s15-20020a63524f000000b00434acf7a05fsm13723090pgl.45.2022.09.16.06.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 06:31:46 -0700 (PDT)
Date:   Fri, 16 Sep 2022 06:31:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: harden i2c_mux_alloc() against integer
 overflows
Message-ID: <202209160630.CF7AE9708D@keescook>
References: <YyMM8iVSHJ4ammsg@kili>
 <YyMt2cWtHC2SeG62@work>
 <YyMyKQnWgu0SL6jj@kadam>
 <202209160101.2A240E9@keescook>
 <YyQyfaI0WCsQ8F48@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyQyfaI0WCsQ8F48@kadam>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 16, 2022 at 11:23:25AM +0300, Dan Carpenter wrote:
> [...]
> net/ipv6/mcast.c:450 ip6_mc_source() saving 'size_add' to type 'int'

Interesting! Are you able to report the consumer? e.g. I think a bunch
of these would be fixed by:


diff --git a/net/core/sock.c b/net/core/sock.c
index 4cb957d934a2..f004c4d411e3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2552,10 +2552,11 @@ struct sk_buff *sock_omalloc(struct sock *sk, unsigned long size,
 /*
  * Allocate a memory block from the socket's option memory buffer.
  */
-void *sock_kmalloc(struct sock *sk, int size, gfp_t priority)
+void *sock_kmalloc(struct sock *sk, size_t size, gfp_t priority)
 {
-	if ((unsigned int)size <= sysctl_optmem_max &&
-	    atomic_read(&sk->sk_omem_alloc) + size < sysctl_optmem_max) {
+	if (size > INT_MAX || size > sysctl_optmem_max)
+		return NULL;
+	if (atomic_read(&sk->sk_omem_alloc) < sysctl_optmem_max - size) {
 		void *mem;
 		/* First do the add, to avoid the race if kmalloc
 		 * might sleep.


-- 
Kees Cook
