Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C37C77B7E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jun 2023 16:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFAQzZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jun 2023 12:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjFAQzV (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jun 2023 12:55:21 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100151BB
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jun 2023 09:55:16 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6af81142b6dso1033674a34.2
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jun 2023 09:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685638515; x=1688230515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7R//X5NdsgI6wLK3+Qn/oGuxEvWJrNQ/UPsJ5NYCxrI=;
        b=N7jxBsxokIj4dbKG6CfxgzcFsr0fRqCh3i51kOL9bnVoVD7qhUPnQdT61rQLCRW9Sf
         4HqGyhdlZ6lg0JDJd8XMOiBemmXtWSiGpZ0wcSMfI4cdrK3bxXfXe2Dy1jA51fWkUfIo
         8gGyws9b00BKw41Xo6nv9fll2wH3Vr9k8IlBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685638515; x=1688230515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R//X5NdsgI6wLK3+Qn/oGuxEvWJrNQ/UPsJ5NYCxrI=;
        b=f6+XA7ZFPS4QZN63OXkXCQ0BpQmd16up++DVc00smUYDhxP7VDS8x6wK3Pyywo3/a/
         ZJlj9XNbWOKUXKeakxvII3Q4MWklsN+6MvX46CGnMh+ubLYjk8ZyV5tdf2f5V5goTDko
         qAXCVQ8GubeFyjAWv/EYkyPfpoq2KyftfuSQtY+txiIAIyg0r5xNfL8DgVxs/vZ0AtAf
         rTuQrbjI5y3sIjtpZ2c8jacg3k2QKlgMSfCvJGXFwhLSf6nNCMP+f7VYI481dQMpQp3X
         UYPsg+5a0u33KlI+JCLEJ7SnGxdYjAefwzoFVNOPg5y8Qe4FmNuRxeN07RUpkiLW8Bkg
         sHhA==
X-Gm-Message-State: AC+VfDxov8jhFMWkEnM/LY1XH1ARDEvB5vOWaXhat1+GGLgkFv1nI7zk
        5Un4IsN0QW4AW8Og7V7zlh4HZQ==
X-Google-Smtp-Source: ACHHUZ6zCvExEfmdXvt05aBdnohmfteqciUcd9dCgQeL02IZcrLpDgudgpXfQvw66OgRXUYf/54XDw==
X-Received: by 2002:a05:6358:5903:b0:123:41df:5196 with SMTP id g3-20020a056358590300b0012341df5196mr7098945rwf.7.1685638515289;
        Thu, 01 Jun 2023 09:55:15 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o1-20020a17090ab88100b0024dfbac9e2fsm1628265pjr.21.2023.06.01.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 09:55:14 -0700 (PDT)
Date:   Thu, 1 Jun 2023 09:55:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dr. David Alan Gilbert" <linux@treblig.org>
Cc:     Dave Kleikamp <shaggy@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] jfs: Use unsigned variable for length calculations
Message-ID: <202306010954.23972A710A@keescook>
References: <20230204183355.never.877-kees@kernel.org>
 <Y96/SUlPUl7xH1NO@gallifrey>
 <63e1486a.050a0220.7001.ca15@mx.google.com>
 <Y+FaEp2blurmgVlH@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+FaEp2blurmgVlH@gallifrey>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Feb 06, 2023 at 07:50:42PM +0000, Dr. David Alan Gilbert wrote:
> * Kees Cook (keescook@chromium.org) wrote:
> > On Sat, Feb 04, 2023 at 08:25:45PM +0000, Dr. David Alan Gilbert wrote:
> > > * Kees Cook (keescook@chromium.org) wrote:
> > > > To avoid confusing the compiler about possible negative sizes, switch
> > > > "ssize" which can never be negative from int to u32.  Seen with GCC 13:
> > > > 
> > > > ../fs/jfs/namei.c: In function 'jfs_symlink': ../include/linux/fortify-string.h:57:33: warning: '__builtin_memcpy' pointer overflow between offset 0 and size [-2147483648, -1]
> > > > [-Warray-bounds=]
> > > >    57 | #define __underlying_memcpy     __builtin_memcpy
> > > >       |                                 ^
> > > > ...
> > > > ../fs/jfs/namei.c:950:17: note: in expansion of macro 'memcpy'
> > > >   950 |                 memcpy(ip->i_link, name, ssize);
> > > >       |                 ^~~~~~
> > > > 
> > > > Cc: Dave Kleikamp <shaggy@kernel.org>
> > > > Cc: Christian Brauner <brauner@kernel.org>
> > > > Cc: Dave Chinner <dchinner@redhat.com>
> > > > Cc: jfs-discussion@lists.sourceforge.net
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  fs/jfs/namei.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
> > > > index b29d68b5eec5..494b9f4043cf 100644
> > > > --- a/fs/jfs/namei.c
> > > > +++ b/fs/jfs/namei.c
> > > > @@ -876,7 +876,7 @@ static int jfs_symlink(struct mnt_idmap *idmap, struct inode *dip,
> > > >  	tid_t tid;
> > > >  	ino_t ino = 0;
> > > >  	struct component_name dname;
> > > > -	int ssize;		/* source pathname size */
> > > > +	u32 ssize;		/* source pathname size */
> > > 
> > > Had you considered using size_t - this is set from a strlen and used by a memcpy
> > > that both talk size_t.
> > 
> > I considered that, but I've had other maintainers upset about doubling
> > the variable size.
> 
> I bet at least on some platforms it's cheaper as the 64 bit.
> 
> > I opted to keep the variable 32-bit here, so the
> > machine code would only change to lose signed-ness.
> 
> Fair enough.

Thread ping. Can someone pick this up (or Ack it for my tree), please?

Thanks!

-Kees

-- 
Kees Cook
