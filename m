Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993EFC11F64
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jul 2021 07:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71C2A61351
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jul 2021 07:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhGAHxp (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jul 2021 03:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAHxo (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jul 2021 03:53:44 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93811C061756
        for <linux-hardening@vger.kernel.org>; Thu,  1 Jul 2021 00:51:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n11so3765327pjo.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Jul 2021 00:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=NuhQJvSGQNQr0uAb1SnjbvM1kc2WuWvniJOy1G+B9hM=;
        b=TXSzVJsWl9kC9EMGLKuw98Xt+SSOnWT/WwAOndmz8ii+FeiDfHDYHutCvSRc6Uwm5d
         S3jdRdA2EFhmXqamCy4il1umu/HNeujy++kxFlDoNRc2zcOIb25XrVlD7wUMRgVr0wGn
         /CFcsE1wv3fWoY1MkqjCkb6QBgLqD64lnPXfidQJH4SsF/fn+bGwgoR+orf8rJpb0mkE
         xSi0LE23HNbe7vxSB5DD0tsdvz7RiCiftujr6HRZC8V8iZbqWNNMizNn1ZYen+m/6CMW
         Z+JFhci3wEUZi1LuE3/SpBB2zqbKkInItfxWUp1hKPA8jDxIwEtB6tMu7WpA7mwuFsoc
         x8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=NuhQJvSGQNQr0uAb1SnjbvM1kc2WuWvniJOy1G+B9hM=;
        b=lFij+ZBuDfc6xSzz87G8iTqya72MKCr0qEKmAAfmgxpgBHW8Io60tW9O391mbjDXIc
         pebiQG/lwcFomwG47G9Nn24FH31nu7LILY1Lca9CUp4WxBfCzezFgM94F3nqhuFUorL/
         hrT2LRdZQza7zS8HYmL71zvm0f5eT1oB00ikWb5/XdWVlyCMzqiG0jxc0zGP6QXlo8IM
         ea8n3p2buAKEYDVXUZCGC+IAotAinSOb8pR+xi43VJEcltHfNRQ1Q4G3jumMq+YPjh2B
         52vsSqq93QBhT8eeCEB49Z6gqvj+RmOsnG735PJ1G8pClFZPTFpQV2h5FWGCJcLIu/Wc
         CNQA==
X-Gm-Message-State: AOAM53146umnPkwOWe4xnQFj1R99zY8k/QWPaEGYom+ohlPwayD8FjNU
        hT24zJoX9HWJarkcYW1g32Y=
X-Google-Smtp-Source: ABdhPJwR19Q/3nIOeoeHD169zkP2DyAJV+U5yyjYWf9Kw63qNyRL76sKSt4iI3gAOHy69H50cMbhng==
X-Received: by 2002:a17:90a:2d8c:: with SMTP id p12mr22227113pjd.41.1625125873879;
        Thu, 01 Jul 2021 00:51:13 -0700 (PDT)
Received: from localhost (220-244-87-52.tpgi.com.au. [220.244.87.52])
        by smtp.gmail.com with ESMTPSA id j22sm25372963pgb.62.2021.07.01.00.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 00:51:13 -0700 (PDT)
Date:   Thu, 01 Jul 2021 17:51:08 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RESEND PATCH v4 08/11] powerpc: Initialize and use a temporary
 mm for patching
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org
References: <20210506043452.9674-1-cmr@linux.ibm.com>
        <20210506043452.9674-9-cmr@linux.ibm.com>
        <1625119517.e6kkvfphsh.astroid@bobo.none>
        <CCHLZVOEHBYN.JEOBW598P7K5@oc8246131445.ibm.com>
In-Reply-To: <CCHLZVOEHBYN.JEOBW598P7K5@oc8246131445.ibm.com>
MIME-Version: 1.0
Message-Id: <1625125043.re5l9zg4kg.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Excerpts from Christopher M. Riedl's message of July 1, 2021 5:02 pm:
> On Thu Jul 1, 2021 at 1:12 AM CDT, Nicholas Piggin wrote:
>> Excerpts from Christopher M. Riedl's message of May 6, 2021 2:34 pm:
>> > When code patching a STRICT_KERNEL_RWX kernel the page containing the
>> > address to be patched is temporarily mapped as writeable. Currently, a
>> > per-cpu vmalloc patch area is used for this purpose. While the patch
>> > area is per-cpu, the temporary page mapping is inserted into the kerne=
l
>> > page tables for the duration of patching. The mapping is exposed to CP=
Us
>> > other than the patching CPU - this is undesirable from a hardening
>> > perspective. Use a temporary mm instead which keeps the mapping local =
to
>> > the CPU doing the patching.
>> >=20
>> > Use the `poking_init` init hook to prepare a temporary mm and patching
>> > address. Initialize the temporary mm by copying the init mm. Choose a
>> > randomized patching address inside the temporary mm userspace address
>> > space. The patching address is randomized between PAGE_SIZE and
>> > DEFAULT_MAP_WINDOW-PAGE_SIZE. The upper limit is necessary due to how
>> > the Book3s64 Hash MMU operates - by default the space above
>> > DEFAULT_MAP_WINDOW is not available. For now, the patching address for
>> > all platforms/MMUs is randomized inside this range.  The number of
>> > possible random addresses is dependent on PAGE_SIZE and limited by
>> > DEFAULT_MAP_WINDOW.
>> >=20
>> > Bits of entropy with 64K page size on BOOK3S_64:
>> >=20
>> >         bits of entropy =3D log2(DEFAULT_MAP_WINDOW_USER64 / PAGE_SIZE=
)
>> >=20
>> >         PAGE_SIZE=3D64K, DEFAULT_MAP_WINDOW_USER64=3D128TB
>> >         bits of entropy =3D log2(128TB / 64K) bits of entropy =3D 31
>> >=20
>> > Randomization occurs only once during initialization at boot.
>> >=20
>> > Introduce two new functions, map_patch() and unmap_patch(), to
>> > respectively create and remove the temporary mapping with write
>> > permissions at patching_addr. The Hash MMU on Book3s64 requires mappin=
g
>> > the page for patching with PAGE_SHARED since the kernel cannot access
>> > userspace pages with the PAGE_PRIVILEGED (PAGE_KERNEL) bit set.
>> >=20
>> > Also introduce hash_prefault_mapping() to preload the SLB entry and HP=
TE
>> > for the patching_addr when using the Hash MMU on Book3s64 to avoid
>> > taking an SLB and Hash fault during patching.
>>
>> What prevents the SLBE or HPTE from being removed before the last
>> access?
>=20
> This code runs with local IRQs disabled - we also don't access anything
> else in userspace so I'm not sure what else could cause the entries to
> be removed TBH.
>=20
>>
>>
>> > +#ifdef CONFIG_PPC_BOOK3S_64
>> > +
>> > +static inline int hash_prefault_mapping(pgprot_t pgprot)
>> >  {
>> > -	struct vm_struct *area;
>> > +	int err;
>> > =20
>> > -	area =3D get_vm_area(PAGE_SIZE, VM_ALLOC);
>> > -	if (!area) {
>> > -		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
>> > -			cpu);
>> > -		return -1;
>> > -	}
>> > -	this_cpu_write(text_poke_area, area);
>> > +	if (radix_enabled())
>> > +		return 0;
>> > =20
>> > -	return 0;
>> > -}
>> > +	err =3D slb_allocate_user(patching_mm, patching_addr);
>> > +	if (err)
>> > +		pr_warn("map patch: failed to allocate slb entry\n");
>> > =20
>> > -static int text_area_cpu_down(unsigned int cpu)
>> > -{
>> > -	free_vm_area(this_cpu_read(text_poke_area));
>> > -	return 0;
>> > +	err =3D hash_page_mm(patching_mm, patching_addr, pgprot_val(pgprot),=
 0,
>> > +			   HPTE_USE_KERNEL_KEY);
>> > +	if (err)
>> > +		pr_warn("map patch: failed to insert hashed page\n");
>> > +
>> > +	/* See comment in switch_slb() in mm/book3s64/slb.c */
>> > +	isync();
>>
>> I'm not sure if this is enough. Could we context switch here? You've
>> got the PTL so no with a normal kernel but maybe yes with an RT kernel
>> How about taking an machine check that clears the SLB? Could the HPTE
>> get removed by something else here?
>=20
> All of this happens after a local_irq_save() which should at least
> prevent context switches IIUC.

Ah yeah I didn't look that far back. A machine check can take out SLB
entries.

> I am not sure what else could cause the
> HPTE to get removed here.

Other CPUs?

>> You want to prevent faults because you might be patching a fault
>> handler?
>=20
> In a more general sense: I don't think we want to take page faults every
> time we patch an instruction with a STRICT_RWX kernel. The Hash MMU page
> fault handler codepath also checks `current->mm` in some places which
> won't match the temporary mm. Also `current->mm` can be NULL which
> caused problems in my earlier revisions of this series.

Hmm, that's a bit of a hack then. Maybe doing an actual mm switch and=20
setting current->mm properly would explode too much. Maybe that's okayish.
But I can't see how the HPT code is up to the job of this in general=20
(even if that current->mm issue was fixed).

To do it without holes you would either have to get the SLB MCE handler=20
to restore that particular SLB if it flushed it, or restart the patch
code from a fixup location if it took an MCE after installing the SLB.
And bolt a hash table entry.

Thanks,
Nick
