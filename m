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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AB5C4708F
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 07:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC8B61417
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Jun 2021 07:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFDHR6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Jun 2021 03:17:58 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:42848 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhFDHR6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Jun 2021 03:17:58 -0400
Received: by mail-lf1-f47.google.com with SMTP id a2so12570232lfc.9;
        Fri, 04 Jun 2021 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hFVfJJ6Ejdu+Nc6pP4+2Kj/FAk9+HqPn9yXfhDOY5Ro=;
        b=QgkeChCIXwPltaFv0/iPA3nqsD6PxNhw++qgors9r/uV+iU/4fXeTH91YkFwM+fna7
         Voj7VYZEGnJMYqo8Q4pCU7cDDdkvw1GEjFi0ItnLj9pgve+ATxPWSuYU/r0q08XPd3As
         j/9Y1uZiR5rGOrQK4My9s3B7zSOXAa9lGgrb2L5i/vKrL/qzqlJD1jDarMC8E4zKbYLJ
         +Vo/E9UKfDoBevWuyp+sqlxBkJ7mCwiaQlBjNTqqM7AhWpe0zWprPxlAj2jaNb+SaDTa
         T78uQ0gO26GD8eKzOic9Y7Uj/sXuq00Rf7j336ebHOX838ZgTuFayaMfKXGjXuFkhZEK
         XaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hFVfJJ6Ejdu+Nc6pP4+2Kj/FAk9+HqPn9yXfhDOY5Ro=;
        b=YIwhk34asfBDCTCkH4MBKYGBD3gYOtHcoQoC3TtnGGUewVrsuOYYXH9Il085dk5a0E
         GuNebxe3DOrOzFYo+ahithF/n4RB6QU2/AIwoPQ9rkItT/xefxmKghIbf1m9xkcE2Ew+
         MX2Hf6V9XR4wUIAMfnHv2VCcekMyvI+qigCGq2XfYAEdQr1bDmPEFDvI5vRiSeWj4H5k
         OAVEjSdTuY4qjkfADJDq5jL3ujCfjEA2YWJoq7/8CBbjmr3B+UVfjGJ31AS8YtiJq+mU
         NzHiQ5rjlH89j9iTWao+MDF30WWmITtMt12uggHhEkTcFkxcjtJwmakfJwUt+ycW5jU+
         +VkQ==
X-Gm-Message-State: AOAM531LGCXlpiUMpoZG0uxUnBgEodWBHA6fy6HoJMhC/3laew29/z60
        hObKYrpwDq874UxdK5qUjex0xgt4z/A=
X-Google-Smtp-Source: ABdhPJyvLqfzFB8dyRAycRpMLE+vWsX/t92KFUNJOpadhY9cIhKj7mXAnjMuGDP62SM+NjdRU/gutg==
X-Received: by 2002:a05:6512:38a4:: with SMTP id o4mr1831752lft.288.1622790894175;
        Fri, 04 Jun 2021 00:14:54 -0700 (PDT)
Received: from [10.0.0.40] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id s16sm529885lfp.106.2021.06.04.00.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 00:14:53 -0700 (PDT)
Subject: Re: [PATCH][next] ASoC: ti: davinci-mcasp: Fix fall-through warning
 for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210528202047.GA39602@embeddedor>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Message-ID: <25941c37-6e38-88ae-3afe-4f5af44380d3@gmail.com>
Date:   Fri, 4 Jun 2021 10:14:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210528202047.GA39602@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 28/05/2021 23:20, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a goto statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> JFYI: We had thousands of these sorts of warnings and now we are down
>       to just 25 in linux-next. This is one of those last remaining
>       warnings.
> 
>  sound/soc/ti/davinci-mcasp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
> index b94220306d1a..587967720135 100644
> --- a/sound/soc/ti/davinci-mcasp.c
> +++ b/sound/soc/ti/davinci-mcasp.c
> @@ -2317,6 +2317,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>  		break;
>  	default:
>  		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
> +		goto err;

Would:
	fallthrough;

be enough to silence the warning? If so, then I would prefer this version.

>  	case -EPROBE_DEFER:
>  		goto err;
>  	}
> 

-- 
Péter
