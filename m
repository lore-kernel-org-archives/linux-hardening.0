Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6525C63697
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 01:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEA422255
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 01:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Bl2Vu6Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKTBfr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Nov 2020 20:35:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbgKTBfq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Nov 2020 20:35:46 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5863322254;
        Fri, 20 Nov 2020 01:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1605836144;
        bh=mQahlZ4oBkXPItMF4u4Zjyv8WH7f9AQL+MGPFjxwPa4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bl2Vu6Gt2cxOBoF8QYWx3yITQmECR0Z2YJdDa2eB/UlWFYiU2LxwmQmtu7aQf3t/c
         FELxlAHHd25VPIMj9cSoy1JjV5rPGRiQCCOGAXbrF1u7g2usKbwJx+tIX18idLtseI
         M8BiV1QglGu8U/7r6Y2q1Lphj/mPSSBIgM2FRWbg=
Date:   Thu, 19 Nov 2020 17:35:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     laniel_francis@privacyrequired.com
Cc:     linux-hardening@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dja@axtens.net, keescook@chromium.org
Subject: Re: [PATCH v6 0/5] Fortify strscpy()
Message-Id: <20201119173543.8821881942022fc4f39c4c73@linux-foundation.org>
In-Reply-To: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
References: <20201119164915.10618-1-laniel_francis@privacyrequired.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, 19 Nov 2020 17:49:10 +0100 laniel_francis@privacyrequired.com wrote:

> From: Francis Laniel <laniel_francis@privacyrequired.com>
> 
> Hi.
> 
> 
> I hope your families, friends and yourselves are fine.

Thanks.  You too ;)

> This patch set answers to this issue:
> https://github.com/KSPP/linux/issues/46

I fail to understand what this patchset has to do with that
one-element-array issue :(

> I based my modifications on top of two patches from Daniel Axtens which modify
> calls to __builtin_object_size to ensure the true size of char * are returned
> and not the surrounding structure size.
> 
> To sum up, in my first patch I implemented a fortified version of strscpy.
> This new version ensures the following before calling vanilla strscpy:
> 1. There is no read overflow because either size is smaller than src length
> or we shrink size to src length by calling fortified strnlen.
> 2. There is no write overflow because we either failed during compilation or at
> runtime by checking that size is smaller than dest size.
> The second patch brings a new file in LKDTM driver to test this new version.
> The test ensures the fortified version still returns the same value as the
> vanilla one while panic'ing when there is a write overflow.
> The third just corrects some typos in LKDTM related file.
> 
> If you see any problem or way to improve the code, feel free to share it.

Could you please send along a reworked [0/n] cover letter?  Explain in
your own words, without requiring that readers go off and read web
pages

- What problem the patchset solves
- How it solves it
- The value of the patchset (to kernel developers or to end-users) so that we
  can understand why it should be merged.

Thanks.

