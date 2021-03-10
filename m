Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C6DC433E0
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 19:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57C7464FAE
	for <linux-hardening@archiver.kernel.org>; Wed, 10 Mar 2021 19:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhCJTPa (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 10 Mar 2021 14:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhCJTO7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 10 Mar 2021 14:14:59 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6587EC061762
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 11:14:59 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s7so8964796plg.5
        for <linux-hardening@vger.kernel.org>; Wed, 10 Mar 2021 11:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xGBOjaqoqW2el6rCcu+fky2Vrwvc5fZUNN0jvRZFDBY=;
        b=hAXXb+tmOovSqMUvNZJDl98EM9SVnhRBnkvVzwjL4AQ0uE7/v01OfGii0FOxLVoqq2
         cbC81qnrxMpkm4MMx6+CVsmwkfMNFeSUC5PJ3ARoWa0pPZAginJWwpsYkT4egGZv64Kk
         s7eEg1cVdscSQECYuNv20esXEvopj9DCYS09Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xGBOjaqoqW2el6rCcu+fky2Vrwvc5fZUNN0jvRZFDBY=;
        b=uTYzyEhJfGs8jDurJOZQGIlmR//NSCCe+mroKE141d2ZW8BFUbxMBxIPGouFJhQESa
         DxOjgAoLSdpLW/HvZVEEf7x24S0f18knDs8O/J6mSl9JBlgDEZ1XczOXvLZiYFN5PmjM
         C5O/CkzEyB1RkM5iNPxD87Kdlfro9u/bxf0n6CR9Ti1InQrpsh5KiAwEIvPVEllstLEo
         jBMjAu1adZoEV73omG+1t7nQcqIfd2Ffr0WatfQlOBYy4xeGRPSxAmDJy2JcYnizusk1
         pwQZfxABb6VKq2unn6reragZ1zEDzn7Po5HQ942tE3FQyX18BdoDpdSWbXQsMtxHaz/7
         y4xg==
X-Gm-Message-State: AOAM530f05Go+LTAjy6QqlkpNrJn58YsU0ryx8MltwUQBnjXKLyMwcea
        HStXdiQnuWLe4cPdLKhjN5ath8Nqf4r+rg==
X-Google-Smtp-Source: ABdhPJwSmY4D3emq145W7IE+QGbsVU4sEdgWdnmGVa6a0Vakk3f/Swawg8CPtfNPC/29G3yc/RVE7A==
X-Received: by 2002:a17:902:ce88:b029:e6:3a3c:2f65 with SMTP id f8-20020a170902ce88b02900e63a3c2f65mr4322549plg.66.1615403698597;
        Wed, 10 Mar 2021 11:14:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t5sm252777pgl.89.2021.03.10.11.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 11:14:57 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:14:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] rtl8xxxu: Fix fall-through warnings for
 Clang
Message-ID: <202103101107.BE8B6AF2@keescook>
References: <20210305094850.GA141221@embeddedor>
 <871rct67n2.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rct67n2.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 05, 2021 at 03:40:33PM +0200, Kalle Valo wrote:
> "Gustavo A. R. Silva" <gustavoars@kernel.org> writes:
> 
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix
> > multiple warnings by replacing /* fall through */ comments with
> > the new pseudo-keyword macro fallthrough; instead of letting the
> > code fall through to the next case.
> >
> > Notice that Clang doesn't recognize /* fall through */ comments as
> > implicit fall-through markings.
> >
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> It's not cool that you ignore the comments you got in [1], then after a
> while mark the patch as "RESEND" and not even include a changelog why it
> was resent.
> 
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/d522f387b2d0dde774785c7169c1f25aa529989d.1605896060.git.gustavoars@kernel.org/

Hm, this conversation looks like a miscommunication, mainly? I see
Gustavo, as requested by many others[1], replacing the fallthrough
comments with the "fallthrough" statement. (This is more than just a
"Clang doesn't parse comments" issue.)

This could be a tree-wide patch and not bother you, but Greg KH has
generally advised us to send these changes broken out. Anyway, this
change still needs to land, so what would be the preferred path? I think
Gustavo could just carry it for Linus to merge without bothering you if
that'd be preferred?

-Kees

[1] https://git.kernel.org/linus/294f69e662d1570703e9b56e95be37a9fd3afba5

-- 
Kees Cook
