Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D868C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 28 Jan 2022 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245406AbiA1UEZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 Jan 2022 15:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiA1UEZ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 Jan 2022 15:04:25 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8BC06173B
        for <linux-hardening@vger.kernel.org>; Fri, 28 Jan 2022 12:04:25 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id t32so6105356pgm.7
        for <linux-hardening@vger.kernel.org>; Fri, 28 Jan 2022 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ow6eT8rr/7d9xpi/r2pDaVO8JLSWc0gIq0t6DC0fz0U=;
        b=CFNLBB0HiS0aAgD12+s0IyhU2V9a9fHe6nueloJjET0XtN/Ydnat2VpccyE9jrb98d
         E0ccBDqoGU9NNrFwtNYXGqYV9WIZNIkSpMTqJX38g9O+67siB5WRBQFQvjK2pKw8A1I6
         ExWacafu/haB8iGYULV7HeWoe0SOFnXBk59Hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ow6eT8rr/7d9xpi/r2pDaVO8JLSWc0gIq0t6DC0fz0U=;
        b=m6ZmNbhQ0lbayWgBcTNwjptO9HRhR7Pw7BYgbtTjQpxtBTrhjLsX8nkXx+E27nvUK6
         p+UpqmClQfFmyaieUE92de3gmdM5BT/k2+GyS9T76I22jt6qpqQadIbyBALYoGfUdeEa
         ULheRKbYZS2sc2GQWN9Vr6eYQAscu5+h2sw28O+Q4ZaU76iv3uw1hHOoIL1dBmIyvgMa
         7yDhiGkCNGELj12dYllfZEaZUtKBiOukPuvNnVmhrqKrNNQrQ5QJ7+wYuGRlgGg+NodH
         0ZiJWqPORusHv3oVDo4IqUmI2LjV8/ka2dCKKlMJ5zCRPtgPfyuLFEdgR6YDn6JeT2UF
         z4yw==
X-Gm-Message-State: AOAM533BaRXYswFHMzc6DPfXYwFwoB2jrj8khSYlDTyMrAOghXEtkg2S
        WTv7201zyfxtVtnlEj2TYcFoF6KUeVO0cA==
X-Google-Smtp-Source: ABdhPJwoQipIAMdr1PZ2Swd9KmfITLuqOTCVITAwBcqCDdESvWM2724Lmp0TZ+9ryG0UTXwuVir+Ug==
X-Received: by 2002:a05:6a00:1709:: with SMTP id h9mr9467158pfc.23.1643400264496;
        Fri, 28 Jan 2022 12:04:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x17sm9564865pfu.135.2022.01.28.12.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:04:24 -0800 (PST)
Date:   Fri, 28 Jan 2022 12:04:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Magnus =?iso-8859-1?Q?Gro=DF?= <magnus.gross@rwth-aachen.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] elf: Relax assumptions about vaddr ordering
Message-ID: <202201281202.C494BAB574@keescook>
References: <YfF18Dy85mCntXrx@fractal.localdomain>
 <202201260845.FCBC0B5A06@keescook>
 <202201262230.E16DF58B@keescook>
 <YfOooXQ2ScpZLhmD@fractal.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfOooXQ2ScpZLhmD@fractal.localdomain>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 28, 2022 at 09:26:09AM +0100, Magnus Groﬂ wrote:
> On Wed, Jan 26, 2022 at 10:31:42PM -0800 Kees Cook wrote:
> > On Wed, Jan 26, 2022 at 08:50:15AM -0800, Kees Cook wrote:
> > > On Wed, Jan 26, 2022 at 05:25:20PM +0100, Magnus Groﬂ wrote:
> > > > From ff4dde97e82727727bda711f2367c05663498b24 Mon Sep 17 00:00:00 2001
> > > > From: =?UTF-8?q?Magnus=20Gro=C3=9F?= <magnus.gross@rwth-aachen.de>
> > > > Date: Wed, 26 Jan 2022 16:35:07 +0100
> > > > Subject: [PATCH] elf: Relax assumptions about vaddr ordering
> > > > MIME-Version: 1.0
> > > > Content-Type: text/plain; charset=UTF-8
> > > > Content-Transfer-Encoding: 8bit
> > > > 
> > > > Commit 5f501d555653 ("binfmt_elf: reintroduce using
> > > > MAP_FIXED_NOREPLACE") introduced a regression, where the kernel now
> > > > assumes that PT_LOAD segments are ordered by vaddr in load_elf_binary().
> > > > 
> > > > Specifically consider an ELF binary with the following PT_LOAD segments:
> > > > 
> > > > Type  Offset   VirtAddr   PhysAddr   FileSiz  MemSiz    Flg Align
> > > > LOAD  0x000000 0x08000000 0x08000000 0x474585 0x474585  R E 0x1000
> > > > LOAD  0x475000 0x08475000 0x08475000 0x090a4  0xc6c10   RW  0x1000
> > > > LOAD  0x47f000 0x00010000 0x00010000 0x00000  0x7ff0000     0x1000
> > > > 
> > > > Note how the last segment is actually the first segment and vice versa.
> > > > 
> > > > Since total_mapping_size() only computes the difference between the
> > > > first and the last segment in the order that they appear, it will return
> > > > a size of 0 in this case, thus causing load_elf_binary() to fail, which
> > > > did not happen before that change.
> > > > 
> > > > Strictly speaking total_mapping_size() made that assumption already
> > > > before that patch, but the issue did not appear because the old
> > > > load_addr_set guards never allowed this call to total_mapping_size().
> > > > 
> > > > Instead of fixing this by reverting to the old load_addr_set logic, we
> > > > fix this by comparing the correct first and last segments in
> > > > total_mapping_size().
> > > 
> > > Ah, nice. Yeah, this is good.
> > > 
> > > > Signed-off-by: Magnus Groﬂ <magnus.gross@rwth-aachen.de>
> > > 
> > > Fixes: 5f501d555653 ("binfmt_elf: reintroduce using MAP_FIXED_NOREPLACE")
> > > Cc: stable@vger.kernel.org
> > > Acked-by: Kees Cook <keescook@chromium.org>
> > 
> > Andrew, can you pick this up too?
> > 
> > -Kees
> > 
> 
> May I also propose to include this patch in whatever mailing-list
> corresponds to the 5.16.x bugfix series?
> It turns out that almost all native Linux games published by the Virtual
> Programming company have this kind of weird PT_LOAD ordering including
> the famous Bioshock Infinite, so right now those games are all
> completely broken since Linux 5.16.

Thanks for additional rationale!

I included the field that would be expected to have this picked up for
the 5.16 stable tree (the "Fixes: ..." and "Cc: stable@vger.kernel.org")
so once it lands in Linus's tree, it'll get picked up for the v5.16.z
series too.

> P.S.: Someone should probably ask Virtual Programming, what kind of
> tooling they use to create such convoluted ELF binaries.

Does "strings" provide any hints? :)

-- 
Kees Cook
