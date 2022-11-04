Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47F2C433FE
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 18:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbiKDScB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiKDSb4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 14:31:56 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A11D40926
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 11:31:52 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id lf15so3326948qvb.9
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jv/VBBSPGfDMm3BuvCUb6KeKn+DQzFUitFYwYAfTSbw=;
        b=Gf4Igk3vYjYVzOdyjeQvBR+wn0fv9jCoK2u94IZ9RY/2cw8nU9sVSyVIb458qMAPtB
         HzbKuLwRjp58mdYEnl4x7a15rlRVbqpxVdbzzaPcJ+jzYgrrIoaEoCTV4xoGgJBxflSZ
         7rZwl1NRDJVbJ4lTHJfPFdiu2AQCzPsSzJ4uqwQBxHbcLR35xgeCU2WO/yzxOSo59JoK
         QYUSGpYd2BvBoRleK2z/rA5pI+DS5s3rrKXLwV3Ii1zd5AXWDJjHuO8gsHqRg0xTgmYt
         X5yDUgA7ctHYiZimR/DjS+frJl9XuI40oCizh+kuxhOmvVA4qWBXLeOmsFLWSUd3P+wo
         EJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jv/VBBSPGfDMm3BuvCUb6KeKn+DQzFUitFYwYAfTSbw=;
        b=c56cJQBsouZdiTO4mrvHYIv3JbVNEUotpraIygn8EnAP/i5PLuTW6LCvrDoylxjOeu
         LoQUgww3P/EB69rTDWFXqibjAAZne6yqvDP4WlmLx7xho84W6k0xbHQEw//8v5Ntz2Zm
         fH9wzWnfoF+nsrd0Cjt5elDTM2j0g/hof21q5hACuVmTc8y+XO7hiqwx5Zvssrr/KIFj
         AqTn4+A6l7W1ONJKprZf3njBwKEKBhOe16ymGmVB+gwdEagcssm9IGHdVRqBL9XIu8pb
         MLinROMwtf+CO2hxZ9eHh5Rdiv7l+GRZooJHaYxzHWFybkm1W9rZIGQq9AQ+bNJRfDgi
         prMg==
X-Gm-Message-State: ACrzQf2zcwjbyLvsyJWA4Vz3xASNKmx4FMqV8vNSH8jIXkrMNksSUhAe
        LQOKeaWji8XloFCXP8gFCVTvkw==
X-Google-Smtp-Source: AMsMyM6gLeFy71nSxk2gT25tUnCpxV9lEYdESGw3HGK02z1+OuPJ6eKzIpdPlsMCVsuRvg7YFgwQiQ==
X-Received: by 2002:a05:6214:625:b0:4bb:ff88:a937 with SMTP id a5-20020a056214062500b004bbff88a937mr25108338qvx.111.1667586711697;
        Fri, 04 Nov 2022 11:31:51 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id i19-20020ac860d3000000b003a5612c3f28sm2333417qtm.56.2022.11.04.11.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:31:50 -0700 (PDT)
Message-ID: <5eeb52b6-2ac6-0cf0-917b-149ba442285f@linaro.org>
Date:   Fri, 4 Nov 2022 14:31:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/9] dt-bindings: mfd: qcom,tcsr: Add compatible for
 MSM8976
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, ulf.hansson@linaro.org,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-hardening@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com, luca@z3ntu.xyz, a39.skl@gmail.com
References: <20221104172122.252761-1-angelogioacchino.delregno@collabora.com>
 <20221104172122.252761-7-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-7-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> Document the qcom,msm8976-tcsr compatible.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

