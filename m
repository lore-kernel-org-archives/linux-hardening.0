Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 990B2C04A6A
	for <linux-hardening@archiver.kernel.org>; Mon, 14 Aug 2023 23:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjHNXOI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 14 Aug 2023 19:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjHNXN7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 14 Aug 2023 19:13:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399B310F7
        for <linux-hardening@vger.kernel.org>; Mon, 14 Aug 2023 16:13:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bdb801c667so29122305ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 14 Aug 2023 16:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692054837; x=1692659637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DU30yTGenjwr8H/p0lpH7CNdRUrwWJdI1Z1Jmc0+2Vk=;
        b=B+UBhYRWcaaB0nF1PSoMyqS4qeWPfUbK+TEQp0Xz+nb9+YJm+OLQIVvXNlTkflG3od
         fhQiyV/iWRViJ30fmfywnpUSqv+ZUu/wHolkiLrlRXgZ1S2+NQk+mpL9Rze5S/Tu/ftF
         lv0kUgKX0VbPef7KtkvaOzisUdSyop7bHweUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692054837; x=1692659637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DU30yTGenjwr8H/p0lpH7CNdRUrwWJdI1Z1Jmc0+2Vk=;
        b=Vtc231PJt6xfiAnysDzA3AUpc1o4byAatJyOdzcYklYCWZeAh8aPFGn1+dRlMxFr5T
         Gf2seMmSuuiRok2kXOz6dDvwg8U/o4f0OCC8bvSh69wUBc2C89QW8Jdu2wJ/zRvJS6Bc
         LRBt6voG1+615RbYhoRH0DAMXH1jYKUD144LRpg4lWfAOVjbQFrritdwemaWDfI4hbX8
         PoguIv2zH5EUJYfCzeWVCmAI6uu5z4IjjBGeEb66sltuBx8ZPHnu8WTuEKHbHfB80P/Z
         su6bQIulXIXJd+RS+ZJYkoNAeHz+DlWbo6ZeTqm0jZhfKqLHK4RowPErjyB8VfV+mYzC
         igIA==
X-Gm-Message-State: AOJu0YysVzM44GXlHHlIdsm+xyPJLN8dXgU5TT/ap2K2ncrQ7ttMEuUN
        r9xG3Dvia4LJTXLLdTRMNadj9w==
X-Google-Smtp-Source: AGHT+IG5ZiEaSz4ENoyRdjcIg38pZM9w7tQfNTdMqDXt8HFdYmHBsWQAGJWWYXHDCX1kAl5yiRQHzw==
X-Received: by 2002:a17:902:d490:b0:1bd:e64c:5c7e with SMTP id c16-20020a170902d49000b001bde64c5c7emr3923448plg.61.1692054837613;
        Mon, 14 Aug 2023 16:13:57 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b001bda42a216bsm9671965plk.100.2023.08.14.16.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 16:13:56 -0700 (PDT)
Date:   Mon, 14 Aug 2023 16:13:55 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] powerpc/ps3: refactor strncpy usage attempt 2
Message-ID: <202308141612.818819C6@keescook>
References: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-0-301052a5663e@google.com>
 <20230811-strncpy-arch-powerpc-platforms-ps3-v1-2-301052a5663e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-strncpy-arch-powerpc-platforms-ps3-v1-2-301052a5663e@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 11, 2023 at 09:19:20PM +0000, Justin Stitt wrote:
> This approach tries to use `make_field` inside of `make_first_field`.
> This comes with some weird implementation as to get the same result we
> need to first subtract `index` from the `make_field` result whilst being
> careful with order of operations. We then have to add index back.

I think for readability, it's better to avoid the function composition.
The index subtraction undoes the earlier addition -- I say just leave it
separate.

i.e. I like option 1 of 3 the best.

-Kees

-- 
Kees Cook
