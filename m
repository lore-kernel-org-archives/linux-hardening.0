Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B11C77B7C
	for <linux-hardening@archiver.kernel.org>; Thu,  4 May 2023 18:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEDSTs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 4 May 2023 14:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjEDSTr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 4 May 2023 14:19:47 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09646A42
        for <linux-hardening@vger.kernel.org>; Thu,  4 May 2023 11:19:38 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-51f597c975fso721226a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 04 May 2023 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683224378; x=1685816378;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kCiTzOmyWHWq8qYHC8k2z/0RZLeYJjOcNKGNfJf663E=;
        b=GZ4UTzeA5rPV9XwB0E1CnGOx5YglTClFyMz9hTyJvxzHxOUfzql1rg3P19Zj9CpvwX
         9slRCElaX7svCTzj0N44LiXURLmmYmIZHvu2PYxX1mOKPmzzW9Ugiacs1CtyHY0zrrZL
         +M+quAB/x/miiUwqRQ5et/eMgXWjkqZTgPqeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224378; x=1685816378;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCiTzOmyWHWq8qYHC8k2z/0RZLeYJjOcNKGNfJf663E=;
        b=BwDuOnBNi4JQ70BdVkSbFSgowSqpflzhKM12aWYth77TnC7xBRa9C09CDWuZAhDPsR
         nMJkzQfc6ilbTBq3HUnwUXKUMpS3RGgpKLJHMePxkir6b0QHIysGkmOo4Z+0nA25+8C/
         ZDz3LA7nLONNouMMb82jGABDD4iBBGJHvx/qStwUrvqmS0U3JTi2h1W8zMmGH7lWVHkW
         Fxt1hDWbtu9oDuOuiGzeG5r7/n9sTdc65XhWqA+Iah0GS7gTuIkyHDGy+UZDVeKk9/tk
         qwIcycRnAdk8C12yOMKgcNkJCCvBt5EuzU0WgnWYKFdsJUTCnodvOXQzXnfQT/I2cHDQ
         GVXQ==
X-Gm-Message-State: AC+VfDyKSBFif1xND+0NCDbZdXPasp/Nox0fi3T/3uTEWghnfyR2fc+X
        4WhAppqyQ5b+0hkqZHaUOXwaPg==
X-Google-Smtp-Source: ACHHUZ4IHamXVdmQ6HeS+sI01dLo9Gpa93g9AR/NYoqliF6h0f68F02DqZTKm2CJ9gX7zwc2h8nbkA==
X-Received: by 2002:a17:903:32c9:b0:1a6:8ed5:428a with SMTP id i9-20020a17090332c900b001a68ed5428amr5715553plr.22.1683224378276;
        Thu, 04 May 2023 11:19:38 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bx15-20020a17090af48f00b00246f9725ffcsm11448930pjb.33.2023.05.04.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:19:37 -0700 (PDT)
Message-ID: <6453f739.170a0220.62695.7785@mx.google.com>
X-Google-Original-Message-ID: <202305041118.@keescook>
Date:   Thu, 4 May 2023 11:19:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Bill Wendling <morbo@google.com>, Qing Zhao <qing.zhao@oracle.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] Compiler Attributes: Add __counted_by macro
References: <20230504181636.never.222-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504181636.never.222-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 04, 2023 at 11:16:40AM -0700, Kees Cook wrote:
> In an effort to annotate all flexible array members with their run-time
> size information, the "element_count" attribute is being introduced by
> Clang[1] and GCC[2] in future releases. This annotation will provide
> the CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE features the ability
> to perform run-time bounds checking on otherwise unknown-size flexible
> arrays.
> 
> Even though the attribute is under development, we can start the
> annotation process in the kernel. This requires defining a macro for

And FWIW, I've done a first-pass at this annotation with Coccinelle. There
are plenty more to do:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/counted_by&id=adc5b3cb48a049563dc673f348eab7b6beba8a9b

155 files changed, 158 insertions, 158 deletions

-- 
Kees Cook
