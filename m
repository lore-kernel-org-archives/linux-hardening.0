Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E58C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 21 Nov 2021 17:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238443AbhKURti (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 21 Nov 2021 12:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbhKURti (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 21 Nov 2021 12:49:38 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C96C061574
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 09:46:33 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so66539191edb.8
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 09:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSsN2HX9wYE+1anh5i16IzKQM5BVIaPiR81SjlOBpzI=;
        b=I42O535hVim3UE7KiZiLXxrha1EwFKyLmyYcmz4MaD8vjKbIZ6R0k0BrPTlH/HYmmD
         74kbJJODdbr70lMWg2CovoNLbdLxtCamhlo6cJtBUV9ljwzKUeqK4IUlZNOjdP5iQ5il
         PhVe4pMzqJCvxi8Qn8ER/TlX3oxgNOW4TAII4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSsN2HX9wYE+1anh5i16IzKQM5BVIaPiR81SjlOBpzI=;
        b=nOh2UYtreX0NwkSu+16EOR1o0dCrA6oaJYf9KLhNScozrLdM4oDNNFuoypnh3WuHxk
         ptP5HUfo85lf/vv6WCh7nuYpyNu6wo0562EQLwHguze68X+aRQfHYmmvkg4nFgGVExWa
         PD5ySMmrV6UlDyrzDCX8hMEPCjJmCjXBcDxNhzkhcWat0oyYpvQ5eBjY74BKTv0dS3sG
         0cMPQ4dhsc3q8K9C7KxoNFI8IVA+4rXtoVVwETKTOtC5/h9/O+ghbRJAAUaxIeIRz47n
         bf7+twmAoMhpYBS81pa0roc0wnYCdefABCh+v5LhZv0NLeBWK2Ct2Xe9EUZOHBraVtpz
         +c8Q==
X-Gm-Message-State: AOAM5337d4YevR3CIjyuF+HPGtn4IGw+NTgdBCatrrneXAgC6qyytg6r
        iONOGf4DvF34wTsNsZ1ShCyx+tr0eEnRwNlr
X-Google-Smtp-Source: ABdhPJw5M6PfAcoxla9LnAG9QFuBkoKQoAvq93coHAcw+N+5VKxixnNqcyLncwh9URstOXX+MqcW9g==
X-Received: by 2002:a17:906:b055:: with SMTP id bj21mr31394264ejb.292.1637516791625;
        Sun, 21 Nov 2021 09:46:31 -0800 (PST)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id aq6sm2624861ejc.41.2021.11.21.09.46.29
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 09:46:30 -0800 (PST)
Received: by mail-wr1-f45.google.com with SMTP id t30so28210988wra.10
        for <linux-hardening@vger.kernel.org>; Sun, 21 Nov 2021 09:46:29 -0800 (PST)
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr29652752wrm.229.1637516789746;
 Sun, 21 Nov 2021 09:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20211116181559.3975566-1-keescook@chromium.org>
 <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
 <202111181026.D7EF6BCED@keescook> <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
 <f278c6c4-dca2-fd8e-57ba-1568e13db156@kernel.dk>
In-Reply-To: <f278c6c4-dca2-fd8e-57ba-1568e13db156@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Nov 2021 09:46:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCMwdrsFv=jvpX8Krgiq49PeiQbMeUB-WA0JKS2LHkGw@mail.gmail.com>
Message-ID: <CAHk-=wgCMwdrsFv=jvpX8Krgiq49PeiQbMeUB-WA0JKS2LHkGw@mail.gmail.com>
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Nov 21, 2021 at 5:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry, missed this reply. Kees, can you just send this one to Linus
> directly?

I took it from that thread.

Thanks,
             Linus
