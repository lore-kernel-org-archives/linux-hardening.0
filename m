Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7B8C38142
	for <linux-hardening@archiver.kernel.org>; Fri, 27 Jan 2023 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjA0UFx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 27 Jan 2023 15:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjA0UFg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 27 Jan 2023 15:05:36 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5587267C
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 12:04:33 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso6101104wmn.5
        for <linux-hardening@vger.kernel.org>; Fri, 27 Jan 2023 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r1CU7qs7ci6NugYBeu8CzattYoOdRVuz5zL8aur1P60=;
        b=Mm2jA5KxFIWo7aNPEy44ZDeqkSJgdzJRFF4hMgAT92AbLpAwTVsBeGdTv1UHqguKqa
         9eOp2BQtWrcyxDs3AsjF84IlsvEGMvsuSDQy09FzI8TD/3ml+eYfTUSzBqNOPqZpGYpc
         B05eyi2ofn3i49XDFraE1eP6bJEy8Gto/zhUf+YJNCxPNpxkIidqpXrpTgDF4tE+DzXW
         zjeWftockjGChXgadHbAW5uCnN/G1upgR8iTSyvAZsRAQXa1IztvGeDc6laZontO/JHb
         61KXrO7QoTSHDjkg/9n9MmpyyMbHKwPl8uECSE3bglFtSuN1n5Newpgy/VgruTSKHUUZ
         vsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r1CU7qs7ci6NugYBeu8CzattYoOdRVuz5zL8aur1P60=;
        b=CWL6CKuW1kC/vJjJGyLVhtMKgl9DNrbNqJEPqYrxH5xF+v0pQkHXp2JSiAqh+ExWcb
         MGj6qzVEMM82yeGbWQfcScmLsN0BDDk6REG6xCWOLdspMh5epRrYp+GQWvtXSZQhh0Im
         x4ra2Bv69M5W6N6rN1Rgx1WJemEtWDfN34sassD2ulZ7DmR1Q/8fgHsrNtVTB1zEBEAp
         O0aL+54FdG8snS+1mbcImcRfsQq6inO5uIlqtOMoGwF8L5WjP6s0yUX3+l1hMTy9hFck
         2qF52zvq3gGwN2ygYZUk/hgKAKOVPrmMol7sTnALRB00SxPUX6heUakmkSI4xF509daA
         W5JA==
X-Gm-Message-State: AFqh2kqPmev3lHbFhD4+GMGI91/Rr7fEMwrbovA7uIZzkHy0mhZ/xmYk
        xhfB//aI/4guZbDcBQaL9GMSUQ==
X-Google-Smtp-Source: AMrXdXuUC1aSXuKkr7M4Gd98nMnWPuhZvtnLNQK0yVg+I3rnfvlzneSHpw/KEIPtB4X7B1IQiyEKrA==
X-Received: by 2002:a05:600c:331d:b0:3d3:591a:bfda with SMTP id q29-20020a05600c331d00b003d3591abfdamr48236179wmp.27.1674849872256;
        Fri, 27 Jan 2023 12:04:32 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y3-20020adff143000000b002be546f947asm4817532wro.61.2023.01.27.12.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 12:04:31 -0800 (PST)
Message-ID: <10097835-30fe-bbad-6c95-e5ec9dca3e2e@linaro.org>
Date:   Fri, 27 Jan 2023 21:04:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/2] dt-bindings: ramoops: Inherit reserve memory
 property
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1674835252-31954-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 27/01/2023 17:00, Mukesh Ojha wrote:
> The reserved memory region for ramoops is assumed to be at a
> fixed and known location when read from the devicetree. This
> is not desirable in an environment where it is preferred the
> region to be dynamically allocated at runtime, as opposed to
> being fixed at compile time.
> 
> So, update the ramoops binding by inheriting some reserve memory
> property to allocate the ramoops region dynamically.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>

Drop. There is no single need to store automated output of
get_maintainers.pl in the git log forever. It can be easily re-created
at any given time.

If you need it for your own patch management purposes, keep it under ---.

Additionally:
where is patch number 2?

Best regards,
Krzysztof

