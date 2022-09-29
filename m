Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A67C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 29 Sep 2022 10:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiI2KT1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 29 Sep 2022 06:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbiI2KS7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 29 Sep 2022 06:18:59 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEA12B49B
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 03:18:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-131a7bce1acso1256178fac.7
        for <linux-hardening@vger.kernel.org>; Thu, 29 Sep 2022 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1Cl0X39qkQEt/y9Mr2rlDhC6cvyU1oB8bqUhsRPfFjw=;
        b=oKXPJbkf45R1vzWZcxh4YaF25ZAkn4xfL1s/pYp2qTAZiSUrtiJ44rgSQI1VfGTQjH
         vClfq5dYd8DiJ+2lMY8t8pT02diUCStyJykW4WeGUv3fgFetRDkA7VpkRFw6Sw8Z4UwI
         QJrkB0bbE0OgnaA/xoSDRrFQJVRlVOrRdEFQpDJAphXLbsOFLeOh0LPQDsQt5vZBC9xq
         mAi36oTLrnTchR7U4zksdaUwv6HzcIZBlzBfD6ls+K6JMewBOiBovZ9DmD9fu+1oUmMp
         G4TQL7NKWwrJkPefPX7P/QimpvV6kTEeDNSbpTfKFzK2JR6/ZFmcB5dR2pZE3HDwH65n
         0w3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1Cl0X39qkQEt/y9Mr2rlDhC6cvyU1oB8bqUhsRPfFjw=;
        b=k6F9L/tUow+acQ99TjLRO/Bpm4KNpygyuJwTruP38P/EjeIgRS2x3PCturlpnLYagc
         8JDd7Uq0J1YzAd04e0gCjqKg3W75qNfkQQ7ekw8RyhuHXTxEYBbji0kcy5Q3rmkhx8f9
         mTbqluX5Sm/hR/u1X99d1T9Av9hOfuOwa2we6Fy8ZGVvre+eBhP6xxMp7y2dgEjU5Mn0
         7vaUQB9LWX5ZcEXbvtO42ny01XHqAf7s0v5/zZVw2rrMHgy+Zd4Z3bkTHhIe11Pi4xkL
         QeHyrjADmkpEaLa6NclpmVT1UupiN76NWAhHfXA7Kt8f6/enf8Nky2nhISdO5Xz4Bifu
         QCWw==
X-Gm-Message-State: ACrzQf3D/xIsOZnS3OKJH3vMdmkC/Vtqu43tYs396qLrMD5ddbUdeFPZ
        vDaeOUxlh6q6MA8H0L9HhUlRFM4jT3GH6VbFqGfAFA==
X-Google-Smtp-Source: AMsMyM4w85ys+LTV212qG29Xx/YrH+bZHF0Uy+vFG3Y/DUYbV2ChkuLHHdknY7dc+LEqTrikKz9uRVJ4xSMLyjSgruQ=
X-Received: by 2002:a05:6870:a10c:b0:131:c133:39bd with SMTP id
 m12-20020a056870a10c00b00131c13339bdmr1338610oae.106.1664446707905; Thu, 29
 Sep 2022 03:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220927153700.3071688-1-keescook@chromium.org>
In-Reply-To: <20220927153700.3071688-1-keescook@chromium.org>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Date:   Thu, 29 Sep 2022 06:18:17 -0400
Message-ID: <CAM0EoMnGbS-KHknPU+3gf2CaQO7XtKt-jFRZEZ42ZxAS=3ZzMQ@mail.gmail.com>
Subject: Re: [PATCH] net: sched: cls_u32: Avoid memcpy() false-positive warning
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 27, 2022 at 11:37 AM Kees Cook <keescook@chromium.org> wrote:
>
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), use unsafe_memcpy(), as the sizing,
> bounds-checking, and allocation are all very tightly coupled here.
> This silences the false-positive reported by syzbot:
>
>   memcpy: detected field-spanning write (size 80) of single field "&n->sel" at net/sched/cls_u32.c:1043 (size 16)
>
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org
>
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reported-by: syzbot+a2c4601efc75848ba321@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/lkml/000000000000a96c0b05e97f0444@google.com/
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal
