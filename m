Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48099C4363A
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 17:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA7022244
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 17:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PW80dGdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbgJTRTz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730473AbgJTRTz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 13:19:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5D3C0613CE
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2020 10:19:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so1224508pjb.5
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2020 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9kB87QIvnyTMqBYHcbE2q4kll5hngCNoz9GnopGzSUc=;
        b=PW80dGdCD6rre0mDtHqg0g644x/vnf7u1GdejAgmuz3ncimqOjSSDksic4TnwJi8v1
         pFsW5PhKBmp8We/rMoWRzA0hi+soBzBuXBb/6XclxS5Xjq5ZMewDCe6XlqMDpM8ukGFA
         xeWNm6vMuO9UTT+elaRezsfh8+VQwfdK1QduQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kB87QIvnyTMqBYHcbE2q4kll5hngCNoz9GnopGzSUc=;
        b=JsC63TLsmE1xhtqYVfy6QjXT1qLGKpQewRyWBz6H70O1TVbLzQ641Sl366NmInSPXW
         MRVgWCuGnnrwNEMs7fOl85T+ArY1W4k9DJlkaXaiZWkkzjkf54PtJiJWCJhoZR/AVp8j
         Dr52DeUn0WDjc05McVJAFofn72rYNOV4+WPOI+UjIxBA2JZULU04BEFY8L8odKwYQbYE
         nOv75gZmnr50MPv8dqkE3sixQ82pN61eIq7r1Uw/OmDMQI+JS60wUIniE8M2S6sA4HYw
         mTsfQ+BRqJwaKzCdK2fVug3x1TPjIomzWGpfG602xjSpg0/d8vDWINK5xsTtzhgG2ISf
         E3HQ==
X-Gm-Message-State: AOAM530g7mmQ1ZVFKLbZG5kY/qnuJjaYWQmMXZeTr7GhX8Fe7AcAbSqE
        fj+VvK6WvVlwyeO8dxHVpU5cPe5j044PQA==
X-Google-Smtp-Source: ABdhPJykSIPdEgQCaNSYfflPGq5tEWaRmRK4WWJ5Se7tU4VUSHCewM4qoRYoMQ4SlwuuSeQ/txHJ6A==
X-Received: by 2002:a17:902:bf41:b029:d5:c01a:4f4f with SMTP id u1-20020a170902bf41b02900d5c01a4f4fmr982445pls.14.1603214394864;
        Tue, 20 Oct 2020 10:19:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm2721988pfo.208.2020.10.20.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:19:53 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:19:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     laniel_francis@privacyrequired.com,
        linux-hardening@vger.kernel.org, davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match
 that of strscpy.
Message-ID: <202010201019.7BFEC3D@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-1-laniel_francis@privacyrequired.com>
 <20201019152331.20583-3-laniel_francis@privacyrequired.com>
 <20201019094355.4f6f3826@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202010191559.3AC2C3F97@keescook>
 <20201019163449.0a3f4675@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019163449.0a3f4675@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 19, 2020 at 04:34:49PM -0700, Jakub Kicinski wrote:
> On Mon, 19 Oct 2020 16:01:27 -0700 Kees Cook wrote:
> > On Mon, Oct 19, 2020 at 09:43:55AM -0700, Jakub Kicinski wrote:
> > > On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
> > > wrote:  
> > > > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> > > > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t dstsize)
> > > >  {
> > > > +	size_t len;
> > > > +	ssize_t ret;
> > > >  	size_t srclen = nla_len(nla);
> > > >  	char *src = nla_data(nla);  
> > > 
> > > Sort local variables long to short.  
> > 
> > Specifically, "reverse christmas tree":
> > 
> >  	size_t srclen = nla_len(nla);
> >  	char *src = nla_data(nla);
> >  	size_t len;
> >  	ssize_t ret;
> 
> Or even
> 
>  	size_t srclen = nla_len(nla);
>  	char *src = nla_data(nla);
>  	ssize_t ret;
>  	size_t len;
> 
> ;)

Oops, sorry, yes. ENOCOFFEE on my end. :)

-- 
Kees Cook
