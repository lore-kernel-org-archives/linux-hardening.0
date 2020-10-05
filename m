Return-Path: <SRS0=pEkV=DM=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B05C4363A
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E3D206BE
	for <linux-hardening@archiver.kernel.org>; Mon,  5 Oct 2020 22:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ibqSmXVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgJEWj2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 5 Oct 2020 18:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgJEWj2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 5 Oct 2020 18:39:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A463C0613CE
        for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2020 15:39:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kk9so647416pjb.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 Oct 2020 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIoPd7FinJm3q9ARvRH5Nl20y+MTyHzjskcOjhWw2XA=;
        b=ibqSmXVNNpgEoMq7K2TPcLI5XyaBqb9Xn8O7+WEcFmp2w4hBzhSbqBpBIWx7crQnT2
         KdfUoVeK/AwG6EQ9tnopcO32zNyb5OARlnLg2h27D3K26NcdoFjGdFNF5JXfEOzkIQke
         1jdUU2u5KmJb3bZA3iZSI+Wl1aS5kD+2ItDQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIoPd7FinJm3q9ARvRH5Nl20y+MTyHzjskcOjhWw2XA=;
        b=XDkrJmjwyo8ZtblqoVoCj6Vp7ZtJuHElwgyNQHfaR/ljCYsemFlF7JOruLVlJa/4l9
         xVLj5Tem3joPH71pS215G6vchigsrifPvxc/x0HdjQUdMxs7d7YrVirYm9xZMqVX2xPm
         oqlJKdbRHKyUEE2gd2cJ1ExrrVX80U3ZM4nRncFriOKT/ej/OvEr2S4j49QoiAUxpFpu
         l1mREuNajoIxQP6gpYiNE4oQ0raE2Zpy6gjSMHbsoGltBDG++I+6aJxQFhphd1u7SvUf
         0GKBHG54tu6kdWPg5dkT9QZPHRmKsKRSDjBguPR67/6e+7q+jim3Ba39FYSqKBLmlxlq
         oacg==
X-Gm-Message-State: AOAM532W/Sz46aMryXc/pkp8H4qwxPbrq1nebF4id2ppRXGkc1jak5D9
        ZENPjd8KQF2mnlmJk+IzUd8Je66qbEC0A2GO
X-Google-Smtp-Source: ABdhPJxL9pSB42Fin8DjVFQfTJrdQvlaceXjGATgKNwGQSMexY8o2CgeQC6hXJAlCIXrypZAhK+80A==
X-Received: by 2002:a17:902:9b8f:b029:d3:89e2:7956 with SMTP id y15-20020a1709029b8fb02900d389e27956mr598517plp.18.1601937567876;
        Mon, 05 Oct 2020 15:39:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x23sm990940pfc.47.2020.10.05.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 15:39:26 -0700 (PDT)
Date:   Mon, 5 Oct 2020 15:39:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Solar Designer <solar@openwall.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Subject: Re: Linux-specific kernel hardening
Message-ID: <202010051538.55725193C7@keescook>
References: <202009281907.946FBE7B@keescook>
 <20200929192517.GA2718@openwall.com>
 <202009291558.04F4D35@keescook>
 <20200930090232.GA5067@openwall.com>
 <20201005141456.GA6528@openwall.com>
 <20201005160255.GA4540@mit.edu>
 <20201005164818.GA6878@openwall.com>
 <CAG48ez0MWfA8zPxh5s5i2w9W7F+MxfjMXf6ryvfTqooomg1HUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0MWfA8zPxh5s5i2w9W7F+MxfjMXf6ryvfTqooomg1HUQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 06, 2020 at 12:26:50AM +0200, Jann Horn wrote:
> On Mon, Oct 5, 2020 at 6:48 PM Solar Designer <solar@openwall.com> wrote:
> > If 100% of the topics on linux-hardening are supposed to be a subset of
> > what was on kernel-hardening, I think it'd be OK for me to provide the
> > subscriber list to a vger admin, who would subscribe those people to
> > linux-hardening.
> 
> (if folks want to go that route, probably easier to subscribe the list
> linux-hardening@ itself to kernel-hardening@ instead of syncing
> subscriber lists?)

Yeah, that would make things a bit simpler. Solar, would you be willing
to do that? (Then I can tweak the wiki instructions a bit more.)

-- 
Kees Cook
