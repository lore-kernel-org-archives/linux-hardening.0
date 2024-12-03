Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2021E32CB
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 13:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233161; cv=none; b=As2uEJttnZ9AoPEQXzXe9sbxFpgPGtoVW2ucXyIFANnFSQSoiuCt3A8RKn+IZKu7X37vfWIN/0sNPgMjT6Z0aHVsrp0VjG9g03xtKtD61nQQ86U1Nx35jBGZXxK0YVAmz+BMoxbDX27S3/im7vkdlp4QXtx8yfdZqzcS6yfxpkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233161; c=relaxed/simple;
	bh=v6qFgIiHcV1VDR+NEMSaewhxMbo4/MJ55IAep5xQExY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOzwgu3hKYbcNqeEu7pGuNONBEH5dLf5aQgowHX7gRdB5A4NV5HEB5r8ium6tNf42ETF5SjPBN+04Zv0nBVPabmESpUwxHNt4lFA/m8vGECcziw/tRklQbC4nI6U/Rh86A0oQgmOfOf1NIoUE9QzAL3h7fIOvHMoVBzrbuHW9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COOnRTTN; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COOnRTTN"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso6492746e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 05:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733233157; x=1733837957; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nsXC+tBl68LL521BM7Yb2saeVBRmerDcwFzutaDm/o4=;
        b=COOnRTTNFbNb9R03g9p2fCYaJGZRovpRuGJ+EpMRkYo8hxAJkuBX5H4UeWtDkUzbip
         TT5Wft+aEX0BBXEu4oNrEP68lggQQhyRQyhbWWfFt23KRYRPdY7S9/OZCJgWN1hDciqN
         QQ5BZh89vWs+gbZnaS/KM8dfCoo+k1dAOuBnmvy0BCHdQB1deOeWYuR9M+0LDwPb88cR
         hMssdTBoCf2T1fpspFCJFwF+GV4RolHpsYEwfz8DLr2018sBUwr3MiA3mpZ93lTBULyS
         KCpuehcUNvyGPOwgTSYooZI9aGBCY33yX6EEWtjvRDY/xF003ya60cZEsKtaH+3f4IVG
         MVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233157; x=1733837957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsXC+tBl68LL521BM7Yb2saeVBRmerDcwFzutaDm/o4=;
        b=UCnhbCga/3xtYFxzEtrtoE0lWtH2SN0DOMLm7e/Eew8dHfsV7ZMdsh7pFa0q3zTpGs
         hUbQJw95evUKM2LBlW2pE8vI+LmGOAzYkXK+2dInIFnW2ur0/bo1VRsOX2nm25jycZNp
         0E0HCfb//5RTcESUmknbe8l5dbYZT90ICU+dnY2G1SI/qXXx/0JO0bbsdgQ0EpD9NcGK
         ZYOkW5rQmbX9Jd4S9wHqOdHtVvyQejgbxlTPMoZsJ6iIaVAn5pjWJo1LVRsBq3OiJKWA
         AJ0cH4FwT7jNxSCtXd7z5LCbv0uO4Woca10H9mLDyB0flxHACAN8YNV2AB2sF8mugJ++
         hfIA==
X-Forwarded-Encrypted: i=1; AJvYcCXXrgaafC/79H6E4sF3zhd8P/FM02CJHmS/lnkWa2o/+BGkFAsJnDGGQ2GMuhcRIg7JSUAtnMHWQ9K4m+Wu918=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweg7HL74Ytca/fEOokkLAxv4QijKtzM7FG2BhcEEdF6Lh6SdsV
	vQ2ueeqRD9c6un2fmb0PMVXR0ZpqCdzRk1inqLAek1TNIFVUyILA
X-Gm-Gg: ASbGncuUnrZqwo84hqNL8Mn0iF3Hw5+hHclw4js4fQbX3S+dGE9eRMbAJsNSDm4uyGt
	dchyMuFRLMnJI3ueorcUSeYT131HZid1Tc2LxaTmhdQdeBVquDkwPgWxeyL1hAS3goxjl1yeeUe
	w/7r9XuJXCcqtnNnlPA/loicdWoR/ih3jbJdwnInapTSFAPmsKNJwzuMm4InpEryB9ajxOS3Vmj
	ZgcN4SxTfNayLmC21XvBO3khIHfV7L0XSlrR/zCsGNJkX1EHKPG/l72dV5EeP4Osry+b9plrQs=
X-Google-Smtp-Source: AGHT+IFiNea8noRxLx0ybm43E6g5REpoL8P/YyW8t9MOua+uWQAdXbMKpaDuFKTwtpdgb8e32gaI0g==
X-Received: by 2002:a05:6512:6d6:b0:53d:ed2f:fab0 with SMTP id 2adb3069b0e04-53e129ef19bmr1789639e87.9.1733233157095;
        Tue, 03 Dec 2024 05:39:17 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df649f6dcsm1826140e87.243.2024.12.03.05.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:39:16 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 3 Dec 2024 14:39:14 +0100
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: zuoze <zuoze1@huawei.com>, Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, gustavoars@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z08KAupLBo--JGz8@pc636>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
 <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>

On Tue, Dec 03, 2024 at 09:30:09PM +0800, Kefeng Wang wrote:
> 
> 
> On 2024/12/3 21:10, zuoze wrote:
> > 
> > 
> > 在 2024/12/3 20:39, Uladzislau Rezki 写道:
> > > On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
> > > > We have implemented host-guest communication based on the TUN device
> > > > using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
> > > > and the operating system is based on the 6.6 LTS version with kernel
> > > > version 6.6. The specific stack for hotspot collection is as follows:
> > > > 
> > > > -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
> > > >     - ret_from_fork
> > > >        - 99.99% vhost_task_fn
> > > >           - 99.98% 0xffffdc59f619876c
> > > >              - 98.99% handle_rx_kick
> > > >                 - 98.94% handle_rx
> > > >                    - 94.92% tun_recvmsg
> > > >                       - 94.76% tun_do_read
> > > >                          - 94.62% tun_put_user_xdp_zc
> > > >                             - 63.53% __check_object_size
> > > >                                - 63.49% __check_object_size.part.0
> > > >                                     find_vmap_area
> > > >                             - 30.02% _copy_to_iter
> > > >                                  __arch_copy_to_user
> > > >                    - 2.27% get_rx_bufs
> > > >                       - 2.12% vhost_get_vq_desc
> > > >                            1.49% __arch_copy_from_user
> > > >                    - 0.89% peek_head_len
> > > >                         0.54% xsk_tx_peek_desc
> > > >                    - 0.68% vhost_add_used_and_signal_n
> > > >                       - 0.53% eventfd_signal
> > > >                            eventfd_signal_mask
> > > >              - 0.94% handle_tx_kick
> > > >                 - 0.94% handle_tx
> > > >                    - handle_tx_copy
> > > >                       - 0.59% vhost_tx_batch.constprop.0
> > > >                            0.52% tun_sendmsg
> > > > 
> > > > It can be observed that most of the overhead is concentrated in the
> > > > find_vmap_area function.
> > > > 
> > > I see. Yes, it is pretty contented, since you run the v6.6 kernel. There
> > > was a work that tends to improve it to mitigate a vmap lock contention.
> > > See it here: https://lwn.net/Articles/956590/
> > > 
> > > The work was taken in the v6.9 kernel:
> > > 
> > > <snip>
> > > commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
> > > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > Date:   Tue Jan 2 19:46:23 2024 +0100
> > > 
> > >      mm: vmalloc: add va_alloc() helper
> > > 
> > >      Patch series "Mitigate a vmap lock contention", v3.
> > > 
> > >      1. Motivation
> > > ...
> > > <snip>
> > > 
> > > Could you please try the v6.9 kernel on your setup?
> > > 
> > > How to solve it, probably, it can be back-ported to the v6.6 kernel.
> > 
> > All the vmalloc-related optimizations have already been merged into 6.6,
> > including the set of optimization patches you suggested. Thank you very
> > much for your input.
> > 
> 
> It is unclear, we have backported the vmalloc optimization into our 6.6
> kernel before, so the above stack already with those patches and even
> with those optimization, the find_vmap_area() is still the hotpots.
> 
> 
Could you please check that all below patches are in your v6.6 kernel?


<snip>
commit 8be4d46e12af32342569840d958272dbb3be3f4c
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Jan 24 19:09:20 2024 +0100

    mm: vmalloc: refactor vmalloc_dump_obj() function

commit 15e02a39fb6b43f37100563c6a246252d5d1e6da
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Wed Jan 24 19:09:19 2024 +0100

    mm: vmalloc: improve description of vmap node layer

commit 7679ba6b36dbb300b757b672d6a32a606499e14b
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:33 2024 +0100

    mm: vmalloc: add a shrinker to drain vmap pools

commit 8f33a2ff307248c3e55a7696f60b3658b28edb57
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:32 2024 +0100

    mm: vmalloc: set nr_nodes based on CPUs in a system

commit 8e1d743f2c2671aa54f6f91a2b33823f92512870
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:31 2024 +0100

    mm: vmalloc: support multiple nodes in vmallocinfo

commit 53becf32aec1c8049b854f0c31a11df5ed75df6f
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:30 2024 +0100

    mm: vmalloc: support multiple nodes in vread_iter

commit 96aa8437d169b8e030a98e2b74fd9a8ee9d3be7e
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Fri Feb 2 20:06:28 2024 +0100

    mm: vmalloc: add a scan area of VA only once

commit 72210662c5a2b6005f6daea7fe293a0dc573e1a5
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:29 2024 +0100

    mm: vmalloc: offload free_vmap_area_lock lock

commit 282631cb2447318e2a55b41a665dbe8571c46d70
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:28 2024 +0100

    mm: vmalloc: remove global purge_vmap_area_root rb-tree

commit 55c49fee57af99f3c663e69dedc5b85e691bbe50
Author: Baoquan He <bhe@redhat.com>
Date:   Tue Jan 2 19:46:27 2024 +0100

    mm/vmalloc: remove vmap_area_list

commit d093602919ad5908532142a048539800fa94a0d1
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:26 2024 +0100

    mm: vmalloc: remove global vmap_area_root rb-tree

commit 7fa8cee003166ef6db0bba70d610dbf173543811
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:25 2024 +0100

    mm: vmalloc: move vmap_init_free_space() down in vmalloc.c


commit 5b75b8e1b9040b34f43809b1948eaa4e83e39112
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:24 2024 +0100

    mm: vmalloc: rename adjust_va_to_fit_type() function


commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:23 2024 +0100

    mm: vmalloc: add va_alloc() helper
<snip>

Thank you!

--
Uladzislau Rezki
