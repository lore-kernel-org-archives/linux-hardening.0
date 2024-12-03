Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFAE1F4261
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 14:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235611; cv=none; b=Xw+QMlCCDUy6VmK7exTogeX45fxy94uJ7UEUA4yRjtZ+ciMT52AUFV0IoWxDXACqOqTfegw2QfprDp5LeaTilTxsbKly3IfScbCy3JLt8b6Fcs7tdb5dz3OQOM3RL8F+3W8NXFkJ5tDJckcrby6p+MsATgrO0eS+/649eiUOqtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235611; c=relaxed/simple;
	bh=hhSIJQNmk13QFdLa8IZsDUNEp2qxYkTEwh7DFwREPQs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ7j9CtBKXCdLBFbGlvx7jpjX7bU1v5kE9iZocmcv7v4o2fXwOIfa79yXMN0Pg/e7ePNmezQYkwdp7goIiTkG5K1gm0RnB9slljm87VFk+Kyv0E/tTNcm479aAeFsjUFwwwd2R7B6zjm42GGBLsDlM52mpBU8PipmTzy1+/73sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPvzUicF; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPvzUicF"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso53401251fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 06:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733235608; x=1733840408; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IxXMiFUbeGDlhh4meUiARNNY1McnaisHCDkS3C8CP0E=;
        b=TPvzUicFsPoQTzOLdg4Cq8I3ERBPVLCYjA8y+ff7dP7RY8vfSSct99dngv4LTqFWi+
         bM/Y04pNxfkHoWWgoNU7e7D2W/ciiR88lMsYeVgINzXxGXiUzUYLrHVferXIy6i+UKwy
         YHWqa6GwNT3s2SUccfFSibc4r/WJl1kHkEKoldFbToTldYUnn2OeLYN9hQQaShpNypq0
         ulqmoasbWlJzZsxlNBQZzhMm9rRcOwn4Vz8JPnMNm9Y0EB7WCzbQawGCMot/uJXLUo+3
         o+mU5pxUPf36KQu50kaSO+ADjMfigcQvuzf1oiL+xu7JmjxrnJ7ECJXcxv5ZZ0fGsIAi
         67CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235608; x=1733840408;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IxXMiFUbeGDlhh4meUiARNNY1McnaisHCDkS3C8CP0E=;
        b=XdMXNh27hSyAWPHj32cKKy6Y/6psU6XqirpfH59cCs28tcP6RBZHM+P/bd+I1jf3Cf
         dWsxr9jwlzks14XIUnHl20mWCbTO6B/p2/t7X/rWZC4bPDeBkv5BBTEN4OduWgMVTOJf
         R35JvR86NIkLNKRkXj7YldFD2gQiKDwtsH5QNd/TN1wNKD+c94x8IczZghAesasxso5s
         MwO0UDl//w1GsqSgH0wvpMu6cEiXsVOA+i/pHpj9OgBsXMk1cvIxeNPmYFurTSb309aN
         cUB5UnNLChgELsf3yBVwablCRtAeyxl1fcixHpMyzg2HHWzgYJ4EGEvJCnloAbfdkad2
         H2BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtHqTkEKNLI0F3fVJ4ltJgWUz6xNdd8jZyImmMKEGP/t6bxO++FZSzzqIjpBixkW5eDFDgNSKslOit4uRwDls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzggr9aBPd/IMZ4VXfQTz7v0zneo4gc4b4h7hWwYno50WS51u3z
	ABf4R/NVFs8vqQWiGMV5oZxG/Q9wQUrGDyx/86sgBI1GPpXIvr3X
X-Gm-Gg: ASbGncvwnFzZOsRW/AdB67RaEjIWLCj8x4H9UtN6dBhud3xkd8jaD85jtktnfnun8k3
	BcCCiZIEO7JScD1xDrHefbMOGSXGn9uA6RvZ15np/kFOT1uuEPdjtWKaZ0sOhcYq6RR4OPh4rei
	BDfqGYzfWuut1fuLNLe1ZNaCsN1cM1COvQWjmfeUe8f7o3ECiNMwWu7zW6xSwXDyTUoXV18exv8
	/W5vqblOlZCjbUjSkYJUYiC3ytxcgIE12TH8Ecaz0MZoNEON4Ano7e5KgDouZfzOn9V2f13Qwo=
X-Google-Smtp-Source: AGHT+IGvdFMh/iLtI3s+dK/8lWWRm6FQvNy2z6QuDSRypjS+I2ayglfe85Q5HSAFObwEMYHS/pFcUA==
X-Received: by 2002:a05:651c:198d:b0:2ff:d5c3:61b3 with SMTP id 38308e7fff4ca-30009c0fb08mr17160711fa.6.1733235607541;
        Tue, 03 Dec 2024 06:20:07 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca133asm16501831fa.107.2024.12.03.06.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:20:06 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 3 Dec 2024 15:20:04 +0100
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, zuoze <zuoze1@huawei.com>,
	Matthew Wilcox <willy@infradead.org>, gustavoars@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, keescook@chromium.org
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z08TlFqWVWs47g9z@pc636>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
 <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
 <dd3f0a9f-ec3c-46c3-8231-2022b67094a6@huawei.com>
 <Z08KAupLBo--JGz8@pc636>
 <76995749-1c2e-4f78-9aac-a4bff4b8097f@huawei.com>
 <Z08M88NdLfugqhu9@pc636>
 <d659d925-a322-4566-955a-97894a2aa795@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d659d925-a322-4566-955a-97894a2aa795@huawei.com>

On Tue, Dec 03, 2024 at 10:10:26PM +0800, Kefeng Wang wrote:
> 
> 
> On 2024/12/3 21:51, Uladzislau Rezki wrote:
> > On Tue, Dec 03, 2024 at 09:45:09PM +0800, Kefeng Wang wrote:
> > > 
> > > 
> > > On 2024/12/3 21:39, Uladzislau Rezki wrote:
> > > > On Tue, Dec 03, 2024 at 09:30:09PM +0800, Kefeng Wang wrote:
> > > > > 
> > > > > 
> > > > > On 2024/12/3 21:10, zuoze wrote:
> > > > > > 
> > > > > > 
> > > > > > 在 2024/12/3 20:39, Uladzislau Rezki 写道:
> > > > > > > On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
> > > > > > > > We have implemented host-guest communication based on the TUN device
> > > > > > > > using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
> > > > > > > > and the operating system is based on the 6.6 LTS version with kernel
> > > > > > > > version 6.6. The specific stack for hotspot collection is as follows:
> > > > > > > > 
> > > > > > > > -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
> > > > > > > >       - ret_from_fork
> > > > > > > >          - 99.99% vhost_task_fn
> > > > > > > >             - 99.98% 0xffffdc59f619876c
> > > > > > > >                - 98.99% handle_rx_kick
> > > > > > > >                   - 98.94% handle_rx
> > > > > > > >                      - 94.92% tun_recvmsg
> > > > > > > >                         - 94.76% tun_do_read
> > > > > > > >                            - 94.62% tun_put_user_xdp_zc
> > > > > > > >                               - 63.53% __check_object_size
> > > > > > > >                                  - 63.49% __check_object_size.part.0
> > > > > > > >                                       find_vmap_area
> > > > > > > >                               - 30.02% _copy_to_iter
> > > > > > > >                                    __arch_copy_to_user
> > > > > > > >                      - 2.27% get_rx_bufs
> > > > > > > >                         - 2.12% vhost_get_vq_desc
> > > > > > > >                              1.49% __arch_copy_from_user
> > > > > > > >                      - 0.89% peek_head_len
> > > > > > > >                           0.54% xsk_tx_peek_desc
> > > > > > > >                      - 0.68% vhost_add_used_and_signal_n
> > > > > > > >                         - 0.53% eventfd_signal
> > > > > > > >                              eventfd_signal_mask
> > > > > > > >                - 0.94% handle_tx_kick
> > > > > > > >                   - 0.94% handle_tx
> > > > > > > >                      - handle_tx_copy
> > > > > > > >                         - 0.59% vhost_tx_batch.constprop.0
> > > > > > > >                              0.52% tun_sendmsg
> > > > > > > > 
> > > > > > > > It can be observed that most of the overhead is concentrated in the
> > > > > > > > find_vmap_area function.
> > > > > > > > 
> ...
> > > 
> > Thank you. Then you have tons of copy_to_iter/copy_from_iter calls
> > during your test case. Per each you need to find an area which might
> > be really heavy.
> 
> Exactly, no vmalloc check before 0aef499f3172 （"mm/usercopy: Detect vmalloc
> overruns"), so no burden in find_vmap_area in old kernel.
> 
Yep. It will slow down for sure.

> > 
> > How many CPUs in a system you have?
> > 
> 
> 128 core
OK. Just in case, do you see in a boot log something like:

"Failed to allocate an array. Disable a node layer"

Thanks!

--
Uladzislau Rezki
