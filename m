Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B612D786
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="h3KfcER9"
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB147109
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:44:19 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5079f9675c6so5776170e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697564658; x=1698169458; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EJ+grLHpGUzgQCivN/ck9HANlKle5gcz1nC0C6eh5V4=;
        b=h3KfcER9YT2N+QU/9SjnfUKzL1H+5Mq9+CMOSFKPU5fdOpkUQczqi1K4wCkfuDEEec
         lE9fumuJxO9lsqI4CM4ZqCuY361V0YjIEVgvTZHKeeHFlexsNYXcppxUNkcGTMiSDzeL
         Esh7yumNHUJVNFgXqFcao5/PnRFH4ry1VuSJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564658; x=1698169458;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJ+grLHpGUzgQCivN/ck9HANlKle5gcz1nC0C6eh5V4=;
        b=HaCTsayaD05+AMgYOQ6Q3Q6eWGsNw3G/0Sl/Kf2y6yztJI8p9s7JUl5qPVS2BLxvJp
         Xcwmiw9230qyx1ZPxk7qAzdp9FRT1JKiGhi1OAv14Xwhdv9wAkoXxNpZdiLGDp7SDvL8
         xZcSGMX3tipPsIDSPXvIZkWQU8d6E4BtZIac00Wmxfsjknqsrbu7RIlZU7+1ozGwRJiN
         FqGhgp4tuFsh2CgINmCMPACJQmuw9G9TZfYTT2l0WrIuS2v+hEA1v/k7beUAguJlhpJp
         3LbMBve/kqv4pZ552qbWlenSAKXDgn5MK7tUMiuZAH4kzeaZlIRV2XdNBdEx6f0zdrAg
         NgGQ==
X-Gm-Message-State: AOJu0YwOp1DrVLTtObkbILRyI9rBUon3qBqT+4SGAaoi16XKvlCR9Jg1
	xCud9JL78+ZmEgR8GhaxbAuCs0qTX8+2bqpAb6nVU4Nt
X-Google-Smtp-Source: AGHT+IHJQWBAPXgoX7biRyF/kGQG97i9msAp9DDf6CP8zVtCr7ggqvoKrR7+NABHvVUnEIu815Unfw==
X-Received: by 2002:a05:6512:304c:b0:507:8c55:39f9 with SMTP id b12-20020a056512304c00b005078c5539f9mr2751925lfb.49.1697564658032;
        Tue, 17 Oct 2023 10:44:18 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b004fbab4b7d45sm360236lfo.67.2023.10.17.10.44.17
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:44:17 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c17de836fbso72348681fa.1
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 10:44:17 -0700 (PDT)
X-Received: by 2002:a17:907:9306:b0:9bd:8cfd:e588 with SMTP id
 bu6-20020a170907930600b009bd8cfde588mr2685824ejc.27.1697564636390; Tue, 17
 Oct 2023 10:43:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
 <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
In-Reply-To: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 17 Oct 2023 10:43:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
Message-ID: <CAHk-=whchB_=Qx_oNAg3KBe-erNg9R2p_91ikaRZhsNY_2-G7g@mail.gmail.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 17 Oct 2023 at 10:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Honestly, there is only two kinds of sealing that makes sense:
>
>  - you cannot change the permissions of some area
>
>  - you cannot unmap an area

Actually, I guess at least theoretically, there could be three different things:

 - you cannot move an area

although I do think that maybe just saying "you cannot unmap" might
also include "you cannot move".

But I guess it depends on whether you feel it's the virtual _address_
you are protecting, or whether it's the concept of mapping something.

I personally think that from a security perspective, what you want to
protect is a particular address. That implies that "seal from
unmapping" would thus also include "you can't move this area
elsewhere".

But at least conceptually, splitting "unmap" and "move" apart might
make some sense. I would like to hear a practical reason for it,
though.

Without that practical reason, I think the only two sane sealing operations are:

 - SEAL_MUNMAP: "don't allow this mapping address to go away"

   IOW no unmap, no shrinking, no moving mremap

 - SEAL_MPROTECT: "don't allow any mapping permission changes"

Again, that permission case might end up being "don't allow
_additional_ permissions" and "don't allow taking permissions away".
Or it could be split by operation (ie "don't allow permission changes
to writability / readability / executability respectively").

I suspect there isn't a real-life example of splitting the
SEAL_MPROTECT (the same way I doubt there's a real-life example for
splitting the UNMAP into "unmap vs move"), so unless there is some
real reason, I'd keep the sealing minimal and to just those two flags.

We could always add more flags later, if there is a real use case
(IOW, if we start with "don't allow any permission changes", we could
add a flag later that just says "don't allow writability changes").

               Linus
