Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A203AC7EE23
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 12:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjEDMgB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 May 2023 08:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjEDMf7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 May 2023 08:35:59 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47314618C
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 05:35:56 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc3088b7aso782444a12.3
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 05:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683203755; x=1685795755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qMm9zCgjmjqNBT9qCeY66Oq88bASTTs9Y+/BD6bZYEs=;
        b=FAui2AqzZXpJO8prSuWYpbOdwOoBt1DM86uMzzlBJNjubAbUVJLjz68SIWf+1DNjMT
         D9pRsLdjCNNy8X+dlyzybOLQdiH/anJx6wADdOhvlnpdFbvXPrKZWnrvikegyPfacnld
         t+AqJgnnucN1HQq3Rz900vQDddW1T0P7qkS2VuauOZ9n7uvBAm5Ason0sf/q6Z21LNfB
         2hT5sfWpXOCQGYLAB1RERoLKl+k11XMPvG9ovvNL4JrwzNyl99UI/SnH4ugY7mQAFN09
         OimEVhL1S3DfgIdX42zSK2wpQJ86qZTvG/Wvm6xMnkHf0ABXgBOiYbZcYwz1mkOi/gsZ
         ZEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683203755; x=1685795755;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qMm9zCgjmjqNBT9qCeY66Oq88bASTTs9Y+/BD6bZYEs=;
        b=M7Cqde4RcBP4G0TPokk0dMk75dquVbFTUQZztSrS9wnDWUsowNkh733y174hBUr1mg
         Z0DNo9Netklg6YGwyvR2gxWrbujeWl34xSjTWrslXyGwEuX+Cspweaz+wBRIraeSIf6W
         EpAyNd/dlYfAQa19lWdKxuh35qKrJIXvthNMQ5OdZZxl4oKLSETUQshYGBZwvIIMd9Tj
         6dSBwqc7YlD96fZBf78OuYZQyJFAdUyN9g5HtNIFnFMWDrTGla3pXlMD680GHN6qmGSF
         +E9hmi/8X6AvcuIflb3IqIrn4L4QMvsRQe8wini7jZr5lObff2XMVGGTpkj00wc9oL9j
         dITQ==
X-Gm-Message-State: AC+VfDz95cj0J+R3wkoo/TYBnkJvcQiSKupNELcId7YKH4JBDP8RcWnV
        axsM1I6CbrLbXYgwq+AUX4ZfdA==
X-Google-Smtp-Source: ACHHUZ4ePHckfpUMq7oTFQIk9Sgbk5MDYXHYzVoBUcorr/dy7jEqin2VrXavka0/Elf5F2FDEMGK+g==
X-Received: by 2002:a17:907:7290:b0:953:9899:d9c1 with SMTP id dt16-20020a170907729000b009539899d9c1mr6609952ejc.1.1683203754788;
        Thu, 04 May 2023 05:35:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:cbf1:e7ef:fb81:e912? ([2a02:810d:15c0:828:cbf1:e7ef:fb81:e912])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060e1200b0094f3338129asm19010078eji.141.2023.05.04.05.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 05:35:54 -0700 (PDT)
Message-ID: <e963d4a4-4159-53ee-1008-4bdec8b48268@linaro.org>
Date:   Thu, 4 May 2023 14:35:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 01/18] remoteproc: qcom: Expand MD_* as MINIDUMP_*
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
 <1683133352-10046-2-git-send-email-quic_mojha@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1683133352-10046-2-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 03/05/2023 19:02, Mukesh Ojha wrote:
> Expand MD_* as MINIDUMP_* which makes more sense than the
> abbreviation.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>  drivers/remoteproc/qcom_common.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index a0d4238..805e525 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -29,9 +29,9 @@
>  #define MAX_NUM_OF_SS           10
>  #define MAX_REGION_NAME_LENGTH  16
>  #define SBL_MINIDUMP_SMEM_ID	602
> -#define MD_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> -#define MD_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> -#define MD_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)
> +#define MINIDUMP_REGION_VALID		('V' << 24 | 'A' << 16 | 'L' << 8 | 'I' << 0)
> +#define MINIDUMP_SS_ENCR_DONE		('D' << 24 | 'O' << 16 | 'N' << 8 | 'E' << 0)
> +#define MINIDUMP_SS_ENABLED		('E' << 24 | 'N' << 16 | 'B' << 8 | 'L' << 0)

You remove it in the next patch, so no, don't touch the line for trivial
cleanup and immediately remove it.

Best regards,
Krzysztof

