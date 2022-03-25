Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F5C433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 25 Mar 2022 22:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbiCYWiC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 25 Mar 2022 18:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbiCYWiB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 25 Mar 2022 18:38:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DE2527F6
        for <linux-hardening@vger.kernel.org>; Fri, 25 Mar 2022 15:36:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b15so7643966pfm.5
        for <linux-hardening@vger.kernel.org>; Fri, 25 Mar 2022 15:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=66gIpeXcj5574AY6+wxqIKtN1GXT+H4zW/55ds9MTRA=;
        b=Pehj9tXJ4jzHdSs9n3UJ6sf8byvgBPWfgS568/84c46HBvPWXXsvdd8pAEE2HzzzdY
         nhBsal9nGQ7ZgSXnQd9IetpG0IdzOgDsbdffL/rqAdzghtq62mKAtGJ4aJMAiJzpd60K
         sk4O1Q2hg3+cF5cPtgpMcYhNZQgEAlSy77zvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=66gIpeXcj5574AY6+wxqIKtN1GXT+H4zW/55ds9MTRA=;
        b=UYGt4XKYm9eOSt8S5lMwj/fAGrwiopioBPFQ8feOwYQLUgsRfzD+xhdbLkmqY1qQXk
         Otnx+7K1gKrunQqQ7l4ugDhI3Bb8qLrV77R1xdIWzWf3Qb2MwglRxrb+iEtbONW541TV
         zpdOQdCHPOkJwPq99ogj9k1SkN81StYNLBIi1sHq8cyb7jihIojHSFerrUAxs6zRLK1G
         rbTeRRjyK9neToE+dG9DWPY0GYucmW/m7sXXLFGaO1xjJoWAT6pjTd5GWBlG2VxgkIGK
         nchBF1E2dvGN/zUhkzSEqqLzshYt3atMlvQfcatCLF0Bhchno3siAHRBKMVLZApZmScM
         aJ+A==
X-Gm-Message-State: AOAM531IpssPtjEp/RT5XIL2aWTVwa3lcb0J7e3xkHJ9G0885lr2e+v0
        g4BRv5VL5Q2bKwEqAjCtScDhMQ==
X-Google-Smtp-Source: ABdhPJwG2BRVqQ2ziox0dNsT7VEIXbPPkmt2DvxPblXiXuRWJAFlpkxVnnE+ApT4WaXP9qsdh951NA==
X-Received: by 2002:a05:6a00:ad2:b0:4f1:2734:a3d9 with SMTP id c18-20020a056a000ad200b004f12734a3d9mr12393340pfl.61.1648247785019;
        Fri, 25 Mar 2022 15:36:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id be11-20020a056a001f0b00b004fb29215dd9sm398786pfb.30.2022.03.25.15.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 15:36:24 -0700 (PDT)
Date:   Fri, 25 Mar 2022 15:36:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/harness: Run TEARDOWN for ASSERT failures
Message-ID: <202203251535.4B900BC0@keescook>
References: <20220324231907.1363887-1-keescook@chromium.org>
 <20220324231907.1363887-2-keescook@chromium.org>
 <f705c381-cbe6-0862-e10f-44f2afdef24d@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f705c381-cbe6-0862-e10f-44f2afdef24d@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Mar 25, 2022 at 01:37:20PM -0600, Shuah Khan wrote:
> On 3/24/22 5:19 PM, Kees Cook wrote:
> > The kselftest test harness has traditionally not run the registered
> > TEARDOWN handler when a test encountered an ASSERT. This creates
> > unexpected situations and tests need to be very careful about using
> > ASSERT, which seems a needless hurdle for test writers.
> > 
> > Because of the harness's design for optional failure handlers, the
> > original implementation of ASSERT used an abort() to immediately
> > stop execution, but that meant the context for running teardown was
> > lost. Instead, use setjmp/longjmp so that teardown can be done.
> > 
> 
> Thanks for the patch. The change look good to me.
> 
> > Failed SETUP routines continue to not be followed by TEARDOWN, though.
> 
> Does this mean failed setup() routines have to handle TEARDOWN? What
> are guidelines to follow for setup() failures?
> 
> Can you add a bit more detail on what you meant by " Failed SETUP
> routines continue to not be followed by TEARDOWN, though".

Sure! It means that any failures in a SETUP need to be cleaned up by the
SETUP, as TEARDOWN won't be run. (As in, this is unchanged from how
things behaved prior to this patch.)

> 
> With that:
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks!

-- 
Kees Cook
