Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141CFC7EE31
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 17:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjFAREQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjFAREB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 13:04:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437D19A
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 10:03:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2af1ae3a21fso15825931fa.0
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 10:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685639037; x=1688231037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YeRop+arriZ7UdvwwhE4N9ZGmbHPO/xTT9fOwXQpOkY=;
        b=k/qSN6OeuKTgmjm2VQJlEF1J3DLAwD0B4p+PSxCObDuBvpNbdpsYPmcNTgH40KYe6v
         mPhJc2M4gV5V/9dgbTABivKVANmYWJs2ZL3lxPwmRZ0xEj+oDZCn3AHVdBkaHUrzzjsA
         gno807vSLGBBgcyzDDnwpsjvCkGxzbhLSHqhTV3TWAfne0L1OXE3gPfiQZBvH+vVlYYr
         rNvowUHDsAVp0B1KbhwObSEmJDaszXxwCCtkfGE00zoUZoPc6UDxkoEWjrwIkGmd2bqL
         ikZJoQNO07ERr7TEPTyWH45IbkxquyfvtrwHg+LbE8U+NNDhsY+SBoqnacmmBSxdIVhg
         5GOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639037; x=1688231037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YeRop+arriZ7UdvwwhE4N9ZGmbHPO/xTT9fOwXQpOkY=;
        b=M+4ojBJAVgNCdGnP9V3UxVqY1ClXoz+3bvI+L8l1KyeE3IKrhKqH9QOK7TUt/zI4Jl
         5bBMX4g3agizhcQQk1kcb6AoV9Y9aYajTejpp426XsUN06J3/Srgxi+8uwaKRToBLJy3
         ydNerSXmS8Um2uCGg9JuTsT+RJ6a8ut96Fy+2vtWPkP9SgdFXXx3qPOaMdlf61k2wd1w
         QIKeHDrtiszqphk12hz0KJ/KM+BbWWDJYt6i3Hw5ZCcqHrNHYyDW1O9uXWtovbbG5Fow
         bQ/3toaxstyhdIvef6yxDF2h6WZW2HinSqimOVDi9Qc0sJxf3rojxI6ii40WX95V3K3v
         QNBA==
X-Gm-Message-State: AC+VfDygLyzklY5BIBRLGVU6xtbopaUwIEGBnQ58Fdk27WwvZr/lxOwp
        P/CADXS+l5JnsVtIO59T+zhXdg==
X-Google-Smtp-Source: ACHHUZ4JBBPfvSGvZl+nxl1n+jULzCxri9dMsTCOhXPcG9xERXqK6Tk5lOydJrZUaqkxFoZnCgRXRA==
X-Received: by 2002:a2e:93c5:0:b0:2a8:ad36:f8ca with SMTP id p5-20020a2e93c5000000b002a8ad36f8camr58566ljh.14.1685639037697;
        Thu, 01 Jun 2023 10:03:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id n21-20020a170906089500b00966265be7adsm10761306eje.22.2023.06.01.10.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 10:03:57 -0700 (PDT)
Message-ID: <6e2bbefc-b25a-e7c4-5a11-f5c2a1e1f8f0@linaro.org>
Date:   Thu, 1 Jun 2023 19:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] w1: sgi_w1: Replace all non-returning strlcpy with
 strscpy
Content-Language: en-US
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230523022023.2406955-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 23/05/2023 04:20, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89

This was already fixed. Please work on linux-next.

https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git/commit/?h=for-next&id=5dfd3c73ff81618fee0ef682b6fd7779863f41e4

Best regards,
Krzysztof

