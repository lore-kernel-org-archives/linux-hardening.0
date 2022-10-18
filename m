Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78275C4332F
	for <linux-hardening@archiver.kernel.org>; Tue, 18 Oct 2022 02:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiJRCLC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 17 Oct 2022 22:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiJRCKt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 17 Oct 2022 22:10:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF785006F
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:09:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so12631946pjo.4
        for <linux-hardening@vger.kernel.org>; Mon, 17 Oct 2022 19:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiyLEWpU5Vr8UNvHaI2P6jWrDxYlYjUoltJSjloVH1I=;
        b=hX0obQ/EZm8Pl/NdNDUk3PWb0v9ZnyxW4jGAKyYBOMy/QF+aY3BkbN/bFyiU29BdyG
         0Sft8RgezxoohSYTfnh6tT+8bxHNJK5Z4rvWiLbIS0HLpDqQQ5p1INRGVmM1R+Hfk6xG
         JtsXhnWrV8oePjEH150pfzyQPEXPJOHPD7a58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiyLEWpU5Vr8UNvHaI2P6jWrDxYlYjUoltJSjloVH1I=;
        b=uTdWMFVfTvoACnE6eQMs+UJ+H7poUIo/TIaDb3kY+xQJ6mtgBAqEQJ/tKqVNL26JMY
         /3x4XE9UXEG9O6kaUQwKsrR9lMPZQ+T6R+dSN+jKhsN9qQq5uCX2pXs6ZRC5zQNOom17
         M0xLHxs0ua5KnylL+F+jSB+AH/aESvlm8TsMs/6EPadj4eezOnpHWf18ISnD8RPN+uZc
         D4uOTUY/SFl1yO29SyreVndx8o1frjPiAnAXIXG/XbIV/KXa9JET/6wOqRwFlIFY36Vn
         1GKTERjslYKaCKA3n3mw5tUy4BcChooa0Jp337E+6AryW/945Kixw+A1LT9DKNDG/t1D
         Q3mQ==
X-Gm-Message-State: ACrzQf2yUj5DqaZGd7MB+Ma/zAVfa6B/zq/A4hviwcV1k7JqE+E4pkFa
        g6xmGVTyCjEUcFqDb/5hfCeTTA==
X-Google-Smtp-Source: AMsMyM76Iwrloo6pXjHpP+l4o1Nu/SlNFgkPEzmA2JfePmZI4bka2pMHfzkcmzlsg/0cbux1EOTczQ==
X-Received: by 2002:a17:902:8b83:b0:17f:5de5:c5ff with SMTP id ay3-20020a1709028b8300b0017f5de5c5ffmr675629plb.52.1666058986011;
        Mon, 17 Oct 2022 19:09:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2-20020a17090a284200b0020dafceec65sm7453398pjf.13.2022.10.17.19.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:09:45 -0700 (PDT)
Date:   Mon, 17 Oct 2022 19:09:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] overflow: Fix kern-doc markup for functions
Message-ID: <202210171909.65FFFB5601@keescook>
References: <20221017035732.1968394-1-keescook@chromium.org>
 <6f8aa670-fb4f-3ff9-bcd9-8490e752b349@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8aa670-fb4f-3ff9-bcd9-8490e752b349@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 18, 2022 at 10:11:43AM +0900, Akira Yokosawa wrote:
> Hi,
> 
> On Sun, 16 Oct 2022 20:57:32 -0700, Kees Cook wrote:
> > Fix the kern-doc markings for several of the overflow helpers and move
> > their location into the core kernel API documentation, where it belongs
> > (it's not driver-specific).
> > 
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Akira Yokosawa <akiyks@gmail.com>
> LGTM,
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Thanks!

> Kees, which tree do you expect this one to go through?

If the Documentation/* changes look okay, I'd rather carry it in my tree
since I'm going to be poking at more functions in there soon.

-- 
Kees Cook
