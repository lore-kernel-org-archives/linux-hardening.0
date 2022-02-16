Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7786BC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbiBPUgB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:36:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiBPUfp (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:35:45 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3220E2AE708
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:35:32 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h7-20020a17090a648700b001b927560c2bso3491748pjj.1
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ZiuFSTUba1ATIIXLsTWrQztSTfw4EGm3xQIUgvLL4Mk=;
        b=YXjfl7xGUMOFGqUfuV8g8dqmpsyREkxR2ZgdxcoP9kPzp2YmCd3cfWw9AYwPKinBnf
         gcJwe5aFs2j51u2c3EReqPEpZ2SfOf7qXc4tnTxvI2sZZl4qjbFKLZZz/kztyyRitwg8
         YzpybCwUVrhXH9Z5tsATr5UR9Cv23DeMtqssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZiuFSTUba1ATIIXLsTWrQztSTfw4EGm3xQIUgvLL4Mk=;
        b=XmWTO1n97LlkwcHYR/TnWJom3Pfzz5RkB5Mhl+9n86GVywuh+9JcU777i7D+ZY6OtB
         c45f0tXR9/2+EjPNgWg/oqmqx/bMb5kPmXSHAAD3yOsSuIf0xWkMulHEnc92EbQlvxeA
         GXF5NdwTNwteNwWLEGZvt29hdh8BBj2ZFIwyU8lTtKHx8wI/0CezGq3ZbKfDNhGQIjaj
         W4AOI0L3gJuztwQjwIry+bPzD6Jq0Kw3Ubbye0iC4yiGy9hw/czdb8mwo6CuT5dfA1LT
         cLSRPjF0IgB8hfBQB6H6TJ8Khm7EcnFnxeyufJs4w2XHJYTYa9puzMHQZZji0Hi/fyYj
         iWtQ==
X-Gm-Message-State: AOAM531MjELFBhH3GHgs1M8O0hxCCAszJncJjy2hHNVG70dbPvqTj0Ho
        9k8Gs/z2y+D07b7lM2tg9iDV1Q==
X-Google-Smtp-Source: ABdhPJwwN7eFoWkSBD6A2li7xRKGQqNGXljyJPz1+jlWuOdkrFtGLad3asl8gm9epTBPDnceOx4M1A==
X-Received: by 2002:a17:903:281:b0:14c:f3b3:209b with SMTP id j1-20020a170903028100b0014cf3b3209bmr4129964plr.87.1645043731720;
        Wed, 16 Feb 2022 12:35:31 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm44055299pfu.127.2022.02.16.12.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:35:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:35:30 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tw89: core.h: Replace zero-length array with
 flexible-array member
Message-ID: <202202161235.0C91ED227@keescook>
References: <20220216195047.GA904198@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216195047.GA904198@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:50:47PM -0600, Gustavo A. R. Silva wrote:
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
