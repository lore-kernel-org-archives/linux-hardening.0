Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7E7FA373D
	for <linux-hardening@archiver.kernel.org>; Tue, 25 Oct 2022 22:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbiJYWzJ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiJYWzG (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 25 Oct 2022 18:55:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4706975FE7
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 15:55:06 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v13-20020a17090a6b0d00b0021332e5388fso434408pjj.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Oct 2022 15:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra6g/OJlkYVneeWayx4/X1tGU61tNPtmZeLJALiKlsg=;
        b=OdfBlk3ohwk4OPGswlL77glZyOEhkpZ9paxEg4UCiRkb5yVtyDSa+yHjdwg4rCAr3W
         yz2OIF4v85vVqzXNMMmsc885oRRYXYJKN3jNWWJ2GA5k2+EM/4MOz0vSg+4c0Ite27nj
         4D2Ycx9FAwYnUQbGwEWLvzR5J94/ofXVY65Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra6g/OJlkYVneeWayx4/X1tGU61tNPtmZeLJALiKlsg=;
        b=VZwWgr+/rQ24nNEQKFbDtZHfYGeoHDKbv4mFmApAWPaAPDthzlBrHRYWhXmNBaC3Lu
         CAKpmapBBa4iwFvZTuBWmmROTgRQMKJrbQ3+NmCLoG2b5rS1MFAFSy1ME7zE/sXZ9kD7
         3VIWIpzM/EfAUJGNi+iQ1uAyr5yhWQDyBzieA3VQlC3I81yZkjzDhFvQnF2LAFGxyW7v
         jzPUF7VQAF/4nVWDP8H10vGsb++TkaSGywcCWPcOTwjSAJ3r8Qpr3JdUO0yRE5AZHf50
         bCe8qE6gVKFJzdW+uNa1QQZBzTGHLimXXflQucmxP2SFwv2BKGGRnQH1D36bG4v/kMz8
         OX4w==
X-Gm-Message-State: ACrzQf1dkrbb19J6cYG+Qb55tXftZwl3PJw0uXGYsKXMvMWo9993d+hz
        KNC+CeHgfO4CJpwDvN2rjp/pjA==
X-Google-Smtp-Source: AMsMyM44mRwoe5IWqac/2v8N0xaf9xGSEr4+1fALOhdzTO3Jh2wF+APz+24QcWl4IO/1AQPTfrJywQ==
X-Received: by 2002:a17:902:d2c1:b0:186:9e90:6ad with SMTP id n1-20020a170902d2c100b001869e9006admr15087411plc.2.1666738505517;
        Tue, 25 Oct 2022 15:55:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b65-20020a62cf44000000b00562784609fbsm1851645pfg.209.2022.10.25.15.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:55:04 -0700 (PDT)
Date:   Tue, 25 Oct 2022 15:55:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mempool: Use kmalloc_size_roundup() to match ksize()
 usage
Message-ID: <202210251554.11FA130@keescook>
References: <20221018090323.never.897-kees@kernel.org>
 <20221018155137.f6898d165aade2e3a5f0b2d3@linux-foundation.org>
 <202210182235.3B19DFCB28@keescook>
 <a9c6c111-d92f-f76f-1b7a-f6220d755eeb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c6c111-d92f-f76f-1b7a-f6220d755eeb@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Oct 24, 2022 at 08:03:34PM +0200, Vlastimil Babka (SUSE) wrote:
> On 10/19/22 07:37, Kees Cook wrote:
> > On Tue, Oct 18, 2022 at 03:51:37PM -0700, Andrew Morton wrote:
> >> On Tue, 18 Oct 2022 02:03:29 -0700 Kees Cook <keescook@chromium.org> wrote:
> >> 
> >> > Round up allocations with kmalloc_size_roundup() so that mempool's use
> >> > of ksize() is always accurate and no special handling of the memory is
> >> > needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
> >> 
> >> Confused.  If the special handling is not needed, why doesn't the patch
> >> removed the no longer needed special handling?
> > 
> > The special handling is in the ksize() implementation, so it can't be
> > removed[1] until all the ksize()-affected users are updated to see their
> > true allocation sizes first.
> > 
> > [1] https://lore.kernel.org/lkml/20220923202822.2667581-16-keescook@chromium.org/
> 
> But in the previous version I was wondering if we can just stop doing
> ksize()-like poison handling in mempool completely, if no mempool consumers
> call ksize() to expand their use of the allocated objects. You seemed to
> agree but this version is uncahnged?
> 
> https://lore.kernel.org/all/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/

Oops, yes. This failed to get on my TODO list. New version coming!

-- 
Kees Cook
