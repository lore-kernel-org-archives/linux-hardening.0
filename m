Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DA9C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 12 May 2022 19:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345169AbiELTMG (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 May 2022 15:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357923AbiELTMF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 May 2022 15:12:05 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45014B1D4
        for <linux-hardening@vger.kernel.org>; Thu, 12 May 2022 12:12:04 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c11so5802284plg.13
        for <linux-hardening@vger.kernel.org>; Thu, 12 May 2022 12:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBuQvnCRlxDCi6HbteFyBtMacgx7JHqhY0mAy+23sMU=;
        b=eCRUbpnjk/fEcpD0c1rKjaMp2OZq3E+mjzf19tsay+g+rRiYw2qKYOaRC7HbmpdgaX
         ehjHpMF4T6hPc0gTaNbV8qw4kAzXB/L8oFA4/hquDa1s64JotM1FD6AFCm1I/pPOmxtB
         RGEPn652qs6sOT3UKtTVpM9/i50z58+LYLDgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBuQvnCRlxDCi6HbteFyBtMacgx7JHqhY0mAy+23sMU=;
        b=c5A2l3JVtPdtvp3vwzK0SSOCr1wsRpaKKYrULHUpzferEC0dGnJ1XWXKvJlrutFmwv
         9vYKrSZH8+rBAYvvCso3OA8e1joYdZcq/qLJaOMmfzeuo7Y9ucWxokZlrqjEWP9uAhz8
         4xj0PNEHM1sdXkymTHmIzyVMAwNnJyMGVtL4Yqp6B0YlSCZDilK8r6aCGXgmXNhVGzwC
         vG+gNkf3aa9Ysl5XDmds2qa1yUn12Broj5ZnIPQqUW5bKDp2OVkejGE+6N9e3MFWXJnr
         JtQy1DxzH6OJ9SoF5LgOnQXZPnAANlU2Y7LFvDPBJ3HGj5O/HY9g+CpvrRMJwdrRAAC0
         6v/w==
X-Gm-Message-State: AOAM531hsdS6Rs/cNlhN+MZt+SgxP50QvIFPJL/TX64WMB71VvOm6pqI
        IplG6fsjNRlKbpbG/TD/zbJsXw==
X-Google-Smtp-Source: ABdhPJzFMIlQvWdvZrnNcVEtDlZHk2iMMaueVcjUNOHdSokOi+f+sVhuVAMjnR60zBB8Cf9BXFDI1A==
X-Received: by 2002:a17:902:ea09:b0:15e:b761:3ca2 with SMTP id s9-20020a170902ea0900b0015eb7613ca2mr1120324plg.121.1652382723949;
        Thu, 12 May 2022 12:12:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709028c8f00b0015e8d4eb290sm234854plo.218.2022.05.12.12.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 12:12:03 -0700 (PDT)
Date:   Thu, 12 May 2022 12:12:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH] lkdtm/usercopy: Add tests for other memory types
Message-ID: <202205121211.B7EFB5A@keescook>
References: <20220512183613.1069697-1-keescook@chromium.org>
 <Yn1YTZkWVWfXk5Q8@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yn1YTZkWVWfXk5Q8@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 12, 2022 at 07:56:13PM +0100, Matthew Wilcox wrote:
> On Thu, May 12, 2022 at 11:36:13AM -0700, Kees Cook wrote:
> > +static void lkdtm_USERCOPY_FOLIO(void)
> > +{
> > +	struct folio *folio;
> > +	void *addr;
> > +
> > +	/*
> > +	 * FIXME: Folio checking currently misses 0-order allocations, so
> > +	 * allocate and bump forward to the last page.
> > +	 */
> > +	folio = folio_alloc(GFP_KERNEL | __GFP_ZERO, 1);
> > +	if (!folio) {
> > +		pr_err("folio_alloc() failed!?\n");
> > +		return;
> > +	}
> > +	addr = page_address(&folio->page);
> 
> Ideally, code shouldn't be using &folio->page.  If it is, we have a
> gap in the folio API.  Fortunately, we have folio_address().

Ah! Perfect, thanks. In trying to find the right alloc/free pair I
missed folio_address() :)

-- 
Kees Cook
