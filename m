Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33F5C77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 16:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjFAQv0 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjFAQvX (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 12:51:23 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A60119D
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 09:50:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-65055aa4ed7so526042b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685638251; x=1688230251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=377IvIKh/BJY96aqP2tWkbD98iSu7iHSs0N1emegXC4=;
        b=KaBFoWq/5dL8Zo/z8/cV/drypu1Hy5sHpPKCs5iZl/RhrGldWvUqOa8aI0Rn5EkkNH
         296E0IA+fLpwpo++zRhs5Um3VjhGDTdcEfX3OMNzHA7i4E9Meq7Ac1R9f02pMFTQKTeB
         euYuq4S0Sfxw3/bLbOI8cWN3W3bt9mfYdxZBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638251; x=1688230251;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=377IvIKh/BJY96aqP2tWkbD98iSu7iHSs0N1emegXC4=;
        b=J3IjKtDZ4UpnKlwEH/bVFDs0WuWeQkpcztGma8H8Ec/tjQKspDAPpm7xR0V1U16L8W
         Va3JQcg+p1WX68kXqyIvxGCSMXfjgEWbxgPWxkK3tYBcnQzG162njrEnz2r8xdtr4x3f
         NhpXOXWY47V6cCTULteM3nLAmM7xLpqY4YxtpZ7fhhB6UgpPS0Le6Kb92mizF0W8rGK3
         9+TvjVQUAm7sUNsLqmkQruGC9h820YEhHWYJZu6HdeSzVYmRCMz8LB6pDU8HQhWOUGwJ
         m/D5iyypli7UPlSQcLKX6F8AK1TrimEoJ66aWtw4iq+nmZ979hdgkqFlpT72wUOZcCOo
         6tqQ==
X-Gm-Message-State: AC+VfDwTwWZCrlck3zRnrFuCmfl6mk9JRfnEHMyujm3j9qYqJxYy2x2n
        n4d5oYvcIPWsjuc+4QYlyVMDsQ==
X-Google-Smtp-Source: ACHHUZ6wvTdEoDHJQBquLQoxUuq9N6B1rkv2yi7SL84Ae6xPOangUsb28RbD2NubLmTnucyFqyLJRQ==
X-Received: by 2002:a05:6a00:c82:b0:64d:22db:1023 with SMTP id a2-20020a056a000c8200b0064d22db1023mr9246378pfv.22.1685638251608;
        Thu, 01 Jun 2023 09:50:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v24-20020a62a518000000b0064f708ca12asm5296324pfm.70.2023.06.01.09.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:50:51 -0700 (PDT)
Date:   Thu, 1 Jun 2023 09:50:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Joan Bruguera =?iso-8859-1?Q?Mic=F3?= <joanbrugueram@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alyssa Ross <hi@alyssa.is>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexander Potapenko <glider@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86/purgatory: Do not use fortified string functions
Message-ID: <202306010950.6DA29909A@keescook>
References: <20230531003345.never.325-kees@kernel.org>
 <3c67fdd6-bce9-f695-a6c5-0fe9209bd3e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c67fdd6-bce9-f695-a6c5-0fe9209bd3e4@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jun 01, 2023 at 09:45:57AM -0700, Dave Hansen wrote:
> On 5/30/23 17:33, Kees Cook wrote:
> > With the addition of -fstrict-flex-arrays=3, struct sha256_state's
> > trailing array is no longer ignored by CONFIG_FORTIFY_SOURCE:
> > 
> > struct sha256_state {
> >         u32 state[SHA256_DIGEST_SIZE / 4];
> >         u64 count;
> >         u8 buf[SHA256_BLOCK_SIZE];
> > };
> > 
> > This means that the memcpy() calls with "buf" as a destination in
> > sha256.c's code will attempt to perform run-time bounds checking, which
> > could lead to calling missing functions, specifically a potential
> > WARN_ONCE, which isn't callable from purgatory.
> > 
> > Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Closes: https://lore.kernel.org/lkml/175578ec-9dec-7a9c-8d3a-43f24ff86b92@leemhuis.info/
> > Bisected-by: "Joan Bruguera Micó" <joanbrugueram@gmail.com>
> > Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3")
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> 
> Hi Folks,
> 
> The -fstrict-flex-arrays=3 commit isn't upstream yet, right?  That makes

Correct.

> it a _bit_ wonky for us to carry this on the x86 side since among other
> things, the Fixes commit doesn't exist.  I'd be fine if this goes up
> along with the -fstrict-flex-arrays=3 code, so:
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

That would be perfect; thank you! I've added it to my tree.

-- 
Kees Cook
