Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFB210EA
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="keG0lQJO"
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08664D7A
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 10:44:28 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-581f78a0206so2075016eaf.2
        for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698083068; x=1698687868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7G5ETqm85R+O8rjCffN/EgWaevuGBBGp+Yfy1oHvZI=;
        b=keG0lQJOTiUGod+aXy/v/c2aUbTY+vdZYc4pxe61FZ8WdY54LwR3RrIfMox3w/599W
         2Sbq1GnRUjQRfrUAWCL0oGQP/B5udJAMuMjh3/o3O15HgSxcVJWNiAKHtcC8v7KKJenU
         A4PZIxhMPoVBdrRLI8kOAQTSkFrExShXLMhhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698083068; x=1698687868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7G5ETqm85R+O8rjCffN/EgWaevuGBBGp+Yfy1oHvZI=;
        b=wXbNRo7hjqEa5LcDxlqnFHZaW7cqs5/n8WyrPz132dg3smHHJAe6CNPXLmAPj/EQLj
         Y7+MXHIasetdXj+YJBVbfL0YaO+IytPN0bO8U6uQ3r6UM36Bbb6negmYjJq45bQBHjCV
         SQBYfJ6I/x3gybEap7kTX2QlYgWvC+y3h3m3mlliCgSmIQrwKPh9eFM9y9rMhpKzhm9g
         osoIEDXcb6Xf0ldo70CJjAtLeCV0D+njkoo4UcT9p44f9YYIJoeIi3dOvfN8sQVn5Xwb
         K2hQyMCSKD3lSibesbS6sRKmYGT6lVYV7EKhVHAwQCSr6WvZRrneRwQYPi3DeJv7bg6S
         cSsw==
X-Gm-Message-State: AOJu0YzbDeM/5Efd7WETyKW/63CxvMudXST0t85ip19/UPdUCnucs18W
	oI92IEt9irTWc0vfccX2EQV9EDsG8/5Nohx3RYCX6Q==
X-Google-Smtp-Source: AGHT+IGvCbHbkUldqJVCJnA7fx4lXJtIFpqmDQAAcI0RyigJuUbtyS+AoYWMaiwgaHhWwvs/j+j1sfSzoNiHFYIFbjg=
X-Received: by 2002:a05:6870:5312:b0:1ea:9898:c07f with SMTP id
 j18-20020a056870531200b001ea9898c07fmr12881189oan.22.1698083068251; Mon, 23
 Oct 2023 10:44:28 -0700 (PDT)
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
 <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com>
 <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com> <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
In-Reply-To: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 23 Oct 2023 10:44:16 -0700
Message-ID: <CABi2SkVqyBgh2JpvFj3yhu8UB-p7R9euvkJAjysmn1sR_NMwsA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pedro Falcato <pedro.falcato@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, surenb@google.com, alex.sierra@amd.com, 
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
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 4:06=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 19 Oct 2023 at 15:47, Pedro Falcato <pedro.falcato@gmail.com> wro=
te:
> > >
> > > For mprotect()/mmap(), is Linux implementation limited by POSIX ?
> >
> > No. POSIX works merely as a baseline that UNIX systems aim towards.
> > You can (and very frequently do) extend POSIX interfaces (in fact,
> > it's how most of POSIX was written, through sheer
> > "design-by-committee" on a bunch of UNIX systems' extensions).
>
> We can in extreme circumstances actually go further than that, and not
> only extend on POSIX requirements, but actively even violate them.
>
> It does need a very good reason, though, but it has happened when
> POSIX requirements were simply actively wrong.
>
> For example, at one point POSIX required
>
>      int accept(int s, struct sockaddr *addr, size_t *addrlen);
>
> which was simply completely wrong. It's utter shite, and didn't
> actually match any reality.
>
> The 'addrlen' parameter is 'int *', and POSIX suddenly trying to make
> it "size_t" was completely unacceptable.
>
> So we ignored it, told POSIX people that they were full of sh*t, and
> they eventually fixed it in the next version (by introducing a
> "socklen_t" that had better be the same as "int").
>
> So POSIX can simply be wrong.
>
> Also, if it turns out that we had some ABI that wasn't
> POSIX-compatible, the whole "don't break user space" will take
> precedence over any POSIX concerns, and we will not "fix" our system
> call if people already use our old semantics.
>
> So in that case, we generally end up with a new system call (or new
> flags) instead.
>
> Or sometimes it just is such a small detail that nobody cares - POSIX
> also has a notion of documenting areas of non-conformance, and people
> who really care end up having notions like "conformance vs _strict_
> conformance".
>
>                  Linus
>

Thanks Linus for clarifying the guidelines on POSIX in Linux.

-Jeff
