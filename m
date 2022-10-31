Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2314FA3740
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Oct 2022 07:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJaHcL (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Oct 2022 03:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJaHcL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Oct 2022 03:32:11 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7758765C0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 00:32:10 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id 4so10046623pli.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Oct 2022 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLaEG1AxuR7+lWKAQO3jvBzrZanxR9GIBe9arbHLQlY=;
        b=bZU0WZ4XKQPhFmsbxFnGkMv1hjyf8dK6g8aLLOG1oyjhGYx3zfxLo7s8ylw0lEjHjx
         Lu/5XoKV76xeY04gmGqY8E6KJnqV+WPHJFJHhh9yeJfAje6nm8oieAnjbTSV/z+Ava7t
         0ZzmuiFbB7KOlVY3cC4A1WH9r6nW9j0viFSNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLaEG1AxuR7+lWKAQO3jvBzrZanxR9GIBe9arbHLQlY=;
        b=jJwPUbLhgLW85DnCELgxeDpozXHH6FJqwAw7BUs7uIMpzXAcfL2JgukbPPRuRhwFMK
         35e7VfOUkfadmtcQ4YZEnpFyWWWA/XBnAh6/cukMUwLwdTyeF5cm+YPt63xUDbKqdLf9
         CitRDH3+Fzs0UBMEKnMy60lT3dzPKTI0YhZcN+6kKlTuvdJGIfSrnpRrJHEoTmf6Tb60
         V311Sg1nNErgsAGhPegWaB4MZpf9wfhLpCS3XLS9nmH5Hlc5Wx2ZGhUjNQ9ZHDffOE42
         oBbCDaPWDhYo2o1yzmZfM7XT4gprok+dkb3yHsW2cJHWixx1OVTQ26PEWKed45B+r+cD
         LSbw==
X-Gm-Message-State: ACrzQf0wG5y4RTg78wL/U04CiehJw0rfvfTTWExpOaQi04YuWRwVrgOr
        4PeoQPLYIQTcfl5CSs5alCdGC3cV6y2jHQ==
X-Google-Smtp-Source: AMsMyM63KrzVf0s9+OO4qil3ZB6Ns6W9yyhUxqgu0fht/8bL9YlnnmByhUTyRGgtVolZAKUs+1PNTg==
X-Received: by 2002:a17:90a:3947:b0:213:ebeb:2cf3 with SMTP id n7-20020a17090a394700b00213ebeb2cf3mr2754844pjf.9.1667201529999;
        Mon, 31 Oct 2022 00:32:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id iw15-20020a170903044f00b00177324a7862sm3799216plb.45.2022.10.31.00.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 00:32:09 -0700 (PDT)
Date:   Mon, 31 Oct 2022 00:32:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     tsbogend@alpha.franken.de, linux-mips@vger.kernel.org,
        linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] mips: boot/compressed: use __NO_FORITFY
Message-ID: <202210310029.29AB38AE16@keescook>
References: <20221030183647.3371915-1-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030183647.3371915-1-git@johnthomson.fastmail.com.au>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 31, 2022 at 04:36:47AM +1000, John Thomson wrote:
> In the mips CONFIG_SYS_SUPPORTS_ZBOOT kernel, fix the compile error
> when using CONFIG_FORTIFY_SOURCE=y
> 
> LD      vmlinuz
> mipsel-openwrt-linux-musl-ld: arch/mips/boot/compressed/decompress.o: in
> function `decompress_kernel':
> ./include/linux/decompress/mm.h:(.text.decompress_kernel+0x177c):
> undefined reference to `warn_slowpath_fmt'
> 
> kernel test robot helped identify this as related to fortify. The error
> appeared with commit 54d9469bc515 ("fortify: Add run-time WARN for
> cross-field memcpy()")
> Link: https://lore.kernel.org/r/202209161144.x9xSqNQZ-lkp@intel.com/
> 
> Resolve this in the same style as commit cfecea6ead5f ("lib/string:
> Move helper functions out of string.c")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
> not sure about the fixes tag:
> compile error only occurs due to the fortify commit, but it looks like
> this change could have been part of the other commit identified in the
> message: lib/string move helper functions?

I think the Fixes tag is reasonable. Strictly speaking, it should likely
be whatever added the memcpy() in decompress.c, but that's mostly
nonsense, since nothing else had tripped yet. :)

The issue is that the memcpy() has a runtime length, so
CONFIG_FORTIFY_SOURCE was inserting the logic for a runtime warning,
which doesn't exist here. This is the correct fix (turning off FORTIFY
in the early boot loader).

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
