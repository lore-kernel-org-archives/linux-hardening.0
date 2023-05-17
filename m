Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961C9C77B7D
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 17:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjEQRu5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjEQRu4 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 13:50:56 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B1BE
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 10:50:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-52cbd7d0c37so687163a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 10:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684345854; x=1686937854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zUT9us1DezRMsnLU4PSux8SpLZ48zmMBvlSSjJkncm4=;
        b=QjotMdSjQZIecoNUy/osx/x608ogH3q/xE1ordj7EdXGfExtIiozjxWLezNEvttun/
         x0j8Ew+Eskxu3YuyfNq1LQjCMKoZVu1jnkJRW/IruBQ9tArjYXLG/EFXEp/6ys4DMIPH
         +1H38AiggKVfv62qiG0zTd3sh6gpXwE47efmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684345854; x=1686937854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zUT9us1DezRMsnLU4PSux8SpLZ48zmMBvlSSjJkncm4=;
        b=jDM/cmO6g/hZ6saKWfiBoZbshJxOjXeYOHITsrPRKKPDu7IaivHlpw1WSGYe5FMuqw
         P6l6kc0arH6fAzCNb3ZoRUPByjQVe3T1ghE0KmMZUGKHpnxti5L+rokhAjrbMo1GGyGE
         dGRaoZBXWyf8/lT+39qAnS9DIZYHg8g6va7Q6EiMQmiIF0UwYeTkx7L5/0QyS/39Pg8d
         q0RCTjiZxBNAOvYj8ukkqtbdYeTrpfU13SduUmeDkkJCJmW46HrkSOkKGJKgzhlAVbku
         6W3B4TGL9eidQYbW0CdWx1j54rQwQl3f8QO3YlZRYniE0oLaqZMdDAmQ4ZB1/OVVuYOg
         RuNw==
X-Gm-Message-State: AC+VfDzc1m9CM/21DSNkI9cy+kIGpS4kwYVPykCM843Or78MklJqVACO
        0qCNrPEn1euhG0Un+SO67L3Tyw==
X-Google-Smtp-Source: ACHHUZ5atc4t6+629ifcijOHATQmHDJlghJcNepJv1I/ddk3F3smO/swEB2POcnGNWpIegFFZScYBw==
X-Received: by 2002:a05:6a20:441c:b0:100:bee5:c80d with SMTP id ce28-20020a056a20441c00b00100bee5c80dmr44711959pzb.25.1684345854541;
        Wed, 17 May 2023 10:50:54 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b23-20020aa78117000000b0063d670ad850sm6041141pfi.92.2023.05.17.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 10:50:54 -0700 (PDT)
Date:   Wed, 17 May 2023 10:50:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-array
 with flexible-array member
Message-ID: <202305171049.9AB52166@keescook>
References: <ZGQn63U4IeRUiJWb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGQn63U4IeRUiJWb@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, May 16, 2023 at 07:03:39PM -0600, Gustavo A. R. Silva wrote:
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

Based on the other place that was subtracting the 1 element, this looks
like hfi_cmds.c:73 is an existing sizing bug that is now fixed with this
patch, yes?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

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
>  };
>  
>  struct hfi_sys_release_resource_pkt {
> -- 
> 2.34.1
> 

-- 
Kees Cook
