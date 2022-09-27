Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BDBC6FA86
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 03:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiI0DJZ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 23:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI0DIO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 23:08:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA5A122064
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 20:02:40 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id f193so8274316pgc.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 20:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=85M7BEeaq9zxW2h3AU3e8O57XOSPgZunos10OsJfDq0=;
        b=KfigKs+pa68qGUfx08Fz5iZPF/LbCgHd5uxt/2Dh09KNMPECXa9wkgYQDDy1HXmGCV
         Y71VHxpZ8kiRBtnqJtoPdQsrWPXgvL0uXPs4xxdOjBkOj6/pYkI9X2XpMAa2Vdb+B0mM
         lSLI/IFeoBVrfsSvKaNYLN0lfIjsVSL31i7rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=85M7BEeaq9zxW2h3AU3e8O57XOSPgZunos10OsJfDq0=;
        b=zfPOyKEtd9wL6CAxUNvwh6N8De+XgJiaF5yKt7wFexY8LgSElzNAnkHzZ1TNPcdj2X
         l4/RTQ/I8MnsdMrMl0spqWoP9TuPOloIM1upiZ8n9lLpqBBsshDs4DRBhAaWWJ2WznfG
         zu2Qr+AVn/c1p9vaUf4BcmbLTz0CafWaHt0hYlyg0XBMR+5n/4zRHobjtPUjMo48L4hj
         3HMaqEmR0ceh5DM4opF1Wr2iTDC7RQj14e0TDWZstJMaVMTnvU/+ieKDzo40PO6F2oK5
         NWk/dIPaQXzEW0Ia8oJayCJnMx+l+8GTM1OqYlUFMM48YnQuGX37XKkLB3AWv8JisP3N
         VJ2A==
X-Gm-Message-State: ACrzQf2mIpp6uTY1tT0F02QugBFB5S76Fes2OeWhEoDgsc9i6QB3FduV
        zH0aAMyo8e5IKT+7Zu4nhbS2LQ==
X-Google-Smtp-Source: AMsMyM55rJie2+871SGa0Nl+9qYm+Jk7BeAdd3mOnkfA+n0BFLgxS701gzO7WRnXsgRXTP0GFUmsig==
X-Received: by 2002:a63:6b83:0:b0:43c:17e8:c2a5 with SMTP id g125-20020a636b83000000b0043c17e8c2a5mr21546502pgc.457.1664247738268;
        Mon, 26 Sep 2022 20:02:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f26-20020a639c1a000000b0042254fce5e7sm234514pge.50.2022.09.26.20.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:02:17 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:02:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overflow: Fix kern-doc markup for functions
Message-ID: <202209261959.A202D045@keescook>
References: <20220926194713.1806917-1-keescook@chromium.org>
 <YzIUS/+H2YA7RBvA@casper.infradead.org>
 <202209261408.59F78C0D@keescook>
 <ada70afe-64d5-ccab-242e-9a3c3c85e6c4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada70afe-64d5-ccab-242e-9a3c3c85e6c4@gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Sep 27, 2022 at 11:53:38AM +0900, Akira Yokosawa wrote:
> Hi,
> 
> Somehow Kees added me in Cc:, so let me comment.  :-)
> 
> On Mon, 26 Sep 2022 14:09:10 -0700, Kees Cook wrote:
> > On Mon, Sep 26, 2022 at 10:06:19PM +0100, Matthew Wilcox wrote:
> >> On Mon, Sep 26, 2022 at 12:47:13PM -0700, Kees Cook wrote:
> >>> -/** check_add_overflow() - Calculate addition with overflow checking
> >>> +/**
> >>> + * check_add_overflow - Calculate addition with overflow checking
> >>>   *
> >>>   * @a: first addend
> >>>   * @b: second addend
> >>
> >> Why did you remove the ()?  And why didn't you delete the blank line?
> >> According to our documentation, the canonical form is:
> >>
> >>   /**
> >>    * function_name() - Brief description of function.
> >>    * @arg1: Describe the first argument.
> >>    * @arg2: Describe the second argument.
> >>    *        One can provide multiple line descriptions
> >>    *        for arguments.
> 
> Matthew, you call it the "canonical form", my take is more of a "template
> that is known to work".

Out of curiosity, why is the trailing "()" part of the standard
template? Isn't it redundant? Or is trying to help differentiate between
things that are non-callable? (i.e. a variable, etc.)

> > Hunh, everywhere I'd looked didn't have the "()" (which seems
> > redundant). The blank line was entirely aesthetics for me. If it's
> > supposed to be without a blank, I can fix it up everwhere.
> 
> So, I think this is more of a territory of preference or consistency
> rather than that of correctness.  Those extra blank lines can be confusing
> as most people expect it in front of description part.
> 
> get_maintainer.pl says Kees is the sole maintainer of overflow.h, so
> it's his call, I guess.

Well, maintainer or not, I want to make sure stuff is as readable as
possible by everyone else too. :) I'm happy to skip the blank lines!

-- 
Kees Cook
