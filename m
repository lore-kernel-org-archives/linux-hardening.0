Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BE4C4332F
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Nov 2022 22:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbiKAWFd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Nov 2022 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiKAWFP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Nov 2022 18:05:15 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7434B7FC
        for <linux-hardening@vger.kernel.org>; Tue,  1 Nov 2022 15:04:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 192so14714905pfx.5
        for <linux-hardening@vger.kernel.org>; Tue, 01 Nov 2022 15:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVvLVWD0SwVO5uuYDW/raVqjoQRxgka09rcDVfoxsVg=;
        b=JTPX3LPX80RfqLtGt8ZES0LkcLA4OD0C3LhC4KCbDqOJU09Lmf5Ju6icnIvviUWwJT
         ccON6ls/fqIrea4ffsNGL3MPShWxM/TgwFdmzQ/oycBFIFSeUYzFH9h9MxjGfg69xCuG
         X+dwSd4VzvVMcavX+QTBxWvPI6vCrRBrgPhX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVvLVWD0SwVO5uuYDW/raVqjoQRxgka09rcDVfoxsVg=;
        b=bSnAnR4k4Z4kcZcaIVJjSuT8gpijXnajHkD7AzsE2fhaEFgu3UDtVMIWFiXq33zaHQ
         yp8TGH0LA8NypZpS0XZQrTAcjMYxu5g9C3ZGqJZsrZ/U43cmpJuHgGF0TpwqrZ29k/wb
         rWdEUcW2V2mRHaLfW0dx0ImZ5CCpCAE+xMjYWX8jnh2VYtYfFf54Whg/yCoYWjxW6U38
         Tyfnxj1MBjYqzpfmUAqGRo/TbuNoeVbc48p/0498EDQunMF55/f+cQ1s3wioj1nWU7IY
         nARdRRFVjUZ+HTLOnIo3nFWJP9/rOPXaAouI99ghjVt/iX0sZdBckTB8MybSgHP6L7Dd
         HT1g==
X-Gm-Message-State: ACrzQf0CHyUN5Wr9kSbWyTEyHB+af4+ByKL3E0kgabMPAeb733wAk4q2
        P4OGHrlrjOj4Rsr2S1GO8UWS+g==
X-Google-Smtp-Source: AMsMyM481JiojcLSf14Hk6/OSNDq4NNy73X2FY8pOwcjt+8Vk3ZZJiNm6ZrAsoOR+o9F9x4ZnHVhgA==
X-Received: by 2002:aa7:96c7:0:b0:56b:c569:99c with SMTP id h7-20020aa796c7000000b0056bc569099cmr21927166pfq.4.1667340288321;
        Tue, 01 Nov 2022 15:04:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m14-20020a63fd4e000000b00460c67afbd5sm6393561pgj.7.2022.11.01.15.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 15:04:47 -0700 (PDT)
Date:   Tue, 1 Nov 2022 15:04:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kunit/fortify: Validate __alloc_size attribute results
Message-ID: <202211011501.CD0E5A9@keescook>
References: <20221018082559.never.406-kees@kernel.org>
 <CABVgOSneaxVgAQH=bN0pxOkN3irtpYVwFhPhNJRoyTcRfEoWhQ@mail.gmail.com>
 <202210182237.C65BCCE2@keescook>
 <CABVgOSn359J8W4DFBO4n8SW=L=-PaVKi9G4R9u67jSBs1zGoGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSn359J8W4DFBO4n8SW=L=-PaVKi9G4R9u67jSBs1zGoGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 19, 2022 at 02:29:44PM +0800, David Gow wrote:
> [13:55:44] # alloc_size_test: EXPECTATION FAILED at lib/fortify_kunit.c:91
> [13:55:44] Expected __builtin_dynamic_object_size(p, 1) == expected, but
> [13:55:44] __builtin_dynamic_object_size(p, 1) == -1
> [13:55:44] expected == 51
> [13:55:44] __alloc_size() not working with kmalloc_node(size++, gfp,
> NUMA_NO_NODE)

So, this turned out to be a rat-hole de-ja-vu. The short version is "I
was using Clang 16 where this doesn't manifest", and the long version is
"some inline attributes are broke on all versions of GCC[1] and on Clang
until version 16". :(

I will send the work-around series I've put together to address it. At
the end of the day I now have a WAY more robust set of __alloc_size
KUnit tests. :P

-Kees

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96503

-- 
Kees Cook
