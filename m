Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3ECC4332F
	for <linux-hardening@archiver.kernel.org>; Fri,  4 Nov 2022 19:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKDTP1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 4 Nov 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiKDTPQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 4 Nov 2022 15:15:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229A48745
        for <linux-hardening@vger.kernel.org>; Fri,  4 Nov 2022 12:15:14 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y203so5324189pfb.4
        for <linux-hardening@vger.kernel.org>; Fri, 04 Nov 2022 12:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MEf9d311gYlVy+enAlEz8rGW1CJ9xfrOljmhcAt92Dg=;
        b=LhjGaHgkBVWHBr/Hub8tG7h7OMzM9VZ+F9/RSmJH3AmPOAxF3jcmpjLhRHst+xu34F
         En6EekpQvCmcfyhPAgT8Wnsm+PpVO9AydAUvODs7XTbkYHVHJw8YrzKiOS6WWcQgh1T1
         NSsrq4CnpSZUgzr5KqYrrWERL+HiysUc2s+us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEf9d311gYlVy+enAlEz8rGW1CJ9xfrOljmhcAt92Dg=;
        b=x9fleSZA/4RpLIQrhGwKCQ6SSVdQ0ZQayQASSbfhMZJmEpfgUnCFayMsFar+LEzi65
         TkWAwVfVzcg4oBYJS/mf6TQdCkFkiH9iTAtFNlTetgeRgpEc3trAWY9Aw3s/HXZ3eBIU
         LALETel1jsu1MYp9OPKnKFhalOH/lgc073QWePB39QgSjBCdqVomevrZTxGIaGb+RYC8
         BFIlkcwLDupCl/1N9SwFwObJZ1sSKOafmCTtdDynxpxOOLNMRpmmQrc6ubjvH96K8KYU
         07+d6DFOmOoikHzhApsFQY/3cT3A6T3zOAjad8HhaAZiOA9yv+O/ntB6fmyAphcom8W5
         27Gw==
X-Gm-Message-State: ACrzQf3pbbJc7rQaC31c5nLGGP1wh/B2frJYMzJej1iCZRrYA68h6zHC
        Y5Z84aPi2cPmsDOqpMCA/LGugw==
X-Google-Smtp-Source: AMsMyM7YfYNFEIynGzowgsu6m5LvrNg+n/4e5PtDyEWzcl6lmyrNsLMr56TmeYEshR0X8edL+EHHRg==
X-Received: by 2002:a05:6a00:1749:b0:56e:4586:4bc1 with SMTP id j9-20020a056a00174900b0056e45864bc1mr10268770pfc.41.1667589314056;
        Fri, 04 Nov 2022 12:15:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b0017f7e0f4a4esm126654pll.35.2022.11.04.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:15:13 -0700 (PDT)
Date:   Fri, 4 Nov 2022 12:15:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Gary Chang <gary.chang@realtek.com>,
        Timlee <timlee@realtek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Coverity: rtw89_mac_resize_ple_rx_quota(): Integer handling
 issues
Message-ID: <202211041204.CCA9C3F778@keescook>
References: <202211021253.44E254479@keescook>
 <884ff1b628e44d32960f438f75a6524c@realtek.com>
 <87h6zgfub4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6zgfub4.fsf@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Nov 03, 2022 at 08:03:59AM +0200, Kalle Valo wrote:
> I noticed that linux-wireless list was missing in CC, would it possible
> for the bot to automatically add that to all wireless related reports?
> Adding it manually now.

Yes, good point. The tooling was looking at the commit's tags, rather
than getting a get_maintainers.pl list. I'll add this logic.

-- 
Kees Cook
