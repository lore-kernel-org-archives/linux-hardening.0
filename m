Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D89AC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Nov 2022 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiKQWuO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:50:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240424AbiKQWuK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 17:50:10 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEDC65E5A
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:50:08 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-39115d17f3dso27296377b3.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 14:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oBQqoT8aYHZ0vQjXNPjZ+F7M4m+OJwx56OthzoHvy+Y=;
        b=V/85NRHCgCKO6025dTcmKElFHjJs4o4UrvwFg35hm1KxroNrAGF7AQPOo4PAFFpz/1
         FS3VuVIVF/5YlLLk0sxnl4d97EI1auCMb5+574cvZaCuSN5BiDDIMzJ6YGQGg7mF2+AT
         M4KFp0JqJK0f2A6W27QB6t3TmXruVIwmPoY6t8nvHesVZl7BojEroj9PPAxBg/etlutO
         XyP6d641aLZ4M1/nneKxVrm1aavnuQb6odm5omN3sW9OazWK1It2axj5S9sME0fNfi9B
         aYQ7+zQout9E3QFu4beIntb8LQKs7LmaTBsgg6fZLaPifO/rIvTa+ngGvAVnY5snL4LZ
         BVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oBQqoT8aYHZ0vQjXNPjZ+F7M4m+OJwx56OthzoHvy+Y=;
        b=HZknPTUnpN7CxeZhNjjRCiVPu3GAQs3jrwUP/siYPLTxy8TWzOWIZd/8rPQH66XgNM
         8rA5X5p46nwiyQkomXn6WcsjtMtOWTpio7Q8faXi69GKcIOXVFGOu98Njabg9lPj8mfz
         M5trxMqidi/XVQvgc9LwJJIYVnxIxfblXqH9upKNUVn7NLsh7gXimd2Pd9ghpCKOBceh
         KHRRfb1uWV710m9iE6j49moyHxzj0yRFfBwCyv9I697juCuEAPccrtTbEX/KWkDhKPeP
         x2p9u7t9t/fIHJLNw1YfCIn7vbO1sC+5Tspnuve3L2CM3/LyGwHbhDrAuvC6f1eZ5FSu
         rwVg==
X-Gm-Message-State: ANoB5pn0a751tQyz0L9lT6kU2n9VEjmTlqrZMaAPE6y1Z6tmvDdOY0iu
        h+Ve2thdAYGeA4/YA1/MlqcA27VOzVBiab9I8fWPmw==
X-Google-Smtp-Source: AA0mqf7GtacDQKaXHIxqNnE9LxIUJ+gq9okc+66L2C9uDEEJ6ZRBroGBuisOb4OGhCNRp77BS5/k2zxDUOhD/n9aITs=
X-Received: by 2002:a0d:e601:0:b0:356:d0ed:6a79 with SMTP id
 p1-20020a0de601000000b00356d0ed6a79mr3999955ywe.489.1668725407806; Thu, 17
 Nov 2022 14:50:07 -0800 (PST)
MIME-Version: 1.0
References: <202211171422.7A7A7A9@keescook>
In-Reply-To: <202211171422.7A7A7A9@keescook>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Nov 2022 14:49:55 -0800
Message-ID: <CANn89iLQcLNX+x_gJCMy5kD5GW3Xg8U4s0VGHtSuN8iegmhjxQ@mail.gmail.com>
Subject: Re: Coverity: __sock_gen_cookie(): Error handling issues
To:     coverity-bot <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Nikolay Aleksandrov <nikolay@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 17, 2022 at 2:22 PM coverity-bot <keescook@chromium.org> wrote:
>
> Hello!
>
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221117 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Wed Nov 16 12:42:01 2022 +0000
>     4ebf802cf1c6 ("net: __sock_gen_cookie() cleanup")
>
> Coverity reported the following:
>
> *** CID 1527347:  Error handling issues  (CHECKED_RETURN)
> net/core/sock_diag.c:33 in __sock_gen_cookie()
> 27     {
> 28      u64 res = atomic64_read(&sk->sk_cookie);
> 29
> 30      if (!res) {
> 31              u64 new = gen_cookie_next(&sock_cookie);
> 32
> vvv     CID 1527347:  Error handling issues  (CHECKED_RETURN)
> vvv     Calling "atomic64_try_cmpxchg" without checking return value (as is done elsewhere 8 out of 9 times).
> 33              atomic64_try_cmpxchg(&sk->sk_cookie, &res, new);


Hmmm. for some reason I thought @res was always updated...

A fix would be to read sk->sk_cookie, but I guess your tool will still
complain we do not care
of  atomic64_try_cmpxchg() return value ?

diff --git a/net/core/sock_diag.c b/net/core/sock_diag.c
index b11593cae5a09b15a10d6ba35bccc22263cb8fc8..58efb9c1c8dd4f8e5a3009a0176e1b96487daaff
100644
--- a/net/core/sock_diag.c
+++ b/net/core/sock_diag.c
@@ -31,6 +31,10 @@ u64 __sock_gen_cookie(struct sock *sk)
                u64 new = gen_cookie_next(&sock_cookie);

                atomic64_try_cmpxchg(&sk->sk_cookie, &res, new);
+               /* Another cpu/thread might have won the race,
+                * reload the final value.
+                */
+               res = atomic64_read(&sk->sk_cookie);
        }
        return res;
 }
