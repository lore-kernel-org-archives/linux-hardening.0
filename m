Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670E0C6FA82
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiI0Cbk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiI0Cbi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:31:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33102D8E37
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:31:36 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a80so8461385pfa.4
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8nZXIbN6hhSoxeA85jrpj1XqgQtYm90/5xBOIy7XZQw=;
        b=kymzENvEXSDuONnNcjcukiJE0epNVw/bQHltTEdQQBXfi0YKa5ZgRgei3Ri0QtBvtB
         gD1KfBc3rHFwsQCh6toHrJDOXtEmj+10BcbZ7I7Ixbfq8axjj4lbm8U5vuQUR2t1wcIz
         wDpw7A8/1gUHvI7wlATvSLlgDbcLndRLsiqSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8nZXIbN6hhSoxeA85jrpj1XqgQtYm90/5xBOIy7XZQw=;
        b=5YfSXIzweuPDhqicDyvTWM4NzeybNVwfnUvW6QhuT3mMUu1j3mPrNEJTgMzGQPTk6A
         JBAE8ovtMurCh7lEamxIK8iGs+D/a5+Aod84ZMR2zcN+Mm9ePVcTeF9XCFuipwzvRxVX
         MZ9IFvhTUm8CQEsJ2JSubhWO96547QDWtPGeA9/e+VgU8UFpKCAEYsp2xq7tbUMHc74F
         NqA6w7rkSGfjwa8I1QvpSqjXw2SYKw9nPFla7smAUU8hgzx7kVog3maghSYm/chiFP0f
         cu2mjcqjjcqFUODg+A2rUSHd+gZA828ddnbFo1SsRK1rKsgb1kBCYXOyf1aVPF9QbgQd
         XxHg==
X-Gm-Message-State: ACrzQf1RtE9Mnzo22K9b/f/omm6PkJRulYHjgCReU6sBCUhYjrPTa8tz
        d84bPgRX6rSTYrzn/JwEheTLnA==
X-Google-Smtp-Source: AMsMyM6eMvXhe7PCuMmkzb3M2roJ/MH7CLj4Tl0C3ZXBMacwANpDN1xmAMunCUxF+nBSpEERnlWRFQ==
X-Received: by 2002:a63:1b4d:0:b0:439:db24:a3a6 with SMTP id b13-20020a631b4d000000b00439db24a3a6mr22845733pgm.539.1664245895671;
        Mon, 26 Sep 2022 19:31:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mm10-20020a17090b358a00b002005f5ab6a8sm7189316pjb.29.2022.09.26.19.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:31:35 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:31:34 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] netns: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261931.6EECD99EE@keescook>
References: <YzIvfGXxfjdXmIS3@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIvfGXxfjdXmIS3@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 06:02:20PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/225
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks! Yeah, I tripped over this one myself while testing
-fstrict-flex-arrays.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
