Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3674DC636C9
	for <linux-hardening@archiver.kernel.org>; Thu, 15 Jul 2021 18:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFB161396
	for <linux-hardening@archiver.kernel.org>; Thu, 15 Jul 2021 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbhGOS2t (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 15 Jul 2021 14:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhGOS2t (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 15 Jul 2021 14:28:49 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F9FC06175F
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jul 2021 11:25:55 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w15so7362735pgk.13
        for <linux-hardening@vger.kernel.org>; Thu, 15 Jul 2021 11:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=it0wdzOj5IOf4QH7awHQpXVwdxQtB+2DZ5D9rw+J8+A=;
        b=KNEtXbHsVy1VxaBx0diFafYW39PiFiwtOvaPudBbwBX1x1F1RGhN9H3y+M3kvY13c/
         TjDB61M0ArN0y0BGAgECWa/U7NlraEur05FNliHpxMolK6nHFuMhZ8lAHrHchVqsJKOk
         Ngh3WS4lAMnruM1NEaesb/9oASnqPQ1JKUghg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=it0wdzOj5IOf4QH7awHQpXVwdxQtB+2DZ5D9rw+J8+A=;
        b=U0Bu9Qm2mAumGTnOv6PcHn9Vj/hViKXgjO8wlcrwBXCyafLYSneOLsmzF0Ijhab6T6
         9+N+5ss3BYHW9+txs+OlfqeZnF1/jG0uClDxZzb1UHsjuHbJQAdL8DynyiWhsfkp3pI2
         fjRQClR8m0xZOLMw7lutlfW9mXjpm9l1cR4/qMMnPDHJcTKiLFSRqiabV+6i5jrtwzpC
         V2K08tvnFowPCQ5nQp5SFLoR3eePq7Kf0+m23Yu6JvtyXWKZBr/DiKvjqwNcCx2Pdp3c
         Fnz4a9McIWvxQYcbvSE06Yl+znIuSvwvvCAMqwRP0dnkckVAXhT42LNdl2jkJf8G57z5
         G5Og==
X-Gm-Message-State: AOAM530p2UvqeKLKLPj5+2D3BdCwtQ4iwes/B5isp2V/RYs3IaUI2EIH
        kSDXTDUC1wP0tVBUqMOTMESzrQ==
X-Google-Smtp-Source: ABdhPJzXFzshYruvYYTzwIuSs+pn6BJM+kBI7K/SePQFd7oT6PQXIEquZif2kyinXBqHC36PaJYW7Q==
X-Received: by 2002:a05:6a00:1508:b029:332:3aab:d842 with SMTP id q8-20020a056a001508b02903323aabd842mr5791036pfu.59.1626373554817;
        Thu, 15 Jul 2021 11:25:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm8281196pgj.8.2021.07.15.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 11:25:54 -0700 (PDT)
Date:   Thu, 15 Jul 2021 11:25:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Norbert Manthey <nmanthey@amazon.de>
Cc:     Kroah-Hartman <greg@kroah.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "foersleo@amazon.de" <foersleo@amazon.de>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        linux-hardening@vger.kernel.org
Subject: Re: Coverity Scan model file, license, public access
Message-ID: <202107151111.23BA48F99@keescook>
References: <d7f096ee-7a9b-684e-433a-f8f3f0e6288d@amazon.de>
 <YOSKuEcPoy/dw0st@kroah.com>
 <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41221c8-86e5-494d-68fd-0a0b87c99e83@amazon.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Jul 15, 2021 at 03:12:04PM +0200, Norbert Manthey wrote:
> On 7/6/21 6:54 PM, Kroah-Hartman wrote:
> > 
> > 
> > On Tue, Jul 06, 2021 at 09:45:47AM +0200, Norbert Manthey wrote:
> >> Dear all,
> >>
> >> I would like to work with code analysis on the Linux kernel. The
> >> currently used Coverity setup already uses a model file [1] to improve
> >> the precision of the analysis. To the best of my knowledge, this model
> >> file is currently not publicly accessible. I did not find a license
> >> attached to  [1], nor any information about licensing.
> > 
> > I have no idea who wrote that thing, sorry.
> 
> Is there anybody else who knows more about the history of the used
> Coverity model? Thanks.

As far as I know, the model was written originally by Dave Jones, with
further changes from myself and, I think, Colin Ian King.

I thought it was visible through the Coverity dashboard, once you're
logged in:
https://scan.coverity.com/projects/linux-next-weekly-scan?tab=analysis_settings
(See 'Modeling file loaded [View]')

Regardless, I keep a copy in git since I'd been tweaking it (mostly to
no meaningful benefit: the model file doesn't work with macros, which is
where the bulk of the false positives in Coverity come from):
https://github.com/kees/coverity-linux

-- 
Kees Cook
