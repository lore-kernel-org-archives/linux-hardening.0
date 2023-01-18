Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35469C38142
	for <linux-hardening@archiver.kernel.org>; Wed, 18 Jan 2023 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjARAsy (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 17 Jan 2023 19:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjARAsO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 17 Jan 2023 19:48:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A06138B53
        for <linux-hardening@vger.kernel.org>; Tue, 17 Jan 2023 16:35:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso653137pjg.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Jan 2023 16:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=akL1ISgHERBfu19IDfIMY0yAhbjaA5tAW8Vf2gv80TI=;
        b=fhpdzYPo7tJdOOLdA0KIYT5MME0zX9pMm17HvNzNDuNFagrQwhyhKFB0t9Awfns1XE
         IOoCHgtCwx90fTxTV7qw7VDlpMG37iJMSKQRZQ+pOiqWFZ6FV1UmBGMnxBra388ZdbMD
         o5TsYRTRrawWTSUD3QGUojwNZA6117upjOcvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akL1ISgHERBfu19IDfIMY0yAhbjaA5tAW8Vf2gv80TI=;
        b=yA6sAvz5Fw9xn2s/rqUeogf6jI2hORxQb97AEto4PFSNWOzzuxrmC8scJ4ZWhZwCyq
         PmtjT98GXLVc0M2thVbk6ddyadw38QC1TuNrXMaJhCkNtFQJyC0UwVBfx77nduPEwdJv
         KgXyZpL7GNPJzubgyrkTCGCd1Sc9uWIEG1XKoQtSk7ziAGuoBx0tNuAq6+ug2IJm/m/8
         dYWVG2b8EMaukNfDABo/DlDV0jteBWVtFv5UnCqa4dCeFbZ8EG+cDfHknZoqFALmPZ9G
         Nsx2WA+w6D6XF+vGu2iCICIFi25oiQCFseZmE9tTabXO8Fd/jxkYuCb4gd3oRjDlCbLZ
         py6Q==
X-Gm-Message-State: AFqh2kr4jWnZBMKCbDrHaYjnKqUhzaRR3QfjiXi2JGccyLKIE+d9LKoL
        lrDN+SOVDyM81YdOi90N/7XeHQ==
X-Google-Smtp-Source: AMrXdXsXpUFrV/O+3ioiidXbSLAauvdYK8JI6ZwWp74sGu8F22srdl8XQ08WwG+RUJaayOO1ZE1QtA==
X-Received: by 2002:a05:6a20:a00d:b0:9d:efbf:6623 with SMTP id p13-20020a056a20a00d00b0009defbf6623mr5985554pzj.49.1674002106618;
        Tue, 17 Jan 2023 16:35:06 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 35-20020a631563000000b0044ed37dbca8sm17756818pgv.2.2023.01.17.16.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 16:35:06 -0800 (PST)
Date:   Wed, 18 Jan 2023 09:35:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        coverity-bot <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: console_prepend_dropped(): Memory - corruptions
Message-ID: <Y8c+tFWFeH272Z1/@google.com>
References: <202301131544.D9E804CCD@keescook>
 <Y8KAhaiZQOWTcfyF@google.com>
 <Y8V8tqMJeB7t+rcJ@alley>
 <Y8YRBo7ZmtzWT4J1@google.com>
 <877cxl3abr.fsf@jogness.linutronix.de>
 <Y8ZTlVX3HQUVkU13@google.com>
 <Y8aEdDxQrQICQtem@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8aEdDxQrQICQtem@alley>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On (23/01/17 12:20), Petr Mladek wrote:
> > Oh, yes, I agree that snprintf() should be replaced. Maybe we can go
> > even a bit furhter and replace all snprintf()-s in kernel/printk/*
> > (well, in a similar fashion, just in case). I'm just trying to understand
> > what type of assumptions does coverity make here and so far everything
> > looks rather peculiar.
> 
> Note that we sometimes need snprintf() to compute the needed size
> of the buffer. For example, vsnprintf() in vprintk_store() is
> correct.

Oh, right, that's an excellebt point.
