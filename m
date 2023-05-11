Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E33C7EE22
	for <linux-hardening@archiver.kernel.org>; Thu, 11 May 2023 18:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbjEKSiM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 May 2023 14:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239030AbjEKShs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 May 2023 14:37:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE521BE2
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 11:37:47 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64115eef620so59964143b3a.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 May 2023 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683830267; x=1686422267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EyigEQsWQlpFj9oAYDvVkxAuY6bSSbrSpQ9TJU1fUQQ=;
        b=VgulxXC92TIpai2A9mZMYW/IK9i/pbkk/lCSOAsmI4qCRS86ew58nvwMY4psK3waHa
         oDnaGwbRJV+VxdhrEmkyR1EvYY7ZorZTP3NEnroWD2FtZIM9JEkoQKmbSQ3Cez+cFJRe
         GXUEkuJLZZyYY/BP9gq3xXVRyYILmk+tYEOaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683830267; x=1686422267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EyigEQsWQlpFj9oAYDvVkxAuY6bSSbrSpQ9TJU1fUQQ=;
        b=OPsjcUSErYyUs2nLni/igHGPZJVj2Ek61m6WhT9TI7bbqQSCjFuPSMAX3G0l44kwkQ
         AIip4uzN6am1BQKHky1DT3ymoGqxSuLI3Vmhs8hLTPiU9cjiMrH0Uol7+9x7lIxP1nYg
         3NURkeDAmvmU6nXecAA8qnTYGAmB/EaOhiFL9XvoWX0rMY01BDcpKkTyw4zEcybGMMTj
         R5tLJzjFBGE1j9MeoqqnzIz8ZnclAbBvD3JW3bTq3KOlawKCwHIcsVE9jR7omwGb9XAf
         VrT1qJeQ34Jl2Gq8dHS+qsZzwVuRa7f4tp8Kgbzq7Qd7LxfJb6jDLlYut50YOp441ypv
         12lQ==
X-Gm-Message-State: AC+VfDzV/qWQEvLMrwzqOyGLdHZzUtBy+gjOwaGWef0ivYcANt0a6mQl
        1TuHJyDiQjDKl8UsNjazTpiYSA==
X-Google-Smtp-Source: ACHHUZ6zBr0iY5TfuweaLUlC4U2Dbutn7tnQtVNcPfDtPlUyC/U05dIfXupcFnLnDi3KcGlP2WAQeA==
X-Received: by 2002:a17:902:dad2:b0:1ac:92db:9677 with SMTP id q18-20020a170902dad200b001ac92db9677mr13610451plx.28.1683830266731;
        Thu, 11 May 2023 11:37:46 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b001ac912cac1asm6253294plk.175.2023.05.11.11.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:37:46 -0700 (PDT)
Date:   Thu, 11 May 2023 11:37:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rong Tao <rtoax@foxmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: Discuss interleaved replies
Message-ID: <202305111135.D65457C24@keescook>
References: <20230510183423.never.877-kees@kernel.org>
 <6c1f853b-b051-c390-267e-1ea1741e8537@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1f853b-b051-c390-267e-1ea1741e8537@leemhuis.info>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, May 11, 2023 at 11:21:36AM +0200, Thorsten Leemhuis wrote:
> On 10.05.23 20:34, Kees Cook wrote:
> > Top-posting has been strongly discouraged in Linux development, but this
> > was actually not written anywhere in the common documentation about
> > sending patches and replying to reviews. Add a section about trimming
> > and interleaved replies.
> 
> Thx for doing this.
> 
> > [...]
> > ---
> >  Documentation/process/submitting-patches.rst | 23 ++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> 
> For some reason we have duplicate code^w documentation for this, hence
> I'd say the same or a similar text should also be added to one of the
> filed in Documentation/process/[0-9].*rst ; from a quick
> Documentation/process/6.Followthrough.rst might be the best one.
> 
> Maybe in fact the text should move there and submitting-patches.rst
> should have a much shorter version, as it's meant to be the terser of
> the two docs about this.

Hm, The place where it is mentioned is even shorter, so I kind of like
it in submittingpatches. But, I'm open to whatever seems best. I just
want to have a URL to point people at, and I'm usually pointing to
places in submittingpatches. :)

> 
> > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > index eac7167dce83..3e838da8822f 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -326,6 +326,29 @@ explaining difference aganst previous submission (see
> >  See Documentation/process/email-clients.rst for recommendations on email
> >  clients and mailing list etiquette.
> >  
> > +Use trimmed interleaved replies in email discussions
> > +----------------------------------------------------
> > +Top-posting is strongly discouraged in Linux kernel development
> > +discusions. Interleaved (or "inline") replies make conversations much
> 
> s/discusions/discussions/

Agh, thanks. Fixed.

> 
> > +easier to follow. For more details see:
> > +https://en.wikipedia.org/wiki/Posting_style#Interleaved_style
> > +
> > +As is frequently quoted on the mailing list:
> > +
> > +  A: http://en.wikipedia.org/wiki/Top_post
> > +  Q: Were do I find info about this thing called top-posting?
> > +  A: Because it messes up the order in which people normally read text.
> > +  Q: Why is top-posting such a bad thing?
> > +  A: Top-posting.
> > +  Q: What is the most annoying thing in e-mail?
> > +
> > +Similarly, please trim all unneeded quotations that aren't relevant
> > +to your reply. This makes replies easier to find, and saves time and
> 
> Nitpicking, feel free to ignore: maybe "s/replies/responses/" or
> something like that, as at least my stupid brain accidentally thought of
> the email reply (as whole) when reading this for the first time.

Yeah, that is more readable. Fixed.

> > +space. For more details see: http://daringfireball.net/2007/07/on_top
> > [...]
> 
> Ciao, Thorsten

Thanks!

-- 
Kees Cook
