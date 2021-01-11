Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FA0C433DB
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 13:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4374A225AB
	for <linux-hardening@archiver.kernel.org>; Mon, 11 Jan 2021 13:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbhAKNiz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 11 Jan 2021 08:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33441 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727126AbhAKNiy (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 11 Jan 2021 08:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610372248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9Ytc0z65ta6VBHkGYAtmWB3CyrCaTNiz9kZPtd9Uis=;
        b=VuWBMiXuaXHH/UzujDs85/x51SZwBDiqfv2HkEXgkWqiYCnc6MlSVm28+DCjBATQRkpexo
        1BqouaJjBmQdmLeyuu+QXdYPTg6A1hLekVFHmCIfpgeMRl/Pna0Hy1pQIA+DICLRTWsASj
        eCtq9BslSeKxy886muOxZ2GifaJZWzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-2Qg1gw1kP32avUrGJwu4QQ-1; Mon, 11 Jan 2021 08:37:24 -0500
X-MC-Unique: 2Qg1gw1kP32avUrGJwu4QQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A2B4835B68;
        Mon, 11 Jan 2021 13:37:22 +0000 (UTC)
Received: from treble (ovpn-120-156.rdu2.redhat.com [10.10.120.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81BED50C0D;
        Mon, 11 Jan 2021 13:37:21 +0000 (UTC)
Date:   Mon, 11 Jan 2021 07:37:19 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-plugins: fix gcc 11 indigestion with plugins...
Message-ID: <20210111133719.w53ad4xnw5yyi2lf@treble>
References: <82487.1609006918@turing-police>
 <160997457204.3687425.15622431721220616573.b4-ty@chromium.org>
 <CAMuHMdU1YSODgh_T5RxqUqorveAQiy_-gQbF_SwMEj7gvG25qw@mail.gmail.com>
 <122278.1610362619@turing-police>
 <CAMuHMdXR09QdSiziQQ_XuPcJPOca_+mK1jYYHj3VsP_eCu_KbA@mail.gmail.com>
 <128149.1610368277@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <128149.1610368277@turing-police>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 11, 2021 at 07:31:17AM -0500, Valdis Klētnieks wrote:
> On Mon, 11 Jan 2021 05:56:59 -0500, I said:
> 
> > > It's probably related. I'm just having a hard time understanding why 4.9 and 5.4
> > > whine about the lack of a space, while 8.3 and 11 didn't complain...
> 
> So after more digging, at least some clarity has surfaced.
> 
> It looks like it's not a kernel source tree issue, it's a g++ issue fixed in g++ 6 and later.
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959
> 
> And it looks like there was an intent to backport it to 4.9 and 5.4:
> https://gcc.gnu.org/legacy-ml/gcc-patches/2016-02/msg01409.html
> 
> The bugtracker doesn't show an equivalent for 69959 being closed against 4.9.x or 5.[56],
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63254 has a patch for one of the
> gcc-supplied files that tosses the warning, but that way lies madness...
> 
> Not sure what we want to do here - the main alternatives I see are:
> 
> Tell people still using 4.9/5.4 to either live with the warning or upgrade to 6 or later
> 
> Make the flag a variable and pass either -std=gnu++98 or -std=gnu++11
> depending on the output of 'g++ --version'
> 
> What say the peanut gallery?

I think putting the flag in a variable (based on call cc-ifversion)
should be easy enough, then we can put this little saga behind us and
pretend it never happened :-)

-- 
Josh

