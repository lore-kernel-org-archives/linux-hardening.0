Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF985C61DB3
	for <linux-hardening@archiver.kernel.org>; Thu, 12 Jan 2023 21:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjALV7Y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 12 Jan 2023 16:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241042AbjALV7G (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 12 Jan 2023 16:59:06 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E386ADB3
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 13:50:13 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n12so20502588pjp.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Jan 2023 13:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fSEpo+jlekBh8KoeQPTXamCuNc4nm4WgyzF/0RduAN4=;
        b=oAYqpDU0KenT0dKKe0fbBtEaPM3gsSBp3Zcleqq0y5F9oKvZhqcY+wceaimEg08vyu
         e/YFil7Rd2Y6esh3/IfXxgarq1mSalXdWRZuleyV+tIkb1Oh/hjCZIC3OUlkfxjryh9U
         ly9P9iFyVtTG6GuZz8OUJgXkpc76j4kDFSSSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSEpo+jlekBh8KoeQPTXamCuNc4nm4WgyzF/0RduAN4=;
        b=NGubMywiwSN4tM45JXYh0bnlCRDlD/ooxuC3F8DUv6H665kOrCQ3s2j+1lXf81EdQ2
         auyRcvHynty/hp+asPU5F8ooFoanhQ9U3seTGOQFLYlNT6ajpl6UT+9vAlkoNileBIbk
         WneDsa8MVfxArqDmLQTo0CN9L64vLUNU7/vYdwC6tBjXDygKohnd7kkvhsY3OxqToSQb
         3DjkWAlpCtfJohpVYy9PF75GMdFxPCIjveSvQ0TMl9onUCiCifLEz2KivUatEsrK5LMc
         2W03z1AO1242Zup8fMd2tV225pSkMZxiTHRTZtxmgpSFVTG43sE2gFyyD9a3dCsMQVbs
         H4cA==
X-Gm-Message-State: AFqh2kpe20hkOADG7mlo1x+vpPbZ/l5HthTUL1zGJGVDOftVcoYfjj9O
        haqOXI1SvL7z7QyiH7vgwRdmhZCReEjCPKro
X-Google-Smtp-Source: AMrXdXtTIBHXsXYk1L2qORNUprlUTSak3SAIoiDdzoYO+OstaVienG17XfCXs3hEla1888A6dg2Qsw==
X-Received: by 2002:a17:90a:3c8c:b0:226:8206:91d9 with SMTP id g12-20020a17090a3c8c00b00226820691d9mr40131211pjc.20.1673560213259;
        Thu, 12 Jan 2023 13:50:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id qa15-20020a17090b4fcf00b00228e56d375asm3520280pjb.33.2023.01.12.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:50:12 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:50:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     gregkh@linuxfoundation.org, torvalds@linux-foundation.org
Cc:     kees@kernel.org, linux@roeck-us.net, vbabka@suse.cz,
        stable-commits@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Patch "gcc: disable -Warray-bounds for gcc-11 too" has been
 added to the 6.1-stable tree
Message-ID: <202301121346.D33FD799E7@keescook>
References: <167352819915167@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167352819915167@kroah.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jan 12, 2023 at 01:56:39PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     gcc: disable -Warray-bounds for gcc-11 too
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      gcc-disable-warray-bounds-for-gcc-11-too.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Ugh, please don't include this in -stable. Prior kernel versions don't
show this warning, so why remove coverage there?

> 
> 
> From 5a41237ad1d4b62008f93163af1d9b1da90729d8 Mon Sep 17 00:00:00 2001
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Mon, 9 Jan 2023 17:04:49 -0600
> Subject: gcc: disable -Warray-bounds for gcc-11 too
> 
> From: Linus Torvalds <torvalds@linux-foundation.org>
> 
> commit 5a41237ad1d4b62008f93163af1d9b1da90729d8 upstream.
> 
> We had already disabled this warning for gcc-12 due to bugs in the value
> range analysis, but it turns out we end up having some similar problems
> with gcc-11.3 too, so let's disable it there too.
> 
> Older gcc versions end up being increasingly less relevant, and
> hopefully clang and newer version of gcc (ie gcc-13) end up working
> reliably enough that we still get the build coverage even when we
> disable this for some versions.
> 
> Link: https://lore.kernel.org/all/20221227002941.GA2691687@roeck-us.net/
> Link: https://lore.kernel.org/all/D8BDBF66-E44C-45D4-9758-BAAA4F0C1998@kernel.org/
> Cc: Kees Cook <kees@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  init/Kconfig |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -892,13 +892,17 @@ config CC_IMPLICIT_FALLTHROUGH
>  	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
>  	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
>  
> -# Currently, disable gcc-12 array-bounds globally.
> +# Currently, disable gcc-11,12 array-bounds globally.
>  # We may want to target only particular configurations some day.
> +config GCC11_NO_ARRAY_BOUNDS
> +	def_bool y
> +
>  config GCC12_NO_ARRAY_BOUNDS
>  	def_bool y
>  
>  config CC_NO_ARRAY_BOUNDS
>  	bool
> +	default y if CC_IS_GCC && GCC_VERSION >= 110000 && GCC_VERSION < 120000 && GCC11_NO_ARRAY_BOUNDS
>  	default y if CC_IS_GCC && GCC_VERSION >= 120000 && GCC_VERSION < 130000 && GCC12_NO_ARRAY_BOUNDS

Linus, this seems like a really giant hammer for a single warning on a
single architecture for an option that gives us real bug coverage. I'm
not sure GCC 11 will be going away any time soon, either. Can we please
limit this to either just the affected file, or at least just powerpc?

-Kees

-- 
Kees Cook
