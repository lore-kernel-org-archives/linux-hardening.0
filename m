Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59BEC433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 19:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJRTBQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 15:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiJRTBB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 15:01:01 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB95B9781
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 12:01:00 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 128so14127347pga.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wlJiXl4dwWwXl6sK1ctObSaJU8vBeL3Ixg+2CByDlQA=;
        b=DiLhFNfpLAqxMjiXFXfuu3qqxM+DuCSxUpz+oehcwgnkGeb4P8+eoHjbTQfbtIi570
         NCBMxAJNeP7Fq4WscLWc/P2XCOV1aoYRKj+2NhGk39ExHikCQg086r60jm4aQUpiVOzS
         Hn6RiX+c1ZoUifOCU2FaTfS9SmCbr+LCYLb5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wlJiXl4dwWwXl6sK1ctObSaJU8vBeL3Ixg+2CByDlQA=;
        b=tEi1Jbr4zrB1AG2+TkpB8aPIGdA+eH5GL3rzBMKrK7R/se6Cxxg4c7kbrRMdfp/LiP
         ry39jewwl8O8rIf/02YbCuY5c1rhlOxe9GiOEQwF4xJgkvkNOTKaZ/5Vu4mkPqCiVGJw
         R0ei0r74BBVx8KYr4nfQ4eod9wEns2EOygP/F1DnOH3lgy5sZOGOsIyAfZaTFaP1vni3
         ZC2erebVnnS4l6RX6ZI6PGUwi5yCsWGebdLrZMEBMiQk4ftMQjkEs6hVDS26RLhmyUau
         nFBmiGC+yMVEYAlJwuwnbutiMFUTn8x1amdDTVuhlRHsY/Xuc/QgFjyUE5Qech/cIM9m
         csaQ==
X-Gm-Message-State: ACrzQf2RJnKEiBLohc8KXej6T/qbRwXxcWv6CVZossiY8BkoydKL1SMo
        mAmAbz+25JVPy5qcR6+PoJj+WA==
X-Google-Smtp-Source: AMsMyM6KORyju5BkyVDDUO9pTvH+Vg7bhmNlb3hrjJ+4D8O5pISmUlnS54kywKF+9NBLubXQ9E3alA==
X-Received: by 2002:a63:5164:0:b0:43b:e57c:a15f with SMTP id r36-20020a635164000000b0043be57ca15fmr3788138pgl.586.1666119659809;
        Tue, 18 Oct 2022 12:00:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e18-20020a63ee12000000b00438834b14a1sm8388324pgi.80.2022.10.18.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 12:00:59 -0700 (PDT)
Date:   Tue, 18 Oct 2022 12:00:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Tobin C . Harding" <tobin@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: Convert strscpy() self-test to KUnit
Message-ID: <202210181159.1B36049D3@keescook>
References: <20221018082824.never.845-kees@kernel.org>
 <Y072ZMk/hNkfwqMv@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y072ZMk/hNkfwqMv@dev-arch.thelio-3990X>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 11:54:28AM -0700, Nathan Chancellor wrote:
> On Tue, Oct 18, 2022 at 01:28:59AM -0700, Kees Cook wrote:
> > Convert the strscpy() self-test to a KUnit test.
> > 
> > Cc: David Gow <davidgow@google.com>
> > Cc: Tobin C. Harding <tobin@kernel.org>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I ran the following commands and they all passed:
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --cross_compile aarch64-linux-gnu- strscpy
> 
> $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 strscpy
> 
> $ tools/testing/kunit/kunit.py run --arch x86_64 strscpy
> 
> $ tools/testing/kunit/kunit.py run --arch x86_64 --make_options LLVM=1 strscpy
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>

Thank you!

I should probably note somewhere that I test it both with and without
CONFIG_FORTIFY_SOURCE:

$ tools/testing/kunit/kunit.py run --arch x86_64 --kconfig_add CONFIG_FORTIFY_SOURCE=y strscpy

etc...

-- 
Kees Cook
