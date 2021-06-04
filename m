Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BA6C07E94
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 08:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D165861411
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 08:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFDIrQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 04:47:16 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:41801 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhFDIrQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 04:47:16 -0400
Received: by mail-lj1-f170.google.com with SMTP id p20so10552635ljj.8;
        Fri, 04 Jun 2021 01:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8qje2jMT9k/yWcqfBZuQl0YlsfGCuFmFF0ZAae2cfIA=;
        b=KOXWEob0hERH0Y0+StGplaqUt60wSGg+aqansgO/OyDXDzsC0XFHoEXfxKfj7uzmpc
         7u4l5kDjjfVj0NIoW/TM64rCid5hMr4EzA4QMQ+hjlgwXaamzzl+iQnB284hethUcyJz
         KxHKDrI7yJxJjd9VklowlZMky6JUjwimfB8kxKt/kuHPZ8uZfTj9JxReDkrLxWAxqWld
         y0M7rZqfg/ftFfPkoRFHOSa/LdTFyYzBxPhCeTIuBE+rkqQDoyDs/weXTkeyVh92u9s0
         1TqqvckhMoFwe3/2H0vWUjJSZpoANH8NhpGs+lPizHTVjfQXpNPTckbuXNdZFv3J26Ft
         sRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qje2jMT9k/yWcqfBZuQl0YlsfGCuFmFF0ZAae2cfIA=;
        b=A8x9njMFDWTuTn1nqFqCfCCrYWQ3Fe9xQWmEKUTP2OZTl5lyjUnrscUQJNNsESAx36
         sHURH3BHK31JQVDvZBdGuFh93JpVxwNdc7m4SuKsDPgvV077pWVFZ1EKpZIPznLRf0k+
         yeW7QqWYkvb32d+UQczW9S4LdbZp6LRhtebYpl2HFsOWyvRDxlcQ2m6jeb9/Sp21wpKm
         xESOm9BLurqtciOulymDAK7iYQUifJCbgvUpw1PY19Oi4T++5xK5VFwrBZXFP7dYCFg+
         gvLOJRdsAcVApZcGxq5g2Dv/H9xmdDQTy8TYPSFQXuVG9NtCi6x3nkqpgEF8My9PEFV4
         DpmQ==
X-Gm-Message-State: AOAM5339WB50Rh46+eLDdUvGiNzk5KbuoZSGZDxAUuRup1TVG94tjPYi
        mIabWzsNaexImgQlqqu2ZkyD1Eyy8uvsow==
X-Google-Smtp-Source: ABdhPJy+1611WuPZMiE8gnObgiAWxRMGON1e8gtOn+PqjM9SDqSc3QyxqFiQ9cR4G4V4w3QmvAEGOA==
X-Received: by 2002:a2e:9f4c:: with SMTP id v12mr2596710ljk.176.1622796260789;
        Fri, 04 Jun 2021 01:44:20 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id 26sm550657lfr.184.2021.06.04.01.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 01:44:20 -0700 (PDT)
Subject: Re: [PATCH v2][next] ASoC: ti: davinci-mcasp: Fix fall-through
 warning for Clang
To:     Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210604072714.GA244640@embeddedor>
 <a0452dc7da2c46e3e764bdd5fd9b94dc96d96912.camel@perches.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <4c217782-21e5-b408-0fb9-f0a2c5b31591@gmail.com>
Date:   Fri, 4 Jun 2021 11:44:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <a0452dc7da2c46e3e764bdd5fd9b94dc96d96912.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 04/06/2021 10:53, Joe Perches wrote:
> On Fri, 2021-06-04 at 02:27 -0500, Gustavo A. R. Silva wrote:
>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>> by explicitly adding a fallthrough; statement.
>>
>> Link: https://github.com/KSPP/linux/issues/115
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>> Changes in v2:
>>  - Use fallthrough; instead of break;
>>  - Update changelog text.
>>  Link: https://lore.kernel.org/linux-hardening/25941c37-6e38-88ae-3afe-4f5af44380d3@gmail.com/
> []
>> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> []
>> @@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>  		break;
>>  	default:
>>  		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
>> +		fallthrough;
>>  	case -EPROBE_DEFER:
>>  		goto err;
>>  	}
> 
> While this is OK, perhaps the below would be clearer and a more common style
> as it doesn't intermix default: with logging output and a case label.

True, this looks even better.

Acked-by: Peter Ujfalusi <peter.ujflausi@gmail.com>

> ---
>  sound/soc/ti/davinci-mcasp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index b94220306d1a8..1059a696ff90e 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2305,6 +2305,9 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	ret = davinci_mcasp_get_dma_type(mcasp);
> +	if (ret == -EPROBE_DEFER)
> +		goto err;
> +
>  	switch (ret) {
>  	case PCM_EDMA:
>  		ret = edma_pcm_platform_register(&pdev->dev);
> @@ -2317,7 +2320,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
> -	case -EPROBE_DEFER:
>  		goto err;
>  	}
>  
> 

-- 
Péter
