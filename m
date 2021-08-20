Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D2DC4338F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Aug 2021 15:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D28D861152
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Aug 2021 15:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238124AbhHTPuc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbhHTPuc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Aug 2021 11:50:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9005CC06175F
        for <linux-hardening@vger.kernel.org>; Fri, 20 Aug 2021 08:49:54 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id qe12-20020a17090b4f8c00b00179321cbae7so7550673pjb.2
        for <linux-hardening@vger.kernel.org>; Fri, 20 Aug 2021 08:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JP8WFZmb9rgUa+mH2LJuzuE/iABY2L7RW9PxVxSWy1g=;
        b=k4UQQteJL7Qh1f6962sQXTg69gVAgArCnEbcoafW8q8WU3a0dFyoCb6HUcE0lFqUsS
         2TQNQdHpbA93nCoa1N/aiXdy8pDJcz4pQGJmxqJfbouuNtmtbloWKcbAnFDzgP+YEWHK
         NHH2EzfCjBYGkA2kf/rNG+rCeii3d90rhg4wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JP8WFZmb9rgUa+mH2LJuzuE/iABY2L7RW9PxVxSWy1g=;
        b=fQg9gZrQZqx+JNc6yGhmyqSj49hdDanxTdsB4ir/5VBHrPOciEES9teFTS76GrNCP5
         X5ied7on1WC15Qaz1x3hZhOdjN9flFLZLipLoNt1bmndpUC746e68nkSZPguTJQUdUGI
         3y8/wxrVZU4VPKaU8NAnu9DoyTFZxGCAp7GXMDk2SYgeAYPPdamE7SC21eAUuZGIuHhu
         18EBdxZw7gfgR4LN5NQoOF9PrcptIpSgIpyFzpQOmyOKDYKva+bQIdGB6Fhbhnw6S2g1
         Oc5CZpwSfrFG6MVmAPs+JPLbnqgC/YHjrq9DCd0vkNoztpi8EFxeitsYyDFIzfaPeVYG
         zqCw==
X-Gm-Message-State: AOAM530tHEMzMP70ztsrt4VW03Mf6MjV7TH6k+HIv5Jmio0S/bQzaaU9
        S6DTL5Th8Ieo5beOthYYpyYLH5zI0EB+MQ==
X-Google-Smtp-Source: ABdhPJwhegutOkRrxvU2g3GeI5YumyD6linmLQRuyi6C1VpKbOltTluibfSiLlEYf9DDH4WcSj+Egg==
X-Received: by 2002:a17:902:7c98:b0:131:21fd:3717 with SMTP id y24-20020a1709027c9800b0013121fd3717mr2602853pll.53.1629474594147;
        Fri, 20 Aug 2021 08:49:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm7564913pfj.178.2021.08.20.08.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 08:49:53 -0700 (PDT)
Date:   Fri, 20 Aug 2021 08:49:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, linux-staging@lists.linux.dev,
        linux-block <linux-block@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 55/63] HID: roccat: Use struct_group() to zero
 kone_mouse_event
Message-ID: <202108200849.9EBF036376@keescook>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-56-keescook@chromium.org>
 <nycvar.YFH.7.76.2108201501510.15313@cbobk.fhfr.pm>
 <CAJr-aD=6-g7VRw2Hw0dhs+RrtA=Tago5r6Dukfw_gGPB0YYKOQ@mail.gmail.com>
 <nycvar.YFH.7.76.2108201725360.15313@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2108201725360.15313@cbobk.fhfr.pm>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Aug 20, 2021 at 05:27:35PM +0200, Jiri Kosina wrote:
> On Fri, 20 Aug 2021, Kees Cook wrote:
> 
> > > > In preparation for FORTIFY_SOURCE performing compile-time and run-time
> > > > field bounds checking for memset(), avoid intentionally writing across
> > > > neighboring fields.
> > > >
> > > > Add struct_group() to mark region of struct kone_mouse_event that should
> > > > be initialized to zero.
> > > >
> > > > Cc: Stefan Achatz <erazor_de@users.sourceforge.net>
> > > > Cc: Jiri Kosina <jikos@kernel.org>
> > > > Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > Cc: linux-input@vger.kernel.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > >
> > > Applied, thank you Kees.
> > >
> > 
> > Eek! No, this will break the build: struct_group() is not yet in the tree.
> > I can carry this with an Ack, etc.
> 
> I was pretty sure I saw struct_group() already in linux-next, but that was 
> apparently a vacation-induced brainfart, sorry. Dropping.

Cool, no worries. Sorry for the confusion!

-- 
Kees Cook
