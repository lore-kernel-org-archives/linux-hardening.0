Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDF0C4332D
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C69964F93
	for <linux-hardening@archiver.kernel.org>; Fri, 12 Mar 2021 02:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbhCLCv7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Mar 2021 21:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbhCLCvq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Mar 2021 21:51:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB39DC061763
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:51:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso10348239pjb.4
        for <linux-hardening@vger.kernel.org>; Thu, 11 Mar 2021 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+3EEyNm7eQ8LTzAuPOfFBo4tKw3xvJrFxDmdpJEANQ8=;
        b=Pw0Wytol3V1W1jSYagNaJuoK7dXXVqpzVhqhkG56gvEbW066nxOADg+yZY9AVoynyD
         HDYm5Fde8wmAQx7uPQFDPwi7KHT0dmeOix4wwzMnENWIDI6GBjFZNEqoJTIFx3IBUknr
         HTdlPPCLI0gUJoS0n7BVVl/PH9ri450DvLqhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+3EEyNm7eQ8LTzAuPOfFBo4tKw3xvJrFxDmdpJEANQ8=;
        b=HBWGy2msv1BmEigF8CMKOgC3nPpeyv/r2V1nP/YO1lNtt9ClG3FVIZ3b64bDq3d7Im
         3l0xaT7fug3vHDnrH4xueh4qDiD6ql9piqrZy9YyvS4miORQM0+lOeBGFKIcEdXhMGiV
         oHmOV+RW/Iwrk91Jie1Y7yfk1JNoEbMC306diULmxhpgl0zrEp11Qx6y8DsgVhg1nRsR
         ylrSD8R//yWB3GM9mWcBw/v7X/LzjIX+E5VO/+2ymVpQdyYDsgzNVGWT+JWUfSP9/8yb
         LRhrQunG5gV1mg4DOcJRezAv/3WiNA1MoevevpX7gZxbFCJ6WYpRYjImyTgyTib9Skpv
         i2hA==
X-Gm-Message-State: AOAM530nYAo2NQKvuUwViJ7cejkjiMdnXmPpzhWuroZT0HUvoO3Gf1yL
        HDzbQzFNZIBjyGTZjOcjnISafw==
X-Google-Smtp-Source: ABdhPJxzPu6mg+lNqyi8pXBzHWDwhwGeEI+Dbicpb8zWXKXZ3bEFdtsbfyio0s4PFHGRZ2yRBsZRHQ==
X-Received: by 2002:a17:902:d114:b029:e4:87c7:39f5 with SMTP id w20-20020a170902d114b02900e487c739f5mr11218690plw.72.1615517505595;
        Thu, 11 Mar 2021 18:51:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k5sm3672672pfg.215.2021.03.11.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:51:44 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:51:43 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] arm64: allow CONFIG_CFI_CLANG to be selected
Message-ID: <202103111851.69AA6E59@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-18-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-18-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:19PM -0800, Sami Tolvanen wrote:
> Select ARCH_SUPPORTS_CFI_CLANG to allow CFI to be enabled.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

Random thought: the vDSO doesn't need special handling because it
doesn't make any indirect calls, yes?

-- 
Kees Cook
