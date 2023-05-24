Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3FFC77B75
	for <linux-hardening@archiver.kernel.org>; Wed, 24 May 2023 00:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjEXAbv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 23 May 2023 20:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEXAbu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 23 May 2023 20:31:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC1EC2
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 17:31:49 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae3f74c98bso6955ad.1
        for <linux-hardening@vger.kernel.org>; Tue, 23 May 2023 17:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684888308; x=1687480308;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nb1HZAA6jWswrdHpi2mE5EOlqvUJPG125mFoOv5VQGI=;
        b=obMsE1lXozS/NM5Qr9t8zyy79IfRikzy9mErrcu9WXXIVCZGHrCglfhMRk5/M6Ve7j
         NZ/J26DbkEfGkW3lDfkwM9Jw80q4ANP1ezaNghYYTTlMzhZhxv3IlwUVNyTp/Tec7FDg
         kgN9XZPGqSp9oQXreB2xmD1ImQ8ZV1lGV7sj7H78Jo7zet9bW+MreTtlT4/q+YGyhBeF
         ROOmQ5yWPG/jEgB/u8vPcSBFN/YdrrFcaxrWAyTDynJD6Fr7l1Y3QW9iVtMjfu1iw4dN
         uUJ0Yla0/jkxpPlcYYNCz0xnCAvrKKiNWaDNEBtXBaX0bAeJw3zh3BqKiqaaLtc1UlUn
         y4/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684888308; x=1687480308;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nb1HZAA6jWswrdHpi2mE5EOlqvUJPG125mFoOv5VQGI=;
        b=lsLQSdZEI+pjmPO8xEPJovZ6xS1++hjRdAM2BJZCs7lwp4c+ZG3acAWdY3j+CDqx/W
         I8oBTlKi0TXnAGwpnc9F3rzyTUzQHfWsAetQQ6oLG02ZIFzHeMjGZmiFrDMikq16vn/4
         c5amM254LKkLbfVhKJIWWsirnQLPtRj/WWciSP0WI7ywyMZejriMZmIzdvz92nGm1iwc
         Wet0SJUoFM9/m88mKLxbcJvq1zdPeQmN4WGrh9Q6TNGxsFzSlJ8fwY6LtivLRTXpvX7W
         apNNQAEVrT0qbfpi7WwmDbSCbwuvlxFRRBCooefwdyMpMalM+eZAA0ZFcxpQEqdrWtq+
         5eJw==
X-Gm-Message-State: AC+VfDwmABdn2ALS4ihbgVpXHmvQ6RchXhfQ67FGsS0UP+uW3/N9q4cV
        inhYRk0Pv6L5p6y4p/dBUxbd36VasckPE+ZvPQBqAA==
X-Google-Smtp-Source: ACHHUZ6+2kjBpeHmmZzzLWonq9l7bPF0sHuH1f2qZtQExMnhCCqp5na25bJ31vG9eFZdE/w5T/SCCw==
X-Received: by 2002:a17:903:32cc:b0:1ac:3605:97dc with SMTP id i12-20020a17090332cc00b001ac360597dcmr130255plr.6.1684888308364;
        Tue, 23 May 2023 17:31:48 -0700 (PDT)
Received: from [2620:0:1008:11:c789:c1fb:6667:1766] ([2620:0:1008:11:c789:c1fb:6667:1766])
        by smtp.gmail.com with ESMTPSA id e3-20020a62ee03000000b0063d375ca0cbsm6210189pfi.151.2023.05.23.17.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 17:31:47 -0700 (PDT)
Date:   Tue, 23 May 2023 17:31:47 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Kees Cook <keescook@chromium.org>
cc:     David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
In-Reply-To: <202305231001.08BC6058@keescook>
Message-ID: <7a16b351-c7f6-b6a3-869b-5163c0d0793f@google.com>
References: <20230523073136.4900-1-vbabka@suse.cz> <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local> <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz> <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local> <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
 <202305231001.08BC6058@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Tue, 23 May 2023, Kees Cook wrote:

> On Tue, May 23, 2023 at 10:14:24AM +0200, David Hildenbrand wrote:
> > On 23.05.23 09:56, Lorenzo Stoakes wrote:
> > > On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
> > > > On 5/23/23 09:42, Lorenzo Stoakes wrote:
> > > > > On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
> > > > > > With SLOB removed, both remaining allocators support hardened usercopy,
> > > > > > so remove the config and associated #ifdef.
> > > > > > 
> > > > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > ---
> > > > > >   mm/Kconfig       | 2 --
> > > > > >   mm/slab.h        | 9 ---------
> > > > > >   security/Kconfig | 8 --------
> > > > > >   3 files changed, 19 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > > > > index 7672a22647b4..041f0da42f2b 100644
> > > > > > --- a/mm/Kconfig
> > > > > > +++ b/mm/Kconfig
> > > > > > @@ -221,7 +221,6 @@ choice
> > > > > >   config SLAB
> > > > > >   	bool "SLAB"
> > > > > >   	depends on !PREEMPT_RT
> > > > > > -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > > >   	help
> > > > > >   	  The regular slab allocator that is established and known to work
> > > > > >   	  well in all environments. It organizes cache hot objects in
> > > > > > @@ -229,7 +228,6 @@ config SLAB
> > > > > > 
> > > > > >   config SLUB
> > > > > >   	bool "SLUB (Unqueued Allocator)"
> > > > > > -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > > >   	help
> > > > > >   	   SLUB is a slab allocator that minimizes cache line usage
> > > > > >   	   instead of managing queues of cached objects (SLAB approach).
> > > > > > diff --git a/mm/slab.h b/mm/slab.h
> > > > > > index f01ac256a8f5..695ef96b4b5b 100644
> > > > > > --- a/mm/slab.h
> > > > > > +++ b/mm/slab.h
> > > > > > @@ -832,17 +832,8 @@ struct kmem_obj_info {
> > > > > >   void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> > > > > >   #endif
> > > > > > 
> > > > > > -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > > >   void __check_heap_object(const void *ptr, unsigned long n,
> > > > > >   			 const struct slab *slab, bool to_user);
> > > > > > -#else
> > > > > > -static inline
> > > > > > -void __check_heap_object(const void *ptr, unsigned long n,
> > > > > > -			 const struct slab *slab, bool to_user)
> > > > > > -{
> > > > > > -}
> > > > > > -#endif
> > > > > 
> > > > > Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
> > > > > not want the prototype?
> > > > 
> > > > Well I didn't delete the prototype, just the ifdef/else around, so now it's
> > > > there unconditionally.
> > > > 
> > > > > Perhaps replacing with #ifdef
> > > > > CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
> > > > 
> > > > Putting it under that #ifdef would work and match that the implementations
> > > > of that function are under that same ifdef, but maybe it's unnecessary noise
> > > > in the header?
> > > > 
> > > 
> > > Yeah my brain inserted extra '-'s there, sorry!
> > > 
> > > Given we only define __check_heap_object() in sl[au]b.c if
> > > CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
> > > if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
> > > unconditionally?
> > > 
> > 
> > The file is only compiled with CONFIG_HARDENED_USERCOPY:
> > 
> > mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
> 
> Right.
> 
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> 
> Thanks!
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 

Acked-by: David Rientjes <rientjes@google.com>
