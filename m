Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F5BC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Oct 2022 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJMGfl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Oct 2022 02:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiJMGfi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Oct 2022 02:35:38 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9486012503D
        for <linux-hardening@vger.kernel.org>; Wed, 12 Oct 2022 23:35:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso739174wmq.2
        for <linux-hardening@vger.kernel.org>; Wed, 12 Oct 2022 23:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ad6t0uqGWVJ44zoze6OqxJ+0EbFaaFeDJhLvuHxelJE=;
        b=gDZTDHiBofgyauaDwnqK6zQAfw+OCNIJIPu9vPc6qja1dciBLmpAgCFrjGifJ1s081
         P5s/9/i2Uvqtg7QkdvDS1tgNDfIIeAR/O1MfLpY0tqsAnBxjRF6rk8Ywrv/Slxs8QJIv
         Mk2koqyyZomyZ1/zXgAPOss4Y8V8uPPN9tQLtGzFfyIAUJ2Xoa/AaHlPE+n16XjSgvkA
         6ykhLRpdN5b+M6tLQilm4nxYWeCwi1yxqQpM9X8OEpyhpJgkeLXfvfjuGvMnpD5ZGA9A
         R6O8joG3vQB5klrMm7t5m+xDYhVBG63zkT7KYRYt0qoi+3pMuABV7FNKwQJc9kGGThCb
         BV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ad6t0uqGWVJ44zoze6OqxJ+0EbFaaFeDJhLvuHxelJE=;
        b=dA99LB5gBZr9e6wwC6quI7TbsX1+TsttO5R0mAWpmMwVeEiCkm7nRaH3QtPgvK8OLK
         BJAkDQLyDeuhIIYNzX4mZg/gjOkfkMPddes9xmzmms4TNJRMtr9zu/cslut27sIG1Kl2
         jh+whdJSzvz9oC4ZqDuVINvGYNxdKsttZJ494h0xuHD6Q7Q1SnEC7eOOqnL3g910Isgp
         I6VPrrA1SGPZwSBplWB9yP8+Dh9dvvL6qWBjhlsM3NHtXWAVVjj4FwePmjHNyRMLs3id
         BZU5beSFGQt9hdVPvHxYff3XxKqpmhnmb75mpIxOK7G02cc4kLh6loQISEcxYcEoy8+H
         veFw==
X-Gm-Message-State: ACrzQf1oC0NWvT0wGOBjZ93kD5Evu6y2Duej1z8+A8R8sV63YG8Js9s1
        rNabE1tpgSM6cW8bs0mh7OCeKw==
X-Google-Smtp-Source: AMsMyM7PeoryycruOSk5MAIFALAVpRMJZCn11Lyo/I45FavURextDXrWr/zktLQ2xOhVoujOtdzxoA==
X-Received: by 2002:a05:600c:548a:b0:3c6:dd03:2d31 with SMTP id iv10-20020a05600c548a00b003c6dd032d31mr1275616wmb.95.1665642933077;
        Wed, 12 Oct 2022 23:35:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:cb49:9049:c0a5:d695? ([2a01:e0a:982:cbb0:cb49:9049:c0a5:d695])
        by smtp.gmail.com with ESMTPSA id az12-20020a05600c600c00b003a62052053csm4263521wmb.18.2022.10.12.23.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 23:35:31 -0700 (PDT)
Message-ID: <53df94fe-3a86-fa27-c32c-3177bc7080df@linaro.org>
Date:   Thu, 13 Oct 2022 08:35:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     kernel test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221012185234.never.936-kees@kernel.org>
Organization: Linaro Developer Services
In-Reply-To: <20221012185234.never.936-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 12/10/2022 20:53, Kees Cook wrote:
> Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
> Sparse:
> 
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
> drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> drivers/firmware/meson/meson_sm.c:206:9:    expected void *
> drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> 
> While here, fix this warning as well:
> 
> drivers/firmware/meson/meson_sm.c:85:24: warning: Using plain integer as NULL pointer
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/202210122023.zF56nCzM-lkp@intel.com
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-amlogic@lists.infradead.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/firmware/meson/meson_sm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
> index 77aa5c6398aa..4efde225a580 100644
> --- a/drivers/firmware/meson/meson_sm.c
> +++ b/drivers/firmware/meson/meson_sm.c
> @@ -82,7 +82,7 @@ static void __iomem *meson_sm_map_shmem(u32 cmd_shmem, unsigned int size)
>   
>   	sm_phy_base = __meson_sm_call(cmd_shmem, 0, 0, 0, 0, 0);
>   	if (!sm_phy_base)
> -		return 0;
> +		return NULL;
>   
>   	return ioremap_cache(sm_phy_base, size);
>   }
> @@ -167,7 +167,7 @@ int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
>   		size = bsize;
>   
>   	if (buffer)
> -		memcpy(buffer, fw->sm_shmem_out_base, size);
> +		memcpy_fromio(buffer, fw->sm_shmem_out_base, size);
>   
>   	return ret;
>   }
> @@ -203,7 +203,7 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
>   	if (!fw->chip->cmd_shmem_in_base)
>   		return -EINVAL;
>   
> -	memcpy(fw->sm_shmem_in_base, buffer, size);
> +	memcpy_toio(fw->sm_shmem_in_base, buffer, size);
>   
>   	if (meson_sm_call(fw, cmd_index, &written, arg0, arg1, arg2, arg3, arg4) < 0)
>   		return -EINVAL;

Thanks,

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
