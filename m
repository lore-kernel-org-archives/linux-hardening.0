Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A411FA3740
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Oct 2022 12:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiJaMPu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Oct 2022 08:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiJaMPd (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Oct 2022 08:15:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7216EF03C
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 05:15:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bk15so15651131wrb.13
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 05:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/xC60NFpQ8YiUuB73hd07wpqDOiKDqftBq/Nx+H0pc=;
        b=fLMYr0IzN+j5ZLN9mtXN9uJJUIP49EtbGy0L7BzxzxfAv7ClE9S7ZiGhCYhG6RPvYS
         htxa6rB78K9oCKyQTQNcRoEXElyZ1cZOPhd/2o13OoQ0/mnCcnz86/FhIpNG15qn/nQg
         UFa/4+D/jb/CriyhNedgnsEdC/fOQD67VnQrAE4J5NKGxyt8CIHVeh0WzZMmnLOTmJjX
         9nU/9K0FjtdkXyBVRfDoxHtHylhk0a0MBFLPW61c/GtbYz0TgvxNBuuuKIWdF9Sge3qd
         sb10Re26rBwv0wbHI34qqn85oGxXjHJCTZldYN0hfAauukeSWGW5g5/bU4I7XiX5MbvD
         ktlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/xC60NFpQ8YiUuB73hd07wpqDOiKDqftBq/Nx+H0pc=;
        b=KGQQ3/VD+MhZhzvwSVxMxNdjb6rAeTh2TMWjbXPLy4EyvCtMt2ZhUta1DdcBGP5y76
         Isb0UbVzVtPpTMEeIonqNcOHcTMYsjkFi6+Y4YAgp6i//clDOsnloan89dfWLeiNoNoM
         Z406iDpVh1cOVvFsWd3lYLxBuj1fGzduV04o4E6Ha35SwLcOcfkIZL3qygNxh/BNHGHA
         vVTCmvw8vQJc+rSpcKZE+OYWHfejItzpsm01EUKGd0IAeXeBch8OiqCIqccdsnAdZ6dR
         NhWFT51Hd0g5iMgDYXyqQl3nCTlvBQR1KlPT3NdR5J7B4gucW38KuHXdXE1pWn3ojfGT
         1OJQ==
X-Gm-Message-State: ACrzQf3XwPdHYD70pde/cLoHHO7IJNxozTrTyqyLKtHNE3X0zFUjgDv+
        0z/NnCKVyLSTOIyhjKFU0Wk9/w==
X-Google-Smtp-Source: AMsMyM4Papbz7gmenhcGeWRLHNTGBU6j8IWT5TkhsU5QNi/FZqmEM15BTTwaCqYZhCnykGo8Tpdl/g==
X-Received: by 2002:adf:9c87:0:b0:232:a0fb:ea5f with SMTP id d7-20020adf9c87000000b00232a0fbea5fmr7895835wre.473.1667218525020;
        Mon, 31 Oct 2022 05:15:25 -0700 (PDT)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id bl19-20020adfe253000000b00236576c8eddsm7006730wrb.12.2022.10.31.05.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 05:15:24 -0700 (PDT)
Message-ID: <6f976e6b-9e00-f6ce-fb95-7b7a21183b5d@linaro.org>
Date:   Mon, 31 Oct 2022 13:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] mips: boot/compressed: use __NO_FORITFY
Content-Language: en-US
To:     John Thomson <git@johnthomson.fastmail.com.au>,
        tsbogend@alpha.franken.de, keescook@chromium.org
Cc:     linux-mips@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20221030183647.3371915-1-git@johnthomson.fastmail.com.au>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221030183647.3371915-1-git@johnthomson.fastmail.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 30/10/22 19:36, John Thomson wrote:
> In the mips CONFIG_SYS_SUPPORTS_ZBOOT kernel, fix the compile error
> when using CONFIG_FORTIFY_SOURCE=y
> 
> LD      vmlinuz
> mipsel-openwrt-linux-musl-ld: arch/mips/boot/compressed/decompress.o: in
> function `decompress_kernel':
> ./include/linux/decompress/mm.h:(.text.decompress_kernel+0x177c):
> undefined reference to `warn_slowpath_fmt'
> 
> kernel test robot helped identify this as related to fortify. The error
> appeared with commit 54d9469bc515 ("fortify: Add run-time WARN for
> cross-field memcpy()")
> Link: https://lore.kernel.org/r/202209161144.x9xSqNQZ-lkp@intel.com/
> 
> Resolve this in the same style as commit cfecea6ead5f ("lib/string:
> Move helper functions out of string.c")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
> not sure about the fixes tag:
> compile error only occurs due to the fortify commit, but it looks like
> this change could have been part of the other commit identified in the
> message: lib/string move helper functions?
> ---
>   arch/mips/boot/compressed/decompress.c | 1 +
>   1 file changed, 1 insertion(+)

Typo "__NO_FORTIFY" in subject.

