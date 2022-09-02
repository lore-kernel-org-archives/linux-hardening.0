Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2702AC6FA82
	for <linux-hardening@archiver.kernel.org>; Fri,  2 Sep 2022 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiIBWpE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 2 Sep 2022 18:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIBWpB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 2 Sep 2022 18:45:01 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E237A19289
        for <linux-hardening@vger.kernel.org>; Fri,  2 Sep 2022 15:44:38 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id f12so3156206plb.11
        for <linux-hardening@vger.kernel.org>; Fri, 02 Sep 2022 15:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=mIxY46m1QzJn3vOoV8Aurpr840TvHU3zLfjo/cbWqFk=;
        b=cYqFKD+l3LBaVj0Nglfk20jgUIjQ5VC+53Os9QTM/lf2Nb/TXPza+rYNtkGp0/fVFU
         B1TpRyVVK3e6ROFqWRySUfIATFBvaSxbSyCQgfXx4V2eANsSh1Gn4Z04EA83JT+HkNkG
         /ApMRwFeSuG0Yf+IZ6tm/VIIHcZKbAsYRJfZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mIxY46m1QzJn3vOoV8Aurpr840TvHU3zLfjo/cbWqFk=;
        b=daPoRn7sraO/32Eozpov9RK3F1T6vejaxywJ4ss1KbIB6tynTiTfU6BCG6gLNy9ZCK
         jZL8lK3SsFS1Gc2tna3xLViyFkUbf1tEZsQGtpV8rC1/vD3hQwd+4pu6XauxuPK4eSNT
         c3c4DuZ2n2GekSV3C0ZsJQfWC4LDHteD1TT5XQOSkzzJu8thHmhqPMASjYA+ztC+UdeC
         efcDOZxjtB7Cg4lEFVIyeLjDML0DcHSciOh7eeMGomIFMSe3Xcgz7gWhyFaiKYqWxoTD
         9cU+i3/pb1giBYTSQNu+KhcCnbFccAYPiRk3VMmH/iRA3EyvN+nudiXw83asQu0KNhn8
         3rog==
X-Gm-Message-State: ACgBeo0GxuAKMADZs1TLEAs3/nZ1/pN+QBlNuLdBkTvPn8uKH9BsRhWL
        4EkJuzsnFFhNWx4atpESTMu8Kg==
X-Google-Smtp-Source: AA6agR51nDiWxMdGZbsqX9QWjVEepoUFgYZiN4SZlJrqmTRnzNhGn8v/2CvIxf3CKgcYDwLWprczKA==
X-Received: by 2002:a17:90b:212:b0:1fd:e61b:866a with SMTP id fy18-20020a17090b021200b001fde61b866amr7000390pjb.141.1662158675307;
        Fri, 02 Sep 2022 15:44:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k12-20020aa79d0c000000b00537d7cc774bsm2323553pfp.139.2022.09.02.15.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:44:34 -0700 (PDT)
Date:   Fri, 2 Sep 2022 15:44:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-hardening@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        David Gow <davidgow@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sander Vanheule <sander@svanheule.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Eric Dumazet <edumazet@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eric Biggers <ebiggers@google.com>,
        Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2 3/3] fortify: Use SIZE_MAX instead of (size_t)-1
Message-ID: <202209021544.AEF73D202@keescook>
References: <20220902204351.2521805-1-keescook@chromium.org>
 <20220902204351.2521805-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902204351.2521805-4-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 02, 2022 at 01:43:51PM -0700, Kees Cook wrote:
> Clean up uses of "(size_t)-1" in favor of SIZE_MAX.
> 
> Cc: linux-hardening@vger.kernel.org
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/fortify-string.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

*brown paper bag*

This needs:

#include <linux/limits.h>

I will fix it locally...

-- 
Kees Cook
