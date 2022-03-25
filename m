Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D00C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Mar 2022 19:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiCYTwN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCYTvt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Mar 2022 15:51:49 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B3B14F102
        for <linux-hardening@vger.kernel.org>; Fri, 25 Mar 2022 12:37:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id j15so5849824ila.13
        for <linux-hardening@vger.kernel.org>; Fri, 25 Mar 2022 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+I5kgyO1tHgpBki5iRD8MjPGB+7NsBMCsnuZBuuE14=;
        b=MqzuSUS0yr/bPjYga/LEvUUNISlNPEafGymcHkHdDo8eBX7GHuzf6g/+kmf1KtFnxZ
         bTDwiRZWThL8Xi79vFyjF5gbvRgB1jkq42i+mjP3YSVt2Xw310TWdk6Rzk6jKRAdeDfZ
         aQEhrHQGJCIvIk+EpnbENPp1prNGxCxUVBwzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+I5kgyO1tHgpBki5iRD8MjPGB+7NsBMCsnuZBuuE14=;
        b=2vHSrEA9xf7WbdgDHjCA25XqPazbnoofQXitIzMtWwR1TnxZeYa7xuDNkxptzrrD0b
         VBNwTs4f0uFc1XAuL7q0tZ0wdLkCiUvseXj3I1jXbuA/HbarO1atzZhSH8iWgTtPiixZ
         4DW1Ur2BPnV4+ZNmjCITF8Zr+/CGwvP7n/JAGvkQj3oOSXZvMjMD+jLNbTthKPUzPNF+
         2KB0AdN8LgqJp2/dkFyBYqfw0qwBmyF+qpqZj+SkinMwBIzUly86yCylv0RZeM0+fU1h
         p5fgTGyor8W9EskEorVFJ/hT3tpjTfyW3dNWPlmFtHrNPKgHhYjb/ghlUN9Q82qEq66I
         9vdQ==
X-Gm-Message-State: AOAM531B5LazZKfC5nToB3zdY0vwL9bKYc4BBubhzNCT9q41clOGoBvX
        Pcu4ZdYu/qzg2y55R+QjOgxf4w==
X-Google-Smtp-Source: ABdhPJxOiBqtQQ67WxLOxsMZLU4xmrMIRljTj398xq62z9MSAACWfwac6+zmpEx65WXMd4V0g5PdDg==
X-Received: by 2002:a92:d09:0:b0:2c3:f141:848b with SMTP id 9-20020a920d09000000b002c3f141848bmr137372iln.230.1648237042167;
        Fri, 25 Mar 2022 12:37:22 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm3449967ioi.25.2022.03.25.12.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:37:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] selftests/harness: Run TEARDOWN for ASSERT failures
To:     Kees Cook <keescook@chromium.org>, shuah@kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220324231907.1363887-1-keescook@chromium.org>
 <20220324231907.1363887-2-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f705c381-cbe6-0862-e10f-44f2afdef24d@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 13:37:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220324231907.1363887-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 3/24/22 5:19 PM, Kees Cook wrote:
> The kselftest test harness has traditionally not run the registered
> TEARDOWN handler when a test encountered an ASSERT. This creates
> unexpected situations and tests need to be very careful about using
> ASSERT, which seems a needless hurdle for test writers.
> 
> Because of the harness's design for optional failure handlers, the
> original implementation of ASSERT used an abort() to immediately
> stop execution, but that meant the context for running teardown was
> lost. Instead, use setjmp/longjmp so that teardown can be done.
> 

Thanks for the patch. The change look good to me.

> Failed SETUP routines continue to not be followed by TEARDOWN, though.

Does this mean failed setup() routines have to handle TEARDOWN? What
are guidelines to follow for setup() failures?

Can you add a bit more detail on what you meant by " Failed SETUP
routines continue to not be followed by TEARDOWN, though".

With that:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
