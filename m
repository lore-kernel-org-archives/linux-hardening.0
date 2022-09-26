Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C87C07E9D
	for <linux-hardening@archiver.kernel.org>; Mon, 26 Sep 2022 21:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIZVJO (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 17:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIZVJN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 17:09:13 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC9A1D74
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 14:09:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a80so7922375pfa.4
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 14:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=z2N8LaF32sVo0MzpvnaJgrHDNgj6iB+hPRs2AGkWfto=;
        b=iNU6fF1RWdROt/mKhKh4y/8mQA0kXSsvh1U2vUwg0opVJI50FrW0nhkdSisbS+YFN9
         B8Gv0OIsH5ynOXaMK89XrVLTRyEeZ4gikeERElQneRjRrgHWrUGTYPtORP/zSK1VOOZj
         wsqw+bXF8lV8ERMgHOCH+e2L1ZvocMDhekVx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=z2N8LaF32sVo0MzpvnaJgrHDNgj6iB+hPRs2AGkWfto=;
        b=5uro2F8GRC8pIEatkZy+BlMY2BywdK/95LFYMr0tUbA8ttR99QjChFSb7cOG1iN5A8
         F/eaJQ1o5iVwyslC7h8SP1AkD2X6d8dAM2+DBZ4abhYvWlHSY3gzvsJVKSVL+83hAyw0
         RQjj40KL/xu2vjiStjY6/6S10WX0Edod5OJN6O3EIqGzKBWJnvotOTYa0oq4NDSdjwY3
         0FqkOh9EVfcbqu8JkxU4bS3Nqu2Gu/5jKpJpIdn6zbJg5f9WIDZqCPrzYBEWkcKVSbcI
         N0tV8VVMYAxeAktxJd5QdJov0oLNz9XAZmt4vqmZZVsZMu9x8ls9dSRbLmp59JTssBvN
         Yc7A==
X-Gm-Message-State: ACrzQf0eHrSXOa4kVh/lvvV0PIphmwZRUial+hHOOzhiOmsiKkGBPEVb
        A3o1fGN/AXMSS0VdB/kPcdc+lQ==
X-Google-Smtp-Source: AMsMyM5WIe3hqBa57RBis752CH191gAYntlDiD5fJNhEuECKTcn7TB+Nt6Sb9VomPqk1ExNiN3sNcg==
X-Received: by 2002:a63:3348:0:b0:439:db24:8b02 with SMTP id z69-20020a633348000000b00439db248b02mr21236503pgz.425.1664226552446;
        Mon, 26 Sep 2022 14:09:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p7-20020aa79e87000000b005459e8a103asm12569831pfq.167.2022.09.26.14.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:09:11 -0700 (PDT)
Date:   Mon, 26 Sep 2022 14:09:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
Message-ID: <202209261408.59F78C0D@keescook>
References: <20220926194713.1806917-1-keescook@chromium.org>
 <YzIUS/+H2YA7RBvA@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIUS/+H2YA7RBvA@casper.infradead.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 10:06:19PM +0100, Matthew Wilcox wrote:
> On Mon, Sep 26, 2022 at 12:47:13PM -0700, Kees Cook wrote:
> > -/** check_add_overflow() - Calculate addition with overflow checking
> > +/**
> > + * check_add_overflow - Calculate addition with overflow checking
> >   *
> >   * @a: first addend
> >   * @b: second addend
> 
> Why did you remove the ()?  And why didn't you delete the blank line?
> According to our documentation, the canonical form is:
> 
>   /**
>    * function_name() - Brief description of function.
>    * @arg1: Describe the first argument.
>    * @arg2: Describe the second argument.
>    *        One can provide multiple line descriptions
>    *        for arguments.
> 
> I don't usually complain about people getting that wrong, but when
> people correct it to be wrong ...

Hunh, everywhere I'd looked didn't have the "()" (which seems
redundant). The blank line was entirely aesthetics for me. If it's
supposed to be without a blank, I can fix it up everwhere.

-- 
Kees Cook
