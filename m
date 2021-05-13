Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DED8C433ED
	for <linux-hardening@archiver.kernel.org>; Thu, 13 May 2021 01:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC24C61264
	for <linux-hardening@archiver.kernel.org>; Thu, 13 May 2021 01:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbhEMBH2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 12 May 2021 21:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbhEMBH2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 12 May 2021 21:07:28 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9EBC061574;
        Wed, 12 May 2021 18:06:19 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n3so1352646plf.7;
        Wed, 12 May 2021 18:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JdjLenGm8qjHYQsyQoKVaW3PTpEveC22o5czLzfvk6Y=;
        b=loq1VJUyP3/kDLOrzwSNufspWWWMh0fp2SKxkcsSBhXkowmGIIe77TWUY9162Gw0PX
         ORNhAADve2zXOpzqO3CA8NZHZdYMxO/gGRNmz01q2c6tWBEB/KZiJe+c31focjlL0Jst
         9CHZOLVuvsuevl8pZ4MJT8/DrxVugQ1lNDdulks8XQU5cLN32VHNTWBJrtZoChrgGB1p
         7kWPFmp/5oSbX5T3lm5SxBKfeFyewPToZuAeEgLznzYjMNyHkgxcLoRQ/nPV8P781Khz
         L9Z1xrEngA4cQcMcGeZF+Qvy1UvyT5l1ghSN237qfLb+BpT+DNkWy3L3z1sT6LYJ/EIG
         Tmhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JdjLenGm8qjHYQsyQoKVaW3PTpEveC22o5czLzfvk6Y=;
        b=Lo6+0kCBAEkx5qnRIvJdr8aaWxEirlVQT6DG9xCUOdD55j9PDtUqiskzfCL/XebC8T
         Qh4Th3GuK1TPbxxEgPal2EH1Y569kccK1RKaY/m6S5p/zQudNPfiKKgHSOvmYusF7I5g
         XMxe6ClEO9IVAsSepTKu13shcXQLOpANs0v7o5dYgGfrJMsQqEaVUX30V9W2BLhzxFVj
         JUHkVWk6b85dPfoh62Z5Ot7uOK2BGIu2JmK5n/RKA5Hu64VtWOYm/1/oAHAW9LqKyQLf
         R5CMxIlJLlV1Ml5yHZpuIYRazObKdAgLW4jmWBH4mAyH1z+YRjS7Ht0pC1k/jYoLztAz
         imlA==
X-Gm-Message-State: AOAM533T6O6iQ7r0nbOmpQ2g8OiR8oZStEf7kVBtVLwJJ7Rxp8GP0TUl
        z7v84c7n99mMA3roR6+MKXs=
X-Google-Smtp-Source: ABdhPJzRlb5fpSedqGJZ1QVc911yW3TBNyDU55CHyi1sTZiBC+SzxoJ5Z0IGJ9dj6BjoJpxN4QQK0w==
X-Received: by 2002:a17:902:7c91:b029:ed:5748:901e with SMTP id y17-20020a1709027c91b02900ed5748901emr37788961pll.27.1620867978613;
        Wed, 12 May 2021 18:06:18 -0700 (PDT)
Received: from localhost ([203.87.99.126])
        by smtp.gmail.com with ESMTPSA id d3sm792225pfn.141.2021.05.12.18.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 18:06:17 -0700 (PDT)
Date:   Thu, 13 May 2021 11:06:14 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Next revision of the L1D flush patches
Message-ID: <20210513010614.GH4236@balbir-desktop>
References: <20210108121056.21940-1-sblbir@amazon.com>
 <cf89f0389379daaaff0cbce9c5f1550866e55e91.camel@amazon.com>
 <202104081319.DAB1D817@keescook>
 <87y2d5tpjh.ffs@nanos.tec.linutronix.de>
 <87tunsofan.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tunsofan.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, Apr 27, 2021 at 12:24:16AM +0200, Thomas Gleixner wrote:
> On Mon, Apr 26 2021 at 10:31, Thomas Gleixner wrote:
> > On Thu, Apr 08 2021 at 13:23, Kees Cook wrote:
> >>
> >> I'd still really like to see this -- it's a big hammer, but that's the
> >> point for cases where some new flaw appears and we can point to the
> >> toolbox and say "you can mitigate it with this while you wait for new
> >> kernel/CPU."
> >>
> >> Any further thoughts from x86 maintainers? This seems like it addressed
> >> all of tglx's review comments.
> >
> > Sorry for dropping the ball on this. It's in my list of things to deal
> > with. Starting to look at it now.
> 
> So I went through the pile and for remorse I sat down and made the
> tweaks I think are necessary myself.
> 
> I've pushed out the result to
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/l1dflush
>

Thank you I'll take a look and test it.
 
> The only thing I did not address yet is that the documentation lacks any
> mentioning of the SIGBUS mechanism which is invoked when a task which
> asked for L1D flush protection ends up on a SMT sibling for whatever
> reason. That's essential to have because it's part of the contract of
> that prctl.

IIRC I documented it, I'll double check.

> 
> Balbir, can you please double check the result and prepare an updated
> version from there?
> 
> If you don't have cycles, please let me know.
>

I might have some cycles for testing and re-review. Thanks for all the
hard work on this

Balbir Singh. 
