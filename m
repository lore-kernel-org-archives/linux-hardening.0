Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DF0C11F64
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jul 2021 06:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB3A6148E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Jul 2021 06:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbhGAGP2 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Jul 2021 02:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhGAGP2 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Jul 2021 02:15:28 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B14C061756
        for <linux-hardening@vger.kernel.org>; Wed, 30 Jun 2021 23:12:57 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 21so4996211pfp.3
        for <linux-hardening@vger.kernel.org>; Wed, 30 Jun 2021 23:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=kqSxCfVFDw5LwUcKdGAuUWfWaUH/oxkMxNPG9jwy9/E=;
        b=t7j3WYdc0qQPtFRbj+EfHPO43M0PSuBgnHe8BxHBOdDwPmfmvrYcvSP6Ekcag+7b04
         G5UF3RUzwc3duJwld4hmFApAqDllQ2EddDZja8E7XJk7NSVwFMo6aXQEE/FqYBMgf1HM
         g6c4zqlFFxbMVKzs16pqKcgDR4EoBgqD3QCk2XO1DCASSaFSjF3lCatY3LkQGYmHdvuB
         DbXGa67FyP+x/PP9XeujxrsTXwHlAtmGejuJ967W5wMhnGnntGXPTOspybWgBrvwIvqC
         DOam+/0eTJhRoDbHKzYtz/ablgDEilMLSBKxDRKp3G1QiPyrpYbn/QVA0zzpU4C75t6u
         zqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=kqSxCfVFDw5LwUcKdGAuUWfWaUH/oxkMxNPG9jwy9/E=;
        b=o3/SFsxXWoTXCmD0V4ea9LizyjHvVYAVPim1aZlrbTJe6MFaI+Vm2I/5/oV04dNrGj
         jqVYIpRKlJ5EfwJl2zW/cHczWePmSt/ad4GXgo+D5IhufjfIsAjtgXsbTMBklEIaSOIL
         hCD4kRK3XIgfUjT7L46KvX37P7ZKtRDP1O3Dx194KvhxZxD9woVRQmWJfneUTkI74/Jm
         nYRmdZfuf/2BaKrnRkbtzYdJI/cSGYlgS7Ub0cT1TEsZ+1x4FZzLazCcnHRSklZEyRCH
         0KQ8+XU8EJcLB+HAwqyLTmbjcIoYuyIKxcuLSBA2DA4LXBc7LN+emVGkuOZJBW2hu32I
         bI0w==
X-Gm-Message-State: AOAM5327Wjt1MW0iIFKHR3C/X4J+cedXkX4cVKq9Xytu+Ez4dwtmtJJx
        RJqFCyQ4JKSRUxPiodZu62M=
X-Google-Smtp-Source: ABdhPJzWKdhVy/IYl6zNzIda9IDDa9wIrbQZEzn5v/Bz0OBcBSpBJwpN75CbzHr2/aYuYmW26VR4pw==
X-Received: by 2002:a05:6a00:806:b029:307:3ffc:f6bb with SMTP id m6-20020a056a000806b02903073ffcf6bbmr39640599pfk.44.1625119977053;
        Wed, 30 Jun 2021 23:12:57 -0700 (PDT)
Received: from localhost (220-244-87-52.tpgi.com.au. [220.244.87.52])
        by smtp.gmail.com with ESMTPSA id h24sm23434124pjv.27.2021.06.30.23.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 23:12:56 -0700 (PDT)
Date:   Thu, 01 Jul 2021 16:12:52 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RESEND PATCH v4 08/11] powerpc: Initialize and use a temporary
 mm for patching
To:     "Christopher M. Riedl" <cmr@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     keescook@chromium.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, x86@kernel.org
References: <20210506043452.9674-1-cmr@linux.ibm.com>
        <20210506043452.9674-9-cmr@linux.ibm.com>
In-Reply-To: <20210506043452.9674-9-cmr@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1625119517.e6kkvfphsh.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Excerpts from Christopher M. Riedl's message of May 6, 2021 2:34 pm:
> When code patching a STRICT_KERNEL_RWX kernel the page containing the
> address to be patched is temporarily mapped as writeable. Currently, a
> per-cpu vmalloc patch area is used for this purpose. While the patch
> area is per-cpu, the temporary page mapping is inserted into the kernel
> page tables for the duration of patching. The mapping is exposed to CPUs
> other than the patching CPU - this is undesirable from a hardening
> perspective. Use a temporary mm instead which keeps the mapping local to
> the CPU doing the patching.
>=20
> Use the `poking_init` init hook to prepare a temporary mm and patching
> address. Initialize the temporary mm by copying the init mm. Choose a
> randomized patching address inside the temporary mm userspace address
> space. The patching address is randomized between PAGE_SIZE and
> DEFAULT_MAP_WINDOW-PAGE_SIZE. The upper limit is necessary due to how
> the Book3s64 Hash MMU operates - by default the space above
> DEFAULT_MAP_WINDOW is not available. For now, the patching address for
> all platforms/MMUs is randomized inside this range.  The number of
> possible random addresses is dependent on PAGE_SIZE and limited by
> DEFAULT_MAP_WINDOW.
>=20
> Bits of entropy with 64K page size on BOOK3S_64:
>=20
>         bits of entropy =3D log2(DEFAULT_MAP_WINDOW_USER64 / PAGE_SIZE)
>=20
>         PAGE_SIZE=3D64K, DEFAULT_MAP_WINDOW_USER64=3D128TB
>         bits of entropy =3D log2(128TB / 64K) bits of entropy =3D 31
>=20
> Randomization occurs only once during initialization at boot.
>=20
> Introduce two new functions, map_patch() and unmap_patch(), to
> respectively create and remove the temporary mapping with write
> permissions at patching_addr. The Hash MMU on Book3s64 requires mapping
> the page for patching with PAGE_SHARED since the kernel cannot access
> userspace pages with the PAGE_PRIVILEGED (PAGE_KERNEL) bit set.
>=20
> Also introduce hash_prefault_mapping() to preload the SLB entry and HPTE
> for the patching_addr when using the Hash MMU on Book3s64 to avoid
> taking an SLB and Hash fault during patching.

What prevents the SLBE or HPTE from being removed before the last
access?


> +#ifdef CONFIG_PPC_BOOK3S_64
> +
> +static inline int hash_prefault_mapping(pgprot_t pgprot)
>  {
> -	struct vm_struct *area;
> +	int err;
> =20
> -	area =3D get_vm_area(PAGE_SIZE, VM_ALLOC);
> -	if (!area) {
> -		WARN_ONCE(1, "Failed to create text area for cpu %d\n",
> -			cpu);
> -		return -1;
> -	}
> -	this_cpu_write(text_poke_area, area);
> +	if (radix_enabled())
> +		return 0;
> =20
> -	return 0;
> -}
> +	err =3D slb_allocate_user(patching_mm, patching_addr);
> +	if (err)
> +		pr_warn("map patch: failed to allocate slb entry\n");
> =20
> -static int text_area_cpu_down(unsigned int cpu)
> -{
> -	free_vm_area(this_cpu_read(text_poke_area));
> -	return 0;
> +	err =3D hash_page_mm(patching_mm, patching_addr, pgprot_val(pgprot), 0,
> +			   HPTE_USE_KERNEL_KEY);
> +	if (err)
> +		pr_warn("map patch: failed to insert hashed page\n");
> +
> +	/* See comment in switch_slb() in mm/book3s64/slb.c */
> +	isync();

I'm not sure if this is enough. Could we context switch here? You've
got the PTL so no with a normal kernel but maybe yes with an RT kernel
How about taking an machine check that clears the SLB? Could the HPTE
get removed by something else here?

You want to prevent faults because you might be patching a fault=20
handler?

Thanks,
Nick
