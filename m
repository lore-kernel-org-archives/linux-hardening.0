Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851924;
	b=hI1eH3M9thxV0Oo2QLKlRDXCdHuFH9rezYPmmXKpzXM1nwTWdY2fhhA8wCkNqyu4pZKi
	 AyaUcmXEBj5sg2ptEeHc3lhKYQ7KESYU9X0fQ6Ef9ENx/5r8oZJCNU52UTdotXRkshdll
	 F5MOC37NIk3EIksd/jfz7l7A4zjzgDVpUUgc4+7VyGbfIdEZygu07/JhNDGlqCqZwK/FX
	 7f/Y0/y1/7kWqgUonrwm53vlMLYVO7u0007K5Q1Oa5mBVVEVGabrGWeT0ucu5ug/GEg9a
	 qZZLKBNAq9i/pSAyMfP96zHtjdgzZnBqwuMVeSXV0/755Sm+4u23O62mT7j9qSbKxcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PvDPwRq8GAh/t3oB1kQXSCGMwADwrNJEuUFh0I6qC50=;
	b=bfzEFgM7cb8OFjytkAJfttjuS89DrxTVQw5kgStQVhkxlHxXPPY6hjr+d2aeIYGcH0tD
	 SA5Awh6scTUG51DXfO3WJdknU9dlGFIVgavfu/3wpNHY8YrtNkz7lxdw6eiv9AOeIVRop
	 R+2yQfboxQjBybQpBtjeLaH+UBDvv2RGbI4aTTWKs7izOFmrd5ZOxIBmP5QMKp1pvcarM
	 TKkyILNC1vsFLJdGMLG7PrfQWxwdj/hp3kKkLuVcUq6NSbTiU1nB3p4NnvyCaF56ovofr
	 pbfA0WJxMQoiLHOATREC1yw208xN4v7DWvSrDV+TZYQlu+nZCg8dUUecqe8qNOB/P3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="estmKI2/";
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A335F606A31C
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 07:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A335F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=estmKI2/
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-385c497bf94so9684623eec.1
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 23:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795851923; x=1796456723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PvDPwRq8GAh/t3oB1kQXSCGMwADwrNJEuUFh0I6qC50=;
        b=estmKI2/Je+0ZF5XWrFZEGp2YpgwykMpcxeX38GmVypCWFASEa9hoFypIvfmIJYSnw
         6smocHz5iokydiXWZXuE7530lM7lqt75TOpc1ryPDmWroBlWxLILPzewYIdyKZweAYtE
         KZy18phuqxMNPs82wDHzMR8QxKS7JBekWAYOuxovjgjmpZ3OU0CW0ctPxc4IYp66mLwv
         rLcZo13JREPJv4Ws7fHpWIZJAsZyDeH52grgCePfwvZ3LZYsWZyNd0u6YmvBeTGoZYmX
         PMczF4txpa4XBHkwCHvLrU+8mXw1YlzBNlhPr20Q/u00/7B0YEPEm65Af05nPxp/CoQt
         f4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795851923; x=1796456723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PvDPwRq8GAh/t3oB1kQXSCGMwADwrNJEuUFh0I6qC50=;
        b=fd1LlDpeb6w0WITqpvoTe8rNbZJH5a+1xhhSojMMakGlq7+kw6Pp/ZsY7E8q2DhWBu
         4Sa0l8S2heaMra8O+J9HavI4RijRp00D773C1GwLBjeEY5Rd6fVyoeSDZQUyCHiuGRBO
         +02ELp2gd6OC6swXIQrKI2KiM9D35rCzciYJ3kYgZ6rk3n3y3kuMU4N0ewQT+j+dJJzz
         aL5w3R+AP6kiDvV3d92Ul3M0YjtXhmEfCB2HUTrbE+4tJoxwRqqsz+RKaX0Dh3YgrtLX
         jHnF2SkZbJwYcMe564ZxmI0RWzoWi6kxHWarVquV0jMJSN2wsoWt3xbRvJNoDlZbmLF6
         1YYw==
X-Forwarded-Encrypted: i=1; AL+hErEf+xh+l4k91hkkyYtz21VOk5a7EunhZA3ceQjOJhqng0uzJ77thIqnNtHm19ewP6/TgS9YNwlheCek4FWjf+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qG0EarYt6YWOu++b33i5FvGhj3dVz4/J1mJAt3m4HPMYtX1bB
	REYeWILz+4u2NFbmmxIggUQD3tpsqzbH+BVyV/D+dAvdUJfjw9iw9HMA
X-Gm-Gg: AZFdTZcy6omTpNVSAw4lYwsNIgnBJjTmGkfm+lmNn1u5o2p19vUOSLRj577Paq3PQJk
	MRr32g16iYRJaHzD99UDjPzKxdM1+HNtJ9j40xTBPIVjSL+8vYDveXddCPu+OylWdp19rszMBE7
	obaByvgZc0Rwfz/NipGrCjksKgjax2+sHS0EnHw+6dZOyUcPQrEIGJVD9TN6sU7TSIwpylZPVMl
	vD0+kUiJ03TIr3yf3l1o9sOlwGQhbwzg2cKCXkXIFEY3T4HW9qZXoNIhy6GpEXn4EhRPawjWkic
	95DG2AwSiazVR3+r5o6fnUwpYvvvleWD647s4/M0sNGt3z6AZYdHAR1ziwvxu7sEMn1LLgOW3kg
	CcmlO+Bz9pOvQAPDwhkfRREy0Y8loNuw8cyYRMLbRZ4hzIAMZKPShHOkL3bD1hyoDXu1Qeo5b5h
	KGJaWtfGoVn319TiAPJY25yancY6qL9pYgXGa4A2/kczwE4gMxY3HBOJpyvKzDTEUlNQ7eycmBe
	8fyIrW+47PBWshEjxGt3P2UMWE40n080u/4vdvUEyrlOIrxcx6o2EZ8ZVBpqKxVcNn8Mh+svWD2
	PMaDxKRCUMOqCHOXHqOnfzYF77Ont5I+Vgi5ZTbSWyB0XgIqqYiOXWQtF/lvDEBW+QOm
X-Received: by 2002:a05:7301:f02:b0:384:ce59:5e21 with SMTP id 5a478bee46e88-3856f6503d8mr25637676eec.32.1795851922626;
        Fri, 27 Nov 2026 23:45:22 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm72104322eec.20.2026.11.27.23.45.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:45:22 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Chris Li <chrisl@kernel.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 06/19] mm/swap: serialize swap publication before removing swapon mutex
Date: Sat, 28 Nov 2026 15:44:47 +0800
Message-ID: <20261128074459.34838-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbUYHBD+To2CGe9b5_zWbYVrYU6Mv-pxzhXEgB7r1DJrdg@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <030796dcb2086484f87e2250d9cf9a04fccf54ab.1795439990.git.lianux.mm@gmail.com> <CACePvbUYHBD+To2CGe9b5_zWbYVrYU6Mv-pxzhXEgB7r1DJrdg@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 26 Nov 2026 10:17:44 -0800 Chris Li <chrisl@kernel.org> wrote:

> The current commit message describes what changed. This is the most
> critical part of the locking change in this series; it deserves a
> better description of why this new locking protocol is safe to use.

Before this patch, /proc/swaps held swapon_mutex from ->start() to
->stop(). On swapon, the mutex covered publishing si->swap_file, while
swap_device_enable() separately took the write side of swapon_rwsem.

With this patch, swapon sets swap_file, resurrects si->users and makes
the device writable, in that order, in one writer section. /proc/swaps
holds the read side across the walk and skips entries with no swap_file.
On swapoff, the writer clears swap_file before the file is closed: a
reader that saw the file finishes before the writer can clear it, and
a later reader skips the entry.

That protects the proc reader, not all users or the whole teardown.
Users that don't take the rwsem still rely on the live reference;
swapoff kills it, waits for RCU and drains the references before
dismantling their state. I'll spell out those two guarantees in the
commit message.

> The function name can reflect that it is locked. Maybe
> __swap_device_enable_locked()

Great suggestion. I'll rename the helper to __swap_device_enable_locked()
in the next revision.

Thanks,
Lian
