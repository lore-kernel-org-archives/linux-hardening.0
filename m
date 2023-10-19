Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CA242923
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JiTnmeIb"
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13772115
	for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 16:06:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso207258a12.2
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697756813; x=1698361613; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vyephYMGi9WkrF+MMy/aTcTtLZAvJsqtW+X3GM9oKyI=;
        b=JiTnmeIbyn0eI7O7WEeJEu3EpZGm4Rum3Ml96JxNuphs3OlRWaP09T4SW/jnPtgBv4
         QYloOGaltrnCuDc7ilBWtuS9XeCgEBb1QX+OLRCoyWOBGabdKolVfefZ0UUZBB9k4ERo
         Z7CO2TVsxEJzMCC4ONxsTVgIj26hXlF7w/gFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756813; x=1698361613;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyephYMGi9WkrF+MMy/aTcTtLZAvJsqtW+X3GM9oKyI=;
        b=AeLIU4EMGUo9NweUROeEZJ4MBvSBhLqjab66GFE5ea9ArC3YaFt89v5/Ux0izCojRD
         GYkb58gYdEuoXbvqZ6J7RtqmvaYErvSrXKoVM9FDSHU7kkZRGt9xP1z0XtLaTBFjffFI
         H7fM5MDLrBoEQqQ6DktIGtHt2mIXIoFjvbPEzefmcuISSUotMR9V4/kAx9GhitAPBS0F
         qQAJFI2wBXUSDUi/JGUxWxvzJcrBnn1aojsAwzC8vR/PuA3InMAwhdjnO/WUobRl3MHQ
         fdozfxffkVSvwpgklIbS10GcpkK+y6VnypLhgkwsOeJRhArp5XEKvraEhYF6tgmnszBG
         jMWQ==
X-Gm-Message-State: AOJu0YyJZ0/34VgvH1pcfGdNU+3CxdEXKcp2g7/4LrqXMFV/T+ZTF2q8
	kEP2nzIfIE3sM4pWbdkfFllew16DHcARltr3yPoOte/i
X-Google-Smtp-Source: AGHT+IH5AQRzOgafgVwt6G9L5ZQlXt5nEvPkgWwXak7u+CpdNCW+OH5Aq8Cd8MAGCKel3Ruqsfqvzg==
X-Received: by 2002:a17:906:6a19:b0:9c7:5a01:ffe7 with SMTP id qw25-20020a1709066a1900b009c75a01ffe7mr62306ejc.12.1697756813339;
        Thu, 19 Oct 2023 16:06:53 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906019000b009b2c9476726sm328809ejb.21.2023.10.19.16.06.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 16:06:52 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4084de32db5so1789445e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 19 Oct 2023 16:06:52 -0700 (PDT)
X-Received: by 2002:ac2:533c:0:b0:503:3453:ea7a with SMTP id
 f28-20020ac2533c000000b005033453ea7amr52431lfh.66.1697756791018; Thu, 19 Oct
 2023 16:06:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
 <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
 <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com>
 <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com> <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
In-Reply-To: <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 19 Oct 2023 16:06:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
Message-ID: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Jeff Xu <jeffxu@google.com>, Matthew Wilcox <willy@infradead.org>, jeffxu@chromium.org, 
	akpm@linux-foundation.org, keescook@chromium.org, sroettger@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, jannh@google.com, 
	surenb@google.com, alex.sierra@amd.com, apopple@nvidia.com, 
	aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, ben@decadent.org.uk, 
	catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk, 
	ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, corbet@lwn.net, 
	wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, lstoakes@gmail.com, 
	mawupeng1@huawei.com, linmiaohe@huawei.com, namit@vmware.com, 
	peterx@redhat.com, peterz@infradead.org, ryan.roberts@arm.com, 
	shr@devkernel.io, vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com, 
	zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 19 Oct 2023 at 15:47, Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > For mprotect()/mmap(), is Linux implementation limited by POSIX ?
>
> No. POSIX works merely as a baseline that UNIX systems aim towards.
> You can (and very frequently do) extend POSIX interfaces (in fact,
> it's how most of POSIX was written, through sheer
> "design-by-committee" on a bunch of UNIX systems' extensions).

We can in extreme circumstances actually go further than that, and not
only extend on POSIX requirements, but actively even violate them.

It does need a very good reason, though, but it has happened when
POSIX requirements were simply actively wrong.

For example, at one point POSIX required

     int accept(int s, struct sockaddr *addr, size_t *addrlen);

which was simply completely wrong. It's utter shite, and didn't
actually match any reality.

The 'addrlen' parameter is 'int *', and POSIX suddenly trying to make
it "size_t" was completely unacceptable.

So we ignored it, told POSIX people that they were full of sh*t, and
they eventually fixed it in the next version (by introducing a
"socklen_t" that had better be the same as "int").

So POSIX can simply be wrong.

Also, if it turns out that we had some ABI that wasn't
POSIX-compatible, the whole "don't break user space" will take
precedence over any POSIX concerns, and we will not "fix" our system
call if people already use our old semantics.

So in that case, we generally end up with a new system call (or new
flags) instead.

Or sometimes it just is such a small detail that nobody cares - POSIX
also has a notion of documenting areas of non-conformance, and people
who really care end up having notions like "conformance vs _strict_
conformance".

                 Linus
