Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819D4C43460
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Apr 2021 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6344B613BC
	for <linux-hardening@archiver.kernel.org>; Tue,  6 Apr 2021 14:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345265AbhDFOmm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:42:42 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:39966 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbhDFOmj (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 6 Apr 2021 10:42:39 -0400
Date:   Tue, 06 Apr 2021 14:42:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1617720149; bh=oJpZdJdRCbGDRnUwga5oT056lLMZteop8NZbFOdEXdE=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=LhDCuK2TaPMHBvK0ZdULyzsJMyTCHi6w/6LZRO1wZgu15z7RYuMLl18o6dWHe8kVq
         WL6SrEz9no1GSQLwOiQYZlPnkRLvZ94+jpco1XCDmxbtAzTeSfd6+PL1Nsi1NXSKI6
         /Pehtfs++C1q51sOQAQ+0thQQFVhuebHhH6vbk+GidCHeendFIazfyP3o4cHuh5lyK
         lbaI2eumHvcKUHcnxRdGS4hqhOAyGOWf+X7iyyPnBZsdcc81NlgOQkDVm/bqWs8jpI
         riU79Fnm8z/LaYMXtnyhOwzQTqJZFnuxSQh/NK6d8DvUD3HOJ9NU5x/JL/zNbVgymZ
         Gv3ftphgHz+Uw==
To:     Sami Tolvanen <samitolvanen@google.com>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH] kbuild: merge module sections under CONFIG_LD_DEAD_CODE_DATA_ELIMINATION too
Message-ID: <Gt4--xIFQdFQbd97OwKvRwelvfikSSv3Vkc_KKzAeGgp6c2fe8SPW6v_njp0xvwepPwC_UcWdyWeAjSdFEXpheJWlnmWNY-mVsaMEnJV56A=@pm.me>
In-Reply-To: <CABCJKufH262ki4FCQJxSO-v+gQzPBsVntQWnNZY7h-cvt1KYTA@mail.gmail.com>
References: <20210402123959.5143-1-alobakin@pm.me> <CABCJKufH262ki4FCQJxSO-v+gQzPBsVntQWnNZY7h-cvt1KYTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Friday, 2 April 2021, 18:09, Sami
Tolvanen <samitolvanen@google.com> wrote:

> On Fri, Apr 2, 2021 at 5:40 AM Alexander Lobakin alobakin@pm.me wrote:
>
> > When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> > -fdata-sections and -ffunction-sections are being enabled by the
> > top-level Makefile, and module section merging is also needed.
> > Expand the ifdef (and the comment block) to cover that case too.
> > Fixes: 6a3193cdd5e5 ("kbuild: lto: Merge module sections if and only if=
 CONFIG_LTO_CLANG is enabled")
>
> Wouldn't this trigger the ld.bfd bug described in the commit message
> when LD_DEAD_CODE_DATA_ELIMINATION is enabled? LTO_CLANG always uses
> LLD, so it won't have this issue.

LD_DEAD_CODE_DATA_ELIMINATION is marked
=E2=80=9CEXPERIMENTAL=E2=80=9C in the config prompt, and
arches have to opt-in
HAS_LD_DEAD_CODE_DATA_ELIMINATION to give
an access to it (only a few does). This
should be relatively safe.

> Sami

Thanks,
Al
