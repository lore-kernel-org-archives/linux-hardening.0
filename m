Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51570C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiBPUeq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:34:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiBPUep (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:45 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220FA2A39E8
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:34:32 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id q11-20020a17090a304b00b001b94d25eaecso3465692pjl.4
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lM3wWhDpKhtMoYgQLKWR7U8Z6MzzZFEnmP4Z5wjzN+8=;
        b=lSRFGSANbEVrOokV4rWf6cpxepU41iwsUUTXoSNcl2ejVHK5f3qVLMrkCqiUNeL7fC
         ph9ue3IvWkoIU0dtUp1mjNvMcUUYIu76J3wkAg1kURrPRP0UfYvqGRFtT/0b0gK3Wfc/
         7vueckZkR33wj5J2jPADjtx7SJWKqJh/4jmgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lM3wWhDpKhtMoYgQLKWR7U8Z6MzzZFEnmP4Z5wjzN+8=;
        b=1J9Oy9dmqlBaf2SmxUf0b7YusbZblVGwDi29zNziGMr8FbQGnVUlMDBUef5dfqpYBv
         diHkt/RHMXV42RF/681vuHN2NtmVBFR90oFmzeFj7m0omb63CsDS/TI49+ZAC84CyUhC
         6lCilPblV8l5v38eZ3ZlGGDjt4uYFcZz3WRkCdd/vkJg5WpdPyMk434gqQ343awOfc9N
         eW2BzRqloZSTIMgYMmmzDQoj/pXmCZjC432RDV7fv8cTsIhVcKfmUuxLQwWZJDx/37hE
         JEN6CAgYq75Am2q5tw9bh47beDUgs4Ll1M4P33PuUVG5cSf5SH42CKdcP/fqr20KnEIW
         Oczg==
X-Gm-Message-State: AOAM532k1523aPvWSaL67vfiIai861PQe0uV7Dp2gXXbMsMbkxR1ByFY
        FeyT6MadFDtQHcvlHMycph60Eg==
X-Google-Smtp-Source: ABdhPJxmluPD0ktYlysj8vNbzpWnhJoArECRiPqpwQ+ZHzWuD6DCMhi9X2HkGTk1xwUIt7vrE8Ms6A==
X-Received: by 2002:a17:90a:9b16:b0:1b9:fda3:2a8 with SMTP id f22-20020a17090a9b1600b001b9fda302a8mr3754878pjp.198.1645043671691;
        Wed, 16 Feb 2022 12:34:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x1sm5796970pga.40.2022.02.16.12.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath6kl: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.035ED44@keescook>
References: <20220216194857.GA904059@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194857.GA904059@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:48:57PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare
> having a dynamically sized set of trailing elements in a structure.
> Kernel code should always use “flexible array members”[1] for these
> cases. The older style of one-element or zero-length arrays should
> no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/78
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
