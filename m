Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A249DC4338F
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 16:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F30610FF
	for <linux-hardening@archiver.kernel.org>; Thu, 19 Aug 2021 16:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhHSQZo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 19 Aug 2021 12:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhHSQZj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 19 Aug 2021 12:25:39 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8FEC061756
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 09:25:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso11731401pjb.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Aug 2021 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UyAqbe771W+Lff6kTHtxqnAb6wyR4jVkJwEdQgLmwXM=;
        b=RCXKCYv9ln5LbhRxVsZkAgrsxHMHPqdffVncbCoP8zHTR2s05PTRSMgK+hG8fnm1xI
         VE6KocOflCQf5XUe9L88OiJ4Gd0AvGpF0XcmTinZR6J2WFjWLqXyGYbTjTqdNZrTLIee
         af/RfWFTDj7DmtJmZJTbT1bZunbQVpzZBc1ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UyAqbe771W+Lff6kTHtxqnAb6wyR4jVkJwEdQgLmwXM=;
        b=mzrB3LySOz4egfQ77HdcdAMH1jf60cYtvo+mGjjDc0NElTmqDv5GMVLDuOK/6g2GQ8
         EguhT5PGKkAKvrZqUziGngXijjsZa2XnsIju/RzxRpTfedVLVf75zYl3vFYXNS7Op7VT
         2SZrJkd9ZuVN7i3UrKO6vYXpgFrq0V6D0TX0LdowqCJpFkZAC+b4vWIn1/jLdfP82Xb0
         5r2WTx2x8oKZD5Na/0MAMQBThip1xe1uVqhPtVywkMPoco0AEsTGBmUjvck6/rOD65aN
         sLF3nDlWo3ruEzxy1P8I9nlyCalgqwUexH2SrL6nmyGI9jVBxMX0WGmsM2ETvM1V55d4
         L2BA==
X-Gm-Message-State: AOAM533gScCTVY5LdBqqbz/SyH9UPXHzsPA6Z5V5NOg9tBYraKNlXPn6
        hQiL7ZZqmWwW/rdP89gebGtpMw==
X-Google-Smtp-Source: ABdhPJyq4LOVatvfadz65o72x/gkprpZlPk/8y+Qcd235dkYfx++eKkOf6dJ+KUNEdEavgccQRbFxg==
X-Received: by 2002:a17:90a:4894:: with SMTP id b20mr16180176pjh.13.1629390302929;
        Thu, 19 Aug 2021 09:25:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nn18sm8165841pjb.21.2021.08.19.09.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:25:02 -0700 (PDT)
Date:   Thu, 19 Aug 2021 09:25:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 45/63] ath11k: Use memset_startat() for clearing queue
 descriptors
Message-ID: <202108190923.30FD4FC6E@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-46-keescook@chromium.org>
 <87eeapbmhi.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeapbmhi.fsf@tynnyri.adurom.net>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 19, 2021 at 04:19:37PM +0300, Kalle Valo wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > field bounds checking for memset(), avoid intentionally writing across
> > neighboring fields.
> >
> > Use memset_startat() so memset() doesn't get confused about writing
> > beyond the destination member that is intended to be the starting point
> > of zeroing through the end of the struct. Additionally split up a later
> > field-spanning memset() so that memset() can reason about the size.
> >
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: ath11k@lists.infradead.org
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> To avoid conflicts I prefer taking this via my ath tree.

The memset helpers are introduced as part of this series, so that makes
things more difficult. Do you want me to create a branch with the
helpers that you can merge?

-Kees

-- 
Kees Cook
