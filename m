Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B069C433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 13 Oct 2022 15:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJMP1X (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJMP1W (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 13 Oct 2022 11:27:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B87E3055F
        for <linux-hardening@vger.kernel.org>; Thu, 13 Oct 2022 08:27:20 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id l6so1837915pgu.7
        for <linux-hardening@vger.kernel.org>; Thu, 13 Oct 2022 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aUZ/46ycsp3DJEfmK/6AVnhgzohCjDWCaVCuiIUcej8=;
        b=Jgmk+CV61Utx3BgV0FoFGaeTX//b36caqIBOSaoe2IFWSx0k33sfei8VRnkfVCeiGz
         J0uv9Vuk6SRA3YthFh2pZEwbgs7cU97QjAU0cqPbrm+wNw+E6X/btYzkiKvKoxQp0IRr
         9wSCeGwuje917RHOZeMzpmGtV5/YbEcYLcHls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aUZ/46ycsp3DJEfmK/6AVnhgzohCjDWCaVCuiIUcej8=;
        b=4mom7MhPG+tX7tYGaXUPMrCxKvAa/6PWJXGyeFTFPwCjNH6U8+0EjQD7cho7zsCw4r
         COv8wmYPVwlH/69GtgGg0MGrpHRvanZ89za+nS9LYRYZqS2v9d1r65L80nn2GASj9Kxt
         KHFL7m8EVveZN42oolRfO6uozbj7ZauQ2PNN0zSYbZrO73w2m53FNWIPlRPllw0ft1E6
         L9rHX2Oe2gdUoGUSDDjwDsnxO8yvAaxTAQK6xh8ZRFCDGPjG4EhkVluwoucH4QYW8US6
         XFHAxrSEfwcvoD977rk6BpDSfi9p48pCBR0pdxMGan9jbEnEEiL2tHMd8hKrZm0RdoFL
         BDKQ==
X-Gm-Message-State: ACrzQf2P3wB2hETPBR9HXtIytqXaxl5stbUH4AxC7YowovS2h0TMmMJf
        ToLH9x/YvkXz/Wjm1Y+5bLQLqw==
X-Google-Smtp-Source: AMsMyM72ldvuO255gINJBzXpo3KG6ewB9Swic+SfkzzawRKS2qaM9Xre3yPOmNA0KJy4jNA0bqV1TA==
X-Received: by 2002:a63:c4e:0:b0:45f:795:c20a with SMTP id 14-20020a630c4e000000b0045f0795c20amr329465pgm.559.1665674839506;
        Thu, 13 Oct 2022 08:27:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3-20020a17090a2a0300b0020a1f091a0asm3367125pjd.55.2022.10.13.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:27:18 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 13 Oct 2022 08:27:17 -0700
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     Steve French <stfrench@microsoft.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: invalidate_all_cached_dirs(): Concurrent data access
 violations
Message-ID: <202210130827.48F03E2A39@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221013 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Wed Oct 12 16:54:23 2022 -0500
    a350d6e73f5e ("cifs: enable caching of directories for which a lease is held")

Coverity reported the following:

*** CID 1525256:  Concurrent data access violations  (MISSING_LOCK)
/fs/cifs/cached_dir.c: 396 in invalidate_all_cached_dirs()
390     		/* To prevent race with smb2_cached_lease_break() */
391     		kref_get(&cfid->refcount);
392     	}
393     	spin_unlock(&cfids->cfid_list_lock);
394
395     	list_for_each_entry_safe(cfid, q, &entry, entry) {
vvv     CID 1525256:  Concurrent data access violations  (MISSING_LOCK)
vvv     Accessing "cfid->on_list" without holding lock "cached_fids.cfid_list_lock". Elsewhere, "cached_fid.on_list" is accessed with "cached_fids.cfid_list_lock" held 5 out of 6 times.
396     		cfid->on_list = false;
397     		list_del(&cfid->entry);
398     		cancel_work_sync(&cfid->lease_break);
399     		if (cfid->has_lease) {
400     			/*
401     			 * We lease was never cancelled from the server so we

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1525256 ("Concurrent data access violations")
Fixes: a350d6e73f5e ("cifs: enable caching of directories for which a lease is held")

Thanks for your attention!

-- 
Coverity-bot
