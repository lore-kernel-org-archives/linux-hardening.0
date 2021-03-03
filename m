Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7645C433DB
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B1364FB4
	for <linux-hardening@archiver.kernel.org>; Thu,  4 Mar 2021 00:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbhCDAvZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:51:25 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:35184 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234166AbhCCSyH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 3 Mar 2021 13:54:07 -0500
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 123IoDLr006152;
        Thu, 4 Mar 2021 03:50:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 123IoDLr006152
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614797413;
        bh=fvTDpDKpHB2RoYVt26aVSfRN8H+EkrwI+Rs0xBOTnaY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=x056maJ4bLhrtmh+om8k4pFwPKY7SUSf9fSjaV61pzOCe+r54ANja43k/dNlMyfKT
         viwScA1dES2h6rSh+y8sxfXG50bhOUTFL50oo+aGXOopPxi1KGwpoxuXoGfiT/0XJn
         K/HDajcgWeaxF79vOsyd1HbV/PXQxNf6tCJwPRSKb4kqI0g+2H04+Jiz4pjEUoaZ1G
         VdnQuEAn3+bb3l8+b7TbVnr4hU8tij4eL24zMCrYmtb+BPNI8ZuquwvA0EJufn+93R
         UZouzZ2hY5rr/81r8aLXZRR8oM17llg0B0UCDpp/2+T0ludvTD2Uf9yEdhS62DmQvP
         Xo8EMzomXHMnQ==
X-Nifty-SrcIP: [209.85.215.182]
Received: by mail-pg1-f182.google.com with SMTP id t25so17053281pga.2;
        Wed, 03 Mar 2021 10:50:13 -0800 (PST)
X-Gm-Message-State: AOAM533Iy1qEQBUJU3+Iu8yHslbsYEvkWk3TspHToky1aKaonaVNDN0g
        t0UC61vAQHBjah6nmQVr1FaHw/vt9p7/nOtq5u8=
X-Google-Smtp-Source: ABdhPJxJeSO/hkm+twwtXdqQxYmlQhQvuY5QvILOCuJ2lY3fPjFUNkrsevggNJm/rQDa4DHuSRNV0XWfvtHG038rb6o=
X-Received: by 2002:a65:428b:: with SMTP id j11mr292481pgp.47.1614797412617;
 Wed, 03 Mar 2021 10:50:12 -0800 (PST)
MIME-Version: 1.0
References: <efe6b039a544da8215d5e54aa7c4b6d1986fc2b0.1611607264.git.jpoimboe@redhat.com>
 <20210302232649.y2tutffhxsblwqlb@treble>
In-Reply-To: <20210302232649.y2tutffhxsblwqlb@treble>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 4 Mar 2021 03:49:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
Message-ID: <CAK7LNAReuB5zUq_7S8ZG25+tdQowECDOK1rApYvkPCpHhPjK5w@mail.gmail.com>
Subject: Re: [PATCH RFC] gcc-plugins: Handle GCC version mismatch for OOT modules
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Justin Forbes <jforbes@redhat.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Frank Eigler <fche@redhat.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 3, 2021 at 8:27 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Mon, Jan 25, 2021 at 02:42:10PM -0600, Josh Poimboeuf wrote:
> > When building out-of-tree kernel modules, the build system doesn't
> > require the GCC version to match the version used to build the original
> > kernel.  That's probably [1] fine.
> >
> > In fact, for many distros, the version of GCC used to build the latest
> > kernel doesn't necessarily match the latest released GCC, so a GCC
> > mismatch turns out to be pretty common.  And with CONFIG_MODVERSIONS
> > it's probably more common.
> >
> > So a lot of users have come to rely on being able to use a different
> > version of GCC when building OOT modules.
> >
> > But with GCC plugins enabled, that's no longer allowed:
> >
> >   cc1: error: incompatible gcc/plugin versions
> >   cc1: error: failed to initialize plugin ./scripts/gcc-plugins/structleak_plugin.so
> >
> > That error comes from the plugin's call to
> > plugin_default_version_check(), which strictly enforces the GCC version.
> > The strict check makes sense, because there's nothing to prevent the GCC
> > plugin ABI from changing -- and it often does.
> >
> > But failing the build isn't necessary.  For most plugins, OOT modules
> > will otherwise work just fine without the plugin instrumentation.
> >
> > When a GCC version mismatch is detected, print a warning and disable the
> > plugin.  The only exception is the RANDSTRUCT plugin which needs all
> > code to see the same struct layouts.  In that case print an error.
>
> Hi Masahiro,
>
> This problem is becoming more prevalent.  We will need to fix it one way
> or another, if we want to support distro adoption of these GCC
> plugin-based features.
>
> Frank suggested a possibly better idea: always rebuild the plugins when
> the GCC version changes.


That is just another form of the previous patch,
which was already rejected.


- That is a hack just for external modules
- Our consensus is, use the same version for the kernel and external modules



I use Ubuntu, and I do not see such a problem.
(I have never seen it on Debian either, except sid.)

I see Fedora providing GCC whose version is different
from the one used for building the kernel.
That is a problem on the distribution side.



In my ubuntu.

$ grep CC_VERSION_TEXT   /lib/modules/$(uname -r)/build/.config
CONFIG_CC_VERSION_TEXT="gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0"
$ gcc --version  | head -n1
gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0



> What do you think?

NACK.


>  Any suggestions on how to
> implement that?  Otherwise I can try to hack something together.
>
> --
> Josh
>
--
Best Regards
Masahiro Yamada
