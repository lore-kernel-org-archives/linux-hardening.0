Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F718C7EE25
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 02:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQCLg (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 May 2023 22:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjEQCLf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 May 2023 22:11:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B307235AE
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 19:11:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so271437e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 16 May 2023 19:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684289491; x=1686881491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qaRPWIuvvo3gKtUu4wmte+gXSZRNUUE3b0hTHt7FVeI=;
        b=qcc6+LY33iYMdnoWxQl0Nw3hnx8hftcEH6+291YxF+99TCvNIgIT9Vs1tRqlgy6SLp
         NVAAkS3CXbxRYLfFun9TckrjqOY5WkGg90oS+nFoKUXPnKcFkoImqLT88o4noosnA6iU
         qQOYLKfPXE1MGARk5WcEaEUy+IdeOKExF+FbZUTSSBXsK1BHsSfUdkRwbtgvtqmZZ4c1
         Q4FdREnV9yVxHwc+GURkCulGJgftPo9056ZZ1V7LkLDQHFwZVmaZuUCqTHgzzWbLTQZv
         ZDB6FJUr67rq/Ir2IPL585KDnLh1Bnob4EgFdNDI6nrg5uB1fnKtbg4I9VoUmp18rNE4
         NGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684289491; x=1686881491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaRPWIuvvo3gKtUu4wmte+gXSZRNUUE3b0hTHt7FVeI=;
        b=CJhZnoBR2oeY8qGw2lzYzNRwKj0GRUQTQtVVDjqpFlfnQw5xB+dCkVy6w+/87d2Jeo
         tF9anypVyIwUZsbnEdj/jWP74REuHALB49iR1bRegAmL38DAPxuax8TVMIAM1DWlSKjq
         sZR5+DaESypYd6z/JSoDaoKO6QFygnDhI6PpjeWmPeC3aYXrGQwwBGeT6vF7x786oAN+
         cS1cq1Wmg9C41yXMDKHkybPMT1W/TMo6bWgiTOM4tuvkE3QsMRGCfsCsQXno7dJpmYwf
         rt2fuTgjL+E5E8glFa2L/He+bRnk5ow+oF3LTTn2RVrz+/tLwdvTv/p8N2wtEri5Ov8t
         QeeQ==
X-Gm-Message-State: AC+VfDyvoWyjzMQ5EZ+/jeUsoKaJpXP4rhWSA8BaBC1YZ4jvCvAM0ChY
        0O7OS9qB4CapmvsMK0JRALwDiQ==
X-Google-Smtp-Source: ACHHUZ7+kHgnJiIdvaT/l2mo2jQRgHMKRqrizkhRNDelJvR9JTYZeGG7PdtVSV0XIuy4BZmDR8l7FA==
X-Received: by 2002:a05:6512:11ec:b0:4ef:d482:9c91 with SMTP id p12-20020a05651211ec00b004efd4829c91mr7811176lfs.47.1684289490905;
        Tue, 16 May 2023 19:11:30 -0700 (PDT)
Received: from [192.168.58.94] (public-gprs529629.centertel.pl. [31.61.188.30])
        by smtp.gmail.com with ESMTPSA id j4-20020a19f504000000b004f25ca0be7fsm2951942lfb.291.2023.05.16.19.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 19:11:30 -0700 (PDT)
Message-ID: <8f9ca4a1-26ee-cd37-6c15-abdc832d77b3@linaro.org>
Date:   Wed, 17 May 2023 04:11:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-array
 with flexible-array member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZGQn63U4IeRUiJWb@work>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZGQn63U4IeRUiJWb@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 17.05.2023 03:03, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in struct hfi_sys_set_resource_pkt, and refactor the rest of
> the code, accordingly.
> 
> This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
> routines on memcpy() and help us make progress towards globally
> enabling -fstrict-flex-arrays=3 [1].
> 
> The only binary differences seen before/after changes are the
> following:
> 
>      17ba:      mov    %rbx,%rdi
>      17bd:      call   17c2 <pkt_sys_set_resource+0x42>
>                         17be: R_X86_64_PLT32    __tsan_write4-0x4
> -    17c2:      movl   $0x14,(%rbx)
> +    17c2:      movl   $0x10,(%rbx)
>      17c8:      lea    0x4(%rbx),%rdi
>      17cc:      call   17d1 <pkt_sys_set_resource+0x51>
>                         17cd: R_X86_64_PLT32    __tsan_write4-0x4
> 
> which is expected once this accounts for the following line of code
> at  drivers/media/platform/qcom/venus/hfi_cmds.c:73
> 
> 73         pkt->hdr.size = sizeof(*pkt);
> 
> and as *pkt is of type struct hfi_sys_set_resource_pkt, sizeof(*pkt) is
> reduced by 4 bytes, due to the flex-array transformation.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/293
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
>  drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 3f74d518ad08..7c82e212434e 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -83,7 +83,7 @@ int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
>  		res->size = size;
>  		res->mem = addr;
>  		pkt->resource_type = HFI_RESOURCE_OCMEM;
> -		pkt->hdr.size += sizeof(*res) - sizeof(u32);
> +		pkt->hdr.size += sizeof(*res);
>  		break;
>  	}
>  	case VIDC_RESOURCE_NONE:
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
> index ba74d03eb9cd..dd9c5066442d 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.h
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
> @@ -56,7 +56,7 @@ struct hfi_sys_set_resource_pkt {
>  	struct hfi_pkt_hdr hdr;
>  	u32 resource_handle;
>  	u32 resource_type;
> -	u32 resource_data[1];
> +	u32 resource_data[];
Would making this an u32* be a better resolution?

Konrad
>  };
>  
>  struct hfi_sys_release_resource_pkt {
