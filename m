Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD23C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Sep 2021 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2866B600D4
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Sep 2021 15:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239624AbhIPPiB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Sep 2021 11:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239978AbhIPPh7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Sep 2021 11:37:59 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB8EC061764
        for <linux-hardening@vger.kernel.org>; Thu, 16 Sep 2021 08:36:39 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id bg1so4071380plb.13
        for <linux-hardening@vger.kernel.org>; Thu, 16 Sep 2021 08:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=ENvOsyQTP3q+b7sG/A34KHGPYvoe5AEUOk70oriKBEY=;
        b=hEE4psC5jT2K7UdsYae884Fi6US6W+HiSw9IenKyuz+BFnhOu991MCrIQ0kI8p2EFz
         nwmWG+Y2+moyIutFt+4yJ0SitHFsPL8Z6nTV7DqEuOwQ8lke4/X6VnmIJ+0dxBeJb//y
         nrjN1bQXaqp2YI2iI3GnbQlIVHB77HkogMQJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=ENvOsyQTP3q+b7sG/A34KHGPYvoe5AEUOk70oriKBEY=;
        b=tqggT1UEaZPApg5s38vK3OZHTqG9F2wn/8kDK37XBRBhQfnUWU2aqSFhJM/9gHzNa4
         m+ZaFklfsEb0BWNzqLqiNg23haC4OpAcIpZhvRBtpfRtvFIKtpaaYVTVNOKjItU5IjHq
         iK2PRj62t85l8kEpf07oBams1cPYmZRA7up0qaPK2Rbyfik8ZuL+BdzGn5xxYDDHOXpk
         mMd2uj7Dv54VX/r8F0Voqudt+/QNlA9nJpQxJ9eGOotZIzc21hpgos64TixQvf93my5F
         fpWMGgLsHkaD7z2f7NM1bLq/i353dm9AMjihGAUyl8W6lcLRtfAkP/uSZV9IOefeCNXc
         ujqg==
X-Gm-Message-State: AOAM533o+mKyD4P62vVjC0Dp6psi6TUH8ahfYpe3qPWTFOzsSCdwU8rx
        7YWvtk/Ra7zbBTvBRtGCHRgxuuty+wmONw==
X-Google-Smtp-Source: ABdhPJwp6RCWH8PgplP50wYCPE7epJ5BF8mbwpACkKZiaHGTG08EtQhk/x9OlXnPbLEkFPcoJe+Sqw==
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr6818879pjd.171.1631806598477;
        Thu, 16 Sep 2021 08:36:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f205sm2510356pfa.92.2021.09.16.08.36.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:36:37 -0700 (PDT)
Date:   Thu, 16 Sep 2021 08:36:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Subject: bug scrub
Message-ID: <202109160827.7F5C1AFC7E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi!

I went through the issue tracker and tried to get issues updated, add
some new labels, etc.

Stuff of note:

- "Global flag" label[1], for compiler options to turn on globally in the
  top-level Makefile.
	https://github.com/KSPP/linux/labels/%5BBuild%5D%20Global%20flag

- Scrubbed per-arch issues, but mostly seemed to update the status of
  powerpc.
	https://github.com/KSPP/linux/labels/%5BARCH%5D%20powerpc64

- Collected all sub-bugs of the top-level "get rid of fake flex arrays"
  issue, so there's a single place to look at status.
	https://github.com/KSPP/linux/issues/21

As always, the "good first issue" list of bugs is a nice place for folks
to look through if they want to help out.
	https://github.com/KSPP/linux/labels/good%20first%20issue

And if anyone wants to continue the strlcpy removal work, I think it
just needs some rebasing and shepherding of patches through to subsystem
maintainers.
	https://github.com/KSPP/linux/issues/89


-Kees

-- 
Kees Cook
