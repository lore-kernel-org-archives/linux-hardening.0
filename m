Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296CDC6379F
	for <linux-hardening@archiver.kernel.org>; Fri, 13 Jan 2023 23:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjAMXUJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 13 Jan 2023 18:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjAMXUI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 13 Jan 2023 18:20:08 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BFA10FC7
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:20:08 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c85so13973554pfc.8
        for <linux-hardening@vger.kernel.org>; Fri, 13 Jan 2023 15:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=84xU26GE6B2A0FvL+1YrfpDZhPaiag0vDWKb7+nHpZ4=;
        b=HzOuTP2OMT93SpVk7dxZEI5EeA5lvl3aMks7aEPL0y4M2MAHsCu1hyNG1blHmW8ccl
         MakQop5gTGOXKoV0JWl3p9eyUjR0G8cl9Jq41Az0VtBP9PdqoM3JAtAPeQvRUktsYvqF
         L4Cc1J43BtxEQCXbQSCkXOArtWT0jW03G0wZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84xU26GE6B2A0FvL+1YrfpDZhPaiag0vDWKb7+nHpZ4=;
        b=0BG/eho1fVxFx4/rDojnrqSEvGdprqLWjH9d8P7RQDv19/3rKp69+4KJLQ9lM81qyz
         sLlA7ldNbbebOHoW/0iqwRm61tS/JbSzsVQ2JJhEtJmLkP3uxaDXWZCuzl7tFQ188xMV
         EaRAqEBFY8jPLh14RI40iy9/Wwy7uscKUIa87L3Sm1yGT+aOLKWyKWr2BWPl5EWWM7Li
         lMkqv5Sltp/9jcArLr83QM2nS4OR6ggi/sR9Tr6a17NVBYvq7I0+vpnoq0RNqBskEIY+
         6TMJdKLkyl+qOSfgr3UowFi+LcRHfzEUteHIDGKQyOAD6lYZh1BkR9jrX+bxWTIsQt+G
         UMfg==
X-Gm-Message-State: AFqh2krnb8ZmQeQhGgiOloM8g5p8Ee/3jzedRfQNa2cBLPcBjg00BOjz
        LoZ5WXkxkEJxX1N/jDVFeDYMXg==
X-Google-Smtp-Source: AMrXdXucWQV00sJtH/NC78tZOA7xDpH4uwBDfzBrARIIStWMoHMs0HM7zt4mNhpDJLkM/CmTLPNpBw==
X-Received: by 2002:a05:6a00:88a:b0:581:19ed:78b9 with SMTP id q10-20020a056a00088a00b0058119ed78b9mr83251283pfj.2.1673652007689;
        Fri, 13 Jan 2023 15:20:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7961d000000b0058bacd6c4e8sm3003724pfg.207.2023.01.13.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 15:20:07 -0800 (PST)
Date:   Fri, 13 Jan 2023 15:20:06 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH] gcc-plugins: Fix build for upcoming GCC release
Message-ID: <202301131519.31DAEA31E4@keescook>
References: <20230113173033.4380-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113173033.4380-1-palmer@rivosinc.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 13, 2023 at 09:30:33AM -0800, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> The upcoming GCC release has refactored the gimple plugin interface a
> bit and unless gimple-iterator.h is included before gimple-fold.h I end
> up with a bunch of missing declarations when building the stack
> protector plugin.
> 
> Link: https://inbox.sourceware.org/gcc-patches/CAFiYyc2q%2Bc-0uZb-zAskmR_U%2BM%2BxQfp-W00ZbLErfjx=j5qHGg@mail.gmail.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  scripts/gcc-plugins/gcc-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Does this work for you?


diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 9a1895747b15..309b39cee275 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -72,6 +72,9 @@
 #include "stor-layout.h"
 #include "internal-fn.h"
 #include "gimple-expr.h"
+#if BUILDING_GCC_VERSION >= 13000
+#include "gimple-iterator.h"
+#endif
 #include "gimple-fold.h"
 #include "context.h"
 #include "tree-ssa-alias.h"
@@ -88,7 +91,9 @@
 #include "gimple.h"
 #include "tree-phinodes.h"
 #include "tree-cfg.h"
+#if BUILDING_GCC_VERSION < 13000
 #include "gimple-iterator.h"
+#endif
 #include "gimple-ssa.h"
 #include "ssa-iterators.h"
 

> 
> diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
> index 9a1895747b15..2c3a3079128a 100644
> --- a/scripts/gcc-plugins/gcc-common.h
> +++ b/scripts/gcc-plugins/gcc-common.h
> @@ -72,6 +72,7 @@
>  #include "stor-layout.h"
>  #include "internal-fn.h"
>  #include "gimple-expr.h"
> +#include "gimple-iterator.h"
>  #include "gimple-fold.h"
>  #include "context.h"
>  #include "tree-ssa-alias.h"
> @@ -88,7 +89,6 @@
>  #include "gimple.h"
>  #include "tree-phinodes.h"
>  #include "tree-cfg.h"
> -#include "gimple-iterator.h"
>  #include "gimple-ssa.h"
>  #include "ssa-iterators.h"
>  
> -- 
> 2.39.0
> 

-- 
Kees Cook
