Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E10224F0
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733232342; cv=none; b=Zh2bgb4ub9HAhAHUicSEA1oX0okPy8soQNgvlIsBYG+t11aj9TMtRb3mgVgR3LaGx3wd3WIAOgt5CH+xeSPzWc4l3+8aG9Hpj1F3oFnls/iGyS1X+/DMz8dj43DGlsTwYl9kEBcY295PuuEI9IM2SDGpYXhy8yBZB0wEr1YJY/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733232342; c=relaxed/simple;
	bh=9ggO8WNpDFhLF0r73KB5qOmksmkLKSzWopXVPs9cyKw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViDwrqLNobLKOl3H+XWOQxYulDLqKZ3dMnKMQZvfjaSI8InWZNLta611TBq/PuhykyL2E+bMlqS0Q4AKQwH8cjC78wz+gfwZYEYfH8LRl3sk8GpIN3heCMiKUTFM2300ws2mqAUZ9F/9HBo35NU0LWk5qxALKzIVqGIWb1F5GBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iETgmOq7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iETgmOq7"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffd6882dcbso43358571fa.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 05:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733232339; x=1733837139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zVR4tTaetOCSp6LEcvJ9nHP83elc5RNEVZ95fPAkdrQ=;
        b=iETgmOq7NVuSwMgBhVA0eIKjvJZ0TJ6U6jUxBxGPIY4Ks4R9Yku7881e81mb1g50Cu
         C0Id9m9JxbFurWoQFL2nqkASZrhmzVQBDfGZwpOfQzRiDHpqGPGUIeJwe3XCc9Glkx5W
         yWMiN7iUGJCArjMysx3Xiqrdv8vPo+kZZZGDxaS3Sb11yLAyUHPLrnq1xjsl6ss6WdLu
         6/ZZUo7PzeUk6rNIevu1uQ7ivn/hcYwbi77uzYptlespbcKDqYPPBLMgxGBTImCdnrwB
         H7sniSYNTTojiYm3N1Bg0BOFd6VUwHU4MnsV16/Po0i19NXx6Ow6Y5xj2Tll4oIW3qru
         hgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733232339; x=1733837139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVR4tTaetOCSp6LEcvJ9nHP83elc5RNEVZ95fPAkdrQ=;
        b=I1SYgcUbGPUA+JGMw8N97ldIbS/gUFSxijC6bVOGuIBVssbzkJphDlA7M+7q8s0N4z
         jrzD1lQ0+RUdzI9wems9mk2qYX+Sk05SJwbtqdKzt/VI2dcaBmS4sKj8u7vT5BKFbvVa
         SdobXlCGwZYCnoTZvxMnFKuuynF04DqrGtG7j3ha9gb+dghqoyEZx6vbzufDPSeyD2vK
         Yf7z2VPACWOTnGG6gNOV9HGQ0n+giTP48vrPtamqz1pxaFH1Nz5q06p66P5x1ViNVGa9
         7yUQxlKjZ62+RaTYS63WfYp/J5TqFGQbQzsWPd1Bey1kmBVCgz8OKC+6lv57TpRTupAC
         qZCw==
X-Forwarded-Encrypted: i=1; AJvYcCWBoGJU6mJUxth4QWi7qNwQcyY+ipEnpmzGsBv3UKY5y7rmu67OtOHaxFMRSAgvQja/c5qsMEWPt8WIPQr7Shs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeokvnm7R8I5/5ehSX6U0arCEAlY2M0Kb+QaaeSyfaiOTx6iE/
	Jg/RIffuKCyTmWHnpWI5ssY8rmYDoElAklldxsjQQW40bRbnacAX
X-Gm-Gg: ASbGnct5AoxTAQNbv2f08/BC+kU53t1iBSaB9k3fBw7imLwngneZlWa98wejpHwKlvj
	b25aA+gNxyAr5JMB3EyMEQWW6CtPgpo0OQ1DGOIMsWJ0NR6iiyuFUD5M71NOSc4Zof62JKRnv+5
	Y8m2lHKnAaW3+2C9/z+9mRimWB7o/Iw6rpzDoD/VIJhQhVzIsoPQ1m7hE4K1atpAwIQUw5sOOIR
	9If/mXSqvDT4ZhD+e/u3WDMlipK37pICnC+VSttwt/ZbVZ3tXCfN2JyLdU44HJ5sug2+zn0rBY=
X-Google-Smtp-Source: AGHT+IE7x1g7HJ509iRHUMOOdJCVlOyYF8QX+s7i7tJU2rZxM20grZvFX8lpvALpliHISfEMvLG12w==
X-Received: by 2002:a05:6512:2209:b0:53d:a264:f25a with SMTP id 2adb3069b0e04-53e1b8c11e5mr96105e87.47.1733232338790;
        Tue, 03 Dec 2024 05:25:38 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6443305sm1849828e87.79.2024.12.03.05.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:25:38 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 3 Dec 2024 14:25:35 +0100
To: zuoze <zuoze1@huawei.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, gustavoars@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, keescook@chromium.org,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z08Gz51WO8QFyVFo@pc636>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
 <Z077_8rNvTGrCb8L@pc636>
 <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92768fc4-4fe0-f74a-d61c-dde0eb64e2c0@huawei.com>

> > On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
> > > We have implemented host-guest communication based on the TUN device
> > > using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
> > > and the operating system is based on the 6.6 LTS version with kernel
> > > version 6.6. The specific stack for hotspot collection is as follows:
> > > 
> > > -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
> > >     - ret_from_fork
> > >        - 99.99% vhost_task_fn
> > >           - 99.98% 0xffffdc59f619876c
> > >              - 98.99% handle_rx_kick
> > >                 - 98.94% handle_rx
> > >                    - 94.92% tun_recvmsg
> > >                       - 94.76% tun_do_read
> > >                          - 94.62% tun_put_user_xdp_zc
> > >                             - 63.53% __check_object_size
> > >                                - 63.49% __check_object_size.part.0
> > >                                     find_vmap_area
> > >                             - 30.02% _copy_to_iter
> > >                                  __arch_copy_to_user
> > >                    - 2.27% get_rx_bufs
> > >                       - 2.12% vhost_get_vq_desc
> > >                            1.49% __arch_copy_from_user
> > >                    - 0.89% peek_head_len
> > >                         0.54% xsk_tx_peek_desc
> > >                    - 0.68% vhost_add_used_and_signal_n
> > >                       - 0.53% eventfd_signal
> > >                            eventfd_signal_mask
> > >              - 0.94% handle_tx_kick
> > >                 - 0.94% handle_tx
> > >                    - handle_tx_copy
> > >                       - 0.59% vhost_tx_batch.constprop.0
> > >                            0.52% tun_sendmsg
> > > 
> > > It can be observed that most of the overhead is concentrated in the
> > > find_vmap_area function.
> > > 
> > I see. Yes, it is pretty contented, since you run the v6.6 kernel. There
> > was a work that tends to improve it to mitigate a vmap lock contention.
> > See it here: https://lwn.net/Articles/956590/
> > 
> > The work was taken in the v6.9 kernel:
> > 
> > <snip>
> > commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
> > Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Date:   Tue Jan 2 19:46:23 2024 +0100
> > 
> >      mm: vmalloc: add va_alloc() helper
> > 
> >      Patch series "Mitigate a vmap lock contention", v3.
> > 
> >      1. Motivation
> > ...
> > <snip>
> > 
> > Could you please try the v6.9 kernel on your setup?
> > 
> > How to solve it, probably, it can be back-ported to the v6.6 kernel.
> 
> All the vmalloc-related optimizations have already been merged into 6.6,
> including the set of optimization patches you suggested. Thank you very
> much for your input.
> 
Do you mean that the perf-data that you posted to this email thread,
contains the: Patch series "Mitigate a vmap lock contention", v3. from the v6.9?

and you still see a high contention?

Thank you!

--
Uladzislau Rezki
