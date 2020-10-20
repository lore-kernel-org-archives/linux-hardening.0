Return-Path: <SRS0=sPYh=D3=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B731C4363A
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 17:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62A322242
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Oct 2020 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j31T+kYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390876AbgJTRXL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Oct 2020 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390857AbgJTRXL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Oct 2020 13:23:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2972CC0613CE
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2020 10:23:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t22so1363510plr.9
        for <linux-hardening@vger.kernel.org>; Tue, 20 Oct 2020 10:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=C2whC7dxW7uUCx15c2+3j06uyxnCZ7apflsBs7iRZkw=;
        b=j31T+kYpVPSb8G7+0XJNMo3ngCFXQTxTlChxMq63AJIXv0q0hHe09F0bNrh80H46oG
         oac6zTN9cNnU+RQQOUrdKf832mCpEjILW/aEpL3FcOCM/VpcG1B0xVeQ4Gu+r3fkYg4R
         sbSAKB8Opy9iSHN7mvm6josCYSB+jz4ySPN04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=C2whC7dxW7uUCx15c2+3j06uyxnCZ7apflsBs7iRZkw=;
        b=unB6Mexkid1jd8CwBCqmcdebvoeQKL8EgREZUN35qGw3Ji2rMVVk0rXtOk+8hpYKcv
         mfxqq8lhjfTXsK8B7Ott6cd2BIRW8NiukSd+ecf34HdxPfK4Fe+zheUkLEsudDWN5LDo
         KCWUCF7DKPrXAC1bBy/WzcsfsSdYNd6VDiFLwZOecva4srC8ll2pFlPWS+rkgmvVuy3o
         ZoDdrty7kEwea9zjWrNK9eK/3vi17w2bI5nKIeJbgwu26zxzrS8vnEiwwFzO4icJEZz2
         LQAdRqAftUDYzoO96Jza7c+Nmxy2qQhAPDrO5hVoPCPbvMeqxGz7g3kbMFirE6eBoz7p
         iWMA==
X-Gm-Message-State: AOAM531GxO8N1Z/0fZPOD7hcrdCVKgtTsvJVFP9KiTQiC7sPPWf4rmAf
        nXrnEV+PzOeUtstH3HzPclmcdwOcbOanaQ==
X-Google-Smtp-Source: ABdhPJw+Xvk7WDG8BtEeO4/9z1QNsAOZ+PKIsVdsodrmAZ9VNkBpYUAm8VniEpyhhXr7+U+fyQrgjA==
X-Received: by 2002:a17:90a:148:: with SMTP id z8mr3773544pje.173.1603214590685;
        Tue, 20 Oct 2020 10:23:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm2561498pgv.87.2020.10.20.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:23:09 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:23:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Francis Laniel <laniel_francis@privacyrequired.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-hardening@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [RFC][PATCH v2 2/3] Modify return value of nla_strlcpy to match
 that of strscpy.
Message-ID: <202010201022.B016A3A41A@keescook>
References: <20201016125216.10922-1-laniel_francis@privacyrequired.com>
 <202010191559.3AC2C3F97@keescook>
 <20201019163449.0a3f4675@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <6912124.fRD6ipzQbq@machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6912124.fRD6ipzQbq@machine>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 20, 2020 at 12:28:49PM +0200, Francis Laniel wrote:
> Le mardi 20 octobre 2020, 01:34:49 CEST Jakub Kicinski a écrit :
> > On Mon, 19 Oct 2020 16:01:27 -0700 Kees Cook wrote:
> > > On Mon, Oct 19, 2020 at 09:43:55AM -0700, Jakub Kicinski wrote:
> > > > On Mon, 19 Oct 2020 17:23:30 +0200 laniel_francis@privacyrequired.com
> > > > 
> > > > wrote:
> > > > > -size_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t
> > > > > dstsize)
> > > > > +ssize_t nla_strlcpy(char *dst, const struct nlattr *nla, size_t
> > > > > dstsize)
> > > > > 
> > > > >  {
> > > > > 
> > > > > +	size_t len;
> > > > > +	ssize_t ret;
> > > > > 
> > > > >  	size_t srclen = nla_len(nla);
> > > > >  	char *src = nla_data(nla);
> > > > 
> > > > Sort local variables long to short.
> > > 
> > > Specifically, "reverse christmas tree":
> > >  	size_t srclen = nla_len(nla);
> > >  	char *src = nla_data(nla);
> > >  	size_t len;
> > >  	ssize_t ret;
> > 
> > Or even
> > 
> >  	size_t srclen = nla_len(nla);
> >  	char *src = nla_data(nla);
> >  	ssize_t ret;
> >  	size_t len;
> > 
> > ;)
> 
> I reordered the variables names for the v3.
> Just to know, is it a new rule? Because scripts/checkpatch.pl did not report 
> anything and I was not aware of it.

This is specific to netdev, but I actually can't find reference to this
in either Documentation/process/coding-style.rst nor
Documentation/networking/netdev-FAQ.rst.

I swear I found this written down before, but it eludes me now.

-- 
Kees Cook
