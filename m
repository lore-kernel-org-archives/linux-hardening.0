Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC0CC001DD
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Jul 2023 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjGMQK2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Jul 2023 12:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGMQK1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Jul 2023 12:10:27 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5CC2736
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 09:10:24 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so9072839f.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Jul 2023 09:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1689264624; x=1689869424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b6kF5J9L8hSVht0LDbW0wdyFD464/aZLfOhvZndOBrM=;
        b=Asd4eg8dXHApU/P9YlIq2nWXTq0m6JoYa03PiZm2oVayPoJl3KIUjhHeDkMkZpCzK1
         0VGJn7uZghpTMvZtqI4dgxsNADJ2/bDMPbYkfW6UFffLoLgW/2q5yNfHMl3Tg2sSS6Jv
         nJQKJOE9BSnMjGfI2qA3wRjsUt5Vx/02Z1zXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689264624; x=1689869424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b6kF5J9L8hSVht0LDbW0wdyFD464/aZLfOhvZndOBrM=;
        b=FDu+1YufwTRRKcqhtBkb7KWs7VaarAZucLopKm8e8hi4c+5KsiIjPXRMvJoMnDt8fk
         kdOIF6pvo+40xkRI+P+Hz0gCE1Ne74Vs2AaeS9N/rVdNPsAXOFzEy7inAaQM8JEC5wUm
         g82D2XK5VqShVs2z7iIY8BdXgcaasrfesZVRimvtklkHOKEi25RK/5xs/j9kv7a73D7U
         r7f/yAvIT+fzCjM4LvL1LW4KLnekgApftSdVqld+KH8cryXUHlfv7INzSTdnmCl7D6Mj
         p0wGwG0scnsPPLN9EfxvLTOyBTTt19ueFm+c8CDmh5kgkuxMMpyt1/AAvtG5P19zMQvb
         0cTg==
X-Gm-Message-State: ABy/qLbjgvb4/1c+6BeiEijliVjXyQksHIVGYN0uDtz6gIeacCDar+ug
        Stl1SvqDxP1RHudcYH6XcsZWeA==
X-Google-Smtp-Source: APBJJlHmZi6lPPKB4F1buWNz4UD+UISqbXEIMU4OCfSwBw3LUO99fP9RYXgNY7+i2bAvahU4qiebqg==
X-Received: by 2002:a05:6602:3ce:b0:780:c6bb:ad8d with SMTP id g14-20020a05660203ce00b00780c6bbad8dmr2408456iov.0.1689264624024;
        Thu, 13 Jul 2023 09:10:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z16-20020a6b5c10000000b0076373f90e46sm2032223ioh.33.2023.07.13.09.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 09:10:23 -0700 (PDT)
Message-ID: <758cff83-7307-8bed-8c13-fd747a106396@linuxfoundation.org>
Date:   Thu, 13 Jul 2023 10:10:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Documentation: mm/memfd: vm.memfd_noexec
Content-Language: en-US
To:     jeffxu@chromium.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230629232501.4157671-1-jeffxu@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230629232501.4157671-1-jeffxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 6/29/23 17:25, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@google.com>
> 
> Add documentation for sysctl vm.memfd_noexec
> 
> Link:https://lore.kernel.org/linux-mm/CABi2SkXUX_QqTQ10Yx9bBUGpN1wByOi_=gZU6WEy5a8MaQY3Jw@mail.gmail.com/T/
> Reported-by: Dominique Martinet <asmadeus@codewreck.org>
> Signed-off-by: Jeff Xu <jeffxu@google.com>
> ---
>   Documentation/admin-guide/sysctl/vm.rst | 29 +++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 

Looks goo to me. Kees and Andrew might have comments on the
specifics.

thanks,
-- Shuah

