Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AD4CD37A9
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 19:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjIOTxo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 15:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjIOTx1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 15:53:27 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7D9210A
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:53:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68fdd5c1bbbso1850793b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694807602; x=1695412402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CERIXMszobECCcmTb35olIeJedTz3jO0YWogNpKALzc=;
        b=k0XG+2aoqM+iN/MfW6LcKsFc1Iofq/lBwx3qPRLKj8qZ8eedBy5PZVuts7KdPhew/3
         nfPin5P6gPOoLJD3dJKjeumHylWN1FRu+2mfI4nQ3ceYLUrI1W9UiY3+d7DJpxFzgBOz
         mo94Et0y6Kj/mnHO6zc/aMTjM/um9IBEvOK3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694807602; x=1695412402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CERIXMszobECCcmTb35olIeJedTz3jO0YWogNpKALzc=;
        b=uZ9N7G6caTtbD4BqzMD0dkqgkE1/L2FbNSLlqBajFUG+zE8rc+i3DiA46RqO01iYLt
         oN3S70FktN6mxyUPgsGgwmLy/jIXyIIBtvf55OA3NhuVgyZFHneRGv2ABXm9OsDGTpZf
         fsNpRVijnNQFy6Y/z05Bpxs0v5Sd368RIRnnWBBS/Bqes/ySXR5FuBCkB9n9TfznrKrn
         0APSYI483sXgjNKfAGzjJFrc8OXPOqxcIsjDvQLovdHBaYafd1VPCKQWGGpn9vOjhGI1
         0zZXRLrnOifDgYK2qgpnF1rkNbp9Ad6NlGabHStQ1HefGWRLv1f7XdARxxuItZ8xopyX
         jMbw==
X-Gm-Message-State: AOJu0YwLnCLqLpArCCwx8vDRJB8OgnZsQgqzEJ8qtPxPc3OZpDBDKOOw
        lM7igZlsPEnZYmJAdXSgjefnjw==
X-Google-Smtp-Source: AGHT+IEPvKFh8vTTzZWluYNsudPUjGFO4rE/xMIMo+tGYyEr5KiifbvSDLT3mH3As6hXoBlLo3SNkA==
X-Received: by 2002:a05:6a00:1a11:b0:68e:2c2a:5172 with SMTP id g17-20020a056a001a1100b0068e2c2a5172mr3314996pfv.6.1694807601720;
        Fri, 15 Sep 2023 12:53:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78551000000b006878cc942f1sm3307731pfn.54.2023.09.15.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 12:53:21 -0700 (PDT)
Date:   Fri, 15 Sep 2023 12:53:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ishizaki Kou <kou.ishizaki@toshiba.co.jp>,
        Geoff Levand <geoff@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: spider_net: Use size_add() in call to
 struct_size()
Message-ID: <202309151253.844C8BFCA3@keescook>
References: <ZQSvsLmJrDsKtLCa@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQSvsLmJrDsKtLCa@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 01:25:36PM -0600, Gustavo A. R. Silva wrote:
> If, for any reason, the open-coded arithmetic causes a wraparound,
> the protection that `struct_size()` adds against potential integer
> overflows is defeated. Fix this by hardening call to `struct_size()`
> with `size_add()`.
> 
> Fixes: 3f1071ec39f7 ("net: spider_net: Use struct_size() helper")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
