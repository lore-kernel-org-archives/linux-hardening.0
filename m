Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067CCD37AA
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 21:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbjIOVED (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 17:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbjIOVDj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 17:03:39 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E2018D
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 14:03:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68fc081cd46so2481530b3a.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 14:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694811803; x=1695416603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APHJKdyAi/Un1XPHZn1Z1pQZW4vCCHalitDLmyiouTQ=;
        b=dx8DPTvbuSlh9TpzZol3/Gyx4GRxRBcPwEjUuOrFdZrrcIkqYUyXgAfBmgY4WsF03M
         hPSwrZPbIXM6+8W2CTfEJ/r3EcWQ8DnB2VTdZ8+5HDZ62Fj5w4nHKOruLoJ9uNXREkya
         nkJnIDPHkznSwrax0w/JCkGyXb1kCiTaYYts4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694811803; x=1695416603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APHJKdyAi/Un1XPHZn1Z1pQZW4vCCHalitDLmyiouTQ=;
        b=M9LY9djINS38Why99R1mTNKn3hZHX/o3iqAwgm7D7jpqEPwXYaoLuT6xdFSYGlbmV4
         +Hf1X9T9f5wxjr0tqei+ygb2QjtcMpXgFCJwGzACGGU0vL/KNnqpEMuuwQNQAptAsz29
         JJTxXmXEExY63FlHVsPRwOkb3DpXX29EOBYwq1UqROd2MHODw18kU14Z3BynRtyoE3xj
         AeATy+AZ99uRY40HggC3DrAqS2knZmMO9aHb1TEMQz2ENonulrFTzWbqaUD1mh9OyzXJ
         B6fkMB7enek6uKo5iYG2XfjnJurglc9VWh+97D8JWRF/6XQkm2hRn+edvlX9GJFIOZWf
         8fWg==
X-Gm-Message-State: AOJu0Ywo0xLWJrity6y+qKyg5b24aJa2qc74POfHfZriCeeQBSNeeVjs
        QLRAkc/D9VjflWBcVhiRL07Mfw==
X-Google-Smtp-Source: AGHT+IH9giN0oiNJip6NSPrpp8FYJe9UYAjCNYEhPQYuBGuLm0ngXdsbwkHYQMIrzQrQbvKrNld2xQ==
X-Received: by 2002:a05:6a20:320d:b0:14b:8023:33c8 with SMTP id hl13-20020a056a20320d00b0014b802333c8mr2834160pzc.2.1694811803227;
        Fri, 15 Sep 2023 14:03:23 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bv6-20020a632e06000000b0056001f43726sm3098867pgb.92.2023.09.15.14.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 14:03:22 -0700 (PDT)
Date:   Fri, 15 Sep 2023 14:03:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Subject: Re: [RFC PATCH 06/14] mm/slub: pass additional args to
 alloc_slab_page
Message-ID: <202309151403.49D5C3CB@keescook>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <20230915105933.495735-7-matteorizzo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915105933.495735-7-matteorizzo@google.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Sep 15, 2023 at 10:59:25AM +0000, Matteo Rizzo wrote:
> From: Jann Horn <jannh@google.com>
> 
> This is refactoring in preparation for SLAB_VIRTUAL.
> 
> The implementation of SLAB_VIRTUAL needs access to struct kmem_cache in
> alloc_slab_page in order to take unused slabs from the slab freelist,
> which is per-cache.
> 
> In addition to that it passes two different sets of GFP flags.
> meta_gfp_flags is used for the memory backing the metadata region and
> page tables, and gfp_flags for the data memory.
> 
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
