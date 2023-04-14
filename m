Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E368C77B76
	for <linux-hardening@archiver.kernel.org>; Fri, 14 Apr 2023 10:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjDNKo6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 Apr 2023 06:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDNKo5 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 Apr 2023 06:44:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808AD210C
        for <linux-hardening@vger.kernel.org>; Fri, 14 Apr 2023 03:44:55 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94a9606518cso293896466b.2
        for <linux-hardening@vger.kernel.org>; Fri, 14 Apr 2023 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681469094; x=1684061094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=99/2Xzq1k3jGcxmT1pTlyb+0p5jdof1SmGadkZ956E8=;
        b=gjpb92BJlyi8AdRk2tXb6yIbRjNjmhPIjGoUt2NuU0q+EpYqyo3wONGmRD1PvavfsD
         3EMTmNpcRpfwkCowxOmjE+xlw7lf9vxOMlVAldE5s1EDeZcUPR4udR2V5FXv/lVgTU/a
         OIKwB7dOGs+wSZw6Cv/dE8mXplb70MkLuDyhswOglpMEgRd9GkBuewhN+8oaW9urSnNk
         rKYjQlFyRam2rXBVRQZ6Hu1fxxH9VWK5AxxvWPXVeGNQ6evxRnM3DaWxY1slE9kzT2ir
         iyKN3Ql0FWU47U5IFa9tz4j3s9ROVKl37k+PnvumIYZONanbc84xGAnXCMu7sZw2fMv3
         kpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469094; x=1684061094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=99/2Xzq1k3jGcxmT1pTlyb+0p5jdof1SmGadkZ956E8=;
        b=SA+dY/SgWjNj7OmV+G0PATF7tEirDCapRXml8g9tW5MS/2H6qIQqSvc3O9OLHo094G
         Z9hOyjM27UkuYT3TxqtdKOKjqL0h6y1K5VpvTT8BNfmXv/JnuTN5quuMh9tWwe62VYsC
         3+zDYCK2qRJOM1T4/rXM3VQxYPYxcLCFp+5jZ5shPgZYHe1+FfgdrgPnVHG52XJNcQa2
         TBhMOtNVTNKtt8Eg1LBbNLss2hxrMzMM4CGSOe3wBGWatlBJeq8jfbD7dlrGog6jq7N3
         vJyaQKT6K+hOQJNoNoNzA7nkG8xBBn8QcYaELZhEZ1vchSfCoYPukgLQZXh3rTbuGKS5
         oCSA==
X-Gm-Message-State: AAQBX9figA+7r7xv86ixIghubRqF71rDow9JYqfR/ya6OETngG1wXyxx
        joQiYhE79z/ruw1tTzjdFVDETw==
X-Google-Smtp-Source: AKy350YAZ4ObREDPTqX+3sDjKddkzxLRFtcc0tjO/9BvuuaM+s0ApmwT+Uw7xC7rJqvbc3fYPtVPzQ==
X-Received: by 2002:aa7:c04f:0:b0:504:aae4:a034 with SMTP id k15-20020aa7c04f000000b00504aae4a034mr5907943edo.31.1681469094005;
        Fri, 14 Apr 2023 03:44:54 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o24-20020aa7c7d8000000b005067d089aafsm1003061eds.11.2023.04.14.03.44.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 03:44:53 -0700 (PDT)
Message-ID: <6c01d2fc-3155-0dcd-f473-9cbd75dd69ec@linaro.org>
Date:   Fri, 14 Apr 2023 11:44:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/6] remoterproc: qcom: refactor to leverage exported
 minidump symbol
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-7-git-send-email-quic_mojha@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1679491817-2498-7-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 22/03/2023 13:30, Mukesh Ojha wrote:
> qcom_minidump driver provides qcom_minidump_subsystem_desc()
> exported API which other driver can use it query subsystem
> descriptor. Refactor qcom_minidump() to use this symbol.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   drivers/remoteproc/qcom_common.c | 13 ++-----------
>   1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
> index 88fc984..240e9f7 100644
> --- a/drivers/remoteproc/qcom_common.c
> +++ b/drivers/remoteproc/qcom_common.c
> @@ -94,19 +94,10 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
>   {
>   	int ret;
>   	struct minidump_subsystem *subsystem;
> -	struct minidump_global_toc *toc;
>   
> -	/* Get Global minidump ToC*/
> -	toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
> -
> -	/* check if global table pointer exists and init is set */
> -	if (IS_ERR(toc) || !toc->status) {
> -		dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
> +	subsystem = qcom_minidump_subsystem_desc(minidump_id);
> +	if (IS_ERR(subsystem))
>   		return;

Sorry If I am missing something but I got lost looking at the below code 
snippet in drivers/remoteproc/qcom_common.c


-------------------->cut<-----------------------------
	subsystem = qcom_minidump_subsystem_desc(minidump_id);
	if (IS_ERR(subsystem))
		return;

	/**
	 * Collect minidump if SS ToC is valid and segment table
	 * is initialized in memory and encryption status is set.
	 */
	if (subsystem->regions_baseptr == 0 ||
	    le32_to_cpu(subsystem->status) != 1 ||
	    le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
	    le32_to_cpu(subsystem->encryption_status) != MINIDUMP_SS_ENCR_DONE) {
		dev_err(&rproc->dev, "Minidump not ready, skipping\n");
		return;
	}
-------------------->cut<-----------------------------

where does "subsystem->regions_baseptr" for this ADSP minidump 
descriptor get set?


--srini

> -	}
> -
> -	/* Get subsystem table of contents using the minidump id */
> -	subsystem = &toc->subsystems[minidump_id];
>   
>   	/**
>   	 * Collect minidump if SS ToC is valid and segment table
