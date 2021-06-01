Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376BEC47080
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1233A6136E
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Jun 2021 19:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbhFATVi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 15:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbhFATVi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 15:21:38 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98789C06174A
        for <linux-hardening@vger.kernel.org>; Tue,  1 Jun 2021 12:19:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k7so253503pjf.5
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wa3tfZkQDm9TvrFXBZKWvxHdH+rOnl8AA6gAmq+Y2uM=;
        b=CYG5wL1m+hCUv7NGyL8Px1fwffuroKyA9gqy5GOPvLkphf7CjzplzTJ19fSryAdE4R
         f2A2IhQAFxuyCKISyCs8zLzitEbGgQNVEuChC8k+xLlZBoEiu9iJzXj6GFmycwfsZrxF
         XUBXttcIy07v84XPj08DmBxZekJq03S95PkO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wa3tfZkQDm9TvrFXBZKWvxHdH+rOnl8AA6gAmq+Y2uM=;
        b=P7OQF5UEmvMv69y++IRHdPEUEFKnli4KZR3QHrSbrRsn+l/U3oMxUdbHjcwIYjzwZI
         yKDbmDBUtTWpD6ymLwhVJuU4qUYhbaYEQ4rbIhJjr/NlNL0xfiKNnR9+elyXV87kLw9B
         XR4w5lf9lD+SHn44RfKGWP+YTNXzpM7i+UVFqfMRYWwS8f8UNrLLiqT35MZdS7pL59R0
         YCDHdXGeF10ylXreT+RRWwSCIhnZ4km5qlMXfzwMtN1rsoqS+prPPjtw1jkWF84UhbDi
         7soiR4mKF2l5ikq4WJFAUwwpsL+kx6pvx5G4FFnrSMJN75kOG4SW3lllgmNti4RCoxof
         jOkg==
X-Gm-Message-State: AOAM530PxTFM9/1mmYuubQtCKoJjDS2HoapQiJ7yuxIZJvPIV7CegxkX
        VB4X/6li3P1kt9W5lduzzHajJQ==
X-Google-Smtp-Source: ABdhPJysqN3oMZZG8qhK3KubBfIOYsd0zeYnnq+4hXl13bxXx0uESRScyJhRv4+mAdyWJvMCLRGBwQ==
X-Received: by 2002:a17:90b:1c0a:: with SMTP id oc10mr13444939pjb.7.1622575196225;
        Tue, 01 Jun 2021 12:19:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n6sm15455368pgm.79.2021.06.01.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 12:19:55 -0700 (PDT)
Date:   Tue, 1 Jun 2021 12:19:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: axienet: Fix fall-through warning for Clang
Message-ID: <202106011219.3B06ABBF@keescook>
References: <20210528195831.GA39131@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210528195831.GA39131@embeddedor>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, May 28, 2021 at 02:58:31PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding a fallthrough statement instead of just
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
