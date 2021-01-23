Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A492C433E0
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Jan 2021 16:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E7DD22C9F
	for <linux-hardening@archiver.kernel.org>; Sat, 23 Jan 2021 16:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbhAWQlR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 23 Jan 2021 11:41:17 -0500
Received: from mout02.posteo.de ([185.67.36.66]:46939 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbhAWQlQ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 23 Jan 2021 11:41:16 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B51ED240101
        for <linux-hardening@vger.kernel.org>; Sat, 23 Jan 2021 17:40:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1611420018; bh=VKYmeAQfMRPl8VtzTlT4SZ+Gbxf09ISdo40XCTRE3t4=;
        h=Date:From:To:Cc:Subject:From;
        b=FElQhn0dId2GNM94noW0qnx4qWEwQKnyARvDQQ4irZwTU2kcppzWzSzj+KACYGFDr
         RUYQEm8tsjS6WZJ7xCNrjNbrS4t1rkxjzR7T5nqJtgiezqVskH0v+IsF5V1XRFkbEN
         nSkWoRddrpHmjbxHi6Mk1O94B/rG4X+DgRvVGGs28EHBJvDxeGo2bnu8QnnZJZkOnl
         9fPjHoZCJwdviKfUkRwrJ5d9PBWw5FSyeKAT1mzKfuZ88HOgOsSdMcWmqB7EMrEgOu
         sxbEM728HxTc6S3JIUjFcFw3SCKBE02vicQm/XObzLQKeaDDipZiOvM5joccarnyrr
         4H5hpFfDF1rCA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DNMLR5PLpz9rxd;
        Sat, 23 Jan 2021 17:40:15 +0100 (CET)
Date:   Sat, 23 Jan 2021 17:40:13 +0100
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Robert Karszniewicz <r.karszniewicz@phytec.de>,
        Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-hardening@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation/Kbuild: Remove references to gcc-plugin.sh
Message-ID: <YAxRbe4DmEbM0feC@HP>
References: <1611338653-175404-1-git-send-email-r.karszniewicz@phytec.de>
 <CAK7LNARn6yhYqA7bm_ExLH5HVvz0gsW_QonX-LXuqYP6q4SDeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARn6yhYqA7bm_ExLH5HVvz0gsW_QonX-LXuqYP6q4SDeg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Jan 23, 2021 at 10:17:59PM +0900, Masahiro Yamada wrote:
> On Sat, Jan 23, 2021 at 3:19 AM Robert Karszniewicz
> <r.karszniewicz@phytec.de> wrote:
> >
> > gcc-plugin.sh has been removed in commit
> > 1e860048c53e ("gcc-plugins: simplify GCC plugin-dev capability test").
> >
> > Signed-off-by: Robert Karszniewicz <r.karszniewicz@phytec.de>
> > ---
> >  Documentation/kbuild/gcc-plugins.rst |  6 ------
> >  scripts/dummy-tools/gcc              | 15 ---------------
> >  2 files changed, 21 deletions(-)
> >
> > [...]
> > diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
> > index 33487e99d83e..a484de576e6f 100755
> > --- a/scripts/dummy-tools/gcc
> > +++ b/scripts/dummy-tools/gcc
> > @@ -74,18 +74,3 @@ if arg_contain -S "$@"; then
> >                 exit 0
> >         fi
> >  fi
> > -
> > -# For scripts/gcc-plugin.sh
> > -if arg_contain -print-file-name=plugin "$@"; then
> > -       plugin_dir=$(mktemp -d)
> > -
> > -       sed -n 's/.*#include "\(.*\)"/\1/p' $(dirname $0)/../gcc-plugins/gcc-common.h |
> > -       while read header
> > -       do
> > -               mkdir -p $plugin_dir/include/$(dirname $header)
> > -               touch $plugin_dir/include/$header
> > -       done
> > -
> > -       echo $plugin_dir
> > -       exit 0
> > -fi
> 
> 
> Well, it is wrong to remove this hunk entirely.
> It would break the ability to enable GCC_PLUGINS.
> 
> I will simplify this part.
> https://lore.kernel.org/patchwork/patch/1369968/
> 
> 
> I took the only change to Documentation/kbuild/gcc-plugins.rst
> from your patch but this document contains more stale info.
> 
> https://lore.kernel.org/patchwork/patch/1370008/

I see, thanks for letting me know,

Robert
