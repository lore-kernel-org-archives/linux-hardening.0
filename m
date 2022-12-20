Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1E5C4167B
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Dec 2022 16:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbiLTQzh (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Dec 2022 11:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLTQze (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Dec 2022 11:55:34 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7C51C126
        for <linux-hardening@vger.kernel.org>; Tue, 20 Dec 2022 08:55:29 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z9so6581141ilu.10
        for <linux-hardening@vger.kernel.org>; Tue, 20 Dec 2022 08:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UmTBCjd4WfDkEIZ41SUabqVQsCDpgvamQQ85cJ8gqF0=;
        b=CSJ9LGK+9xR1eOwHmVWnalfCyuk+oL/PCYF6ETNL7lFOI3yzt/TaJ7C+YlXlpXEDMJ
         Uzk7kF3dgaX9Wkqm4cTgekfJXPnLf9iAiCeEUInmVbE/gmNFvvx97KY6JTrWSLzftHWK
         BzRVwwchdTfgQj7qLq0lDyeRw9+bUl8d5sDWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmTBCjd4WfDkEIZ41SUabqVQsCDpgvamQQ85cJ8gqF0=;
        b=N7Jk1aMLv+KiiCPowQp3qhXhmJ13Puxd5HavGE8EWSYqyXtA0eGH+MlYTMoGotKWY3
         qbyecnKAH+Koa4qFYDBeWPMmKt3DQpajJlq8jK11VQs+4fXbe7GNjifRHFTYBGmfhxrF
         Y0BPsjV+2y+4pivtiGCWdSr58609fni4iRU01BVVUav1DidOyxrJ6rUg3d6w+vwQccJG
         CwwOL7dhFGqELkWyTlL/SkqBbSw/BQkAK6VaIMm+97Rhwyws6Ad2Sx5YNrxs9v+tFdUA
         /l5Cqf49SgZi3sXyP5YexyBVcKYScGEWOS/wdLsONERc03nMe6fVPDznYZ153YuAmb0E
         uWuQ==
X-Gm-Message-State: ANoB5pkwskXmmDHC1DRbZDGN1ZA5NHlxXZUGZ1zvy+ehac/Jo5KvRjIh
        QOXHiko0ZjgaxNaga+vLjskdcA==
X-Google-Smtp-Source: AA0mqf5be6/mjb1uYLE+7Ce9R+B32f8xgMhK4AQZTwjI9AF9595PyJn41kXUUx+xKiFc9qajiFTWcA==
X-Received: by 2002:a92:d3ce:0:b0:303:d8:f309 with SMTP id c14-20020a92d3ce000000b0030300d8f309mr4378979ilh.2.1671555329106;
        Tue, 20 Dec 2022 08:55:29 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s12-20020a92cb0c000000b0030005ae9241sm4493573ilo.43.2022.12.20.08.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 08:55:28 -0800 (PST)
Message-ID: <f185bb42-b29c-977e-312e-3349eea15383@linuxfoundation.org>
Date:   Tue, 20 Dec 2022 09:55:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 3/6] mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC
To:     Jeff Xu <jeffxu@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Peter Xu <peterx@redhat.com>,
        jeffxu@chromium.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, jannh@google.com,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221207154939.2532830-1-jeffxu@google.com>
 <20221207154939.2532830-4-jeffxu@google.com> <202212080821.5AE7EE99@keescook>
 <CALmYWFuKR538vHxqYH1p6mb9iShOohf5bpHZXSfUN4KQHYiwaA@mail.gmail.com>
 <Y5yS8wCnuYGLHMj4@x1n>
 <CALmYWFsDhX76zbcyhYAW-u0BBwD+m+TKpt4_pZTMt+22zHhrGQ@mail.gmail.com>
 <20221216094259.bec91e4abd6cf54a05ce2813@linux-foundation.org>
 <CALmYWFsNp87a5uVQUAb4PG0khFN8Xxd=ibh9Q7g-Y0XW1Mn-8Q@mail.gmail.com>
 <202212161233.85C9783FB@keescook>
 <CALmYWFuENPRvCAOF6of=Ufct5jjAbJ=iDyH7eODhdbm24uAK3Q@mail.gmail.com>
 <20221216140641.bf6e47b7c4f5a53f34c8cf9a@linux-foundation.org>
 <CALmYWFuqAruM=Brh_54hWL+HiKD+RABK4y+hzd4phOzOZ_0=CA@mail.gmail.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CALmYWFuqAruM=Brh_54hWL+HiKD+RABK4y+hzd4phOzOZ_0=CA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 12/16/22 16:40, Jeff Xu wrote:
> On Fri, Dec 16, 2022 at 2:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 16 Dec 2022 13:46:58 -0800 Jeff Xu <jeffxu@google.com> wrote:
>>
>>> On Fri, Dec 16, 2022 at 12:35 PM Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> On Fri, Dec 16, 2022 at 10:11:44AM -0800, Jeff Xu wrote:
>>>>> Once per boot seems too little, it would be nice if we can list all processes.
>>>>> I agree ratelimited might be too much.
>>>>> There is a feature gap here for logging.
>>>>>
>>>>> Kees, what do you think ?
>>>>
>>>> I agree once per boot is kind of frustrating "I fixed the one warning,
>>>> oh, now it's coming from a different process". But ratelimit is, in
>>>> retrospect, still too often.
>>>>
>>>> Let's go with per boot -- this should be noisy "enough" to get the
>>>> changes in API into the callers without being too much of a hassle.
>>>>
>>> Agreed.  Let's go with per boot.
>>>
>>> Hi Andrew, what is your preference ? I can send a patch  or you
>>> directly fix it in mm-unstable ?
>>
>> Like this?
>>
> Yes. Thanks!
> 

Sorry jumping into this discussion a bit late. Is it possible to provide
a way to enable full logging as a debug option to tag more processes?

thanks,
-- Shuah

