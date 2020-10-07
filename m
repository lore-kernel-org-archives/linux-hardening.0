Return-Path: <SRS0=qTGI=DO=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BACC4363C
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7451E20797
	for <linux-hardening@archiver.kernel.org>; Wed,  7 Oct 2020 07:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTNY3QOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJGHFo (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 7 Oct 2020 03:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgJGHFo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 7 Oct 2020 03:05:44 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956AEC061755
        for <linux-hardening@vger.kernel.org>; Wed,  7 Oct 2020 00:05:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so785200pfo.12
        for <linux-hardening@vger.kernel.org>; Wed, 07 Oct 2020 00:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dX2YnK86jg3mNag4yZ1kqiGozLNYxKD7LeiaXlOmuxg=;
        b=HTNY3QOnkc8vwqeHm9bbdUpkxnLhq0Ju4x29Yw1c6h0E0w5UFPAfWVUHf9rgnHcNYV
         iU9g/OlV/QOIyd4bwXP4FHaKSQ8u0EFSNUrWIYOwGO80EK+TQ1z+uVI5jzd4pNAz03RX
         +36P/DJthsE4ztj7Oim4tz9q3DB0gNVqpL+Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dX2YnK86jg3mNag4yZ1kqiGozLNYxKD7LeiaXlOmuxg=;
        b=hklOaH2ZdRwZQuj4Zr64KAjRDg5clk9/98AIG7AQ9nfQ3Cuml6lM0uZOVNN74JFGVI
         85i3cpp/f3LAmWO/Y1EgZYJT+jZTQqw34VX7k0cEFPKIijxqoUSqF4HpHXT82Jr6Hnkc
         OWBVA9ZtNEaLGvijz5VXTgfz0Ybo/Bk/qB547hKpvQom7B85DL7EBmAhzsxVLffWBOeG
         L6yBYViRjSQqCm6K3Rk6/iRfvjvBMlgbsMUL6/RHeA1UfMDKl3GIc/ZOsixGN9rEDzH5
         XfARl+efE7SbSJTBigHV1rVKsV2qKAw+hSvALlCKgZCJh4pW7ADobhkvvuoiBAccEJud
         yw0A==
X-Gm-Message-State: AOAM5319EDjRqq1JucmwOOppK9cehHC3ydna7anjc4fVHh7oHF+V34LT
        WIkN7Q1Rataqy/8ILwPMsa912A==
X-Google-Smtp-Source: ABdhPJyhteyvUXI8ZTYTooyb/Aib8lDQrhbY+geNMWa70IXcEUwmiHsH4OGzBXm+TpSGiTBlUPlsuA==
X-Received: by 2002:a05:6a00:1585:b029:142:2501:39f5 with SMTP id u5-20020a056a001585b0290142250139f5mr1661351pfk.68.1602054341941;
        Wed, 07 Oct 2020 00:05:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p16sm1804951pfq.63.2020.10.07.00.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:05:40 -0700 (PDT)
Date:   Wed, 7 Oct 2020 00:05:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Solar Designer <solar@openwall.com>
Cc:     Jann Horn <jannh@google.com>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-hardening@vger.kernel.org
Subject: Re: Linux-specific kernel hardening
Message-ID: <202010070003.466BA35@keescook>
References: <202009281907.946FBE7B@keescook>
 <20200929192517.GA2718@openwall.com>
 <202009291558.04F4D35@keescook>
 <20200930090232.GA5067@openwall.com>
 <20201005141456.GA6528@openwall.com>
 <20201005160255.GA4540@mit.edu>
 <20201005164818.GA6878@openwall.com>
 <CAG48ez0MWfA8zPxh5s5i2w9W7F+MxfjMXf6ryvfTqooomg1HUQ@mail.gmail.com>
 <202010051538.55725193C7@keescook>
 <20201006142127.GA10613@openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006142127.GA10613@openwall.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Oct 06, 2020 at 04:21:27PM +0200, Solar Designer wrote:
> On Mon, Oct 05, 2020 at 03:39:26PM -0700, Kees Cook wrote:
> > On Tue, Oct 06, 2020 at 12:26:50AM +0200, Jann Horn wrote:
> > > On Mon, Oct 5, 2020 at 6:48 PM Solar Designer <solar@openwall.com> wrote:
> > > > If 100% of the topics on linux-hardening are supposed to be a subset of
> > > > what was on kernel-hardening, I think it'd be OK for me to provide the
> > > > subscriber list to a vger admin, who would subscribe those people to
> > > > linux-hardening.
> > > 
> > > (if folks want to go that route, probably easier to subscribe the list
> > > linux-hardening@ itself to kernel-hardening@ instead of syncing
> > > subscriber lists?)
> > 
> > Yeah, that would make things a bit simpler. Solar, would you be willing
> > to do that? (Then I can tweak the wiki instructions a bit more.)
> 
> Sure, I can do that.  Should I?
> 
> Per http://vger.kernel.org/vger-lists.html#linux-hardening there are
> currently 39 subscribers on the new list.  I guess most of those are
> also on kernel-hardening, and would start receiving two copies of
> messages that are posted to kernel-hardening.  I guess they would then
> need to unsubscribe from kernel-hardening if they want to see the
> content of both lists, or to unsubscribe from linux-hardening if they
> changed their mind and only want the content of kernel-hardening.  I
> think this is still not too many people, so this is reasonable; if we
> were to do it later, we'd inconvenience more people.

Hm, I guess I was thinking about this only from the perspective of
Message-Id handling: the duplicates wouldn't be noticed -- but of course
I've been struggling with IMAP vs Gmail for so long I've almost
forgotten how actual email works. ;)

Yeah, the duplicate emails would be pretty bad. Let's not do this for
now, and if it becomes an actual issue we can change it then.

-- 
Kees Cook
