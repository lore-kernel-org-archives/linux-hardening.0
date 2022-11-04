Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3913C433FE
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 18:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiKDSah (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 14:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiKDSaf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 14:30:35 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9440478
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 11:30:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id i12so3769851qvs.2
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4f+TdJBplqLaGWi6pUvjWe3lL/EBFsiI/nvCrQqglxE=;
        b=Z/9JIxp3NxduGud2z6d1et/+w8JnP82OYOKiXQYW5HfoYzwXG7js4MKh2xg1/N8ziZ
         3aC0xew1zqZB0EN41h1ziv0rxWgskGxEokspDw41Ic1zeUuNvgInc165WZLn5l2eFi2x
         UnSizrSFngMhsVG6p6EtgJceu/N5KeAipKbM+F9e+m0LknanKZ0blpqnKGzi8o+s+x+E
         Q5x+TybEaKpwf+kyXDVRiphCjE0zYQpKAmtN22iPlTGDsWVc/VPI9bQCWoo6iiXjW+2N
         UJYQQJcZ8WPWnaDA+eZZ6qhQligO940s3X8Eyv0atsA/uYHiLZbML1ZSK6nqfJ7j3rig
         IfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4f+TdJBplqLaGWi6pUvjWe3lL/EBFsiI/nvCrQqglxE=;
        b=eO4ImXjFhrQOO2WRon5+epVd+RJPfEZrbbCx2TGsuGgDnQ1Ri7N8y7/3braUPj9RDZ
         hYfuSI6T/U7HymxJ+xZr/Dqu4jVe//lA6Cc7G2xlKV9MC8uiKxIeRd9ogm/X3CfpaNn+
         acDhGWGTZnvP+b3VQ0o/aAb1nTuxfqGlnE+f7jRpAJbGc6ynoZm3gASmjC9AjD6J2h6K
         ADfI+aRpTGzMiIK5eAGcoTAnMSx/auNdF3xyw9eSNdUro+E8B2QVPL8jHRTRp3AyiAo0
         4puHs8Nxsc6dp8MAQBQ6/YnEgar364XkcscTstUmrextp+82JqH+LbI+jPMNno4Zu5yt
         MfBg==
X-Gm-Message-State: ACrzQf3MOzRVx466IQtP+E9gk6snEQ7PP0WFn56TCSQ9/6vyWr5GBri1
        XICeZSVTAB0+F5PDzxGtdrIxNg==
X-Google-Smtp-Source: AMsMyM42APJRgy/7d00EwleDNtgqG3xbZHxlWN420O/pdIjc8qyAuxcbEbcos0UMsFf2CP/4XTpJgA==
X-Received: by 2002:a0c:e3c7:0:b0:473:7d9a:6237 with SMTP id e7-20020a0ce3c7000000b004737d9a6237mr33006251qvl.37.1667586632993;
        Fri, 04 Nov 2022 11:30:32 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:aad6:acd8:4ed9:299b? ([2601:586:5000:570:aad6:acd8:4ed9:299b])
        by smtp.gmail.com with ESMTPSA id fz27-20020a05622a5a9b00b0038b684a1642sm2470qtb.32.2022.11.04.11.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 11:30:32 -0700 (PDT)
Message-ID: <7e36e932-7dfb-bb0a-71fc-3f622d9b8f14@linaro.org>
Date:   Fri, 4 Nov 2022 14:30:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 4/9] dt-bindings: soc: qcom: qcom,smd-rpm: Use
 qcom,smd-channels on MSM8976
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
 <20221104172122.252761-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104172122.252761-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 04/11/2022 13:21, AngeloGioacchino Del Regno wrote:
> Like MSM8916 and some others, MSM8976 uses qcom,smd-channels and not
> qcom,glink-channels.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

