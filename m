Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEB7C433EF
	for <linux-hardening@archiver.kernel.org>; Sun, 12 Sep 2021 18:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAA161026
	for <linux-hardening@archiver.kernel.org>; Sun, 12 Sep 2021 18:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbhILSs1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 12 Sep 2021 14:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhILSs1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 12 Sep 2021 14:48:27 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB6DC061574
        for <linux-hardening@vger.kernel.org>; Sun, 12 Sep 2021 11:47:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id u18so7326895pgf.0
        for <linux-hardening@vger.kernel.org>; Sun, 12 Sep 2021 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TJOhg0T6L8M+ezsmrHAW8f/Dohcbz3T1o4xW0J0kO8o=;
        b=bp26jGuFiACmE+IxK07HXoJM7uogqlEbMHGF1Hd8aCIWab59GPldfAzQidL+nVmNe9
         XLMZOuI5NoCEM2oQUaxefkZqTnqzty1Ysc31VSBYlFbBmib1TyloRAgOOOFybDIYwrzE
         XUkKnY4v1Wkd85ufJiDPvB3yAWyTmyCRhGbYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TJOhg0T6L8M+ezsmrHAW8f/Dohcbz3T1o4xW0J0kO8o=;
        b=c/0yvH9qYJEMwCARnzIuaY19+6iBeXKBTdqAHoxdU2+37twqBaXD68q0bEkO+91ri4
         pfevdy9qHwnBPC6rVscjtgWrZ1ea1tM7H8cLcthuXNl65nRVCElKdVYqIvfkD4B3BNZz
         Nt6sUy/Ne+u6oG/NatuN8zvKi05tIImCOwmw1IDvQ7FaJhHOFmBMSNJczuxVa7UhYbdL
         WqvUscUJUOnXuhWPxuHISLHaUVXghzG/PK7tOXIGAxi0xHsXBda4VOrLHcqyWHkNB3eC
         0kEaEGjAUxOw0mzULUTGuluRD/PZ4hxgIQm21mHmTOl1gRBkPFn+wrg5Y7aSjmWwoH6w
         j2Sg==
X-Gm-Message-State: AOAM532q2oJjFIhDd+pQGY7mzxaV+AI7vfHsUlXaVea1GrGkDlKVQzX/
        T7Mn9K9QFA+g0jkZwaJVLqBoMhHPVCxPfg==
X-Google-Smtp-Source: ABdhPJx55aGsthlbVdn4RFMMxAzcoDxcDzG0gZclP231IwGA63kK6sKtk/DgX4miuqkqyin8tbuKzA==
X-Received: by 2002:a05:6a00:a28:b0:416:6241:e2d5 with SMTP id p40-20020a056a000a2800b004166241e2d5mr7735120pfh.47.1631472432516;
        Sun, 12 Sep 2021 11:47:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e13sm4571187pfi.210.2021.09.12.11.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 11:47:11 -0700 (PDT)
Date:   Sun, 12 Sep 2021 11:47:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     "kernelnewbies@kernelnewbies.org" <kernelnewbies@kernelnewbies.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [Clarification] writes to kernel addresses that came from
 userspace
Message-ID: <202109121140.07EF06758@keescook>
References: <20210912162030.GA4692@titan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912162030.GA4692@titan>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Sep 12, 2021 at 06:20:30PM +0200, Len Baker wrote:
> I am taking a look to the issues in the Kernel Self Protection Project [1]
> and this one [2] (perform taint-tracking of writes to kernel addresses
> that came from userspace) take my attention. Reading the explanation does
> not make it clear to me where the flaw is.
> 
> [extracted from the KSPP]
> 
> It should be possible to perform taint tracking of addresses in the kernel
> to avoid flaws of the form:
> 
> copy_from_user(object, src, ...);
> ...
> memcpy(object.address, something, ...);
> 
> [end of extracted]
> 
> My question is: Why is this scenario a flaw?

I likely didn't give enough context in the Issue tracker. It's not a
flaw on its own, but rather an example of an attack situation if a flaw
were present (e.g. having no sanity-check on "object.address" above).

> If I understand correctly, the copy_from_user() function copies n bytes of
> src (in user space address) to object (in kernel space address). I think
> that it is the correct way to act. Then, in kernel space the object is
> modified. So, I don't see the problem. Sorry if it is a trivial question
> but I can not figure it out on my own.

The trouble is that the address came from userspace and (in this
example) has no validation, etc.

This Issue is about developing methods to perform "taint tracking"
within the kernel to better catch cases where validation is missing.
There is some limited support for this via the "__user" annotation and
the "address spaces" checks that "sparse" does, but that's been rather
limited in scope. Having something more like smatch doing function-graph
analysis would be nice for static analysis, and even better would be
stuff like DataFlowSanitizer[1], which can do this at runtime.

Hopefully that makes things more clear! I'll go update the issue
tracker. :)

-Kees

[1] https://clang.llvm.org/docs/DataFlowSanitizer.html

> [1] https://github.com/KSPP/linux/issues
> [2] https://github.com/KSPP/linux/issues/126

-- 
Kees Cook
