Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30BCC433EF
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Feb 2022 20:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiBBUbu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 2 Feb 2022 15:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbiBBUbt (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 2 Feb 2022 15:31:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192AC06173D
        for <linux-hardening@vger.kernel.org>; Wed,  2 Feb 2022 12:31:49 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id v15-20020a17090a4ecf00b001b82db48754so693925pjl.2
        for <linux-hardening@vger.kernel.org>; Wed, 02 Feb 2022 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yFJj6ZVefTE/vWISdKzupJXVjEcJPH4z8zqtZHrZMU=;
        b=g9ENtVpiaPQ7gXq2RjybtD1vNjZ+vkdx4HgR7sglG5kF08w7f3otDMOAwt6gfBvpXj
         v1OSktJ1XnffVQpqdExOi/gP/MBtuZNQYSffEN+6/VYDauLT9fU7bFs68ehxwVTFV26g
         +ZpnzNGfnrAAIkDbtsRXJF7wLsYtouY9HtgEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yFJj6ZVefTE/vWISdKzupJXVjEcJPH4z8zqtZHrZMU=;
        b=wMKhQN8y5WTxLw8zKBf613z7BQAtPYGM7wnQOPEU9BxIYik5NX0qcwgRNkiYlUyvIL
         b+m9sxurvcGA3oLnJZu84gWAQjJ+Uo0Z77Giv88pC/XXJe1Hlc5sihU+Zi68F4zqI3BF
         cu2KM/XQcnMloIAEp4SmpLNdalhU5fbStCV1cPXWEFf5QXSLqnDix+kZgO44LQHXwPNS
         BL9is/oHxG4oMVfvo2tIGrIiHtBQrTlo3M5yxi/rJjVOf2DVdl3sLO3hmo6ePL30pXLy
         sMveZqe+hy8Iwb+3braVMTFDV8svUVit7XoI49LAPlG2zTLxUbcH37Ho/Q2b4cF6YSpH
         WCfg==
X-Gm-Message-State: AOAM531rokaUZSWnvhCNzOq5P5L5BXEI2gmaFWAL/24FOlDlAoOlRvdB
        ucPS1NsKr/TA9iaGNFhjGoX2DQ==
X-Google-Smtp-Source: ABdhPJwmTwJ5ie1k8bwwQQWok+d1e3DNDo3GqAuF1F32vPbnmIN2LP3OmiFsSSsjNlqbjhUKCc7mLw==
X-Received: by 2002:a17:903:249:: with SMTP id j9mr31864782plh.81.1643833909142;
        Wed, 02 Feb 2022 12:31:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ca12sm7166526pjb.11.2022.02.02.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:31:48 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:31:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] exec: Force single empty string when argv is empty
Message-ID: <202202021229.9681AD39B0@keescook>
References: <20220201000947.2453721-1-keescook@chromium.org>
 <78959c88715049a4be00fc75bb333d3a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78959c88715049a4be00fc75bb333d3a@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Feb 01, 2022 at 09:17:47AM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 01 February 2022 00:10
> ...
> > While the initial code searches[6][7] turned up what appeared to be
> > mostly corner case tests, trying to that just reject argv == NULL
> > (or an immediately terminated pointer list) quickly started tripping[8]
> > existing userspace programs.
> > 
> > The next best approach is forcing a single empty string into argv and
> > adjusting argc to match. The number of programs depending on argc == 0
> > seems a smaller set than those calling execve with a NULL argv.
> 
> Has anyone considered using the pathname for argv[0]?
> So converting:
> 	execl(path, NULL);
> into:
> 	execl(path, path, NULL);
> 
> I've not spotted any such suggestion.

It came up on some IRC discussions at some point. I'm personally not a
fan of this because it creates a bit of "new" ABI that has a lot of
variability (depending on "" is one thing, but depending on a "missing"
argv matching the exec path is very different). I think there were also
concerns about dealing with fd-based exec ("what is the 'right' name"),
etc.

I'd prefer we stay as simple as possible for this change.

-- 
Kees Cook
