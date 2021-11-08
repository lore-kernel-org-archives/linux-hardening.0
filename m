Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F34CC433EF
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 07:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8C861059
	for <linux-hardening@archiver.kernel.org>; Mon,  8 Nov 2021 07:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbhKHHpe (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 8 Nov 2021 02:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhKHHpe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 8 Nov 2021 02:45:34 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19C0C061570;
        Sun,  7 Nov 2021 23:42:50 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g91-20020a9d12e4000000b0055ae68cfc3dso21473528otg.9;
        Sun, 07 Nov 2021 23:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05x0jjtR7e1YyH6ib8YAN/VFxXqCLvpo8Fsy3l3DsA0=;
        b=FHKKRtJK/2JDbedijOU1vmc/iO6PhMG4HASb9dglKXKXqkHXZ3AzqzaTMEI6Q8EVv7
         AmBGyULcMK88QMYHENuZzSo71t5Re3RClsy9muuktD67LvSaNf3Aj8OLuuu6NHjMz6pK
         XTX17umBekk45oMU6up+VosGsU5ReduopxalQYGmvsYrkWo9sZRdWd3vt2P7aQd/MSdP
         KrP6VcBukP+kk+17IPCNV60cy9b2kqKc2YHgq4vtb05FsntRyi98Hghi6ItuVXrU5xoz
         eU8qlLFGA24oYUalTwtuJLPn6/9Yi6ErD4JSOlTFsxrSjQzsiOy7BFNUsM3DwPqdybyT
         wRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05x0jjtR7e1YyH6ib8YAN/VFxXqCLvpo8Fsy3l3DsA0=;
        b=M/hyWOAvPudvcApuOaKeWtTFXBfJEHum+kPZaZnUHsm0Dis5QxChRh6xMG63cr9D3F
         2OdKa65WpT1e7XFvAE4HnGhmVldtl4KnCrLwTFMJtHxYDEsUJTQBAzl7aLZDk4zNdld1
         oo46hYqZsn1VqgM1oZpI5FKdax07oN7BYedJeSgkMhxV+O/gA1RZfmfggeA3ei0h1uNl
         DEjB/DvlqICBze7RXdYkHmkqcls1Gnp5WOKHn/IIe+wyOLnlKC0ipTrLSA0F24c1RQ57
         0qnSRqyPdoKWYxWsmAdlnpPMJ3w2ahgOVcgfR8lx5R4RjDBLyvT6b4lNHCdpsnzrqO5X
         SqKA==
X-Gm-Message-State: AOAM532OfW/2n2/pBB6xhVqgqqvtcUjrYn0gsGFnwL7ZRFxoEfmc8hb0
        UOihXNcz7lXRq03j1lphCFVLvACQMWByavEntMM=
X-Google-Smtp-Source: ABdhPJy7soPkFTRLUxus9ydblly3rU/fRg5seRtGg/oILnzjDdJoDS7p8JyEZC9vYLPwfCO2XYkqWmo8kZH+EGRPviI=
X-Received: by 2002:a9d:7617:: with SMTP id k23mr44483931otl.351.1636357369427;
 Sun, 07 Nov 2021 23:42:49 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <CAHp75VcVZ6dDDm-k=Njo-jDq81bL4BTwrtkkAnm24b23qWKB_g@mail.gmail.com>
In-Reply-To: <CAHp75VcVZ6dDDm-k=Njo-jDq81bL4BTwrtkkAnm24b23qWKB_g@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Mon, 8 Nov 2021 13:12:37 +0530
Message-ID: <CAHP4M8UK6AYVORHCndpw2ZeRLDN+BMj3enJ-+2SWtbOPSqUe9A@mail.gmail.com>
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy and strscpy
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "andy@kernel.org" <andy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

>>
>> The output is as follows :
>>
>> ######################################################
>> Using [strlcpy] ::
>>
>> len = [16]
>> a = [123456789]
>>
>>
>> Using [strscpy] ::
>>
>> len = [-7]
>> a = [123456789]
>>
>
> My gosh, this is error code that you must check. We do not need more string copy functions.
>
>

Hmm, having the additional function would make things a lot easier.

For example, in file fs/kernfs/dir.c, there are methods like
"kernfs_name_locked", "kernfs_path_from_node_locked" which simply
consume the return-value without any checks.

All the above functions have a simple motive : copy as much bytes as
possible in the destination buffer, and then consume/return the number
of bytes actually copied (minus the null-terminator byte of course).

If checks are to be put in-place, it would be too much code/churn,
adding if checks all over the place.
If, instead we do a simple replace of "strlcpy" with "strlscpy" at
these places, we would be good to go (while *really* meeting the
requirements of these clients at the same time).


Anyhow, may be we can wait for some more opinions.
