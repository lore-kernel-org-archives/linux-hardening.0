Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99B0C433FE
	for <linux-hardening@archiver.kernel.org>; Wed, 19 Oct 2022 05:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJSFhM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 19 Oct 2022 01:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJSFhM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 19 Oct 2022 01:37:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3483A4E196
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 22:37:10 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 67so16203820pfz.12
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaB7r0jtcqd2LLd1zpImUKzyF4vb0y3pjRPBPmzYZ4Y=;
        b=A50nB2myoBrpOIvb3e4Ap+0R9BCF2YinNE2QnvkCYhYLCUUM7DBKYMS6gk092eZU3O
         B2/fZxbo7disNyN568ZmLcCeHRhHlCeI8yn2kVzs5e32APmmUAzE0roYLmvwX7uXrWTK
         sK9lV4oZrZg6wGNBET8UFhqJe7sBndgRlCUaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gaB7r0jtcqd2LLd1zpImUKzyF4vb0y3pjRPBPmzYZ4Y=;
        b=wd+txNhI6jvi7XSsln9QNmWcmr8VUCBY70FWdN4UGUp6R1BPWUZ6dzz5Q+w6y/jSro
         GKCarh0OSGB4r3bm+hmK2rL7TQ51BRqRmulOIaSVOYbRHWu7eZnm7kPm5/ZSSirjdJ9v
         uCF/pK1dawI5f7AP1Uqp6cebKGEy+kBJHd8Ar2Hs1gmz7VN9R2EKasQYGzPLHoCoHBzB
         i/8NoNuZrQ6eha9PGH6T3+2/RIdPML67ORSknPIVsC8SIw4x11Sj3vqs/IusPsLIXMRB
         cVEd0ehpHsAhTwLVmJuZHw45lm3z0HHSJGk6GAaZUYJZ0cq7xgRL9/azKaVJOurp4D7/
         peNg==
X-Gm-Message-State: ACrzQf052HL7gGRcT/lC+idU4KTcsh5Um8lp17x+eKDLDGccL8oi0eeu
        N73tR0hQWqXrpHIeMERLNoxNc/dk1gUwrg==
X-Google-Smtp-Source: AMsMyM7fiBtyRBbHFGloOmwtzRNGHuoxgWogV6EAP5VJPWG6EE61GeFExwx/EPTvx0a3W+O4+gXIog==
X-Received: by 2002:a63:ed0a:0:b0:442:2514:95f5 with SMTP id d10-20020a63ed0a000000b00442251495f5mr5867397pgi.402.1666157829640;
        Tue, 18 Oct 2022 22:37:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b0017f7b6e970esm9799332plg.146.2022.10.18.22.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 22:37:08 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:37:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize()
 usage
Message-ID: <202210182235.3B19DFCB28@keescook>
References: <20221018090323.never.897-kees@kernel.org>
 <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 03:51:37PM -0700, Andrew Morton wrote:
> On Tue, 18 Oct 2022 02:03:29 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > Round up allocations with kmalloc_size_roundup() so that mempool's use
> > of ksize() is always accurate and no special handling of the memory is
> > needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
> 
> Confused.  If the special handling is not needed, why doesn't the patch
> removed the no longer needed special handling?

The special handling is in the ksize() implementation, so it can't be
removed[1] until all the ksize()-affected users are updated to see their
true allocation sizes first.

[1] https://lore.kernel.org/lkml/20220923202822.2667581-16-keescook@chromium.org/

-- 
Kees Cook
