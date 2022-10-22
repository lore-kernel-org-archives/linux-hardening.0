Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1195FC433FE
	for <linux-hardening@archiver.kernel.org>; Sat, 22 Oct 2022 01:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJVBwo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 21 Oct 2022 21:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJVBwn (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 21 Oct 2022 21:52:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5B325D644
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 18:52:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso2583357pjz.4
        for <linux-hardening@vger.kernel.org>; Fri, 21 Oct 2022 18:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afdPZP8v0TX/Zy/NVaOu1EQ1KzFRj9XO5sdt02N1QIw=;
        b=byBUNwzD8BfQT9gPd+UCau35i3Ec29XlEf03viviGcFtuMa8DoaRnaCDMKhdTiatp8
         5dQWKnm+fZbZN4Vmkd4XLd73XU6Vzb6AR5kS9QxTBuDw+YrG5xKFVjsWgwTFndV+RIZC
         Uf0XNfm4mPIBksl8MOtKh14ETZpxxZjKMiFoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=afdPZP8v0TX/Zy/NVaOu1EQ1KzFRj9XO5sdt02N1QIw=;
        b=mTXFnm/prr6+Js2gozp90eKTxtV+RDbkJ3qy9jXre6ER+6PRzp/H3UA1EVtAAjrxYZ
         im4S64UFg8TIpRbRd1hkkgsVcKZg8VuSNLs6zOI6ifh8dGq1ZBVhTN83HjvN4U0Rceeq
         1BI6TazJ+jiPqKriXoGAudLBI7DBvx9IQwLubcVRfmOAEAAISmkXdfAb5fVbXLjbjg1Z
         e1jY7EQFGKXeIz0P79AfGEZwNcnIURDjKehXoA49e3sYC/p1KSsVQI1kZgPPZ2mdz306
         2Pek6/zHMzfa9ZJxLxSrE1PPDLS/Pig0SnkPOpptlu2zO3K9cEo3hyrIyQJou/OtI8Qp
         2SBw==
X-Gm-Message-State: ACrzQf3EuQ625FEmVu6jEG8cVlp46JkSAYr6eAwRx2fmzy/RDzYJRfBQ
        IjLXoExdIJPAiudnHHvCNnfkf2CNrAK5WQ==
X-Google-Smtp-Source: AMsMyM7l25D5mnCDMTSTKy8YeC1DWpS7hmUeK83OHYzC79a0fjn9W2pNlDjM9O49hOYPIB1DCr7NCw==
X-Received: by 2002:a17:902:d2ce:b0:185:3f05:acf4 with SMTP id n14-20020a170902d2ce00b001853f05acf4mr22427322plc.35.1666403561336;
        Fri, 21 Oct 2022 18:52:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pf9-20020a17090b1d8900b00212cf2fe8c3sm3180998pjb.1.2022.10.21.18.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 18:52:40 -0700 (PDT)
Date:   Fri, 21 Oct 2022 18:52:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH][next] net: dev: Convert sa_data to flexible array in
 struct sockaddr
Message-ID: <202210211841.031AB46@keescook>
References: <20221018095503.never.671-kees@kernel.org>
 <bd11473cd4e2a92c4ce2a32d370800522862ad4b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd11473cd4e2a92c4ce2a32d370800522862ad4b.camel@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 20, 2022 at 10:58:50AM +0200, Paolo Abeni wrote:
> On Tue, 2022-10-18 at 02:56 -0700, Kees Cook wrote:
> > [...]
> >  struct sockaddr {
> >  	sa_family_t	sa_family;	/* address family, AF_xxx	*/
> > -	char		sa_data[14];	/* 14 bytes of protocol address	*/
> > +	union {
> > +		char sa_data_min[14];		/* Minimum 14 bytes of protocol address	*/
> > +		DECLARE_FLEX_ARRAY(char, sa_data);
> 
> Any special reason to avoid preserving the old name for the array and
> e.g. using sa_data_flex for the new field, so we don't have to touch
> the sockaddr users?

Yes -- the reason is exactly to not touch the sockaddr users (who
generally treat sa_data as a fake flexible array). By switching it to a
flex-array the behavior will stay the same (especially under the coming
-fstrict-flex-arrays option), except that it breaks sizeof(). But the
broken sizeof() allows us to immediately find all the places where the
code explicitly depends on sa_data being 14 bytes. And for those cases,
we switch to sizeof(sa_data_min).

If we went the reverse route (and added -fstrict-flex-arrays) we might
end up adding a bunch of false positives all at once, because the places
that treated it as a flex-array would suddenly all begin behaving as a
14-byte array.

-- 
Kees Cook
