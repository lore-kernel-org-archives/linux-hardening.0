Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1532D028
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ArEzMONo"
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF914AB
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:05:34 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso1032531266b.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697562333; x=1698167133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8E8o2x2e8DzqPr/PksD/TO2/JNV/3RJFF1TJnJk/P9E=;
        b=ArEzMONoLYIu9o2JPMB/Q2STAu8j/zoMEgdT8VjfuaJ1VRcCb1EFPmfZceCKoeBs0j
         lEeEnaWnRamnU7MFy3yQwDJtg8s9CWpZK35PsV8ybTVSRzmMnjQvVUA79hWLlXGa8WCG
         cAZgCme7/LsbZM5No2YUL0U3cQsesN0ZcJcRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562333; x=1698167133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8E8o2x2e8DzqPr/PksD/TO2/JNV/3RJFF1TJnJk/P9E=;
        b=B9n/eOaSVk2tkp7pdNqp5Cy7OZLMTMU3dEzMe+SobzRW3rjff+36bcdPhf5bfv86By
         r63ZAouR7ec7ZiCzamFC8MOJsuLB2noR9woMmHBZsTO54ity/KYdcNJJXFtSqFfbaQT1
         eR2hAVD33qwsVQDs0OqIrhQ8gsikUumNGJl9WqyZh+ZY2Aj2nJr1wYOG4Ps5f/9fSgYj
         x/6nebL1KNnyOECs/HDHK0iRIjAkTxK4CsrJpV1ou6Y5TrCWP6IQF+gddqXk4/fF/KD6
         3fgUA4mCvCmu+RreVKzM0rAvo5z3IO/YS4IYdDCKl5+iuRB+/5ROMpKl8z/MkWx66g98
         3oTQ==
X-Gm-Message-State: AOJu0YxhsoL03uusBoWSp9XjpLVFbPVdkbDwGZzzgtMDOnkDhVwQSm/k
	bd9D8kI0sf7guuCUOJqErlfxroYbdCRE6kSYK1tMOZ3+
X-Google-Smtp-Source: AGHT+IETXKmuWrR5bnFt5GrEgtr00I/Z4DhmlhUJ1jy9JJBatX/lIIe/AZt95BxPcoeTrj+mpyQzSg==
X-Received: by 2002:a17:907:5cd:b0:9bf:ff8a:76c8 with SMTP id wg13-20020a17090705cd00b009bfff8a76c8mr2452546ejb.18.1697562333189;
        Tue, 17 Oct 2023 10:05:33 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id r1-20020a170906c28100b0099bd453357esm145085ejz.41.2023.10.17.10.05.32
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:05:32 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso9248403a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:05:32 -0700 (PDT)
X-Received: by 2002:a17:907:d1c:b0:9b2:b2f8:85dd with SMTP id
 gn28-20020a1709070d1c00b009b2b2f885ddmr2808664ejc.34.1697562311687; Tue, 17
 Oct 2023 10:05:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
In-Reply-To: <20231017090815.1067790-8-jeffxu@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Oct 2023 10:04:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
Message-ID: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com, 
	apopple@nvidia.com, aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, 
	ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com, 
	dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, 
	corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023 at 02:08, <jeffxu@chromium.org> wrote:
>
> Note: Of all the call paths that goes into do_mmap(),
> ksys_mmap_pgoff() is the only place where
> checkSeals = MM_SEAL_MMAP. The rest has checkSeals = 0.

Again, this is all completely nonsensical.

First off, since seals only exist on existing vma's, the "MMAP seal"
makes no sense to begin with. You cannot mmap twice - and mmap'ing
over an existing mapping involves unmapping the old one.

So a "mmap seal" is nonsensical. What should protect a mapping is "you
cannot unmap this". That automatically means that you cannot mmap over
it.

In other words, all these sealing flag semantics are completely random
noise. None of this makes sense.

You need to EXPLAIN what the concept is.

Honestly, there is only two kinds of sealing that makes sense:

 - you cannot change the permissions of some area

 - you cannot unmap an area

where that first version might then have sub-cases (maybe you can make
permissions _stricter_, but not the other way)?

And dammit, once something is sealed, it is SEALED. None of this crazy
"one place honors the sealing, random other places do not".

I do *NOT* want to see another random patch series tomorrow that
modifies something small here.

I want to get an EXPLANATION and the whole "what the f*ck is the
concept". No more random rules. No more nonsensical code. No more of
this "one place honors seals, another one does not".

Seriously. As long as this is chock-full of these kinds of random
"this makes no sense", please don't send any patches AT ALL. Explain
the high-level rules first, and if you cannot explain why one random
place does something different from all the other random places, don't
even bother.

No more random code. No more random seals. None of this crazy "you
ostensibly can't unmap a vma, but you you can actually unmap it by
mmap'ing over it and then unmapping the new one".

             Linus
