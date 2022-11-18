Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFE9C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 18 Nov 2022 04:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiKREkY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiKREkX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Nov 2022 23:40:23 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB672EF09
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 20:40:22 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-369426664f9so38886527b3.12
        for <linux-hardening@vger.kernel.org>; Thu, 17 Nov 2022 20:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Dr1Bit9E2xIsyjg35lmCOjqfBFsJ1wOMewib20+A9s=;
        b=S2m69yrwZynGvy8xNpigka4CC35Tdckv+IU7cZIjoPN/muy3Vk0cBC5wA0XMCBJ4sl
         IY3mgjEaTXF/Vk1pvaHePA7bFVIqAKsC/7M5c0wet6QSG03MTB/zprxTZqoKysZ1aOjy
         w7v5npbzpfrzy1ZaiQSFSKnVHdXrd+C5elFmmqxfjq7JnmMVAhFDZ09ySgVMXtM8nnPD
         CpyrXmRhbGHh0gDjdYFAh25WcEALsLUhwsTecG84NjHg9lu30VACF66fEiZT981A/dLl
         yRYp4dkopCCqwX2He7FLaZ64ZXW8KmN0O1eZ5i5kXsY0sTwjx7Hx7HNHnCS6p+9+wWPL
         aZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Dr1Bit9E2xIsyjg35lmCOjqfBFsJ1wOMewib20+A9s=;
        b=v4/W0mJkBKMPTBj93hanrsvLOhJFqC+tBKVFehfJJmaSn1AUsQcEq1gaNpYNhiVsFL
         tMZJe8VrQKCYvpz3PoAdZkqOISJq+Frx7ZMso4tngJZg71+3aor2nIHN63+AaNSBelPa
         ve/T4yWhd7o69BqAU0mMG5yqkXam0PAoI2f+2N92NyTuAjufya3TlfkgYoMVYGbMVDyC
         hZ11UGnzoBwBZ7RcfQmcE43n2Yh3hNh2/EWQ6+Z+Sk5OnszxuTSrU1G6JqU4GG+uwpbw
         xg1368/pa1zn5jkaODy9Gc6dlctTLyiTZq9oX5a+A9x6qqXJby1LZSYyp1wMZM7aVbHe
         YUHw==
X-Gm-Message-State: ANoB5plvKPmiqpR/lEbL689g37Kx/frBynaAq2tFmGRoghGYFtK8avtq
        hxkyz5ylhYI0SKErNw1o3BfhhSCf9gJhiK7XO3XZRw==
X-Google-Smtp-Source: AA0mqf446ZeH40Y49UBBftPkEOKX3UbeWSS1TwZfSCeFIZ5/4hKnGjwyW5mX4zidCRqlg92GBzKqZdjaq4oPJcl2jmw=
X-Received: by 2002:a81:5f04:0:b0:393:ab0b:5a31 with SMTP id
 t4-20020a815f04000000b00393ab0b5a31mr2980661ywb.55.1668746421116; Thu, 17 Nov
 2022 20:40:21 -0800 (PST)
MIME-Version: 1.0
References: <202211171422.7A7A7A9@keescook> <CANn89iLQcLNX+x_gJCMy5kD5GW3Xg8U4s0VGHtSuN8iegmhjxQ@mail.gmail.com>
 <202211171513.28D070E@keescook> <CANn89iKgMvhLbTi=SHn41R--rBQ8As=E52Hnecch6nOhXVYGrg@mail.gmail.com>
 <202211171624.963F44FCE@keescook> <CANn89iJ1ciQkv5nt5XgRXAXPVzEW6J=GdiUYvqrYgjUU440OtQ@mail.gmail.com>
 <202211171815.D076ED9C@keescook>
In-Reply-To: <202211171815.D076ED9C@keescook>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 17 Nov 2022 20:40:09 -0800
Message-ID: <CANn89iK_uQzXx5ihDnbDCDmiJc3+2kLWTGTNC-+2PiiHfCHCjA@mail.gmail.com>
Subject: Re: Coverity: __sock_gen_cookie(): Error handling issues
To:     Kees Cook <keescook@chromium.org>
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

On Thu, Nov 17, 2022 at 6:16 PM Kees Cook <keescook@chromium.org> wrote:

>
> It looks like the existing code already works as intended, so no need to
> silence the warning. The comment and reload might be nice to add, just
> to clarify for anyone looking at it again in the future, though.


The current code in net-next is broken, because if we succeed to
change sk->sk_cookie,
we return 0 (instead of @new). So your report was not a false positive.

Thanks.
