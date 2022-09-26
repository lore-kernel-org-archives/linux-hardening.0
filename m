Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281A5C32771
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 22:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiIZWAy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIZWAu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 18:00:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E701D70FB
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:00:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q9so7742420pgq.8
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=+ZEMgKZ50aCDjQK68MSGFBCexnl9R3k5e5W2Tro3RWg=;
        b=fT38y1rOWTApfMEBjCgOn+LCoJfBghe/FDgFowftaeDO4tVznkuBwLIPkzDxuMmfu1
         MgaBR9oig2qy8w6PV7ea9JgluQBhB+QBkH2sYw8+imkgqruS0mJh0HXofXKM/RnPWZcP
         vSiKGqcczjqIX8/E8qIY/PaBX7yXfkZAJumsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=+ZEMgKZ50aCDjQK68MSGFBCexnl9R3k5e5W2Tro3RWg=;
        b=JnWGeb/xjj8I2S6OpjDpH/ltRYU8BjRwVAcTj4byxhZ/OSSRi3iDGKuxCtZ/ZJnO1H
         PY7E+hUtCRXsKfLz8yh+7CU1jAI3PPQY3fCaCOIbo/oNswoB+ZlDeuLmDCyd/g8Qfsk4
         cgDjBGPAtw7CjzvQXM4gAOmW1WxNRzUsgK5mHnLZYr0URRB2ILtqw3M+H0uEsj9XUe+y
         rHDzFhp0EHUmMLA78nCQo3IVX5QGbf+RsPjqyBB6Ypjzsbd+R9hSyUsZFqYGclzllqDt
         eeYk8r5pYF2rBDev6aB4wbeZjqGCVGSC7Q9HmizG37dVhHq+A4jRTeCByZC9t8uXAkUm
         iwjQ==
X-Gm-Message-State: ACrzQf3hq5HyoGKHN3kMC/XylVeQlsazw485vqi+6BC559fou9ETlNUB
        ecW6+g8LlCuui9nk2gUymjdszw==
X-Google-Smtp-Source: AMsMyM7kXAcWDr5781Na6ZCbqCa+1IKpuvbiKuMQr7jAwzaYb8SX5lYFg3nTy86MYmKaq1Xy5AVdWg==
X-Received: by 2002:a65:6cc7:0:b0:42a:4d40:8dc1 with SMTP id g7-20020a656cc7000000b0042a4d408dc1mr21904988pgw.321.1664229643966;
        Mon, 26 Sep 2022 15:00:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id mn5-20020a17090b188500b001fd66d5c42csm7021210pjb.49.2022.09.26.15.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:00:43 -0700 (PDT)
Date:   Mon, 26 Sep 2022 15:00:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] bcache: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261500.5A71026@keescook>
References: <YzIc8z+QaHvqPjLX@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIc8z+QaHvqPjLX@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 04:43:15PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/213
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
