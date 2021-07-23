Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFACCC4338F
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jul 2021 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A5A60EAF
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Jul 2021 07:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhGWG2o (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Jul 2021 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhGWG2n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Jul 2021 02:28:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBC9C061757
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jul 2021 00:09:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id hg12-20020a17090b300cb02901736d9d2218so2611357pjb.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Jul 2021 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bhkkYXi3ADOrlZ4EDXCkVoxr0Z1zK3tnngVvHVFWdeg=;
        b=hl0ctl9eQf/deghA9nh2F3A9bSDcalSOUBylDo9UrRj/xMNNvhEBQ47eras39JlOb3
         nDYqMrJ94XVrPM1zhuoWIbTp1ep7unXJtcGWLmljj53mmc7UZgA7ErGQIfs+ac+Tm2e4
         n+6ntjRsOK6LUsLFMHIQDpaajbjAhQ0LDmOmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bhkkYXi3ADOrlZ4EDXCkVoxr0Z1zK3tnngVvHVFWdeg=;
        b=Bge1m6fJRo3q3dhOYBpPIe0dD1HnUy4jRO1Z6IBYOZVcEUSHCBH2H7vjV9FJjfsvfC
         Z0AjU6h5kBD1t/RhBGbrDjP8sGCuWmllnpSWuOK/7+zbPU5y9eJhsMlsGCv3kjvd1/WH
         nAktVyj2CqifT+jUVOKzgPa8VtFtMFckYLL7T0yebxHgwhqPSKPQ9Gf+zez32MecbvSv
         6K9oj+D5GUWPMWyuyM2pxzA0PkMAb55Bn3pRkKi6JIaMOOTFo+RaesXvV0ivKOEjNaaA
         dN15dZAUHzRbdrjUSiVXoj0Xs7YOlQJplBwIpridtlX5j8YxuJYosfbwvpbvw0R8EWHq
         w9Pg==
X-Gm-Message-State: AOAM533Gn6mZcN7LCDteNrAO9wcxxYq/OW6dvPqZ1Lq6LcGJhAf9d/pQ
        A9pvebJKVrL0czFmJ7NiQlq2RA==
X-Google-Smtp-Source: ABdhPJwrICfiLeYa9gCBf5xIwAD5tWSH0gN9yJptX5bd7661BAPnf7l+DlYUNUpSWU8tQ54XF+SpmA==
X-Received: by 2002:a17:90a:db52:: with SMTP id u18mr12684832pjx.56.1627024157295;
        Fri, 23 Jul 2021 00:09:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c19sm5895870pfp.184.2021.07.23.00.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:09:16 -0700 (PDT)
Date:   Fri, 23 Jul 2021 00:09:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Cong Wang <xiyou.wangcong@gmail.com>,
        Qitao Xu <qitao.xu@bytedance.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [Patch net-next resend v2] net: use %px to print skb address in
 trace_netif_receive_skb
Message-ID: <202107230000.B52B102@keescook>
References: <20210715055923.43126-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715055923.43126-1-xiyou.wangcong@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jul 14, 2021 at 10:59:23PM -0700, Cong Wang wrote:
> From: Qitao Xu <qitao.xu@bytedance.com>
> 
> The print format of skb adress in tracepoint class net_dev_template
> is changed to %px from %p, because we want to use skb address
> as a quick way to identify a packet.

No; %p was already hashed to uniquely identify unique addresses. This
is needlessly exposing kernel addresses with no change in utility. See
[1] for full details on when %px is justified (almost never).

> Note, trace ring buffer is only accessible to privileged users,
> it is safe to use a real kernel address here.

That's not accurate either; there is a difference between uid 0 and
kernel mode privilege levels.

Please revert these:

	851f36e40962408309ad2665bf0056c19a97881c
	65875073eddd24d7b3968c1501ef29277398dc7b

And adjust this to replace %px with %p:

	70713dddf3d25a02d1952f8c5d2688c986d2f2fb

Thanks!

-Kees

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#p-format-specifier

> 
> Reviewed-by: Cong Wang <cong.wang@bytedance.com>
> Signed-off-by: Qitao Xu <qitao.xu@bytedance.com>
> ---
>  include/trace/events/net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> index 2399073c3afc..78c448c6ab4c 100644
> --- a/include/trace/events/net.h
> +++ b/include/trace/events/net.h
> @@ -136,7 +136,7 @@ DECLARE_EVENT_CLASS(net_dev_template,
>  		__assign_str(name, skb->dev->name);
>  	),
>  
> -	TP_printk("dev=%s skbaddr=%p len=%u",
> +	TP_printk("dev=%s skbaddr=%px len=%u",
>  		__get_str(name), __entry->skbaddr, __entry->len)
>  )
>  
> -- 
> 2.27.0
> 

-- 
Kees Cook
