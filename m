Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5061C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Jan 2022 23:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348041AbiATXeE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Jan 2022 18:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239239AbiATXeD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Jan 2022 18:34:03 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E6CC061574
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:34:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id h12so7761498pjq.3
        for <linux-hardening@vger.kernel.org>; Thu, 20 Jan 2022 15:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W8u4xvb9YGTbkR+XB2tficjJLp06bXV9VHY3GrFF5AU=;
        b=kjnvRURd0d5x4xaHgLsQrLQFFTt+6yuhoqo3w1AgYdyRqMIxqjqTk1Abi+NnFy1KoR
         2S/bTBbPiE9z6gFVosCCBEaPqyADyS2hQbiyxp7FMquiOAB+5EulTVKKnC8kTYEy/OuS
         8YIa2ev/7/gxr61vJa9wq41lGpWwuDmLHruro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W8u4xvb9YGTbkR+XB2tficjJLp06bXV9VHY3GrFF5AU=;
        b=JjyQAH89PyG17XwParpDI+AMhHDLohCjwFb3HKyIFur2/WgJJKbRiOD/kQ+xxpq/xz
         zaXIc5M+2/oJpuEhA3X4aG3ffcXOxas6ANNpBidcbhb6v7BjCg00eIWcFrsto4ehf+ZM
         VOPnzi1FSVTxDm9ua/wPps6OrrglXVO5zhoRbrgRCMxvOnEscniUq/H5hzuiGuDff7wG
         vAlj4Mq90/gYC25OQIzv0SZJZp+FcMRBTuRDpwx7jEBcjO4N3i1W770+FlZmNHatNovb
         A+/wesafVm480AVfyUJOlKt5fssgM1F0H5ojOLsHwxsAlKEh2iGZy6iVOhvU5lrIlgaC
         PQIg==
X-Gm-Message-State: AOAM530hPPYjQczZih8Wiy9ETb+hdx9BjGOPXsHHSz92LGKAj++it1BY
        CEF5smma0CuxyxfzI96bKdeTmLyaupQpJQ==
X-Google-Smtp-Source: ABdhPJwU4q/RhAzX8q32y3IhhvwpRjOdIOJmRH0cShdwRxJhGaw2bCqB3Cy8q1CLWCJ0I+0xU8z7EA==
X-Received: by 2002:a17:90a:4305:: with SMTP id q5mr13751808pjg.222.1642721643308;
        Thu, 20 Jan 2022 15:34:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm3168035pgb.85.2022.01.20.15.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:34:03 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:34:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] NTB/msi: Use struct_size() helper in devm_kzalloc()
Message-ID: <202201201533.975AD386E@keescook>
References: <20220120230247.GA40182@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120230247.GA40182@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 20, 2022 at 05:02:47PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/ntb/msi.c:46:23: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Heh, the variable was even named struct_size. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
