Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D514EC47083
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 19:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD8A613E9
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhFBT5p (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Jun 2021 15:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFBT5p (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Jun 2021 15:57:45 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D9FC06174A
        for <linux-hardening@vger.kernel.org>; Wed,  2 Jun 2021 12:55:46 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 6so3162874pgk.5
        for <linux-hardening@vger.kernel.org>; Wed, 02 Jun 2021 12:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lKbsKx/CwwAJJJ3AtTHNwIW7e/uQT1ru3Qvh7qWozN4=;
        b=C36W36k/YR2ljUGOFpoAKJFu5nQRxby9kwvSxtfLb/imsjGhqUGlv3F7O+9oJ1ptCn
         qp96ZY07ns1fQnEsEV2LkXkYfcb7fBVAZaySltRccEhLmzqDFQ2Sia+DJX697iwh685q
         XSqIR3hZ7Vl4SEUNGZlCvM0oRpLKSGJYyzqWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKbsKx/CwwAJJJ3AtTHNwIW7e/uQT1ru3Qvh7qWozN4=;
        b=gIsZNkQwXIxOdo2X67/TV+35B4rVCqLK146504HsX1OgRaR2RwiAjnBmeyxt1gC6Ng
         82DOTZH1XvIXw62VjO4fkMq7munmByv7RYCMLW1a6Ni5b8MxknoFUih8/hbJ5EsxTYrl
         NTgJhltMEpYzOEVq4atHugxjFGkM+RY4VjNQ+VlYexx29FDz8c3uxY81vYALcqdJWoX8
         LsFVYK9/TU3iWHowbW6WgbI0ysvnkDOWLkM9LZFtfklkIiQcB/iWBaTdTq1E5iSuxgUM
         xhezmBEiBLR3eTabhItCLdm3HuH04IC+0I3oI49GvlU5HFd4uzJWWrwKMCnUdMTOkBcW
         wzzg==
X-Gm-Message-State: AOAM530EuFMFHV8fBhL2njtVHu3COOkaJ91vWuoS02thQuHaMRL/jSvu
        vkc5c8NDCMJRyyOpJhQp0VVpxA==
X-Google-Smtp-Source: ABdhPJzIPKjT1TLLgSWyjmNLfEFggACWHy09QcHyBfeSTF7lHho5w9YuPL/W/+D2tvDivWu+TScb3Q==
X-Received: by 2002:a05:6a00:d41:b029:2db:1549:219e with SMTP id n1-20020a056a000d41b02902db1549219emr28795898pfv.71.1622663745490;
        Wed, 02 Jun 2021 12:55:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r135sm355480pfc.184.2021.06.02.12.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:55:44 -0700 (PDT)
Date:   Wed, 2 Jun 2021 12:55:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][venus-for-next-v5.14] media: venus: hfi_cmds: Fix packet
 size calculation
Message-ID: <202106021254.39A1561075@keescook>
References: <20210601184616.GA23488@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601184616.GA23488@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 01, 2021 at 01:46:16PM -0500, Gustavo A. R. Silva wrote:
> Now that a one-element array was replaced with a flexible-array member
> in struct hfi_sys_set_property_pkt, use the struct_size() helper to
> correctly calculate the packet size.
> 
> Fixes: 701e10b3fd9f ("media: venus: hfi_cmds.h: Replace one-element array with flexible-array member")
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> BTW... it seems that a similar problem is present in
> https://lore.kernel.org/linux-hardening/20210211001044.GA69612@embeddedor/ 
> and that is what is causing the regression. I will send v2 of that
> patch, shortly. Thanks.
> 
>  drivers/media/platform/qcom/venus/hfi_cmds.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 11a8347e5f5c..c86279e5d6e8 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -27,7 +27,7 @@ void pkt_sys_idle_indicator(struct hfi_sys_set_property_pkt *pkt, u32 enable)
>  {
>  	struct hfi_enable *hfi = (struct hfi_enable *)&pkt->data[1];
>  
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);

I think this should be "1" not "2".

(i.e. there is a single "data" item, followed by an entire *hfi (which
starts immediate after data[0]).

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_IDLE_INDICATOR;
> @@ -39,7 +39,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
>  {
>  	struct hfi_debug_config *hfi;
>  
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);

Same here.

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_DEBUG_CONFIG;
> @@ -50,7 +50,7 @@ void pkt_sys_debug_config(struct hfi_sys_set_property_pkt *pkt, u32 mode,
>  
>  void pkt_sys_coverage_config(struct hfi_sys_set_property_pkt *pkt, u32 mode)
>  {
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2);

This looks correct.

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_CONFIG_COVERAGE;
> @@ -116,7 +116,7 @@ void pkt_sys_power_control(struct hfi_sys_set_property_pkt *pkt, u32 enable)
>  {
>  	struct hfi_enable *hfi = (struct hfi_enable *)&pkt->data[1];
>  
> -	pkt->hdr.size = sizeof(*pkt) + sizeof(*hfi) + sizeof(u32);
> +	pkt->hdr.size = struct_size(pkt, data, 2) + sizeof(*hfi);

Also 1.

>  	pkt->hdr.pkt_type = HFI_CMD_SYS_SET_PROPERTY;
>  	pkt->num_properties = 1;
>  	pkt->data[0] = HFI_PROPERTY_SYS_CODEC_POWER_PLANE_CTRL;
> -- 
> 2.27.0
> 

-- 
Kees Cook
