Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF89EC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 01:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243476AbiBBBHy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Feb 2022 20:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiBBBHx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Feb 2022 20:07:53 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3FC061714
        for <linux-hardening@vger.kernel.org>; Tue,  1 Feb 2022 17:07:53 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c194so4890070pfb.12
        for <linux-hardening@vger.kernel.org>; Tue, 01 Feb 2022 17:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSo0lKBxOCaeF2/Z6BYia50YxeJQ1xKTwofT0YCtOAQ=;
        b=B3j4wMvjt0cGoNPIVXr6D80603KlI3Z7B+sUmYIOhoFgfE2zf3NRTDe4GSRjHWwW31
         fk1LI0CfMYHlx/H3SeBT1X5DbmR63YNeyglveui0E8zE97a081Ul3E7Sx99BKqcCnCaw
         Qnk20qVNZEqsc0IgJ6FgFIXWg838wQWG1FbXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSo0lKBxOCaeF2/Z6BYia50YxeJQ1xKTwofT0YCtOAQ=;
        b=1ddTUi9gkHjb5Fjwygx1DZgWcnFs6r5JISmLvDMfGkWjPKxKZnNUHvzW4vWqqWjnrH
         z7fAjoaAzitOYNmywI2D0qjzyxBP9Li0GFaKs0qgyQB8BwC4cqpDl+TfPQXlrO/b2Xi4
         YQRzpcs1tWXeR6Q3enxi6weXwTb4VZ9KLF+WjoKJoRefrXZEJEKb1dr4nZ5wTC4YsoUx
         xLoe8X6qyBxkkRotv8qzsQQI/WIq4puyMdyO+vHbDYbASAuvgNCJNIYc2zIgE9oufC6w
         +phBMMffmb5AtbJ8NMbvzvLVZysOakFqm5Qgzz3ReMzMjGvA+FpNhJn5WMz+YQR+IsVw
         IKzA==
X-Gm-Message-State: AOAM531NfTrsPXViu9svQ3kemCMJ9D+SC7q3SgHNBKGl9xJIkAa2Kr6U
        ledUEFAjhd7177G/t5wiowgBlw==
X-Google-Smtp-Source: ABdhPJxPjwMwuYyjXbYv75EsIRWlL4woTQ0yr1bgcp5S7GmLVGAyQU2AJPAJggFeEX/0dz94hZOq7A==
X-Received: by 2002:a63:343:: with SMTP id 64mr22646388pgd.463.1643764073491;
        Tue, 01 Feb 2022 17:07:53 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nv13sm4471158pjb.17.2022.02.01.17.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 17:07:53 -0800 (PST)
Date:   Tue, 1 Feb 2022 17:07:52 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <202202011707.F4137C55B@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
 <202201281347.F36AEA5B61@keescook>
 <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201144816.f84bafcf45c21d01fbc3880a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 01, 2022 at 02:48:16PM -0800, Andrew Morton wrote:
> On Fri, 28 Jan 2022 14:30:12 -0800 Kees Cook <keescook@chromium.org> wrote:
> 
> > Andrew, can you update elf-fix-overflow-in-total-mapping-size-calculation.patch
> > to include:
> > 
> > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > Cc: stable@vger.kernel.org
> > Acked-by: Kees Cook <keescook@chromium.org>
> 
> Done.
> 
> I'm taking it that we can omit this patch ("elf: Relax assumptions
> about vaddr ordering") and that Alexey's "ELF: fix overflow in total
> mapping size calculation" will suffice?

Yes, it has the same result. Thanks!

-- 
Kees Cook
