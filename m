Return-Path: <SRS0=m/Ru=D2=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97CEC433DF
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 22:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7650822200
	for <linux-hardening@archiver.kernel.org>; Mon, 19 Oct 2020 22:58:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a6TCAAUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgJSW6j (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgJSW6j (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 19 Oct 2020 18:58:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0608AC0613CE
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 15:58:38 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v12so568077ply.12
        for <linux-hardening@vger.kernel.org>; Mon, 19 Oct 2020 15:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGZUN8Ev6ZCdGiiUwFA4QjwQhl301+YVO6uWwnm1zew=;
        b=a6TCAAUZmEncwUZ1miTIEP3VjUcNxQVyv9BF3oJ31v9lMPQIY7q/APvUyOgyJ7uvSY
         TdZkzSflAjwxINaJeXyFZItqiUYOzv43V01At/o26SWzQdVqBJqZfpKknDDRAaas8/8G
         DmH/6DnWfwn1SmhXDnGeBH7RGAbYAGnbXcrKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGZUN8Ev6ZCdGiiUwFA4QjwQhl301+YVO6uWwnm1zew=;
        b=iePFUtyG+xQ8Yt+bftHOkx8EW/PgoMcnqLiBTVusc7GPWZQj+n6hufmi2FZQZWqw1B
         WPTTYQ5+NJ9HB8QMTQzSp60MXKTXsgmQKSATO4pKQVNfK9iqyRfLA5zK+nYoUMd0yMzC
         qG6tgnoQGUcj1nrEevY1XyeGWpHZAvJ6T94lJamVpvoEbHnScL4z5lwtt4H8DjrbOWZo
         NsIegchXozU7X8p8dCQeC9eTn4Y+2h11b2K+wdzg5D/83V9SQOJQM+oKd1VQ/x4NfCIJ
         Tc4DgO8Ijfbjp8i88sXiP0KYtIk8yFUvy5BhAadl5lF1sM6urG7a25GKrvK5O6ToLoic
         s2GQ==
X-Gm-Message-State: AOAM533vWs7MogdBPV9Vgx4p5L780+9q01lyF30A4KEG/dVd5xnzbS5G
        QJx/Ed8G2Dg9gMaE63cbzRvrhg==
X-Google-Smtp-Source: ABdhPJzitQw5KnZpM1Zw52qRWTMFoEQ+19ON1z9ZNqn8E6GzqEUihCbZu1yXCXJ/olDGAt4AwPlqCQ==
X-Received: by 2002:a17:90a:2ec1:: with SMTP id h1mr40778pjs.51.1603148318452;
        Mon, 19 Oct 2020 15:58:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5sm555514pgf.61.2020.10.19.15.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:58:37 -0700 (PDT)
Date:   Mon, 19 Oct 2020 15:58:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 0/3] Fix inefficiences and rename nla_strlcpy
Message-ID: <202010191557.C2653B0A@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-1-laniel_francis@privacyrequired.com>
 <20201019094515.46db8af1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019094515.46db8af1@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 19, 2020 at 09:45:15AM -0700, Jakub Kicinski wrote:
> On Mon, 19 Oct 2020 17:23:28 +0200 laniel_francis@privacyrequired.com
> wrote:
> > To sum up, the first patch fixes an inefficiency where some bytes in dst were
> > written twice, one with 0 the other with src content.
> > The second one modifies nla_strlcpy to return the same value as strscpy,
> > i.e. number of bytes written or -E2BIG if src was truncated.
> > The third rename nla_strlcpy to nla_strcpy.
> > 
> > Unfortunately, I did not find how to create struct nlattr objects so I tested
> > my modifications on simple char*.
> > This is why I tag this patch set as RFC.
> > 
> > If you see any way to improve the code or have any remark, feel free to comment.
> 
> You follow semantics of strscpy, yet rename to strcpy. Wouldn't it be
> more intuitive for developers to rename to nla_strscpy?

It's closer to strscpy_pad() but that seems a long name. What's
preferred from the NLA perspective?

-- 
Kees Cook
