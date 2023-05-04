Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313BCC7EE21
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 11:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEDLkT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 May 2023 07:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjEDLkS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 May 2023 07:40:18 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E401B8
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 04:40:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965a68abfd4so66519666b.2
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 04:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683200407; x=1685792407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwcFtadppve4lv74YkqLFXuvB3xgQv6HeO3vLVBicaY=;
        b=JduoJ8Rjtc1D98/7qKXamMLBH9gdJ4lv7jY7TegUiAQlOIlOcXU9zDMJfa5P+zy9AW
         yF1WBZ6JIMXJKg+1E/eHQeBdG3ptizsU220R2ipMNJheb96qpFcinWYPd1lSbxhxxLUP
         F8fUkrUlH90G+RJPps7pKOJDs/10RRQtvPIvf9oaHkpPBNLW/8x27AbP2ZKNEjChhGw+
         NcWhL5H/xSquLxMfQm/181tvRwoTo/kjWFhIqoKWpyIWIC1NQ36JJ9QWWoEvmhRwL1O1
         0UBmSthjHsb0sKDZSZwghzMWOIzXmflw0Sw5P8txL+AJ/Dnvb/NhV+uyVpRO89rSu5hb
         f7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683200407; x=1685792407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GwcFtadppve4lv74YkqLFXuvB3xgQv6HeO3vLVBicaY=;
        b=fZBSXLi827kYcskcxwn55XC5gf7sTk/BHzEqLPNzx5gQWgCn3Z9hM1WrbVH0ThPeEL
         6EwivWpfpoQMJiiYCv7sFnTCQMphxX5idUfhm8IGeO91HrjQ35tbjLimssQlAhYTsx9H
         OcjD6VsPOZvjmgPaw8/n7Q6EGyA2UDQ0gZ0eq7PSLg5QZR6eyIPB/FsYHfqfwuRLOsay
         pHoVpDU8LEQO6apk7yaCe/aoglgoDi/V0nz3HLCEHoQn5G2JOPROtjNXhtX/YXREkh53
         hydGvyfOqIpVjm4qQoIrubIpf9P5C2qYwwKB5kfl+VcKgWKvcirUR3M8itHFZ9omvbyZ
         oUVg==
X-Gm-Message-State: AC+VfDzel1kUJL6fwUGoL39WTJG2HvuTzvHtICNR4xa/jhagwfcfXzDW
        vsC8t++AOcBhAvZ/8js20LCgRA==
X-Google-Smtp-Source: ACHHUZ4roDnjzyYHGX6UlBiuSulfpRHtIUhI9+9RXEbR2QXO/4Sbmjwk6yPogDryB0pXOelWSZFQpg==
X-Received: by 2002:a17:907:728c:b0:94f:31da:8c38 with SMTP id dt12-20020a170907728c00b0094f31da8c38mr6583700ejc.24.1683200407519;
        Thu, 04 May 2023 04:40:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id vh7-20020a170907d38700b0094f31208918sm18378341ejc.108.2023.05.04.04.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 04:40:07 -0700 (PDT)
Message-ID: <645416da-7cc7-6dd5-3db1-0d3c8d247bab@linaro.org>
Date:   Thu, 4 May 2023 13:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 06/18] soc: qcom: minidump: Add update region support
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-7-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-7-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 03/05/2023 19:02, Mukesh Ojha wrote:
> Add support to update client's region physical/virtual addresses,
> which is useful for dynamic loadable modules, dynamic address
> changing clients like if we want to collect current stack
> information for each core and the current stack is changing on
> each sched_switch event, So here virtual/physical address of
> the current stack is changing. So, to cover such use cases
> add the update region support in minidump driver.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/soc/qcom/qcom_minidump.c | 57 ++++++++++++++++++++++++++++++++++++++++
>  include/soc/qcom/qcom_minidump.h |  7 +++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_minidump.c b/drivers/soc/qcom/qcom_minidump.c
> index 6d29371..853bdda 100644
> --- a/drivers/soc/qcom/qcom_minidump.c
> +++ b/drivers/soc/qcom/qcom_minidump.c
> @@ -561,6 +561,63 @@ int qcom_apss_minidump_region_unregister(const struct qcom_apss_minidump_region
>  }
>  EXPORT_SYMBOL_GPL(qcom_apss_minidump_region_unregister);
>  
> +/**
> + * qcom_apss_minidump_update_region() - Update region in APSS minidump table.

Description of the function is exact copy of function name. This is a
hint for two things:
1. Your function has wrong name.
2. Your description is not helping.



Best regards,
Krzysztof

