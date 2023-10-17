Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABF1F606
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 17:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Sm8viTof"
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F4AFF
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:22:58 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso57011771fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697563376; x=1698168176; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pYYZG7yAyFfJYvTA6jWgYrv4Zal/uQTaztc6Ctmxivo=;
        b=Sm8viTof2xiy4A2RW3mev2AmdN07fghDIyQ+KnNKVB1DCN8kJ+1QUSvuLUJUZbd58a
         cLw5Dn/RtTKKzO5LNELyZ3X/1+JlOtEaJi8B9fe/H5g4z/Qi27FggyiVFDOZz/IbYgre
         1Atl679J+IKgPeIl4qSdQNtUEEAlBz1OKuxAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697563376; x=1698168176;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pYYZG7yAyFfJYvTA6jWgYrv4Zal/uQTaztc6Ctmxivo=;
        b=bde9dbq/uc12arbTTvTbnCQ3TVUD7SMtRtb+VR4ta+jl5OqEaVUSfIV2VjtjPo8nai
         xllmKi1Vmr2u3fhpQisrLGRLAQvS1BjOj8CRKWBCECDz421u6cDuSpDNHAkqkd2dhQCi
         er1OJtv3LDGyz0CZYqzZFBCdsRArw+CgIyspDZQNY25CdMvugoKmyBFL5QDbSZneIZDy
         LDcSlpyncDIYbM9Epegz5Y6147hP4fwWSjEisJQeWcgeHkfZfXWbCtFsTMv4CufNKPKh
         pWhVGQ4MsKX6l/MZ7oM5qpeDX3KiQ2o0n9LGdpmJdBDVPuGddVew/lRFuoiPtIu5xTYs
         CYlw==
X-Gm-Message-State: AOJu0Yz29HL+5Fc2+TTuFLWnlyE2yBWMbjhAHMOh8p6FENT94eDpo6Aa
	akSaMGPx+flmA7mada5FJdQILmX6gtgM170TkHvwtRqE
X-Google-Smtp-Source: AGHT+IGf5XXbEO6MFuLMDybTY6FMb76CHdRVR4+kFGsEsNXzRSGc3cYdC0q+q1uMbTACAOVJNfb2dA==
X-Received: by 2002:a05:651c:321:b0:2bc:b224:98ac with SMTP id b1-20020a05651c032100b002bcb22498acmr1819872ljp.31.1697563375824;
        Tue, 17 Oct 2023 10:22:55 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y26-20020a2eb01a000000b002c02e57c72bsm331219ljk.140.2023.10.17.10.22.54
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:22:55 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c515527310so43609951fa.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:22:54 -0700 (PDT)
X-Received: by 2002:a17:907:c08:b0:9bd:e017:370e with SMTP id
 ga8-20020a1709070c0800b009bde017370emr2539597ejc.54.1697563353335; Tue, 17
 Oct 2023 10:22:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <CAHk-=whFZoap+DBTYvJx6ohqPwn11Puzh7q4huFWDX9vBwXHgg@mail.gmail.com>
 <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
In-Reply-To: <CALmYWFtTDAb_kpZdAe_xspqwNgK1NWJmjTxaTC=jDEMzfe297Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Oct 2023 10:22:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
Message-ID: <CAHk-=wj87GMTH=5901ob=SjQqegAm2JYBE7E4J7skJzE64U-wQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To: Jeff Xu <jeffxu@google.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	sroettger@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, jannh@google.com, surenb@google.com, alex.sierra@amd.com, 
	apopple@nvidia.com, aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, 
	ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com, 
	dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, 
	corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	lstoakes@gmail.com, willy@infradead.org, mawupeng1@huawei.com, 
	linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com, 
	peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023 at 02:08, Jeff Xu <jeffxu@google.com> wrote:
>
> It is probably worth noting that I choose to check one and only
> one sealing type per syscall. i.e. munmap(2) checks
> MM_SEAL_MUNMAP only.

Yeah, this is wrong.

It's wrong exactly because other system calls will unmap things too.

Using mmap() to over-map something will unmap the old one.

Same goes for mremap() to move over an existing mapping.

So the whole "do things by the name of the system call" is not workable.

All that matters is what the system calls *do*, not what their name is.

And mmap() will fundamentally munmap() as part of the action.

This is why I absolutely hated the old "ON_BEHALF_OF_xyz" flag, and
why I still absolutely hate the "randomly pass different sealing flags
fto do_munmap()".

You should *not* be passing any flags at all to do_munmap(). Because
*regardless* of who calls it, and regardless of which system call
started the action, do_munmap() unmaps a virtual memory area.

See what I'm saying?

                 Linus
