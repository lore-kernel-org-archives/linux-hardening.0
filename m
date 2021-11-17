Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22989C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 00:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C71C61547
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Nov 2021 00:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKQA0o (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 16 Nov 2021 19:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhKQA0n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 16 Nov 2021 19:26:43 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC69C061746
        for <linux-hardening@vger.kernel.org>; Tue, 16 Nov 2021 16:23:46 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w22so876861ioa.1
        for <linux-hardening@vger.kernel.org>; Tue, 16 Nov 2021 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=zsadljEAoTW1O/e6cBvAvPdWibAzK1CvOl83K6umqDA=;
        b=Cw5MV68s67fj6e6eunrAfI8H7rqe/BTcJGJBpr6DRoKSdSqEtBsi5ls/9TuKBbVI8J
         q1K1VTKED0cHapqbe+bwWL4K9RJ6plgB0OgwkiebykgvzpQILjZF1+wf9nn8ti+FB7tC
         hw5rLPDHB0l6iWz53ihirPji06SIRyVp0ZYQRhj7UhHj3gQWUbHH9VPwXIxSvmGO2p9F
         w8OxFY+bNSm++4n/GikcCV0uz41W+BAQXjlSgckec0cGDAEQbk0asp2DVrY4DBm6UUiw
         5rjCx71CF5RtjbJTwM768S8xDO+Rx2ykNiOIRBc5BAGdLGbThM2lARm8VjiFKmwt/KhA
         VsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=zsadljEAoTW1O/e6cBvAvPdWibAzK1CvOl83K6umqDA=;
        b=p63a3EiVlekltusKW7w3dGH+UVIvpJ46LX8oXQm7AzBBWt9A3huUZ3j0cPi7e9M1Oo
         q+hcSqAvb1PfA/sEVuB8HMQBEEzao2PckCj9Gb9owbhDVMCUN8iA53wUFEhM148uRrzd
         wRZTf9DmW6/6fe/HNGm7uLoHd8HVzePsGjMBW++NRkjZZhavs7z0AJ2uoeNd04nNGjgW
         N0GhbB//FSgmXMZst1vi+3r7UImLe4ry0yzs3LPtGC99CRPkQEtLPsSZ5AbL/V3e+2vc
         DNUDL1XsahyG5fvgh6b6i8d50aROp0zgqJ43I+aWpttMz9JBqeLbwUp26jBslmMex8Xs
         14lA==
X-Gm-Message-State: AOAM532TvP68t6oc33WazG4ufqsys7rn/FtLk4x4Cj0R7YTwGLO+Jxvt
        7ErTX8M8XVswsRYPoE7E7CDJCw==
X-Google-Smtp-Source: ABdhPJyD3SUnIXbcZ9FIm143ErrNjM4H/LvjYDgSMsBFswHxvwmWNYHdOuryNqeFN5/zGT/1kSbgDQ==
X-Received: by 2002:a6b:ea0a:: with SMTP id m10mr7997067ioc.91.1637108625356;
        Tue, 16 Nov 2021 16:23:45 -0800 (PST)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h19sm13701133ila.37.2021.11.16.16.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 16:23:45 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Colin Cross <ccross@android.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Christoph Hellwig <hch@lst.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-hardening@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20211116181559.3975566-1-keescook@chromium.org>
References: <20211116181559.3975566-1-keescook@chromium.org>
Subject: Re: [PATCH] Revert "mark pstore-blk as broken"
Message-Id: <163710862474.168539.12611066078131838062.b4-ty@kernel.dk>
Date:   Tue, 16 Nov 2021 17:23:44 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 16 Nov 2021 10:15:59 -0800, Kees Cook wrote:
> This reverts commit d07f3b081ee632268786601f55e1334d1f68b997.
> 
> pstore-blk was fixed to avoid the unwanted APIs in commit 7bb9557b48fc
> ("pstore/blk: Use the normal block device I/O path"), which landed in
> the same release as the commit adding BROKEN.
> 
> 
> [...]

Applied, thanks!

[1/1] Revert "mark pstore-blk as broken"
      commit: d1faacbf67b1944f0e0c618dc581d929263f6fe9

Best regards,
-- 
Jens Axboe


