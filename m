Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0340CC7EE32
	for <linux-hardening@archiver.kernel.org>; Tue, 23 May 2023 17:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbjEWRaT (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 13:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbjEWRaR (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 13:30:17 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2425BF
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:30:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d57cd373fso2310809b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 10:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684863012; x=1687455012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHRHm9cqQ7Q0n1UjBQwnZXDQwg6SsSkREtAQzpA0zS8=;
        b=SP811KKYOneg7dl/rmLOhy9/xH6sqzY2GnOzj4smgfmDjcrNa1t+TeWH+MftwdTdYc
         E4BW4v0YCWJszzUnIyk6s5yZ8eHJPHGmGtHHpiX8qXFCDB3eF6JRsj5bjXrESVN39YKd
         /i1og6RnHIp8XIO4y1LBmPTKuDNMNqYW0a7Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684863012; x=1687455012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHRHm9cqQ7Q0n1UjBQwnZXDQwg6SsSkREtAQzpA0zS8=;
        b=MDeYEKHu5sY1vvdGLjzx6ybG7vzNbqxsfZK9H6hhYMmxugWfQF7zzHFRLJvXLqDLRR
         A9EMMGe2DG+0g7EHkCWpvj8j1nwl0YDXKQ14uN/QHkTHUMvojl1d/kDq9LQSmR9GVUOk
         kAfvKAQKX57av4qAA5SsSYbcvR4Sd0pCd7BlXE1mja6sBPQT54BcfPPEgRIleTvnStJ/
         I5xuQOtSypL++VN6tcAsoTy3l3kTS38XwETqKfSh7tFtuClPFvxaO3HBRCQXVYcp3uj2
         3vxcKPJ9UkROJGwnUWx39bqR1Es18vFCtxBBof27cmLtbpWlTnRVIkul9jUy8QDcKKa8
         wctA==
X-Gm-Message-State: AC+VfDwQTFBREEZzC6YZcRx7HSGEvsNdhFUzDkvn7rlKkCGoMB9jiT4q
        JP/rtBd/d57aO9SUvhXk4IvNI6Dl750uy3sAX/s=
X-Google-Smtp-Source: ACHHUZ7YEdTfg2D6FXrXBlWvhCCMQ2QiK02a1DwN2Y+FEqHr4FZs/WDdEAE9LsGJyuvLGJwEHXnMcg==
X-Received: by 2002:a17:903:228d:b0:1a9:6a10:70e9 with SMTP id b13-20020a170903228d00b001a96a1070e9mr14552996plh.33.1684863012392;
        Tue, 23 May 2023 10:30:12 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001a1c721f7f8sm7073073plr.267.2023.05.23.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:30:12 -0700 (PDT)
Date:   Tue, 23 May 2023 10:30:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] vfio/ccw: Use struct_size() helper
Message-ID: <202305231030.5DE9FCD31@keescook>
References: <cover.1684805398.git.gustavoars@kernel.org>
 <f657276073630e806e69726a40ad1cc85101448a.1684805398.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f657276073630e806e69726a40ad1cc85101448a.1684805398.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, May 22, 2023 at 07:35:59PM -0600, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
