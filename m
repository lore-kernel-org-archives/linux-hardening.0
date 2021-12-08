Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BA4C433F5
	for <linux-hardening@archiver.kernel.org>; Wed,  8 Dec 2021 05:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhLHF1k (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbhLHF1k (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 8 Dec 2021 00:27:40 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A18C061574
        for <linux-hardening@vger.kernel.org>; Tue,  7 Dec 2021 21:24:09 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l64so1081841pgl.9
        for <linux-hardening@vger.kernel.org>; Tue, 07 Dec 2021 21:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jN21r6OJSTFsgj9r64Hh1jCiMPIix6wU4qgpRwHwfG8=;
        b=hMsTpPd8gWi3Ujy3PvMKm2AhRb2ML1jyzMuE/erpda/1/AF+rUNIald/GfGViq/tLd
         o2y4W8cc2ICUanBvcqepDNezWtTFgQCoX+Qfcc5GqmL6Bn1U9t7Lny66rM704bugnGTq
         9X3HvHzswrV2tjhfCa9a4cA09icmI/vCPfxNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jN21r6OJSTFsgj9r64Hh1jCiMPIix6wU4qgpRwHwfG8=;
        b=Cf2c2S0muT29su4ExupSnmn5FpjyTz/gKMm4pHeGrlfnB8tK1KnskpMBFUTydz9IRv
         kcfF27AFeIigH8wm5PAmXFOXV8Qcy9a3y+/tVhdH+A3tRrcGid4Ky+jpjoQ2KZUPsteo
         FAGqOjlGUW40py6md70t3D2GbKZ48st1UhuKG+OS3Wk1/CLfUdcytf3QEAFBxmbJ12Sw
         SfRbHUKGkA/PvxcFykt6lGwAGN/Kerv8uLBYWp/PwkzFIrbAy+s3lVhLZexa3h0uXz4i
         Z0Njs7N1GFT5bWDXLK+H0DfZfQ6AH05ptBlqAv1AWgvfY2reVZW57wdmLASGx07ovVtL
         6VeA==
X-Gm-Message-State: AOAM532JIPkDFdBFzD6hsceMReax5Hkp7GrX/9IyZDl/uxidpPIwqzqf
        2LQ2cWwLacT9vUqVVVZWXJpYcw==
X-Google-Smtp-Source: ABdhPJzlHAKuLFlj8TFLJdbJpyf/D+l9/UBbiFuXowho3aLkJt0awiY6BtPP69mJOwjO/M528bBz0w==
X-Received: by 2002:a63:8148:: with SMTP id t69mr28164809pgd.79.1638941048615;
        Tue, 07 Dec 2021 21:24:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id md6sm1202665pjb.22.2021.12.07.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:24:08 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:24:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: huawei: hinic: Use devm_kcalloc() instead of
 devm_kzalloc()
Message-ID: <202112072124.16F7CD13@keescook>
References: <20211208040311.GA169838@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208040311.GA169838@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Dec 07, 2021 at 10:03:11PM -0600, Gustavo A. R. Silva wrote:
> Use 2-factor multiplication argument form devm_kcalloc() instead
> of devm_kzalloc().
> 
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
