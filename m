Return-Path: <SRS0=+MkC=DJ=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E0C46466
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Oct 2020 23:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71474206B6
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Oct 2020 23:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LOTTLgi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJBXza (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Oct 2020 19:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJBXza (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Oct 2020 19:55:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5340DC0613E3
        for <linux-hardening@vger.kernel.org>; Fri,  2 Oct 2020 16:55:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id i3so1864083pjz.4
        for <linux-hardening@vger.kernel.org>; Fri, 02 Oct 2020 16:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rqxvmSasQjlgVbaPeIKaSrToGxLtYT0M0RkvDPPApmc=;
        b=LOTTLgi5WeWLE3h3cPaIzvWhlk0qSvrVGP6jVVq8gW3kmepi+rLBD4t1C16kWjsntn
         KS/qYioUIuhZtFgK5dleAi2COwm1VZHspZjN7GE3o+BO1iWMSfhgmxOWYO4VzRfu3VaR
         CjlbmQPs6eWxh8xUib5SUxuQinNjvppw7pys+R7FgudePCkAkpuG7qocPLX4QGGKarBU
         t57hXCNZ/JRSWja3UIE2J1e8Igkz/HVl/ioCHkXP2bYd/ZLeFoPl8LOxemoMzZsC/z7k
         c38NAowwbPZqMRGR+IdimNJj4TahRZ45zhYfMduWbta+CLgZXVazzxppYRo1u3O40i87
         SkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rqxvmSasQjlgVbaPeIKaSrToGxLtYT0M0RkvDPPApmc=;
        b=UV1/OMwTlF3C3C7M2s1cdOY4VbTGt2X2BRlu3ny0OCxhpIsTausqVmbq3dQzl/CiIl
         CeJjZ1NYIOtDv1vNEpNTsUDgurFWNElw26wqwplIemZUmuQutUKpIwZp1vfA8vhoCweF
         GxhGfnI16zYpYoMZHMFZlNGz75ovTDqRO3b9Ve8JXHm6TQQIoeruoYavAIvE3v1kXAXt
         9or4l/9HQnp5iksZQDQrDwI+UdjFq1IHPP/xk+e2av6rjuLI3p6qJgneKy5XypYDSGNj
         WFXaKNpNWT+q6CtZCJg8bmjLKjxB7pN2SX8eIDJbW1eWqs3KZScbcEQjFNiuiLm9Qk/A
         /Wmw==
X-Gm-Message-State: AOAM530KJQYlhh91RgUAmppJ+Dkendmv2Kt3dJLdakI8XN8tzuW0Q9I7
        R+PChsCDuyt27TB4ombS5BfTuGmedD1v/dhi
X-Google-Smtp-Source: ABdhPJxAubvtUF5U07ypj+nujnmOFtmQNvBFDt1wJZbt8c9NbwJDa6TctAJgZcWyGsHNqzQTYQLC6A==
X-Received: by 2002:a17:90a:94c1:: with SMTP id j1mr3273371pjw.120.1601682928624;
        Fri, 02 Oct 2020 16:55:28 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w195sm3240685pff.74.2020.10.02.16.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 16:55:28 -0700 (PDT)
Subject: Re: [PATCH][next] rsxx: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20201002235928.GA13477@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ff2b483a-004f-2653-db65-8d1e3c48fe1c@kernel.dk>
Date:   Fri, 2 Oct 2020 17:55:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201002235928.GA13477@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 10/2/20 5:59 PM, Gustavo A. R. Silva wrote:
> Replace /* Fall through. */ comment with the new pseudo-keyword macro
> fallthrough[1].
> 
> [1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Applied, thanks.

-- 
Jens Axboe

