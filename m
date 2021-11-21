Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB3C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 21 Nov 2021 18:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbhKUSID (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 21 Nov 2021 13:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhKUSID (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 21 Nov 2021 13:08:03 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F37C061714
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 10:04:58 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id f9so20155505ioo.11
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 10:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y6/CqKrcbfcpYhyghibRPnEwdPsXNyiegIBeS/KdCv4=;
        b=OrXWk896N8TiYOLq+4bjmNldUT8zk/sFaJzfCz7Q/MiWZQOY6V+VcnwTLdobGXwI4Y
         bWqFvch0Q4nYuXxl7px6Ijr5p/bGqtLCQshHJkIQKsX8P9rjp2OkiepT+mpWKNGI5S1Q
         OfKWKTgZdWuQ1D/z6N1+2SUGWHSbK1QZBlPq8X6In8E4Jv475v49inuZzamUUyb6p4I0
         9MvtmDaivDyNRWbX4g61SRoB3cZrBIremSL9bvsnSFQf+1MbljDZifOm5MHdzgX0DsKP
         ENph9OINTR6bYfFxDvpt1WRy5HOKD+XgIhak4caN9kaRaY2lJnP5fx0DUiX9uREbPNNu
         MZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y6/CqKrcbfcpYhyghibRPnEwdPsXNyiegIBeS/KdCv4=;
        b=11PyQ35ptdAzSs4t67KNaTa1ytFype7UR1d11SNID9nY8CwDZ0qK0lIWy1uUeehNmM
         b6WD08HCfwRs7iBEW7qtrNDSCzGg6Bsxi1/gS7SI99QMPrAeQWhqUow0CR+9DFKySwGu
         hmrCYacP+5wGCib80yBUB08scNnbzT4+d6UAJJmhGLMV1RXUCW85x9j53gGGuxXLHVsx
         4h4eL682nPHT8y73sBpg+8g02WvgI38Yjhndvwcy7CaoumQvMz+zMY7Bxp3vmG47rQv0
         7u779nNqvQ6MrxXZwisEf5qAXqPW+sHiCnnSwrymFYBTf/FwmUweM4F7MJ/EBi4ibOSs
         2Xfw==
X-Gm-Message-State: AOAM531HSMyZZh1ac+MF4/UKGD18pi0Qn2/4ZeXYcI8e6hlvWPUNp5zW
        qGs7Z9y9CHTpi4Mup030xi08YHKdENghqTUh
X-Google-Smtp-Source: ABdhPJytdZKppzmVlxTFP6O9GYS4M4nGOJRBegGvRMUh4SKhUmHQMdOM15hp8zIbeqcLq4H9t7w08w==
X-Received: by 2002:a05:6638:4087:: with SMTP id m7mr43693455jam.112.1637517897126;
        Sun, 21 Nov 2021 10:04:57 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y15sm490114iow.44.2021.11.21.10.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 10:04:56 -0800 (PST)
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org
References: <20211116181559.3975566-1-keescook@chromium.org>
 <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
 <202111181026.D7EF6BCED@keescook>
 <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
 <f278c6c4-dca2-fd8e-57ba-1568e13db156@kernel.dk>
 <CAHk-=wgCMwdrsFv=jvpX8Krgiq49PeiQbMeUB-WA0JKS2LHkGw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe2176e0-0f9b-df73-db68-72fa2bc2671d@kernel.dk>
Date:   Sun, 21 Nov 2021 11:04:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgCMwdrsFv=jvpX8Krgiq49PeiQbMeUB-WA0JKS2LHkGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 11/21/21 10:46 AM, Linus Torvalds wrote:
> On Sun, Nov 21, 2021 at 5:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Sorry, missed this reply. Kees, can you just send this one to Linus
>> directly?
> 
> I took it from that thread.

Great, thank you!

-- 
Jens Axboe

