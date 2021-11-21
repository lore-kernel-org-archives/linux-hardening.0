Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58E2C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 21 Nov 2021 13:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238112AbhKUNjX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 21 Nov 2021 08:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhKUNjU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 21 Nov 2021 08:39:20 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6B1C061574
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 05:36:15 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x9so15257480ilu.6
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 05:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mjgTCrSYedUc749fCFMMgQSu5enUWM+JD5Zz1USHu/w=;
        b=G09k/1saNek895gPINpPQO2FJSCPrx+x595lL1FuVduXqnOHUmSkQJwH/hiJ67uTCO
         qv3uHDAhxiy4nYh9vz0BHB6xQ9veCwGY6segTr9GNLMqeylqFgdGwV+pcBg5MIUHTqaG
         VKoA1xuH0cJq9HF5RXkF4ftYvhd3pXForU0W7dwZFY+6V6Y4BeEotUVYURVhCqxH8GVg
         cVqW1RnDzFUNFyHsc26Q16FQuqb7jlQkdVdbrv2eH5L02p2T7Onc8CwBl52Pf9O4D1Jj
         toltTqnN8WeOeU/EXWqmHDZRrrp1CqEUvsVpY5v7nKJe+y+J6r4Vjkzo0kFGlkYloKzs
         rF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mjgTCrSYedUc749fCFMMgQSu5enUWM+JD5Zz1USHu/w=;
        b=EO/GjChkptZUhWZFhAsr4eLbzWbUI+/0QlkBx66j4us+up8tVnrWHwEgxxh7HFRvM8
         qGAnsX3HZDQLWtMidVozSrdzn91bkXHSgV0bqKc6pL/IosA0TAk3bk1hAMkkityKm3Im
         QNnX5YXBs/l9GzuTBCsGlwsmzBfWgXoVz+HLEZBYv8aoQPC8GsVqsz28sJEDcpjD6RlO
         oLOUb5VcuGzNMoi9mp9hUxFOTwgcbF0yuMMGXKhWMUlDpxIEH4PsOxaZkrgu61yiDvv7
         pirWShvzuvRGDY9bhOabzpsa5h+yczQmjPCsQhPpZD2hp/7Jln2f3Fi65hBZRD7jTdrV
         Do8A==
X-Gm-Message-State: AOAM533K8MoYfpGVZtr/Ur/mHoMpqXTP+nWocQpILbsP8N4u9E7HwL38
        RMn6K5eyGlZz4hoAVxXEqlRlOQ==
X-Google-Smtp-Source: ABdhPJyxhUX5YRDaR9o4ik1zF8dbuX3zNHA/Fn7kGx9a5vyrbnNzP7wR5W2ufooEV8KbQSOLsQrZdQ==
X-Received: by 2002:a05:6e02:ec8:: with SMTP id i8mr2928917ilk.112.1637501774346;
        Sun, 21 Nov 2021 05:36:14 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z12sm3416399ilp.21.2021.11.21.05.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 05:36:13 -0800 (PST)
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211116181559.3975566-1-keescook@chromium.org>
 <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
 <202111181026.D7EF6BCED@keescook>
 <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f278c6c4-dca2-fd8e-57ba-1568e13db156@kernel.dk>
Date:   Sun, 21 Nov 2021 06:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/21/21 3:25 AM, Geert Uytterhoeven wrote:
> On Thu, Nov 18, 2021 at 7:29 PM Kees Cook <keescook@chromium.org> wrote:
>> On Tue, Nov 16, 2021 at 05:23:44PM -0700, Jens Axboe wrote:
>>> On Tue, 16 Nov 2021 10:15:59 -0800, Kees Cook wrote:
>>>> This reverts commit d07f3b081ee632268786601f55e1334d1f68b997.
>>>>
>>>> pstore-blk was fixed to avoid the unwanted APIs in commit 7bb9557b48fc
>>>> ("pstore/blk: Use the normal block device I/O path"), which landed in
>>>> the same release as the commit adding BROKEN.
>>>>
>>>>
>>>> [...]
>>>
>>> Applied, thanks!
>>>
>>> [1/1] Revert "mark pstore-blk as broken"
>>>       commit: d1faacbf67b1944f0e0c618dc581d929263f6fe9
>>
>> Thanks! I realize now what Geert meant in an earlier thread that I
>> actually can't split this change from a warning fix that was living in
>> the pstore tree (and was masked by the now removed BROKEN). Can you take
>> this patch as well? I've removed it from my tree now...
>>
>> https://lore.kernel.org/lkml/20211118182621.1280983-1-keescook@chromium.org/
> 
> Which is now a build error instead of a warning in Linus' tree.

Sorry, missed this reply. Kees, can you just send this one to Linus
directly? I already flushed my block patches for this week. If there's
some reason you can't let me know, and I'll do another one...

-- 
Jens Axboe

