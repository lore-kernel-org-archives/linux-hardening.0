Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F5DC6FA83
	for <linux-hardening@archiver.kernel.org>; Sat, 24 Sep 2022 06:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiIXGG1 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 24 Sep 2022 02:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbiIXGGY (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 24 Sep 2022 02:06:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA0713AF01
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 23:06:21 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2067041pjm.5
        for <linux-hardening@vger.kernel.org>; Fri, 23 Sep 2022 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=AWMu/McMAHOInUGLKjW0IWLj+xXBo94zkzcoUaCWYEo=;
        b=T2J7+KLc0zkKZJu6SL+njcGC21cUjTVY9l5pGzwaqBnNZ4CYr2MlWY1nKxJXONgXcT
         45WdyRdan+VWD41IyM6Dzdha1p80JP3H8YkwCDkXxRlCCZ0Z/C4e9iq9GyxxiUeljGu4
         BQz4dNiUYUKZ5QME1dIqO7S6x18NZRrUfsZyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=AWMu/McMAHOInUGLKjW0IWLj+xXBo94zkzcoUaCWYEo=;
        b=DJgvFuStDfO5xtFcdzpfyak/UBcFJ7gEabYxyPJYJFwFCBN2SWTtB3Lq+qaSX81ul0
         I6YWKfYrhxmV34pZMhovt6dkZdydIykEMtCbN2V4Cv6Ec6AWU7Liltd8cQzn1FlNNTOW
         ZhKF2v4eGjfz3Ulo5awx8FEhzDHC42SJTV7ktqxoXHiHF+1nB7MQQ4wm0Vu5x22ewKzL
         2qe9epe5BDUhaJIcv3gtQ11ztQpSYLOw6E4/HfkcOapWt236hOfS4AMay+dMMlbOvWQ1
         OhqWXZM42GTUhlOMsvYCOpHqfeN3+mDWc8d3iTVQgVm2q/eNx0pFMlFQChR3x8KBkjVb
         Q5QA==
X-Gm-Message-State: ACrzQf2Yiq+earwA1soRu71hX5d9xDAjttKrW4LdTh26jnY3igKA9njL
        V8LyeSmlGOHP835pvhL/XrSC7A==
X-Google-Smtp-Source: AMsMyM4StouRatp1QX9v6675j36Y+QCSYAjjgPuayYL8XnlJhFb4lPSj6MMHONev0v15ZRZENXFZDA==
X-Received: by 2002:a17:90b:1bc7:b0:202:52ce:a1d with SMTP id oa7-20020a17090b1bc700b0020252ce0a1dmr13750710pjb.110.1663999581220;
        Fri, 23 Sep 2022 23:06:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902714d00b00178aaf6247bsm7045441plm.21.2022.09.23.23.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 23:06:20 -0700 (PDT)
Date:   Fri, 23 Sep 2022 23:06:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2][next] scsi: hptiop: Use struct_size() helper in code
 related to struct hpt_iop_request_scsi_command
Message-ID: <202209232305.60356F5EDF@keescook>
References: <cover.1663865333.git.gustavoars@kernel.org>
 <54e2bb1e39b21394c5a90cacbadfb6136b012788.1663865333.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54e2bb1e39b21394c5a90cacbadfb6136b012788.1663865333.git.gustavoars@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Sep 22, 2022 at 11:55:33AM -0500, Gustavo A. R. Silva wrote:
> Prefer struct_size() over open-coded versions of idiom:
> 
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * count
> 
> where count is the max number of items the flexible array is supposed to
> contain.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks correct; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
