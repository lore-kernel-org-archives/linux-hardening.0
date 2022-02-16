Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4DFC433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 16 Feb 2022 20:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbiBPUee (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:34:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiBPUec (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 16 Feb 2022 15:34:32 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768692A39F0
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:34:18 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id p23so3133867pgj.2
        for <linux-hardening@vger.kernel.org>; Wed, 16 Feb 2022 12:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dUD1O3o1ifOwlrT9wCiI69FVgZyS7G64yh4bIznkTt8=;
        b=cToYCa4Q9YzpuQ8hWjqhI9GAV7hdMX5zFfA045ME9Esgzb7iXXOnP66rLDTpXnUrsH
         ZXAOBQjk3+lTbLD8wwG/XQjRIHof/WW7ZnfXUIQbSGmHV1myOfuF1iJY07seXS5BUgSt
         UWRna5Sk/M3/2NaZ6zLnXSYBj4DI3P+O7+ly0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dUD1O3o1ifOwlrT9wCiI69FVgZyS7G64yh4bIznkTt8=;
        b=E7RsMv5yKjiF0uC4cThsxAq8xHtG2S0EmyNT6R3ahfHFpZ1ty/mXCmeF3RVrQLBwNl
         /t7oJkH59FIlDU4YnHF/vEUCzk1Fz+Q3rRuME5gyxuR750D320TpM4w1aXG43+ke3OoV
         WbpGbwII4wdk7xV8Eor8SK29waYEVEhyHIU9fZ54cCDKp2edZE5mo2Ov2P7EStMeEheT
         2iSgU0ECsn9GihDQyyH835yoilq83M26hib2oHrFw+PQqsEaNiJ0CGMHHkRAwV7NmtUi
         ndHIucH707pDUKYy4Usoy4EFcSoB4Nua9IoEwm9o6Bn76G33czT4lcOlIxJ+2zyVc2SE
         f91Q==
X-Gm-Message-State: AOAM531dMrvfGRTzYl/0M1YIwqTWRxmmz07Ei2r7viZxwS7JLAv57qes
        pS8TobFHx573GuJYissGdXTY2Q==
X-Google-Smtp-Source: ABdhPJxQlIx/zpkn6DzwhHmBHxoQ/aVVFwDrNfFlAwdVpmL8Xx2laM6IKnYH6S9ktvf3oiVfYtmAgA==
X-Received: by 2002:aa7:8d08:0:b0:4e1:5fb5:b15 with SMTP id j8-20020aa78d08000000b004e15fb50b15mr4799283pfe.70.1645043657895;
        Wed, 16 Feb 2022 12:34:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t2sm44157008pfj.211.2022.02.16.12.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 12:34:17 -0800 (PST)
Date:   Wed, 16 Feb 2022 12:34:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ath11k: Replace zero-length arrays with
 flexible-array members
Message-ID: <202202161234.7DBAE56797@keescook>
References: <20220216194836.GA904035@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216194836.GA904035@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 16, 2022 at 01:48:36PM -0600, Gustavo A. R. Silva wrote:
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
