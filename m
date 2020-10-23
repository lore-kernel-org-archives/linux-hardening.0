Return-Path: <SRS0=thHn=D6=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50073C388F9
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 09:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11F624182
	for <linux-hardening@archiver.kernel.org>; Fri, 23 Oct 2020 09:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S461034AbgJWJCi (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 23 Oct 2020 05:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460918AbgJWJCi (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 23 Oct 2020 05:02:38 -0400
Received: from gaia (unknown [95.145.162.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F24921D43;
        Fri, 23 Oct 2020 09:02:35 +0000 (UTC)
Date:   Fri, 23 Oct 2020 10:02:32 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: BTI interaction between seccomp filters in systemd and glibc
 mprotect calls, causing service failures
Message-ID: <20201023090232.GA25736@gaia>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022075447.GO3819@arm.com>
 <78464155-f459-773f-d0ee-c5bdbeb39e5d@gmail.com>
 <202010221256.A4F95FD11@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202010221256.A4F95FD11@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Oct 22, 2020 at 01:02:18PM -0700, Kees Cook wrote:
> Regardless, it makes sense to me to have the kernel load the executable
> itself with BTI enabled by default. I prefer gaining Catalin's suggested
> patch[2]. :)
[...]
> [2] https://lore.kernel.org/linux-arm-kernel/20201022093104.GB1229@gaia/

I think I first heard the idea at Mark R ;).

It still needs glibc changes to avoid the mprotect(), or at least ignore
the error. Since this is an ABI change and we don't know which kernels
would have it backported, maybe better to still issue the mprotect() but
ignore the failure.

-- 
Catalin
