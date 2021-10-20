Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1480CC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 22:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E21F86103D
	for <linux-hardening@archiver.kernel.org>; Wed, 20 Oct 2021 22:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJTW3H (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 20 Oct 2021 18:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbhJTW3G (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 20 Oct 2021 18:29:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F26DC06161C
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 15:26:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id i1so529965plr.13
        for <linux-hardening@vger.kernel.org>; Wed, 20 Oct 2021 15:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=fbp2dMqzqsLzaK2fqOr04ZEdLzjptq3j7UX1IpCxDuo=;
        b=laJaNRW6dzkM62xKhNNJkerUWs/XeBuYOGOym0ER4sQSZkhxb8hLQGIKyoxXLW8k1L
         P/d942ZnkrfJSPbiqeyewf2ftV3A+afkWuvuBOzHccw2cViL+tOEwYuLYmaFvv9YFuXQ
         s36u+9sSUOLr2NhCJNPH2CPr+GzirTvybGlTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=fbp2dMqzqsLzaK2fqOr04ZEdLzjptq3j7UX1IpCxDuo=;
        b=joqcWNNDQIs6Tg2WoHZOWSmUQ7EPQWsjl4X9Ze6F/UIs8jy+fw1d1m35+hM8n1SXkA
         8GvsHo0ShNz3uW+6AXkEDxMcDoGFQ3hhqjGFk7A6LyNU8Q1etZNDtxoMXMtmtREIGAbl
         TlNfcYFnKCF2wbOA5gemjDpJVCthGPWQANgLDMSCyLNv/ouDvG7m1jw9ONfkkbs41q5N
         6fg95Ti+3GhBBIh1zrizLtFejRLUlXzEDgdL4DCcqaMnfFhsJnmmDoNrYc0PBjW4srmO
         v74WGoQlp7d/SwfWFUUuDHkh/YQaKNmTpoLgtOWIeu4rgXvKNXTVStyrVFKSdRPL+oav
         K6TQ==
X-Gm-Message-State: AOAM530VpiHoiP9jjJo/AlFoyKForZ5NZTmxJGWQcQAIDYhuNOt0P87f
        ipr8f8D9kgOGqhd1/m0wYGyt9Df93QM=
X-Google-Smtp-Source: ABdhPJyn36Bux9lkSYQkr+BdUYk6jXpUXurMDz3Qq2YIob5KoxLCuKhd9stADWEFmSXS3AiFpGoilA==
X-Received: by 2002:a17:903:234f:b0:13e:e6e1:c132 with SMTP id c15-20020a170903234f00b0013ee6e1c132mr1684390plh.57.1634768811285;
        Wed, 20 Oct 2021 15:26:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id lb9sm977732pjb.25.2021.10.20.15.26.50
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 15:26:50 -0700 (PDT)
Date:   Wed, 20 Oct 2021 15:26:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: patchwork triage process
Message-ID: <202110201522.7C700A80D7@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi,

Here's my proposal[1] for handling the patchwork patch states:

New: No activity yet.
 - Move to "Under Review" (possibly with a delegate assigned to do the review).
 - Move to "Superseded" if a newer version of the same patch has been sent
   (the patchwork-bot usually does this automatically).

Under Review: Reviewers need to give feedback on the patch.
 - Move to "Changes Requested" if a new version of the patch is needed
   after review feedback.
 - Move to "Handled Elsewhere" if a non-linux-hardening tree says they are
   applying the patch.
 - Move to "Queued" if a linux-hardening tree applies the patch.
 - Move to "Superseded" if a newer version of the same patch has been sent
   (the patchwork-bot usually does this automatically).
 - In rare cases, a patch can be moved to "Rejected", but that is uncommon,
   as normally review feedback is expected to be acted on.

Handled Elsewhere: Going via another tree, but not yet in linux-next.
 - Move to "Awaiting Upstream" once a patch appears in linux-next (the
   patchwork-bot usually does this automatically).

Queued: Going via a linux-hardening tree, but not yet in linux-next.
 - Move to "Awaiting Upstream" once a patch appears in linux-next (the
   patchwork-bot usually does this automatically).

Awaiting Upstream: In linux-next, but not yet in Linus's tree.
 - Move to "Mainlined" once a patch appears in Linus's tree (the
   patchwork-bot usually does this automatically).

Mainlined: Done! In Linus's tree.


This should let us see each given state, and makes a distinction between
things going via one of the KSPP trees (Queued) vs a different subsystem
(Handled Elsewhere). i.e. we can check for stalled patches by getting
a list of all the "Handled Elsewhere" patches, since any that appeared
in -next should have moved on to "Awaiting Upstream", etc.

Thoughts?

-Kees


[1] https://kernsec.org/wiki/index.php/Kernel_Self_Protection_Project/Patch_Tracking

-- 
Kees Cook
