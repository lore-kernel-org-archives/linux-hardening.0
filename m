Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F9FC4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJRRNC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 18 Oct 2022 13:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJRRNB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 18 Oct 2022 13:13:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE053EE887
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 10:12:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q9so13853011pgq.8
        for <linux-hardening@vger.kernel.org>; Tue, 18 Oct 2022 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAUG1pQ9zmruVe1EzRA9y5o1htxEAHaV3vjlx1PvioU=;
        b=nzKKwHewBZhQkpGqWY2fZ8Vt1vPyfMkkPk7rDiaTwuOOjEAVocgdOrZpuLpDpd3cSK
         EekAyNKusgAHiYURIJrYqayqPptP5UTEzTdjbxVZfu0MbujBKvHnNczNpQeK6XoJ8mL/
         ituEFLOXwJ0FCA/pMMzFCOfG4dcy5bUbRfg7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dAUG1pQ9zmruVe1EzRA9y5o1htxEAHaV3vjlx1PvioU=;
        b=JF4RWWsQzzb2G5TLTDsUOHK+mOgYdLqCQOZ67X+rwwY00p5w8eehchuDKAFfWtr5pK
         sFCGBJR9L61NmjQbXR2QGcNV4B9jn7MbBcfKM5U8zQSWY+ufHfSg4Ex11KQh1wG82olY
         2f+rrD8PrNssQ5VB8WkUywg9Bs4zM1mAVTguH4gd6XW9e+Q+UYSce6K295vJXYIhTOgl
         2QjJbnd9ACtmGSrznCkt0YYYaMSqI4ZPLRIHlDRXAAd4InDfBPo2X7xRTOQ42DKALe5p
         +gK2rI/sEGM+/RySouIisnIiai5gkkwA3IOYmj32AfER/mlYij/XEzWVmyLoIu+9weut
         7ltg==
X-Gm-Message-State: ACrzQf1zPqMF1r1+gJ8YS3MDgxdgq/LGGxmEfrzXGNYb+FJRQSGWESft
        9Y7xm0EePczTIwBPwAGWP+38lg==
X-Google-Smtp-Source: AMsMyM5o5aEiKzImAs02HXBjk9nHa12jVLYhs6td4NQwwFXXfIjV1nZLD++2ZrmHM9N+w+Fbe5pn0g==
X-Received: by 2002:a63:2ac9:0:b0:457:24a2:6fa7 with SMTP id q192-20020a632ac9000000b0045724a26fa7mr3424011pgq.484.1666113179208;
        Tue, 18 Oct 2022 10:12:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0017f80305239sm9054018plh.136.2022.10.18.10.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:12:58 -0700 (PDT)
Date:   Tue, 18 Oct 2022 10:12:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] siphash: Convert selftest to KUnit
Message-ID: <202210181011.EA0B964@keescook>
References: <20221018100510.never.479-kees@kernel.org>
 <Y07bqnZVrA9FO03z@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07bqnZVrA9FO03z@zx2c4.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 11:00:26AM -0600, Jason A. Donenfeld wrote:
> On Tue, Oct 18, 2022 at 03:05:46AM -0700, Kees Cook wrote:
> > Convert the siphash self-test to KUnit so it will be included in "all
> > KUnit tests" coverage, and can be run individually still:
> > 
> > $ ./tools/testing/kunit/kunit.py run siphash
> > ...
> > [02:58:45] Starting KUnit Kernel (1/1)...
> > [02:58:45] ============================================================
> > [02:58:45] =================== siphash (1 subtest) ====================
> > [02:58:45] [PASSED] siphash_test
> > [02:58:45] ===================== [PASSED] siphash =====================
> > [02:58:45] ============================================================
> > [02:58:45] Testing complete. Ran 1 tests: passed: 1
> > [02:58:45] Elapsed time: 21.421s total, 4.306s configuring, 16.947s building, 0.148s running
> > 
> > Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> > Cc: David Gow <davidgow@google.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I'll queue this up. Thanks for the conversion. Appears to work well.

Cool! Thanks for looking it over. If we want to avoid some tree
collisions, I could carry it in my tree? I've got some other conversions
in progress. Though maybe this begs the question of "how should kunit
tests be ordered in the Kconfig and Makefile?" so that collisions are
obvious about how to order...

-- 
Kees Cook
