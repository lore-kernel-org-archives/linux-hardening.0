Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AF2AD02
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233915; cv=none; b=o0nbYE7Klh/m+qeQSKtHW2IB4kQ0zOkByB6KVHn7YH7Um/vtB6EhFdGfjOHQGCPh89TRX/meZIWwKFL2RkC59F2W1WibW+vPYSSxzoalUpcQATMQdqQLAGU+ZO/p9IwuADNH4RBUbP1xxtYES+vcMOL0FeVwzZjHEbFvepiNp2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233915; c=relaxed/simple;
	bh=rFibgAbyi8k2g92ofpO5eBNoqFLdXg9NSHhDZ6OjBQk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pr75pCwNypmdrVCwwTZzcc56q/1t4bxbW8twmczZvSvOFgXpsKB84PDBIk5io/yzjtWOR+lv1ZnJdid7pd1CAJHnpyjYl57WUmYs5rspt3mNXZCASx9AKl5J+0Yc4abK+TfEROJvWKnk4/u/JHX1ymq1ZiL4oN+oLpqBGdJmt1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AykYWWaB; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AykYWWaB"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53e18b1baecso591464e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 05:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733233910; x=1733838710; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UQ1aC9i3QKw+4vNIX8jBAnpgfVHP1OgdayEkI4zrdI=;
        b=AykYWWaB9vVA9V8ZHa6I+dbq+XOF4S1WI6A7FqO7w83BUVTSBg+v3zyjxvgeC5VYHd
         Zr8Ckd+2DVRiqoJLXJdivBuftgRDq8TjZkgWf1mjGWtxGwLH6/cuGjXhU51ZkORYpr9H
         42iIzFrXOsIFjyeR26/r0h9uxvm2cNmbCle+v5j16YDKcA4KErNU1KrP4LXjxRh168yW
         pzvNrTBwrQZsEwrkpGYoIgY/wbNuE01NCiLXzYtfVUTU3LkJ/v6tPMB0dz39FJCNSvDh
         GiUx+DpNxj1l75KKoXD9Go4e2DG9WSJWqfurOu3gXKm9srMQa+ivtDKBGS37G7ybRJIT
         fZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233910; x=1733838710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UQ1aC9i3QKw+4vNIX8jBAnpgfVHP1OgdayEkI4zrdI=;
        b=tVQA2ehBTILQsPDNWERupvxyRJElRMSVX+23SM07Q1Bt8AVNd/fSOMm9kJFtTCF7Lb
         SZGZV3HalNkgY1IXCkog6nYIO3PfxqUapDF5N1Ilzr6jUfAZI8VAndxASMWQUsBI511P
         v/cyMDjS84P5tXMIq8WZAqLBDOmz3VbXVNnF/ePrA/HQlu7MvmlBczoKQkJuhoK+IT+k
         cVbkJonw/AeAmTCMPrL5hv8ax/GD0e1GdTPbgM0VqEKNjeYcFeYaTYI5vQV9tvCCmoai
         BnURbg18Lfo3NGh6iPLy+qRpa/eV24gIpOZWTr5OShRFNuw6ZxE0jT0ZF1npR7OZRN+j
         TRqw==
X-Forwarded-Encrypted: i=1; AJvYcCXdx/r2d+VALhJw/MjRoLXDujzh9qqouK8EVEO+B54RmkrUTzBoqYsRnsdmoGb1GTLJ9DeedNUTxyTv2Dkxyn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHszlWqfvdsWqL1UtXANaPTHw+h/zY30AZ40xgPRD/zLwfKqzx
	Am1JL5I94ktx5JdhPLkQRlmV+84tgS1wyM3qSo6W53X//HeyM7fahWfBoQ==
X-Gm-Gg: ASbGncvC75GDZnq4GJ4PncDrVd70s1eQ4gn10LaKvAFJdiT8tNOOjXWwdy62UDD08uW
	sL0y+neo/TiQhyxOtJfw+1K+met06Jy4UDy4dfR+M4MYp4pd3PcAMSZC2CApDSdceiNnxP5144f
	ICe8q4I14ADoBw5EMfFbdePppMKpiWpLy3Cx7wXC9vJFzAxY+ImQ06Wblfqu0IRkIgXNtKBLeCR
	cDqQ/gRZ997CziX5uPA84WiaKrpKhykG+dfahs9jSLOPSNvwnuUflSV2iNDDSOvyR9WWSlA/CE=
X-Google-Smtp-Source: AGHT+IHe2R4BqO2ewKdCJ+lB2QDGwVDVqPmqwVdmzQ7UffHte6KQqYnDxa+KjcgM65VsESMIec8BtA==
X-Received: by 2002:ac2:5461:0:b0:53e:12dc:e806 with SMTP id 2adb3069b0e04-53e12dce87cmr1201667e87.10.1733233909954;
        Tue, 03 Dec 2024 05:51:49 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1b5a4725sm53493e87.162.2024.12.03.05.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:51:49 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 3 Dec 2024 14:51:47 +0100
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, zuoze <zuoze1@huawei.com>,
	Matthew Wilcox <willy@infradead.org>, gustavoars@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z08M88NdLfugqhu9@pc636>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
 <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>

On Tue, Dec 03, 2024 at 09:45:09PM +0800, Kefeng Wang wrote:
> 
> 
> On 2024/12/3 21:39, Uladzislau Rezki wrote:
> > On Tue, Dec 03, 2024 at 09:30:09PM +0800, Kefeng Wang wrote:
> > > 
> > > 
> > > On 2024/12/3 21:10, zuoze wrote:
> > > > 
> > > > 
> > > > 在 2024/12/3 20:39, Uladzislau Rezki 写道:
> > > > > On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
> > > > > > We have implemented host-guest communication based on the TUN device
> > > > > > using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
> > > > > > and the operating system is based on the 6.6 LTS version with kernel
> > > > > > version 6.6. The specific stack for hotspot collection is as follows:
> > > > > > 
> > > > > > -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
> > > > > >      - ret_from_fork
> > > > > >         - 99.99% vhost_task_fn
> > > > > >            - 99.98% 0xffffdc59f619876c
> > > > > >               - 98.99% handle_rx_kick
> > > > > >                  - 98.94% handle_rx
> > > > > >                     - 94.92% tun_recvmsg
> > > > > >                        - 94.76% tun_do_read
> > > > > >                           - 94.62% tun_put_user_xdp_zc
> > > > > >                              - 63.53% __check_object_size
> > > > > >                                 - 63.49% __check_object_size.part.0
> > > > > >                                      find_vmap_area
> > > > > >                              - 30.02% _copy_to_iter
> > > > > >                                   __arch_copy_to_user
> > > > > >                     - 2.27% get_rx_bufs
> > > > > >                        - 2.12% vhost_get_vq_desc
> > > > > >                             1.49% __arch_copy_from_user
> > > > > >                     - 0.89% peek_head_len
> > > > > >                          0.54% xsk_tx_peek_desc
> > > > > >                     - 0.68% vhost_add_used_and_signal_n
> > > > > >                        - 0.53% eventfd_signal
> > > > > >                             eventfd_signal_mask
> > > > > >               - 0.94% handle_tx_kick
> > > > > >                  - 0.94% handle_tx
> > > > > >                     - handle_tx_copy
> > > > > >                        - 0.59% vhost_tx_batch.constprop.0
> > > > > >                             0.52% tun_sendmsg
> > > > > > 
> > > > > > It can be observed that most of the overhead is concentrated in the
> > > > > > find_vmap_area function.
> > > > > > 
> > > > > I see. Yes, it is pretty contented, since you run the v6.6 kernel. There
> > > > > was a work that tends to improve it to mitigate a vmap lock contention.
> > > > > See it here: https://lwn.net/Articles/956590/
> > > > > 
> > > > > The work was taken in the v6.9 kernel:
> > > > > 
> > > > > <snip>
> > > > > commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
> > > > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > > Date:   Tue Jan 2 19:46:23 2024 +0100
> > > > > 
> > > > >       mm: vmalloc: add va_alloc() helper
> > > > > 
> > > > >       Patch series "Mitigate a vmap lock contention", v3.
> > > > > 
> > > > >       1. Motivation
> > > > > ...
> > > > > <snip>
> > > > > 
> > > > > Could you please try the v6.9 kernel on your setup?
> > > > > 
> > > > > How to solve it, probably, it can be back-ported to the v6.6 kernel.
> > > > 
> > > > All the vmalloc-related optimizations have already been merged into 6.6,
> > > > including the set of optimization patches you suggested. Thank you very
> > > > much for your input.
> > > > 
> > > 
> > > It is unclear, we have backported the vmalloc optimization into our 6.6
> > > kernel before, so the above stack already with those patches and even
> > > with those optimization, the find_vmap_area() is still the hotpots.
> > > 
> > > 
> > Could you please check that all below patches are in your v6.6 kernel?
> 
> Yes，
> 
> $ git lg v6.6..HEAD  --oneline mm/vmalloc.c
> * 86fee542f145 mm: vmalloc: ensure vmap_block is initialised before adding
> to queue
> * f459a0b59f7c mm/vmalloc: fix page mapping if vm_area_alloc_pages() with
> high order fallback to order 0
> * 0be7a82c2555 mm: vmalloc: fix lockdep warning
> * 58b99a00d0a0 mm/vmalloc: eliminated the lock contention from twice to once
> * 2c549aa32fa0 mm: vmalloc: check if a hash-index is in cpu_possible_mask
> * 0bc6d608b445 mm: fix incorrect vbq reference in purge_fragmented_block
> * 450f8c5270df mm/vmalloc: fix vmalloc which may return null if called with
> __GFP_NOFAIL
> * 2ea2bf4a18c3 mm: vmalloc: bail out early in find_vmap_area() if vmap is
> not init
> * bde74a3e8a71 mm/vmalloc: fix return value of vb_alloc if size is 0
> * 8c620d05b7c3 mm: vmalloc: refactor vmalloc_dump_obj() function
> * b0c8281703b8 mm: vmalloc: improve description of vmap node layer
> * ecc3f0bf5c5a mm: vmalloc: add a shrinker to drain vmap pools
> * dd89a137f483 mm: vmalloc: set nr_nodes based on CPUs in a system
> * 8e63c98d86f6 mm: vmalloc: support multiple nodes in vmallocinfo
> * cc32683cef48 mm: vmalloc: support multiple nodes in vread_iter
> * 54d5ce65633d mm: vmalloc: add a scan area of VA only once
> * ee9c199fb859 mm: vmalloc: offload free_vmap_area_lock lock
> * c2c272d78b5a mm: vmalloc: remove global purge_vmap_area_root rb-tree
> * c9b39e3ffa86 mm/vmalloc: remove vmap_area_list
> * 091d2493d15f mm: vmalloc: remove global vmap_area_root rb-tree
> * 53f06cc34bac mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
> * bf24196d9ab9 mm: vmalloc: rename adjust_va_to_fit_type() function
> * 6e9c94401e34 mm: vmalloc: add va_alloc() helper
> * ae528eb14e9a mm: Introduce vmap_page_range() to map pages in PCI address
> space
> * e1dbcfaa1854 mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
> * d3a24e7a01c4 mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
> * fc9813220585 mm/vmalloc: fix the unchecked dereference warning in
> vread_iter()
> * a52e0157837e ascend: export interfaces required by ascend drivers
> * 9b1283f2bec2 mm/vmalloc: Extend vmalloc usage about hugepage
>
Thank you. Then you have tons of copy_to_iter/copy_from_iter calls
during your test case. Per each you need to find an area which might
be really heavy.

How many CPUs in a system you have?

--
Uladzislau Rezki
