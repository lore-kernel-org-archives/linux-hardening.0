Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC50EB64D7
	for <linux-hardening@archiver.kernel.org>; Tue, 20 Jun 2023 19:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjFTTvI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 20 Jun 2023 15:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFTTvG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 20 Jun 2023 15:51:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342D1712
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 12:51:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6686ef86110so1775083b3a.2
        for <linux-hardening@vger.kernel.org>; Tue, 20 Jun 2023 12:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687290665; x=1689882665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fEQfxADvgSzjQCfBomhgDaEgGtqyU75um/V6Dxu05cc=;
        b=bYg+oupnLPHq6deMXlRsxgjqDTrfbi7ADGIUtbQfBQXgJObZaO/KjayEbPgKT45RRz
         icYzOrlCbPuoaZu8Xl+6oXqqOBi/yyNQJ8SwgCBgJUredayRBaNxkcYKZygJDu16iCwy
         OMnbMkyBU6X4YOPCSK3RdowMxqqtNjyQ0QM8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687290665; x=1689882665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEQfxADvgSzjQCfBomhgDaEgGtqyU75um/V6Dxu05cc=;
        b=YiQ6NP5b89YC6XI5L2bxa7iwdWhiXka0JSUbPqr2qSvh0Hq6AyGs6nfq/kunGBpuHf
         CVbf2lpA1tFd+yOnvbVkKAXZoy+UZNp0+w1bPGUmba/XkGREvSGd5CUQuH5xsmGiR0wc
         qJQsZRBUrDsI3JZE2dYizzi7DGcqfQxuH9i3OXFAMy6LIweOBGKbTo25TUXS6pkpSgKK
         s/t1BGo1IFluuTu4Hoekuh0BzsnNQxPCdysAFSZ7MLogL+GzjaCtpNk7I8KT0ejlChAy
         Cn9TvKA1iPHwI8HPZiASzEW52xkx4916ZaciASUf53UN8s0yGwGNLcPmxvPXPzfaWORV
         uXrA==
X-Gm-Message-State: AC+VfDzSkup0C11bvv5RRT31MLwFixhlnpKedVXxg+TcLgHOUXEmDsD3
        qaIdqEMHa+5EInOW+Gz4VVLj5A==
X-Google-Smtp-Source: ACHHUZ4TimNUxg4QuYmqqw/d7bpUNnlZ+a7/HOjhOBUmPcWtRzW9sHMHAQboQezXlCCQItZp438xZg==
X-Received: by 2002:a05:6a00:1913:b0:668:7292:b2c2 with SMTP id y19-20020a056a00191300b006687292b2c2mr5636126pfi.2.1687290665523;
        Tue, 20 Jun 2023 12:51:05 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fe10-20020a056a002f0a00b0064f95bc04d3sm1655296pfb.20.2023.06.20.12.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 12:51:04 -0700 (PDT)
Date:   Tue, 20 Jun 2023 12:51:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] cgroup: Avoid -Wstringop-overflow warnings
Message-ID: <202306201250.6FA10ADF4@keescook>
References: <ZIpm3pcs3iCP9UaR@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIpm3pcs3iCP9UaR@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 14, 2023 at 07:18:22PM -0600, Gustavo A. R. Silva wrote:
> Address the following -Wstringop-overflow warnings seen when
> built with ARM architecture and aspeed_g4_defconfig configuration
> (notice that under this configuration CGROUP_SUBSYS_COUNT == 0):
> kernel/cgroup/cgroup.c:1208:16: warning: 'find_existing_css_set' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:1258:15: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6089:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> kernel/cgroup/cgroup.c:6153:18: warning: 'css_set_hash' accessing 4 bytes in a region of size 0 [-Wstringop-overflow=]
> 
> These changes are based on commit d20d30ebb199 ("cgroup: Avoid compiler
> warnings with no subsystems").
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Ah nice, this should reduce code size for the "0" case too.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
