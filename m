Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBECC433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 14 May 2021 15:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE56C61166
	for <linux-hardening@archiver.kernel.org>; Fri, 14 May 2021 15:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbhENPCL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 14 May 2021 11:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbhENPCK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 14 May 2021 11:02:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57F8C061756
        for <linux-hardening@vger.kernel.org>; Fri, 14 May 2021 08:00:58 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z24so28369868ioj.7
        for <linux-hardening@vger.kernel.org>; Fri, 14 May 2021 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFbowzzPmTj3jyLGuQbNYzZiGpBZhRFAidVoo1PXCOE=;
        b=nSnM4FdnqKKZdRnCZ5mAj/2SIZby4F1z7eH5tCDrlx6dPi5pcoxOk6W1CsSyFERCNm
         fm2HWWqzIesnxZiIGrqaxzzjXEs1/wxJ9ZEH6+mXKBYt6y9lddtgQfB0jXRKQ3iXIL/R
         3mLlWLZfdLqQJbySkI5E7/Z7aJo8QxfY9M4MUCgYy1ESSmFqxzmzgcUCGrSeWkOmBx5N
         2SMMtuCy5hmvDXFMF6OwUbC3NScGKGU+GWYYftWR5x/rSU0p4hlXOlwS3slnN5umkeiC
         B6NUqgDXl/gA3iztIXIvlurZJyzwbcanoFLKtS+ZOv+WlpqZD3sgQmLQMCBBWW/e3oeB
         Agqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFbowzzPmTj3jyLGuQbNYzZiGpBZhRFAidVoo1PXCOE=;
        b=AtSXXyqGOOXS7qI0CNXI26s74z2H3r3ED+IWpxjK/zqayv6n6V0JXjAkI2cwdtIxDH
         /SSKjkF7S5275UppYQupbaLm2hl/R3wy+QMHTnNLNoFOMj6iNPaKIN77UckasZ3sI1hk
         QiOKfcU+K5jsT/7rjKI7TfGslvx87No9nmMhhW4OOvJAzuqV5SO1tdjSec9IVaxAT0re
         aOjH9hhpwX5eqfMOX2Sk0Yx8ped1ik4ATx4/guN/36RHAQUGXYcj14Igow1Pa2glfbLM
         h/zqXhRPgpxAYnW4ZdCTSo/6phpYCZzGMBc+zoH5Ad1gIlvh+2ffDEVJ3W5GyCrqQsGb
         Yw8A==
X-Gm-Message-State: AOAM533oBsMINjJ921Y0F/6cxnGfeuGLvbL5xMEn47SuyVJsY/B5uIBn
        BrW0tQb/9UFXLqgubUK5lGgn4XC73HMdig==
X-Google-Smtp-Source: ABdhPJyVcxAGjFolEtTidhP1667r0C4uVQOhyfuQG7f35Pu3QxM+iofTvJpr034kTL57GEgNZk/B3w==
X-Received: by 2002:a02:380d:: with SMTP id b13mr42709885jaa.77.1621004458045;
        Fri, 14 May 2021 08:00:58 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n16sm3117493ilq.44.2021.05.14.08.00.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 08:00:57 -0700 (PDT)
Subject: Re: [PATCH][next] rsxx: Use struct_size() in vmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20210513203730.GA212128@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb567b7b-5ea4-fe8b-52cc-f148ff6a61b7@kernel.dk>
Date:   Fri, 14 May 2021 09:00:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210513203730.GA212128@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 5/13/21 2:37 PM, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows
> that, in the worst scenario, could lead to heap overflows.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.

Applied, thanks.

-- 
Jens Axboe

