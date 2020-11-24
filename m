Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D8AC2D0E4
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 10:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E71D206F9
	for <linux-hardening@archiver.kernel.org>; Tue, 24 Nov 2020 10:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+OCt6pP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbgKXKsH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgKXKsH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 24 Nov 2020 05:48:07 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F21AC0617A6
        for <linux-hardening@vger.kernel.org>; Tue, 24 Nov 2020 02:48:07 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h21so2375151wmb.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Nov 2020 02:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EKUHQucYeb31HOoREAkeI7Xr3ONZ6GpyN2wdl6mhvTE=;
        b=o+OCt6pPEtBp5sG9QBlJlxOlGwBf9AHPWZYEk4c7X6VYcrTixfHQQJ4Wu9kfNihKoD
         6q/QauNDpLX48kzcTChcZJ9dQt/QMcRuoWv3xKg/Pkto2sbkNiAOUuA7ImAncN6Z1r/Z
         Q0qGW2sLi8rYUnpPrXaLc8uV2UnpsRg3qhU6oushflRiEuJQX/+D4g8bpNEjxb7ViBQK
         imQoXnExp88Bid1lhoSl5EQfYPnlkGp+nXSKCKH5roJ7eq2rwjyFZMA/8ApqCFhSJXok
         V5I4qMlVt65Mnv89o1ATv1H6JF97Lv3/QZ82AUYYdZjVqgyvpbVVazFS4CfP/MSmw27t
         BCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EKUHQucYeb31HOoREAkeI7Xr3ONZ6GpyN2wdl6mhvTE=;
        b=ka4O611jOexzwywT6DsQ/thxVw8aY9bMXMixZb6ss9QTtxptowT/DQuIcW1eHz6maT
         uOzjP0EuP6WhIUwybQttZhiL/vv5L0GyEDjUaEPU2N0yr8Jf5bbjTPAAyLVPOFCBDdVx
         vlGf6bbO+XnYkciIbN54QNlPfOaJGdToQloe0sm8xI29YnwGGzlPRjKdWZCkl8w82XYm
         gxp/pzv9SLjJsYM41hDu6zsXQ1Sy4hPt6I1dYCM0QrPPGZNqNHYNU1BkcRtov4x9MThg
         npcadjQVdoZwgOkIbkaYOjaueQHH6Rpg1pB1e95vx0z4baBNC/8oYf/rAwEyUPW3dSu/
         M0xQ==
X-Gm-Message-State: AOAM5311S+i4gPyxJEXLqZpUXcb8G/NH4M3nBE4q/enV1dppzLsT9JtP
        JpBLASt2L0UhqrPwB9X0O0+8Eu2Q4w2oKNHM
X-Google-Smtp-Source: ABdhPJxW9BitmnI8OPwhFe6AWn0n6S/KopfpYJQ+7H/0nejHyup9DFlc3ZwLIY+7GWtngQ1AqVs7lw==
X-Received: by 2002:a05:600c:2886:: with SMTP id g6mr3790149wmd.110.1606214885516;
        Tue, 24 Nov 2020 02:48:05 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id e6sm4810310wme.27.2020.11.24.02.48.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:48:04 -0800 (PST)
Subject: Re: [PATCH 126/141] slimbus: messaging: Fix fall-through warnings for
 Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1605896059.git.gustavoars@kernel.org>
 <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <794916c9-30fb-1202-ec26-9abf750886dc@linaro.org>
Date:   Tue, 24 Nov 2020 10:48:04 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <08a882fa7a3145bc33bc02392df8319e95092dcf.1605896060.git.gustavoars@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 20/11/2020 18:39, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---


Applied thanks,

srini

>   drivers/slimbus/messaging.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
> index d5879142dbef..f2b5d347d227 100644
> --- a/drivers/slimbus/messaging.c
> +++ b/drivers/slimbus/messaging.c
> @@ -258,6 +258,7 @@ int slim_xfer_msg(struct slim_device *sbdev, struct slim_val_inf *msg,
>   	case SLIM_MSG_MC_REQUEST_CLEAR_INFORMATION:
>   	case SLIM_MSG_MC_CLEAR_INFORMATION:
>   		txn->rl += msg->num_bytes;
> +		break;
>   	default:
>   		break;
>   	}
> 
