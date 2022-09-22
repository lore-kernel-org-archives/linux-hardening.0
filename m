Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2687C6FA8B
	for <linux-hardening@archiver.kernel.org>; Thu, 22 Sep 2022 03:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIVDd4 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Sep 2022 23:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIVDdz (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Sep 2022 23:33:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B66598368
        for <linux-hardening@vger.kernel.org>; Wed, 21 Sep 2022 20:33:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b23so7973480pfp.9
        for <linux-hardening@vger.kernel.org>; Wed, 21 Sep 2022 20:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=XNbtSxfuJM0TvCbKrDSFlGazSHd4nOQHgC+9b6ylUe4=;
        b=JLTH01KnBgmnNcpiE4BaxPSMUmiRK1wixqi2R2fDvpYZ7mbFuWVA+eCMwV9Ooy7Y2R
         Woa8XpodShi3pnIGGNpgTJfitVebcLwCm8c/U0JiK4sHYFoOL+kb1m3bgvOAeN7Z7r0W
         00Y2KF+MivPazWmmeeTVy/Yh2IAp+53XXFWOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=XNbtSxfuJM0TvCbKrDSFlGazSHd4nOQHgC+9b6ylUe4=;
        b=MSWVv5q83BIG249m9PLuss6k0RrJmQO2wnt5Zn5ZqUg99TdALOMbQMhVIrWI8R26YK
         fNw+dYZCi7Ij3/XbURALez22JX/GuPUcc8I8l2rMMGRPQv/nAUI1XOLerIf9fwC+tQtM
         tlLda7xHlWafKoqw7OxpVLeMLyqKLNrBox4cdFKPO/lpqEkzsPpdO/NfOBSZ4vKQKXIi
         CJAtejkXsJ7UlnLHf9ba5SWlPptHJ3whxTyx0zxUro4ZTe8A8sE7qRQC3ZnhzxATqD5M
         EWBEtXBpk4/f+RXiZaXtXG1AsBi0s5aCSV1Z50+J9uEJ5FT43ilfFZWFaYxk1kbBt7v1
         uOBA==
X-Gm-Message-State: ACrzQf0gJFYURsOYEsUTUFh/etMXXmSnQKxkRSHbhyWEcdbr4Dg1DQj1
        +Q2hg2ZpyFaQId4AcZ0NDn4wQw==
X-Google-Smtp-Source: AMsMyM7tC1MtDvRJS7cc5qSCv8s84GqWYuQca9GUuvaL53zNqSZvZvxuvVucuuBYn6cgvQqhY2zIhQ==
X-Received: by 2002:a05:6a00:1889:b0:540:acee:29e4 with SMTP id x9-20020a056a00188900b00540acee29e4mr1550769pfh.49.1663817633640;
        Wed, 21 Sep 2022 20:33:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902bf4900b00176ca089a7csm2754925pls.165.2022.09.21.20.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 20:33:53 -0700 (PDT)
Date:   Wed, 21 Sep 2022 20:33:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Siddhesh Poyarekar <siddhesh@gotplt.org>
Cc:     linux-hardening@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] fortify: Use __builtin_dynamic_object_size() when
 available
Message-ID: <202209212032.5F392F42@keescook>
References: <20220920192202.190793-1-keescook@chromium.org>
 <20220920192202.190793-5-keescook@chromium.org>
 <9d80e0a3-3fcc-0676-4529-79743f418557@gotplt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d80e0a3-3fcc-0676-4529-79743f418557@gotplt.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Sep 21, 2022 at 07:43:17AM -0400, Siddhesh Poyarekar wrote:
> On 2022-09-20 15:22, Kees Cook wrote:
> > Since the commits starting with c37495d6254c ("slab: add __alloc_size
> > attributes for better bounds checking"), the compilers have runtime
> > allocation size hints available in some places. This was immediately
> > available to CONFIG_UBSAN_BOUNDS, but CONFIG_FORTIFY_SOURCE needed
> > updating to explicitly make use the hints via the associated
> > __builtin_dynamic_object_size() helper. Detect and use the builtin when
> > it is available, increasing the accuracy of the mitigation. When runtime
> > sizes are not available, __builtin_dynamic_object_size() falls back to
> > __builtin_object_size(), leaving the existing bounds checking unchanged.
> 
> I don't know yet what the overhead is for __builtin_dynamic_object_size vs
> __builtin_object_size, were you able to measure it somehow for the kernel?
> If there's a significant tradeoff, it may make sense to provide a user
> override.

So far I've not seen any measurable performance difference, but I just
may not be creative enough yet.

So far, the tunable is building a kernel with or without FORTIFY_SOURCE
and UBSAN_BOUNDS. :)

-- 
Kees Cook
