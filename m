Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE4C433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 16:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C996124B
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 16:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhKSQ1Y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhKSQ1Y (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Nov 2021 11:27:24 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59CFFC061748
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 08:24:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so11391389pja.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 08:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qui87OY5Jed4+H9Eeo8B5vVSCb7VatAB11Im4YTYJRU=;
        b=llELplFVoWfVosynWC9z829rWucL2lgjibfYGe7Wjc/w2c39KJ8ALIgzVb0vwI6zZs
         klS0Tvi8i7jIVaOU/DYlIxm4ulh1KGfEbnWjdpRELoTVhMAe8ybvt8t8GoASncsmKlw0
         Z/HweGsovgW4dQ/GBFXje/nE/Uos0iqCW7s3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qui87OY5Jed4+H9Eeo8B5vVSCb7VatAB11Im4YTYJRU=;
        b=WuEkpZOPx/jrOedLDsoYx14QIBGYaD4uSfBMVR/yamOTFUnk65N++HPk2t2floOCJc
         IOQAOU+6W3FZRoMmiLBtobbs/hgBnqmNNwpTkUTDVvWytJWBJrt3nx8YKK9QXB+yRr8L
         eIrWIvgImj5vQGmqRCYnupawWjdY9VjO3CClNqSO3BaRcNb1EfoCWpWnum1oJccEB7EM
         127mXZHoWhWLCHT6VOIUrn+4jargqcrChNTWbGbRi6gxbpO/zX6DOSQB3WjFvQaX1jJt
         63IckTGM0k/YzxruuarYZfKr9kivUejIN4ytwWpwVNF5ARwtyw67RWNSfWZ3HkHsCdOm
         kQqw==
X-Gm-Message-State: AOAM531nDhCjFFO4KELhnrlbuM32QIywTbceCqBx8KL2jsl/c2dvR+Ya
        Uki2/OQDrZ8aexz565mw/ftJrg==
X-Google-Smtp-Source: ABdhPJzOSTnQ3rV6Qyg1u/LKfX0KBy8F72q5HyeDuG/FkYat7OxNw9TLTL+XNHEUVXP48WDRb6uSuQ==
X-Received: by 2002:a17:90b:1c02:: with SMTP id oc2mr990156pjb.65.1637339061491;
        Fri, 19 Nov 2021 08:24:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u22sm144313pfi.187.2021.11.19.08.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:24:21 -0800 (PST)
Date:   Fri, 19 Nov 2021 08:24:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Marco Elver <elver@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Cong Wang <cong.wang@bytedance.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Talal Ahmad <talalahmad@google.com>,
        Kevin Hao <haokexin@gmail.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        linux-kernel@vger.kernel.org, wireguard@lists.zx2c4.com,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] skbuff: Switch structure bounds to struct_group()
Message-ID: <202111190821.8147EF796B@keescook>
References: <20211118183615.1281978-1-keescook@chromium.org>
 <20211118231355.7a39d22f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118231355.7a39d22f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 18, 2021 at 11:13:55PM -0800, Jakub Kicinski wrote:
> On Thu, 18 Nov 2021 10:36:15 -0800 Kees Cook wrote:
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memcpy(), memmove(), and memset(), avoid
> > intentionally writing across neighboring fields.
> > 
> > Replace the existing empty member position markers "headers_start" and
> > "headers_end" with a struct_group(). This will allow memcpy() and sizeof()
> > to more easily reason about sizes, and improve readability.
> > 
> > "pahole" shows no size nor member offset changes to struct sk_buff.
> > "objdump -d" shows no object code changes (outside of WARNs affected by
> > source line number changes).
> 
> This adds ~27k of these warnings to W=1 gcc builds:
> 
> include/linux/skbuff.h:851:1: warning: directive in macro's argument list

Oh my, I see it[1]. I will get that fixed. This smells like a missing
header or something weird. I have a dim memory of fixing this warning
long ago when evolving this series.

Thanks!

-Kees

[1] https://patchwork.kernel.org/project/netdevbpf/patch/20211118183615.1281978-1-keescook@chromium.org/

-- 
Kees Cook
