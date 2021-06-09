Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B90C48BCD
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Jun 2021 16:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01855613D0
	for <linux-hardening@archiver.kernel.org>; Wed,  9 Jun 2021 16:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFIQyk (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Jun 2021 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFIQyk (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Jun 2021 12:54:40 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C12C061574
        for <linux-hardening@vger.kernel.org>; Wed,  9 Jun 2021 09:52:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v11so4372091ply.6
        for <linux-hardening@vger.kernel.org>; Wed, 09 Jun 2021 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LD9HSxwVBYD4Eigmm4/eFaSooe5X81yBa6b9diyTxLk=;
        b=N47Q7iKRccjNkYwWKqUHqFn73mIgkb6yUnEgVpfiCnpd7KGAo+RwkJGh7fCyhsJ5rJ
         PHoctqrgLpYFlXiogoGImI85Yu3OsLM3sfJYRnwP4OzsOAGtIgoKDG+IYVT+VOE0fTE/
         27PJSIvlhBf+evKmhRLXx/yOa0KOermG9co7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LD9HSxwVBYD4Eigmm4/eFaSooe5X81yBa6b9diyTxLk=;
        b=MHhIoDMiibzCKx6gycEOshD0QbGjwN8uwwyTxJoQPrpvAgxNlruLhJbQEDJRnr+zoL
         AKdMAV6jAwSQktGUFPpUFNbT1y1rr7b2bTk7vX9ey8778CCKUMKyNo5n+d4dgJEkk39W
         M7GiBzIASKLHzyZlN8lE9Wv+DKHbdhF3Kkllc9c+WEr90PKcQx6SzlBzc6jU4xJQhntG
         rCyniY1Srt2UnXiw/h1bVfCkfv0Ck/bFHD1n8yvx+9bI8uAr31WuzTwCXVBU1bMLZjdB
         Es60aAbAS5SXDYvBaVRYVmQVwVGjLet9GP6QxpzCF3tDsOgWkSbGI8se0U0KdC+4gNF4
         Ottw==
X-Gm-Message-State: AOAM533h3fmGwY153fp+qjX/pfPD49oajTh/0z/rPUwz2uxNso/lyHC+
        oHS/3L5hFJKcacU3qdD9V2ktzQ==
X-Google-Smtp-Source: ABdhPJzNXeQzlTinS1wmW8MEliQZalVLosypCXm6YUl9Lebh2/tT7cpsPFLagkE3mdC+ClBbYzFVAQ==
X-Received: by 2002:a17:902:988f:b029:114:12d2:d548 with SMTP id s15-20020a170902988fb029011412d2d548mr479973plp.73.1623257550841;
        Wed, 09 Jun 2021 09:52:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k30sm305187pgf.59.2021.06.09.09.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 09:52:30 -0700 (PDT)
Date:   Wed, 9 Jun 2021 09:52:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     John Wood <john.wood@gmx.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>, valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v8 0/8] Fork brute force attack mitigation
Message-ID: <202106090951.8C1B5BAD@keescook>
References: <20210605150405.6936-1-john.wood@gmx.com>
 <202106081616.EC17DC1D0D@keescook>
 <cbfd306b-6e37-a697-ebdb-4a5029d36583@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbfd306b-6e37-a697-ebdb-4a5029d36583@linux.intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Jun 08, 2021 at 04:38:15PM -0700, Andi Kleen wrote:
> 
> On 6/8/2021 4:19 PM, Kees Cook wrote:
> > On Sat, Jun 05, 2021 at 05:03:57PM +0200, John Wood wrote:
> > > [...]
> > > the kselftest to avoid the detection ;) ). So, in this version, to track
> > > all the statistical data (info related with application crashes), the
> > > extended attributes feature for the executable files are used. The xattr is
> > > also used to mark the executables as "not allowed" when an attack is
> > > detected. Then, the execve system call rely on this flag to avoid following
> > > executions of this file.
> > I have some concerns about this being actually usable and not creating
> > DoS situations. For example, let's say an attacker had found a hard-to-hit
> > bug in "sudo", and starts brute forcing it. When the brute LSM notices,
> > it'll make "sudo" unusable for the entire system, yes?
> > 
> > And a reboot won't fix it, either, IIUC.
> > 
> The whole point of the mitigation is to trade potential attacks against DOS.
> 
> If you're worried about DOS the whole thing is not for you.

Right, but there's no need to make a system unusable for everyone else.
There's nothing here that relaxes the defense (i.e. stop spawning apache
for 10 minutes). Writing it to disk with nothing that undoes it seems a
bit too much. :)

-- 
Kees Cook
