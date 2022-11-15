Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A9C43219
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Nov 2022 16:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbiKOQmL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbiKOQmK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Nov 2022 11:42:10 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9830C2D768
        for <linux-hardening@vger.kernel.org>; Tue, 15 Nov 2022 08:42:08 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u2so18268264ljl.3
        for <linux-hardening@vger.kernel.org>; Tue, 15 Nov 2022 08:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jb1svEkUmggBlpVRHrknk39IWZlG+Y0uIqQEOYSyi8=;
        b=w3GCgTOUTD0J7IW0L/hJ91pCWBJ3IwmBduHmODYjszPNbLFxeDh5/wKwrQzbQr4Kq0
         YtGAT6VzrwHcOMb5i+8Sj0vbU+Twb9VNxJSISKn1r2yRx6as4Y+kY3vazoKVnURObgvW
         ntpuceelBv+C1adAUHTFEx3vXbWdgkmRMhZVJZp393VZ0LNmbyAeBdxe8eIibe1e/34v
         y6pGrGlcOD2Hw/LMbzVXjTVk7g5e63S+gqvUMJGYM0Rw55Q+wydi6Coht0BVgBMCcsTe
         +xbyvkZ5D9kokEOZBQRvRV5sGoCPNO86Yj25VxCW1p2S5g7GKUwKFcaLCns9AJDI1oIN
         RVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jb1svEkUmggBlpVRHrknk39IWZlG+Y0uIqQEOYSyi8=;
        b=DCFyqw9TzTe7xjasJOmW++yGuqtbfo7uEYmn3JVxuTGUE06fzOTXMD94F4kXg0FKxl
         g3VvniA6uyGb7Epu7paey9YbmZyCI8Nl0gQWYFGj+PrQCQm6TeUge3Ut8FH5Swm3QX8O
         kTBmKeoubXNfQnI7AZ5wYkyUX4tsSet7PRXMxwvE0lpaV8nDWTmfVYn94WWuT84uJkil
         QkN8pjxOPBQotiY8QSR65Du+b6kyWHU50sBdgC8eg/lgcRBDocQYT0QQy7ROiRB8CB7t
         Ndybi1Iw3x7vDaolvsnG8Fj5wNIrrqdRfGEmQs01j8elL1F1iyvNuvzzGucdqBex01JO
         ZEpQ==
X-Gm-Message-State: ANoB5pn65hDCjFB3KRMidlKU4C+3L5qlAPLjkskuGDaoVPzJouGHL6WU
        nfYKenzOkTn4hKnHLMJrXngbiQ==
X-Google-Smtp-Source: AA0mqf75eymhe8iemrFEPOiuBlkfykZb27qfQ/xZRMN9Wv45n2T8ywkw2TqFyFY7j1uwmWrbhHSVyg==
X-Received: by 2002:a2e:2201:0:b0:275:a127:cace with SMTP id i1-20020a2e2201000000b00275a127cacemr6071141lji.378.1668530526951;
        Tue, 15 Nov 2022 08:42:06 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a12-20020a19f80c000000b004ac088fdfd2sm2269353lff.85.2022.11.15.08.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:42:06 -0800 (PST)
Message-ID: <b611f647-c46f-3780-c6b4-3cfb4fe402e7@linaro.org>
Date:   Tue, 15 Nov 2022 17:42:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 02/11] dt-bindings: nvmem: Fix qcom,qfprom compatibles
 enum ordering
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111120156.48040-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
> Move qcom,msm8974-qfprom after qcom,msm8916-qfprom to respect
> alphabetical ordering.
> 
> Fixes: c8b336bb1aeb ("dt-bindings: nvmem: Add soc qfprom compatible strings")

It's a style, code readability, but not a bug. I propose to drop the tag.

With that:
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

