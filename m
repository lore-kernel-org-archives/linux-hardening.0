Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A70AC433E0
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 19:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298B9207B1
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 19:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbhAKTtP (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Jan 2021 14:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388447AbhAKTtP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Jan 2021 14:49:15 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF042C06179F
        for <linux-hardening@vger.kernel.org>; Mon, 11 Jan 2021 11:48:34 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id m6so575925pfm.6
        for <linux-hardening@vger.kernel.org>; Mon, 11 Jan 2021 11:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=L2dO51YCX50/jqI3yiEYU3ac1GBJfHi3X0HQmwH4sZc=;
        b=k2V72fKFl01J3y3Dzl0Pb6pZuFQYuafr+l3lvOn50o/U0VCG+t32afav1f0rmeUdbK
         Kl/J/+vHfWdWmmgtWD94eQ1MAdyNlwvQqBdDRS6AvUsQLjIQu0ILWUBNQAmeB/0VrrEi
         WNISKNaK+FzpOLMwl+JNKvVcbNYHPUNiq6NeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=L2dO51YCX50/jqI3yiEYU3ac1GBJfHi3X0HQmwH4sZc=;
        b=Ixbkb39n2U+a0nA/4fSKTSKBT+Z1isGqKmkOBENZ+4LsD+mj5i+CFYAIRQ8j5dpru2
         41btS7oQ1Ec7T+mplRQbMbKTsIRb6AiIWcX6Ai0azNpwpfsS3hCzkyRcRf/MHkHN1Pse
         dXquAkwdqV09w+h2NtwCtHXKVRgQ1/+643/CoHNBBSdGTQrGT/Dzy3VVlC6ib0aO3mp0
         wyU5/y3Bwdb+kF6mp3goXwF0fh5e6pbBGslSrBdtEkQ4LL94od0It9m6gll1EQX2NeiZ
         POhH3Zma8TzC2sKCAf7H3QJLf4oHXTazc59rJUldghnbYNmETkqBdDpEU/OvDzVcOnre
         0v6g==
X-Gm-Message-State: AOAM532xsXYY29xx7F+gQPQJIXWdVyzi45PDXYwVXWICSJD9Pf93fVpm
        +NGsvjxYtZUKYGKeV9RNjxowXg==
X-Google-Smtp-Source: ABdhPJzslm0sW3E1xyjK6iTczmGD4MMC+I117oW3pqCCuY683Jr0Df72IrmO5iJXCHhOZBvC/X91fA==
X-Received: by 2002:a62:79cd:0:b029:1a8:4d9b:921a with SMTP id u196-20020a6279cd0000b02901a84d9b921amr953318pfc.33.1610394514381;
        Mon, 11 Jan 2021 11:48:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h12sm579029pgs.7.2021.01.11.11.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:48:33 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:48:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
Message-ID: <202101111148.CDE77FF@keescook>
References: <82487.1609006918@turing-police>
 <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
 <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com>
 <122278.1610362619@turing-police>
 <CAMuHMdXR09QdSiziQQ_XuPcJPOca_+mK1jYYHj3VsP_eCu_KbA@mail.gmail.com>
 <128149.1610368277@turing-police>
 <20210111133719.w53ad4xnw5yyi2lf@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210111133719.w53ad4xnw5yyi2lf@treble>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 11, 2021 at 07:37:19AM -0600, Josh Poimboeuf wrote:
> On Mon, Jan 11, 2021 at 07:31:17AM -0500, Valdis Klētnieks wrote:
> > On Mon, 11 Jan 2021 05:56:59 -0500, I said:
> > 
> > > > It's probably related. I'm just having a hard time understanding why 4.9 and 5.4
> > > > whine about the lack of a space, while 8.3 and 11 didn't complain...
> > 
> > So after more digging, at least some clarity has surfaced.
> > 
> > It looks like it's not a kernel source tree issue, it's a g++ issue fixed in g++ 6 and later.
> > 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> > 
> > And it looks like there was an intent to backport it to 4.9 and 5.4:
> > https://gcc.gnu.org/legacy-ml/gcc-patches/2016-02/msg01409.html
> > 
> > The bugtracker doesn't show an equivalent for 69959 being closed against 4.9.x or 5.[56],
> > 
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63254 has a patch for one of the
> > gcc-supplied files that tosses the warning, but that way lies madness...
> > 
> > Not sure what we want to do here - the main alternatives I see are:
> > 
> > Tell people still using 4.9/5.4 to either live with the warning or upgrade to 6 or later
> > 
> > Make the flag a variable and pass either -std=gnu++98 or -std=gnu++11
> > depending on the output of 'g++ --version'
> > 
> > What say the peanut gallery?
> 
> I think putting the flag in a variable (based on call cc-ifversion)
> should be easy enough, then we can put this little saga behind us and
> pretend it never happened :-)

Yeah, that seems best. Valdis, can you send a patch for this?

-- 
Kees Cook
