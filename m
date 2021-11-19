Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A9C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A16361A6C
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Nov 2021 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhKSS3Z (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Nov 2021 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbhKSS3X (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Nov 2021 13:29:23 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE2FC061574
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 10:26:21 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h24so8569548pjq.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Nov 2021 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DlGTN7Qf7Ih3sgz22eokhwuPXp2v1jWtJCK8cZnkjw=;
        b=a/NGcBNkciMHrO1NIuWo4GADEyiNdWAldzXFAihYFgTQrxCfIyMR1wLZDX+9jTIsEh
         J3p0Fzgr0kMN7+TNMAbZIyoKFNksnJs1M0LjMp/vB423igsRP3uDUi8MJG4n3cNDj+jL
         Hj8kwJHSLjjEGWB/uzGO/Nimqb6n7KOQ1lsO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DlGTN7Qf7Ih3sgz22eokhwuPXp2v1jWtJCK8cZnkjw=;
        b=fTqnaxs5dNJWt0tqrI/Bvjryn4GmgNl3RWjylV6RcvJ1ZKC/feYQMdNDzQeUhRnHz8
         gbxJbonNvMlzb3ZymL0zJWv9QJXAiwRVUqBsxKueeeXHM4mhcW196xA/VQl+RBRpgxT2
         qetdnL9yC8xZKtKfOAAeLduYZdec3uKnThIlbGlGDUfDChchVYzlQ3GKYrDu9hspOxkB
         poeHpOfP6K00F6yo0SLjlh6UGFGWycte9TF9j+DNQqOC5/0ZUDIUUsxLxjgyf0ztjZK2
         M5bVYl7SiAbXUOE7Y3vI74dBTYD0qICFHHICr5UWVWynu+VCnOpEZROM8GgzBckis11i
         3ZKg==
X-Gm-Message-State: AOAM5304RVaEHUmlUDV6yikXp37/xwZ/4sSItXIC0QYZGhJjsyxE3GFm
        AgXNwutAa/Zc4YTU9Vzq6MawPg==
X-Google-Smtp-Source: ABdhPJyOqQz8idH7cSV5BVRoiuqwbUEIYSGwMWy267I6HNSSKZ43xmLMBY94sDQSjeEi7DfAgmWbiw==
X-Received: by 2002:a17:90a:ac0b:: with SMTP id o11mr2032931pjq.143.1637346381329;
        Fri, 19 Nov 2021 10:26:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p19sm375250pfo.92.2021.11.19.10.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 10:26:21 -0800 (PST)
Date:   Fri, 19 Nov 2021 10:26:19 -0800
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
Message-ID: <202111191015.509A0BD@keescook>
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

Hrm, I can't reproduce this, using several GCC versions and net-next. What
compiler version[1] and base commit[2] were used here?

-Kees

[1] https://github.com/kuba-moo/nipa/pull/10
[2] https://github.com/kuba-moo/nipa/pull/11

-- 
Kees Cook
