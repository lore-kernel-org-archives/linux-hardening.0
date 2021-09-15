Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFB1C433EF
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Sep 2021 11:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A70A60698
	for <linux-hardening@archiver.kernel.org>; Wed, 15 Sep 2021 11:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbhIOL74 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 15 Sep 2021 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbhIOL74 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 15 Sep 2021 07:59:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA72C061574;
        Wed, 15 Sep 2021 04:58:37 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d07000c3d48728178681f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:700:c3d:4872:8178:681f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 08E451EC0246;
        Wed, 15 Sep 2021 13:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1631707112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7hCArrqxq0Qci8ylNfmgdAjsDrtbpQawOVjshhDjY7E=;
        b=OSalYsvT788Z61aexg2fiPKFerIUw4nOwq3ZBuMk4dVxJ2yMEER3//m6AsY+jyns8JUIHl
        hmkUgdawNrvbNhOd/qstaU3Gh+pR8ih6/sKMU8/J4i/wxRYGgPLl0D9WgyPN/BHGz4lYP3
        Nh9cr2J7i0LkxZbZ6aGwb9nTS8HptTI=
Date:   Wed, 15 Sep 2021 13:58:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rric@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Joe Perches <joe@perches.com>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/mc: Prefer strscpy or scnprintf over strcpy,
 sprintf and snprintf
Message-ID: <YUHf4cEEKFjQznJS@zn.tnic>
References: <20210903150539.7282-1-len.baker@gmx.com>
 <YT8S3poKyd5Nr5cK@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YT8S3poKyd5Nr5cK@rric.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 13, 2021 at 10:59:10AM +0200, Robert Richter wrote:
> From 01a3c62a533e71984dfff7189e247b3e848f1449 Mon Sep 17 00:00:00 2001
> From: Len Baker <len.baker@gmx.com>
> Date: Fri, 3 Sep 2021 17:05:39 +0200
> Subject: [PATCH] EDAC/mc: Prefer strscpy or scnprintf over strcpy, sprintf
>  and snprintf
> 
> strcpy() performs no bounds checking on the destination buffer. This
> could result in linear overflows beyond the end of the buffer, leading
> to all kinds of misbehaviors. The safe replacement is strscpy().
> [1][2]
> 
> However, to simplify and clarify the code, to concatenate labels use
> the scnprintf() function. This way it is not necessary to check the
> return value of strscpy (-E2BIG if the parameter count is 0 or the src
> was truncated) since the scnprintf returns always the number of chars
> written into the buffer. This function returns always a nul-terminated
> string even if it needs to be truncated.
> 
> While at it, fix all other broken string generation code that wrongly
> interprets snprintf()'s return code or just uses sprintf(), implement
> that using scnprintf() here too. Drop breaks in loops around
> scnprintf() as it is safe now to loop. Moreover, the check is
> needless: For the case when the buffer is exhausted, len never gets
> zero because scnprintf() takes the full buffer length as input
> parameter, but excludes the trailing '\0' in its return code and thus,
> 1 is the minimum len.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> [2] https://github.com/KSPP/linux/issues/88
> 
>  [ rric: Replace snprintf() with scnprintf(), rework sprintf() user,
>    drop breaks in loops around scnprintf(), introduce 'end' pointer to
>    reduce pointer arithmetic, use prefix pattern for e->location,
>    adjust subject and description ]
> 
> Co-developed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Len Baker <len.baker@gmx.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/edac/edac_mc.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
