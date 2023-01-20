Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47D0C05027
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Jan 2023 19:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjATTQj (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:16:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjATTQi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Jan 2023 14:16:38 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C584A1E8
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jan 2023 11:16:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k18so6182024pll.5
        for <linux-hardening@vger.kernel.org>; Fri, 20 Jan 2023 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCTlYntdRgC/e/OHfXERmz4JTpH8MxX2a2uQoCMaeEw=;
        b=CcMDWOHcyMnDiMwpgS5KqKwroy7aL1E0Ae04q5EpKSaPeVXGENNuXVZh1k0Yl9Qz0v
         BQOBkxIcFHCOL3MMLUutpeFghnqEzE+QGhESgvpGiZg1X7LUn/pbyNBpeiiMgwGHVAep
         rdBKE8JXBwffXj2zUp06Yu8REDfy+HIl3/sEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCTlYntdRgC/e/OHfXERmz4JTpH8MxX2a2uQoCMaeEw=;
        b=QyK6DLXUKYdpj/b4ZIjZJ2P0lZ1jjoOl5bWcjHazc1R7AT6FB6QKPnPzOU5QhTtmCe
         aRQHFtNKaoLAhG2tMGi8am8IeqdUrmy6J+6SYQBdh3IUAShq++SSkr+WkItSyH+YyeAp
         fyg7s051QXSuNY5HD6MvbbeS6lK9UVAC/4JmdmfmXMcMth4ZhACPFci4gnRq8KYZWj21
         n/VJ78IVnomjm0frLn0MYFZgQgTq3JB/qjy1niSkH5Re48kYTtzMue/DWUiNnl2HZNx4
         svID4baym9hHDqLVsDzqxA7R9Ydrj5eIaYNniXJBcieTsbuDxptFhR98y5O262zlZByS
         xZSw==
X-Gm-Message-State: AFqh2krAvZQlVQACC1S1jJmXj0O7IgojVMpVZAWe78pwr/OXzYizM2Z1
        BMo87zWNi6qCp5XPl7TsQsP/XQ==
X-Google-Smtp-Source: AMrXdXtXgcXIzHSpoCCIGk2/oEfPyUo0g+DDqUTAM9VueR6qgPjttfn4ZtIrjTyXomEzUx6R0vvSKw==
X-Received: by 2002:a17:903:210a:b0:192:6195:44b6 with SMTP id o10-20020a170903210a00b00192619544b6mr14493111ple.58.1674242197238;
        Fri, 20 Jan 2023 11:16:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ab8b00b00195e8f97e72sm1447209plr.111.2023.01.20.11.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:16:36 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:16:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Subject: Re: [PATCH] ACPICA: Replace fake flexible arrays with flexible array
 members
Message-ID: <202301201116.6ED85A70@keescook>
References: <20221118181538.never.225-kees@kernel.org>
 <202301151037.20CC3F0@keescook>
 <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hvoAD1WLXzpMobTRSasBqy5dypHTysBU3=ionGgWR6nQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Jan 20, 2023 at 07:10:52PM +0100, Rafael J. Wysocki wrote:
> On Sun, Jan 15, 2023 at 7:38 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> > > Functionally identical to ACPICA upstream pull request 813:
> > > https://github.com/acpica/acpica/pull/813
> >
> > Any update on this? Upstream is currently unbuildable since October.
> >
> > > One-element arrays (and multi-element arrays being treated as
> > > dynamically sized) are deprecated[1] and are being replaced with
> > > flexible array members in support of the ongoing efforts to tighten the
> > > FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> > > with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> > >
> > > Replace one-element array with flexible-array member in struct
> > > acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> > > padding in a union with a flexible-array member in struct
> > > acpi_pci_routing_table.
> > >
> > > This results in no differences in binary output.
> >
> > In the meantime, can you take this patch for Linux, and we can wait for
> > ACPICA to catch up?
> 
> Applied now (as 6.3 material), sorry for the delay.

Thanks!

-- 
Kees Cook
