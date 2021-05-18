Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FABC433B4
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 01:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9DA613B9
	for <linux-hardening@archiver.kernel.org>; Tue, 18 May 2021 01:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbhERBpA (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 May 2021 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbhERBpA (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 May 2021 21:45:00 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18039C061573;
        Mon, 17 May 2021 18:43:42 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id f8so6383001qth.6;
        Mon, 17 May 2021 18:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VDEfHlmjhOJt3nhxPPEyRnbv69jWXQnDs7QGgGPn30I=;
        b=HxLWjbf4YnmukKbdgbNfuTL3hy2jd5drR5Nix7BP7A/0n6ypJ1Yh4Id38fpB4Ub9Hs
         VbUd5Ala73cfnGBHmsoPFuI+W3hlcOcSOQ56VvA6wPCtGB9aF6lD2n8k0idrzcDUMi7y
         tikxgNZMTNE9L2q/oJq70aib3HtrKmdnP2jytIHm/L0o+ebdkcj9kTF1Yr+hf9mCJLQL
         vg3fKdhYGkGNrhME5YzVvLW9QcohT21zGcE9g6dB6C3If/Va4Nt1b1B87KQYbKOuRCAi
         OJDPhWxUEAU2cJtsG+inZMvgsr6Z0IReFOCl7I7Ua16+5UBEyYVG8/SdUW5Xs3r8RlGy
         vGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VDEfHlmjhOJt3nhxPPEyRnbv69jWXQnDs7QGgGPn30I=;
        b=orbnU+1L8atpwKC/VjoltVLE4MhbfSFzr8nocanOqBt2TDuiUyNqjd+KHqqidfL3/R
         uRzdg0y+kItXBfIeOBgrwVK7Gmny7nGkb+9yPo/oqNEVSk5RO/01qJj8dAXtTjrOzEAV
         fvqMKpqxxCHZaRcuoiZMuFyM9nsdsYppSC3WZElc8uwsM2CBYZTTDZ+P/8a0RgNht16F
         TUiSduHLGdriM0k+WOFGWDjSxCyrGwu6z9MDGme4Su+8yL51bqfVBaxfhVe4xEIUdID5
         BLe8SbGShHnfa6nXLX6l/n97icRR4XJw/T7zkH8AtVVFaJHijj5s6pMlm4Axx0iHwvys
         67kw==
X-Gm-Message-State: AOAM533WdDRF3BhsmqzTCBmGBjn0OfSOvzSZ+XMXXTXk5B3K+cc892bb
        wAHwCX5G03RL98ZK9VLOHrA32PAOaew=
X-Google-Smtp-Source: ABdhPJzeA021cDl4Llgxn5JSeqjsknucA9KObWeuK3ZsLLaJaQruUsiV4EeF8e+SWn0FUowV/Tet9A==
X-Received: by 2002:ac8:5a4c:: with SMTP id o12mr2376485qta.121.1621302221018;
        Mon, 17 May 2021 18:43:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m4sm12539041qtg.21.2021.05.17.18.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 18:43:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH RESEND][next] hwmon: (max6621) Fix fall-through warnings
 for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20210305095258.GA141583@embeddedor>
 <20210306031847.GA192807@roeck-us.net>
 <1bd99c46-730e-ee56-96e4-c87f69488f49@embeddedor.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <563d33b6-981b-8297-fb70-97de738d1688@roeck-us.net>
Date:   Mon, 17 May 2021 18:43:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1bd99c46-730e-ee56-96e4-c87f69488f49@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 5/17/21 5:45 PM, Gustavo A. R. Silva wrote:
> Hi Guenter,
> 
> On 3/5/21 21:18, Guenter Roeck wrote:
>> On Fri, Mar 05, 2021 at 03:52:58AM -0600, Gustavo A. R. Silva wrote:
>>> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
>>> by explicitly adding a break statement instead of letting the code fall
>>> through to the next case.
>>>
>>> Link: https://github.com/KSPP/linux/issues/115
>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>> ---
>>
>> I Acked those, thus assuming that they would be applied through some
>> other tree. If that is not the case, you'll need to let me know. The
>> resend only means to me that whatever tree was supposed to pick it up
>> did not do it, but it doesn't result in any action from my side.
> 
> If you don't mind, I'm taking this in my -next[1] branch for v5.14.
> 

Ok with me for all.

Guenter

> Thanks
> --
> Gustavo
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/log/?h=for-next/kspp
> 
>>
>> Guenter
>>
>>>   drivers/hwmon/max6621.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
>>> index 367855d5edae..7821132e17fa 100644
>>> --- a/drivers/hwmon/max6621.c
>>> +++ b/drivers/hwmon/max6621.c
>>> @@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
>>>   		default:
>>>   			break;
>>>   		}
>>> -
>>> +		break;
>>>   	default:
>>>   		break;
>>>   	}
>>> -- 
>>> 2.27.0
>>>

