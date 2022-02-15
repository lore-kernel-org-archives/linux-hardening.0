Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FE9C433FE
	for <linux-hardening@archiver.kernel.org>; Tue, 15 Feb 2022 20:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244130AbiBOUmv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 15 Feb 2022 15:42:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244126AbiBOUmu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 15 Feb 2022 15:42:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DD5C084F;
        Tue, 15 Feb 2022 12:42:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6B63B81C1F;
        Tue, 15 Feb 2022 20:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD6CC340EB;
        Tue, 15 Feb 2022 20:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644957757;
        bh=lf8m5m92vdkIEAB+HSJak7RdqA5l3PCagYqMsT6Kuuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=li+sxWxpcvHCSZA5kwm5lLmbzaSWhgRO3thTmuOqvvqZPBpeCPa0dfMJNktmV8iTn
         a7ALcr0E86oTc+GA5jnF1oaYZ8ZwKYXyzp+H5oPjflz4otGlZqx67cNZcg7uVMQyda
         4GFMSbNuu7WYd/0l7Z6NDvSvcrsJTCc9NhOy+6zE3WZeONOuaQU5YUwdicqI/EbRK8
         D5+VDsn6Xjj7rgj3ym74DsRfiNUc3j9cReblsdSnzV9/nVZvUPGbixOqfIOVKtF8Tz
         ZNdfWsNNp2GZigxJsq0bxFN3F2sNe3qhygDQYltJlMjZ7oZTsUO/a6XrGlZIsAzMTT
         1q0jvBlYGEfmw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 706F3400FE; Tue, 15 Feb 2022 17:42:35 -0300 (-03)
Date:   Tue, 15 Feb 2022 17:42:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Justin Forbes <jmforbes@linuxtx.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Message-ID: <YgwQO1Z0UmV241vg@kernel.org>
References: <20220213182443.4037039-1-keescook@chromium.org>
 <20220214200730.a3qz6ocy2ohwafrt@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220214200730.a3qz6ocy2ohwafrt@treble>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Em Mon, Feb 14, 2022 at 12:07:30PM -0800, Josh Poimboeuf escreveu:
> On Sun, Feb 13, 2022 at 10:24:43AM -0800, Kees Cook wrote:
> > GCC 12 was correctly reporting a potential use-after-free condition in
> > the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
> > when size == 0:
> > 
> > In file included from help.c:12:
> > In function 'xrealloc',
> >     inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> >    56 |                 ret = realloc(ptr, size);
> >       |                       ^~~~~~~~~~~~~~~~~~
> > subcmd-util.h:52:21: note: call to 'realloc' here
> >    52 |         void *ret = realloc(ptr, size);
> >       |                     ^~~~~~~~~~~~~~~~~~
> > subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
> >    58 |                         ret = realloc(ptr, 1);
> >       |                               ^~~~~~~~~~~~~~~
> > subcmd-util.h:52:21: note: call to 'realloc' here
> >    52 |         void *ret = realloc(ptr, size);
> >       |                     ^~~~~~~~~~~~~~~~~~
> > 
> > Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
> > Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1: https://lore.kernel.org/lkml/20220212181855.3460176-1-keescook@chromium.org/
> > v2: simplify logic (josh)
> 
> Thanks, running through testing now.

I assume that testing went ok, may I add a Tested-by: you?

- Arnaldo
