Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4DCC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 20 Oct 2022 08:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJTI7R (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 20 Oct 2022 04:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJTI67 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 20 Oct 2022 04:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A46194220
        for <linux-hardening@vger.kernel.org>; Thu, 20 Oct 2022 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666256337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4JdVTNocmv+5C7FFGGGdfOf1ttmjLbFkFJntY9Bfk4=;
        b=UMjprOgTFCEFd0JZii2I8t8EHl3UciTaBHk9eJ3JXK3h2YRA3F5VvKmR4PPZ4d2PekQ9zS
        I+uaM6O6Ogi86nV1idWONPSx3z98jZT6sa8CLo8z9wrOlC6BpbXHdvAC2l80IokWW7Ut0l
        r6Fs6NQieUJqn9EBHoF9WVDzH3aqG9c=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-82-DTg_Hg0yNNuVF8bWwIDdkg-1; Thu, 20 Oct 2022 04:58:56 -0400
X-MC-Unique: DTg_Hg0yNNuVF8bWwIDdkg-1
Received: by mail-qt1-f197.google.com with SMTP id cb19-20020a05622a1f9300b0039cc64d84edso14574388qtb.15
        for <linux-hardening@vger.kernel.org>; Thu, 20 Oct 2022 01:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z4JdVTNocmv+5C7FFGGGdfOf1ttmjLbFkFJntY9Bfk4=;
        b=wvxDsBHvTYIpG3qd9gjOJCNXSkkVBqW00bSJ8lP83x/gu8b+3l94nWzjtwYWPO2c4h
         svquplPezU/sc9JT70DdVNBXF2pICh7qJRH9b3ZmEpeVwK6/DQb1cI89zxNgB9e8oqnT
         eLTYgyQ1MbE7cMas46v8cFGPFTws5NrCeTr+9T6smT0hLq///rnKfRIG5bTQEoaRbHGs
         1zEpXxCJZXrHVP3rgnIPVT96yIIlOkBUqbwlgyGv4cA0zXaXqPpU9f3+/ltmetJ+azXI
         HOidCFKVewKgKWBMUfb+w+09sEB933SsLU/DZ0HHfr7mkLhwB3HXGkwN7NQCWpjNgM+x
         nmMA==
X-Gm-Message-State: ACrzQf12tzESNeyYalVUdgt4NpIA6N3Yoz0zy19RCakL9QvtXpvYzf/a
        JyyZ1cnQ6mK4WIVqIIe5SlN9bKukheheAPM+xLofPFmt1i/UzqquVcfravLkaU5N9ou1g+mf8Jq
        ta1bh41mj2Rm42OeX8tYGcIYVJJND
X-Received: by 2002:a0c:cb88:0:b0:4b8:d79e:b2c1 with SMTP id p8-20020a0ccb88000000b004b8d79eb2c1mr694655qvk.85.1666256336286;
        Thu, 20 Oct 2022 01:58:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4bXCasRwb46Qr+S4wxdTnTzsOhS4+ji7UC6MR7ZQFF8dYmBWGwTTEIKInkUbNKjOcrOIHvKQ==
X-Received: by 2002:a0c:cb88:0:b0:4b8:d79e:b2c1 with SMTP id p8-20020a0ccb88000000b004b8d79eb2c1mr694632qvk.85.1666256336012;
        Thu, 20 Oct 2022 01:58:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-103-235.dyn.eolo.it. [146.241.103.235])
        by smtp.gmail.com with ESMTPSA id z15-20020a05622a124f00b0039a08c0a594sm5671319qtx.82.2022.10.20.01.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 01:58:55 -0700 (PDT)
Message-ID: <bd11473cd4e2a92c4ce2a32d370800522862ad4b.camel@redhat.com>
Subject: Re: [PATCH][next] net: dev: Convert sa_data to flexible array in
 struct sockaddr
From:   Paolo Abeni <pabeni@redhat.com>
To:     Kees Cook <keescook@chromium.org>, Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Dylan Yudaken <dylany@fb.com>,
        Yajun Deng <yajun.deng@linux.dev>,
        Petr Machata <petrm@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        syzbot <syzkaller@googlegroups.com>,
        Willem de Bruijn <willemb@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Menglong Dong <imagedong@tencent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Congyu Liu <liu3101@purdue.edu>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Date:   Thu, 20 Oct 2022 10:58:50 +0200
In-Reply-To: <20221018095503.never.671-kees@kernel.org>
References: <20221018095503.never.671-kees@kernel.org>
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello,

On Tue, 2022-10-18 at 02:56 -0700, Kees Cook wrote:
> One of the worst offenders of "fake flexible arrays" is struct sockaddr,
> as it is the classic example of why GCC and Clang have been traditionally
> forced to treat all trailing arrays as fake flexible arrays: in the
> distant misty past, sa_data became too small, and code started just
> treating it as a flexible array, even though it was fixed-size. The
> special case by the compiler is specifically that sizeof(sa->sa_data)
> and FORTIFY_SOURCE (which uses __builtin_object_size(sa->sa_data, 1))
> do not agree (14 and -1 respectively), which makes FORTIFY_SOURCE treat
> it as a flexible array.
> 
> However, the coming -fstrict-flex-arrays compiler flag will remove
> these special cases so that FORTIFY_SOURCE can gain coverage over all
> the trailing arrays in the kernel that are _not_ supposed to be treated
> as a flexible array. To deal with this change, convert sa_data to a true
> flexible array. To keep the structure size the same, move sa_data into
> a union with a newly introduced sa_data_min with the original size. The
> result is that FORTIFY_SOURCE can continue to have no idea how large
> sa_data may actually be, but anything using sizeof(sa->sa_data) must
> switch to sizeof(sa->sa_data_min).
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Dylan Yudaken <dylany@fb.com>
> Cc: Yajun Deng <yajun.deng@linux.dev>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: syzbot <syzkaller@googlegroups.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/socket.h |  5 ++++-
>  net/core/dev.c         |  2 +-
>  net/core/dev_ioctl.c   |  2 +-
>  net/packet/af_packet.c | 10 +++++-----
>  4 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index de3701a2a212..13c3a237b9c9 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -33,7 +33,10 @@ typedef __kernel_sa_family_t	sa_family_t;
>  
>  struct sockaddr {
>  	sa_family_t	sa_family;	/* address family, AF_xxx	*/
> -	char		sa_data[14];	/* 14 bytes of protocol address	*/
> +	union {
> +		char sa_data_min[14];		/* Minimum 14 bytes of protocol address	*/
> +		DECLARE_FLEX_ARRAY(char, sa_data);

Any special reason to avoid preserving the old name for the array and
e.g. using sa_data_flex for the new field, so we don't have to touch
the sockaddr users?

Thanks!

Paolo

