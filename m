Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE41E47C1
	for <linux-hardening@vger.kernel.org>; Tue,  3 Dec 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229574; cv=none; b=jIRR1usclvteDhKGWOHd/S07EIaPkgKiMR34m+R+syiXHcW76V1fT/qhFgxnlpQEDmkm/VJiJrXMKkXlMNEH/zFycNRB7g2PQ5Jez0uYuVC3cCRQonQO0S+36bVoHl/SidcUVN+Xu0wevhJopAiFOlc1XcO8h3Ys9XPSAMjrAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229574; c=relaxed/simple;
	bh=4q69o57vD9ZO2a9PADoVx5HyiA8Xu8fDEcCVWJiotZA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwpVrZkkbqkg4rnwxGNu/9ORlZ2OL+oCxs17bHAZaZlknATTuMMEedjOtzJVKFv7I5xpSd5keR/jzaXu+fH6JmSDCOShww6+w4+v1n1aTpP5RTm+gkTkeTH1aGKJdZAYJpv3JiUM5Xy6JZ3GN3eQrIeDbyjvtNQZ322e5u66Hhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPFIQ87L; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPFIQ87L"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df7f6a133so5761344e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 03 Dec 2024 04:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733229571; x=1733834371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vFxhjwEQHKpTIm6rgKkVijYZ+fIksPXhashUraPYMs4=;
        b=QPFIQ87L7taQcT6xx5Bs5AjTP8TwO+RFTKb2lr1oUe/tMomlOFnwMimHZ54wpZlxzc
         XNrsPtpDpxn19CRliKZXrRKaCFGaJ4YxYTHJWarjeLKj3b0ma5cobCNSAkOUPSI+Iamu
         KgvqFdj6uUBa4vsHnmgvCCzCVCiXA9abH17wpFCE+UcmN49NIMJwMHyxyS838tYZP8xI
         yHU4yv06E/hf2F7kx1SJflmtRpdE3V4MkeCnhPTeuCFXvtebMx9pzxfC0U0uFL6JY+qE
         4rijXdaTRRUba1CxlrvUMLW3JwBtabxF4KHFvSuWlB/tFD9VNWzBlAfwYESNJeBaFBnK
         WGAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733229571; x=1733834371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vFxhjwEQHKpTIm6rgKkVijYZ+fIksPXhashUraPYMs4=;
        b=o1Y9q8DYjv8RsqHPDC/kMncceYwDdkOtMTYgerqDL8rN1tGj/jLYjJbAYm0WAiPoQd
         jIeXfbsb35V/BPFZlsZl8iZW5bPAhgKMyAbQf6vXiECdLlvCj5UMkvsAuhhD4J/bXoSH
         jxR63IiM70eRSnpSidu8fP1Dy+5ZtIJqdd2JEt7QUe63lhBR59FiYus0sBnDig6n7kuQ
         PbF5wvUEE4TGl0UrmdxFaoCCMB4fzLViQ84pgPGVY7N/VNjCyyM37eKA2kQbIjCkvx96
         mPztqRvC3/AsI8loZyyNMSfIUcTpciTyaWjSRmu85ynUQSqpo5+lNJdAlxt66iENopaW
         B0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVcN6bSTNESTQkHHJs8zLwJuzlS99MF3xmkw2AVyooG44JPuBD7nz5Fk0QCd40XDL9pQWpH95eYrc24ST2cfJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdxmQUjr1TpOxdoH16uc1EChHG1W1OsLoNgYuAjT8donuCFc3
	yfgIzzMAlfUBUHCnvD022mN2YQHD3fVt6+4kotvrPNRvuiAMzdq0
X-Gm-Gg: ASbGncun3HUzKGUcyFj8rVcmrZbTelZXfPvNGWNIsqLvh4MpHj6Q6je4P3ldmOasAtF
	2RpT5rQE8pq4ijeOhTG9/m2yCLb9BqezFVd1T/m60UgEcK/y7DVJDIHhSBzVCQrR045QD7HWFhY
	j42bUIhbRXX6PnaK6u8seeMmfv3aI0zKoazsy+eGgwIT8tIPiwCEXX4Oyynz/DQfChLYd2HsDd3
	o6pyXVveRUZHtxwPsOPEMw7xh5f6qltLXiFLbnbyE+ZtUpAAge4YeiqbdZTs+U1mYzrxs00Oqc=
X-Google-Smtp-Source: AGHT+IG4MHL45fco/5PoB5PtaDieZUaMWK7lUgxPDf8A/Dg54zXVJYTct2xEw4EFK53rcuwMXwKhKw==
X-Received: by 2002:a05:6512:b12:b0:536:56d8:24b4 with SMTP id 2adb3069b0e04-53e129ed0efmr1319398e87.5.1733229570525;
        Tue, 03 Dec 2024 04:39:30 -0800 (PST)
Received: from pc636 (host-95-203-13-87.mobileonline.telia.com. [95.203.13.87])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e1ac98755sm65921e87.74.2024.12.03.04.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 04:39:29 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 3 Dec 2024 13:39:27 +0100
To: zuoze <zuoze1@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, gustavoars@kernel.org,
	akpm@linux-foundation.org, linux-hardening@vger.kernel.org,
	linux-mm@kvack.org, keescook@chromium.org, urezki@gmail.com,
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH -next] mm: usercopy: add a debugfs interface to bypass
 the vmalloc check.
Message-ID: <Z077_8rNvTGrCb8L@pc636>
References: <20241203023159.219355-1-zuoze1@huawei.com>
 <Z06FAoq59x07-hoN@casper.infradead.org>
 <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57f9eca2-effc-3a9f-932b-fd37ae6d0f87@huawei.com>

On Tue, Dec 03, 2024 at 07:23:44PM +0800, zuoze wrote:
> We have implemented host-guest communication based on the TUN device
> using XSK[1]. The hardware is a Kunpeng 920 machine (ARM architecture),
> and the operating system is based on the 6.6 LTS version with kernel
> version 6.6. The specific stack for hotspot collection is as follows:
> 
> -  100.00%     0.00%  vhost-12384  [unknown]      [k] 0000000000000000
>    - ret_from_fork
>       - 99.99% vhost_task_fn
>          - 99.98% 0xffffdc59f619876c
>             - 98.99% handle_rx_kick
>                - 98.94% handle_rx
>                   - 94.92% tun_recvmsg
>                      - 94.76% tun_do_read
>                         - 94.62% tun_put_user_xdp_zc
>                            - 63.53% __check_object_size
>                               - 63.49% __check_object_size.part.0
>                                    find_vmap_area
>                            - 30.02% _copy_to_iter
>                                 __arch_copy_to_user
>                   - 2.27% get_rx_bufs
>                      - 2.12% vhost_get_vq_desc
>                           1.49% __arch_copy_from_user
>                   - 0.89% peek_head_len
>                        0.54% xsk_tx_peek_desc
>                   - 0.68% vhost_add_used_and_signal_n
>                      - 0.53% eventfd_signal
>                           eventfd_signal_mask
>             - 0.94% handle_tx_kick
>                - 0.94% handle_tx
>                   - handle_tx_copy
>                      - 0.59% vhost_tx_batch.constprop.0
>                           0.52% tun_sendmsg
> 
> It can be observed that most of the overhead is concentrated in the
> find_vmap_area function.
> 
I see. Yes, it is pretty contented, since you run the v6.6 kernel. There
was a work that tends to improve it to mitigate a vmap lock contention.
See it here: https://lwn.net/Articles/956590/

The work was taken in the v6.9 kernel:

<snip>
commit 38f6b9af04c4b79f81b3c2a0f76d1de94b78d7bc
Author: Uladzislau Rezki (Sony) <urezki@gmail.com>
Date:   Tue Jan 2 19:46:23 2024 +0100

    mm: vmalloc: add va_alloc() helper

    Patch series "Mitigate a vmap lock contention", v3.

    1. Motivation
...
<snip>

Could you please try the v6.9 kernel on your setup?

How to solve it, probably, it can be back-ported to the v6.6 kernel. 

Thanks!

--
Uladzislau Rezki
