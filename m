Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121DBC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 27 Apr 2022 22:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiD0Wmc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiD0Wmb (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 27 Apr 2022 18:42:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABA1290;
        Wed, 27 Apr 2022 15:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=s6XKX8og5KIUAHRB93AiGU36ErCzIx+ZrYZ7ApHfXVY=; b=PzOWfZAdgPjJPl9GnpKb5EH5TQ
        RfRROgx/z6q+6pL25n+U2OA6d/EZ1YgBP7ykxsbEWMgLrLOKQAPiO01FJDnCAxUcYFHubLunAbC9U
        rOoMMoAiaqaP4obscEKwBHy+dDMiSwDn5PSaYCdCf6WbBbFFQXWZgJAhCfq67JgiksvaWrcWamIrh
        +P8jh8FD2Ok1rJpu8GahsN0Kcz/JewPTJP2TMyAHAMinPK5GVNyZoLIhfgmNindrZ5zr9XkZ7fL7m
        v99XVpJvp+dfzjvLINVLkG20L7jF/6nVIAkj6KG8pXib83nTVRTRP0E7ePnFLg27+tcc7xgr0YGLb
        lIPX9HVA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njqJR-00Ay1a-3H; Wed, 27 Apr 2022 22:39:09 +0000
Message-ID: <c0bf9c05-9345-b203-611d-411f0237cf26@infradead.org>
Date:   Wed, 27 Apr 2022 15:39:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] lkdtm: cfi: Fix type width for masking PAC bits
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Li <ashimida@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20220427001226.1224704-1-keescook@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220427001226.1224704-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 4/26/22 17:12, Kees Cook wrote:
> The masking for PAC bits wasn't handling 32-bit architectures correctly.
> Replace the u64 cast with uintptr_t.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Link: https://lore.kernel.org/lkml/CAMuHMdVz-J-1ZQ08u0bsQihDkcRmEPrtX5B_oRJ+Ns5jrasnUw@mail.gmail.com
> Fixes: 2e53b877dc12 ("lkdtm: Add CFI_BACKWARD to test ROP mitigations")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Tested-by: Randy Dunlap <rdunlap@infradead.org>
fwiw
Thanks.

> ---
>  drivers/misc/lkdtm/cfi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/lkdtm/cfi.c b/drivers/misc/lkdtm/cfi.c
> index 804965a480b7..666a7f4bc137 100644
> --- a/drivers/misc/lkdtm/cfi.c
> +++ b/drivers/misc/lkdtm/cfi.c
> @@ -59,7 +59,7 @@ static void lkdtm_CFI_FORWARD_PROTO(void)
>  #endif
>  
>  #define no_pac_addr(addr)      \
> -	((__force __typeof__(addr))((__force u64)(addr) | PAGE_OFFSET))
> +	((__force __typeof__(addr))((uintptr_t)(addr) | PAGE_OFFSET))
>  
>  /* The ultimate ROP gadget. */
>  static noinline __no_ret_protection

-- 
~Randy
