Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28956C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 21 Nov 2021 10:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhKUK2p (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 21 Nov 2021 05:28:45 -0500
Received: from mail-vk1-f173.google.com ([209.85.221.173]:41904 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbhKUK2o (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 21 Nov 2021 05:28:44 -0500
Received: by mail-vk1-f173.google.com with SMTP id 188so5503090vku.8;
        Sun, 21 Nov 2021 02:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76gUnwG+pJE+hG34Clu5oVhtc4cHsXMWN/mmsz4K8hk=;
        b=Z6ywDiA3koLvSkqD9n/0g4esUUoLqJ8Klx5oJlZkezfA9G0cGuhIEFTi3ubs9z+NZy
         PyKGEZbkeo2nKELE4WsX1NNDQvP8k2eUodJTfU04gwCDjaK7SsIJlnsM3LONjYLmj0JD
         JupN4wTkHoEL0E/+HijbmJe9v5IGsQq7tUGqSqWGkf6UMjC0O+y8uP5At7OlXgzlw9tR
         vaZYiZ2NhcHCt2S0nLjIgscMYoMQinU2Sg875Jk5A8vdQSFvFv4OR2tfT5nJdO/xmZEq
         0mQYDfoAvNA3yYVN09N+qlr2FvdWEWCP83ihhA0+sXD9UTCv5UVgzW89GZ76Didx3jPx
         YVpA==
X-Gm-Message-State: AOAM531te05QC9DN/5cf6mqJXbbfleEH9DW973xSQctf631Zp/sxlTHe
        j2MVX8+Lvu0e+eACKCSd/xpPe18wm25/Ag==
X-Google-Smtp-Source: ABdhPJx01Z5AKcsTdfiawScpRE/COhi4VpqGxUH3XQGmpP9fV7m/ays2Lf/0YRbxq5qIgTEmDpjUDQ==
X-Received: by 2002:a05:6122:c8b:: with SMTP id ba11mr141800228vkb.3.1637490339348;
        Sun, 21 Nov 2021 02:25:39 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id q26sm3189229vsp.23.2021.11.21.02.25.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Nov 2021 02:25:39 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id u68so8463022vke.11;
        Sun, 21 Nov 2021 02:25:39 -0800 (PST)
X-Received: by 2002:a1f:f24f:: with SMTP id q76mr144641464vkh.11.1637490336147;
 Sun, 21 Nov 2021 02:25:36 -0800 (PST)
MIME-Version: 1.0
References: <20211116181559.3975566-1-keescook@chromium.org>
 <163710862474.168539.12611066078131838062.b4-ty@kernel.dk> <202111181026.D7EF6BCED@keescook>
In-Reply-To: <202111181026.D7EF6BCED@keescook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 21 Nov 2021 11:25:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
Message-ID: <CAMuHMdX6Su_4G4H5GEjy17a0xkZrqPj0kh9Tg++-2-=SGSsj_Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
To:     Kees Cook <keescook@chromium.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 18, 2021 at 7:29 PM Kees Cook <keescook@chromium.org> wrote:
> On Tue, Nov 16, 2021 at 05:23:44PM -0700, Jens Axboe wrote:
> > On Tue, 16 Nov 2021 10:15:59 -0800, Kees Cook wrote:
> > > This reverts commit d07f3b081ee632268786601f55e1334d1f68b997.
> > >
> > > pstore-blk was fixed to avoid the unwanted APIs in commit 7bb9557b48fc
> > > ("pstore/blk: Use the normal block device I/O path"), which landed in
> > > the same release as the commit adding BROKEN.
> > >
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] Revert "mark pstore-blk as broken"
> >       commit: d1faacbf67b1944f0e0c618dc581d929263f6fe9
>
> Thanks! I realize now what Geert meant in an earlier thread that I
> actually can't split this change from a warning fix that was living in
> the pstore tree (and was masked by the now removed BROKEN). Can you take
> this patch as well? I've removed it from my tree now...
>
> https://lore.kernel.org/lkml/20211118182621.1280983-1-keescook@chromium.org/

Which is now a build error instead of a warning in Linus' tree.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
