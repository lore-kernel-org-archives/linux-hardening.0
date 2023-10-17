Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFEF2D024
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C95fucLX"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A117A4
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 09:55:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-504a7f9204eso7739172e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697561713; x=1698166513; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K1bTNFT87lr+HVy46GvlRl8WsLt2mWlRGa4YdiUNjuo=;
        b=C95fucLXDJ79V/XKh6ttBIPWEEXVfV8RilQN/2vkEUAhKwGV28ZkrLTlFMRfz4zvDb
         lj9/aAqcGmMOVuklTGYFEPLVkIXFR5NaRMGcFW+YpY20iCZ5+u+/ipqkMXAwknp7J2/I
         JkyLi4gIgFLRSWZemhuigpIbAlV8BW2fpXIFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697561713; x=1698166513;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1bTNFT87lr+HVy46GvlRl8WsLt2mWlRGa4YdiUNjuo=;
        b=G9efGa0o7j55RfnP7T0ZIVCEyX7cvBuC/tXnceKGmAL0emp2TiLHvYOq5QmBMUJEPU
         fNqR2HO3DM7DCClIathYhaRS1xYxbJboLg4NpfRGOtIsAXAmzgpIwpv8KBD1duz+lulS
         nbC6GuakHL6II6vlmTWXV7j8R2zUcA29wvaOKTusWdivNe5tNy31C4Wn/ds0Jtiq8jfs
         rmixVcIwM9TyBpWAhAeaDQxmnNB5n2Ncu3zdK+JGDTaw9VdFBluNCJPANbYJr2jCd39O
         vN8UH4MX4ILs2ZjHj4BNd2JwHaYZEPCCGKNg8ixD1Qj7aX3kztaC2iTrAUx4MBxviAy/
         e66A==
X-Gm-Message-State: AOJu0Yx+k8bk4gjmQyr9FKecsHArCfF9mgvfoCILvBaAaG1KliTmJ9RF
	9zchBo00qqa4mfFRKVFmCxSxWKYsWJ0qlBY5ExPTGjPc
X-Google-Smtp-Source: AGHT+IH+z82iSlcdRXIZim90Nx4GW+ig4U+tdzjiVIgRHUiYM2PvelBbfw2JjvQbgNCxfHZPFa7SvQ==
X-Received: by 2002:a05:6512:3136:b0:4fd:c715:5667 with SMTP id p22-20020a056512313600b004fdc7155667mr1767102lfd.20.1697561713114;
        Tue, 17 Oct 2023 09:55:13 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t8-20020ac243a8000000b005009b4d5c14sm344794lfl.265.2023.10.17.09.55.12
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 09:55:12 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2c523ac38fbso31671201fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 09:55:12 -0700 (PDT)
X-Received: by 2002:a17:907:3cd:b0:9c4:b8c9:1bf2 with SMTP id
 su13-20020a17090703cd00b009c4b8c91bf2mr1497085ejb.60.1697561692367; Tue, 17
 Oct 2023 09:54:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
In-Reply-To: <20231017090815.1067790-6-jeffxu@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Oct 2023 09:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
Message-ID: <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
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
> Of all the call paths that call into do_vmi_munmap(),
> this is the only place where checkSeals = MM_SEAL_MUNMAP.
> The rest has checkSeals = 0.

Why?

None of this makes sense.

So you say "we can't munmap in this *one* place, but all others ignore
the sealing".

Crazy.

             Linus
