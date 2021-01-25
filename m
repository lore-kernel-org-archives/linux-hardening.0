Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FDBC433E9
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Jan 2021 22:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC62B22582
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Jan 2021 22:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732803AbhAYWDw (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Jan 2021 17:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733207AbhAYWDt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Jan 2021 17:03:49 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8AC061573
        for <linux-hardening@vger.kernel.org>; Mon, 25 Jan 2021 14:03:09 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so9205126pfm.6
        for <linux-hardening@vger.kernel.org>; Mon, 25 Jan 2021 14:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9uTkelnkgdH1/h1qSEC3+KB2ZZOMZMIqxRYnkoanZM4=;
        b=e48pg2fnQuL945QN5H8Vqv7bjX7l4CQIY5iNiZMX75XZLI2m+HxbhLqfsgNifpr/SZ
         qaR8nCtuU+N+h4snOkvPLNyDR8PxaMl8kXfvWPiXP/auSxLP+ru06vivV0yQ5r/mJqDh
         Pq1GsRCAqqvXIL7IvnbcFpPZJMU3JssEpiHKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9uTkelnkgdH1/h1qSEC3+KB2ZZOMZMIqxRYnkoanZM4=;
        b=Kd2mU3uyAYnWkHWzuRqNFQzVrhTR+En762y4Fw8H0MLlHXj7ZYzm/r4DluXKLVpLls
         KzJV3oeLrgkxfzS2Dx14S5DlvtgQ+osVwozOYlZf4+/Col2WpAg3yilV0G2isPVPh1kg
         UuhhpWFee7szZtKEYzW5gUXgVpaLPM69iibKL9USB9VATK83oTqV80aLlOx2SDt1RCui
         B+BPG9a6MeZMI+xdr2L/La2Pf0KFKEfPU1twQiz77xQ25vJHHA3ukWahMVE9DWsV9IUh
         ickbNGxuCCaxy9E3D61xrM4vzE0OY/TLO3VAGxUr9IigackBt6JOus8YRgh2WE4nwdtr
         ejTg==
X-Gm-Message-State: AOAM530mQK/1YORY93L8G5C/R3+6utRWHPpjGNYMeX1UEHx7h4vOhZSC
        cCnXjU6MirHJRpfxgLOZRMTNUQ==
X-Google-Smtp-Source: ABdhPJxELKHojiOS5LE+ZaEcSNUqh2aAeWOTc0igtRFBcAtlACI3x+7qSajwJcaRvf2ETtq/yQ/s3A==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr2597849pgm.295.1611612189024;
        Mon, 25 Jan 2021 14:03:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a131sm18614270pfd.171.2021.01.25.14.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 14:03:08 -0800 (PST)
Date:   Mon, 25 Jan 2021 14:03:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT
 modules
Message-ID: <202101251401.F18409FDD1@keescook>
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> When a GCC version mismatch is detected, print a warning and disable the
> plugin.  The only exception is the RANDSTRUCT plugin which needs all
> code to see the same struct layouts.  In that case print an error.

I prefer this patch as-is: only randstruct needs a hard failure. The
others likely work (in fact, randstruct likely works too).

Masahiro, are you suggesting to be a hard-failure for all plugins?

-- 
Kees Cook
