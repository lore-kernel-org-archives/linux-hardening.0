Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE93AEB64DA
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Jun 2023 15:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjFVPcK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjFVPbw (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 22 Jun 2023 11:31:52 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655912D5E
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 08:30:36 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7748ca56133so67427039f.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jun 2023 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687447834; x=1690039834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=it9RfQZoHvlt4i7NjPP7j9e/je2l7GBneNbO1SZ/LaE=;
        b=U5QSUgYjwQQ92kt5FvG2tHnBkSv+41vonZTo2+NgsxvSzPMREYwFv0DYVpKWYIpaL8
         hQ/HAFNBnaXvk6X/CyCoiUHw5gjsRRxY50FmAlTKZ/emXYrpEVf7uLYBROR566vmxy+A
         QgidH1OlYIsWAkj+9lIjD34UBJASmPJGNLLwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687447834; x=1690039834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=it9RfQZoHvlt4i7NjPP7j9e/je2l7GBneNbO1SZ/LaE=;
        b=VPXtMML1c+8poeGBC0igh8a4XbQMPt6ahM3kMdG2++5I6916kYpbPx4hT8vVKVPCZg
         Y3EXmV2B2MnlhHS70gJFNfelWNK6QL0yS+kRaLoofkyqiAgMbRSq3pZJu89L4ot5HLKF
         tPMUQaWT7r9B22eGkheCXJhuHLy9n530T2a/o7W53mR/EFEIoMPu4oiyqX82ltgQII1m
         Iypq1oZZeGBiHiYAP9p0K8JgUvctL1u8aRFwB8mCW9w6svPtNlXSSv0YnU4bXc6aYfn5
         tt6CiGnn3VYcno8A0Z983sBazno5YJymJRXC0+RZ1bmEXRGO7mn40BBoV+v5RPRPLFoP
         IqWg==
X-Gm-Message-State: AC+VfDygfYgXkvpyi3yiAPMyAvFJY+YHa5dnqUq8mK4atHVPEvoQcHmM
        QTPNNYWuE35zodfNuekzOAPKGA==
X-Google-Smtp-Source: ACHHUZ6WQHNu9IShb1qUDx2kQeEQ8/k/YbNklzp5Wi6heL7ES6u5LaL8TuaW9FctaeBl1FnOkIDpvA==
X-Received: by 2002:a05:6602:3f04:b0:780:d557:1984 with SMTP id em4-20020a0566023f0400b00780d5571984mr655337iob.2.1687447834010;
        Thu, 22 Jun 2023 08:30:34 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id x4-20020a02ac84000000b0042690648930sm1746926jan.106.2023.06.22.08.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 08:30:33 -0700 (PDT)
Message-ID: <d206311e-4fe6-54b6-f591-e2c11194aed2@linuxfoundation.org>
Date:   Thu, 22 Jun 2023 09:30:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] usbip: usbip_host: Replace strlcpy with strscpy
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-hardening@vger.kernel.org,
        Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230615180504.401169-1-azeemshaikh38@gmail.com>
 <202306212010.E6CBCE23E@keescook>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <202306212010.E6CBCE23E@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 6/21/23 21:10, Kees Cook wrote:
> On Thu, Jun 15, 2023 at 06:05:04PM +0000, Azeem Shaikh wrote:
>> strlcpy() reads the entire source buffer first.
>> This read may exceed the destination size limit.
>> This is both inefficient and can lead to linear read
>> overflows if a source string is not NUL-terminated [1].
>> In an effort to remove strlcpy() completely [2], replace
>> strlcpy() here with strscpy().
>>
>> Direct replacement is safe here since return value of -errno
>> is used to check for truncation instead of sizeof(dest).
>>
>> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
>> [2] https://github.com/KSPP/linux/issues/89
>>
>> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
