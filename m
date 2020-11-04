Return-Path: <SRS0=8UcS=EK=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5690FC2D0A3
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 14:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0BFB20735
	for <linux-hardening@archiver.kernel.org>; Wed,  4 Nov 2020 14:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgKDOfI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 4 Nov 2020 09:35:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:43428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgKDOfI (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 4 Nov 2020 09:35:08 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32CF20709;
        Wed,  4 Nov 2020 14:35:03 +0000 (UTC)
Date:   Wed, 4 Nov 2020 14:35:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Florian Weimer <fweimer@redhat.com>, Will Deacon <will@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/4] aarch64: avoid mprotect(PROT_BTI|PROT_EXEC) [BZ
 #26831]
Message-ID: <20201104143500.GC28902@gaia>
References: <cover.1604393169.git.szabolcs.nagy@arm.com>
 <20201103173438.GD5545@sirena.org.uk>
 <20201104092012.GA6439@willie-the-truck>
 <87h7q54ghy.fsf@oldenburg2.str.redhat.com>
 <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2f51a90-c5d6-99bd-35b8-f4fded073f95@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Nov 04, 2020 at 11:55:57AM +0200, Topi Miettinen wrote:
> On 4.11.2020 11.29, Florian Weimer wrote:
> > * Will Deacon:
> > 
> > > Is there real value in this seccomp filter if it only looks at mprotect(),
> > > or was it just implemented because it's easy to do and sounds like a good
> > > idea?
> > 
> > It seems bogus to me.  Everyone will just create alias mappings instead,
> > just like they did for the similar SELinux feature.  See “Example code
> > to avoid execmem violations” in:
> > 
> >    <https://www.akkadia.org/drepper/selinux-mem.html>
[...]
> > As you can see, this reference implementation creates a PROT_WRITE
> > mapping aliased to a PROT_EXEC mapping, so it actually reduces security
> > compared to something that generates the code in an anonymous mapping
> > and calls mprotect to make it executable.
[...]
> If a service legitimately needs executable and writable mappings (due to
> JIT, trampolines etc), it's easy to disable the filter whenever really
> needed with "MemoryDenyWriteExecute=no" (which is the default) in case of
> systemd or a TE rule like "allow type_t self:process { execmem };" for
> SELinux. But this shouldn't be the default case, since there are many
> services which don't need W&X.

I think Drepper's point is that separate X and W mappings, with enough
randomisation, would be more secure than allowing W&X at the same
address (but, of course, less secure than not having W at all, though
that's not always possible).

> I'd also question what is the value of BTI if it can be easily circumvented
> by removing PROT_BTI with mprotect()?

Well, BTI is a protection against JOP attacks. The assumption here is
that an attacker cannot invoke mprotect() to disable PROT_BTI. If it
can, it's probably not worth bothering with a subsequent JOP attack, it
can already call functions directly.

I see MDWX not as a way of detecting attacks but rather plugging
inadvertent security holes in certain programs. On arm64, such hardening
currently gets in the way of another hardening feature, BTI.

-- 
Catalin
