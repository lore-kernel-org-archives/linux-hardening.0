Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851623;
	b=DOaysAzG7FFhfU2R6vq0Iw0S62DB3UxZNGN3/8AJstRTvIlEsRnOpTJ6aE9IpuiG76Qy
	 Na7fvYD1bK8P/SOvc3ihyvsvciuhmHzFtEvDhoaAVhytTEh9X9HqIt/YuBPktp+v/qUc4
	 Toi4vDlGuy40lwZ6VX9oXUcMa3jcOLbtdAJrD1HwcbvDmPzV+aMTsUQ38AFqSYJBqw1RQ
	 y/YIgpNs62rKcDQZswjUjcBgc7wKGXAuzMPHnkUHBW7PG23D0KfAieRttjrQbWLSYF0Pv
	 OmHZzAr4AWJbvbEvjQICe+OTRA4WyXhGCNH9n8VLrQ35WKl77iU4KC0xKGECk/VBgIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851623;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sWrlXEvllKA5pRtJLqxc6tJXfxKMf5ArtU7M3EbpoFc=;
	b=ldCPAznAGw4D2pS1tyFdzhZ8aFUAtL6fSZDvoS05xyDSoubI/CiATEv9+LXcYPireHCi
	 n9qeElJ2KuxWP60bSUKpzl59T+KqNMAddJEW8TMIg58XTyAR05qkMpMoPzcV6Eu3ZmFst
	 Wr9AFyeOOvdyZeHxO0/gziCoRTLKCACfRJIB1eiWYg5BWSnFkKhddhDp+1ifj3I2FA28s
	 UXR67dgj0gGJl2A6djzsqvJlRTXC1J1Litl2obbedJzY9Jjuq6hdLfDx2S3jJ7KdNpwoB
	 Z/bEJrG7xtijFcDEikiCMstZZ8vdsvvEth5IsN9e8X/Q4hbfbk0QO69MZW9YF0Jbd1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFIh3W8+;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011C606A31C
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 07:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E011C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DFIh3W8+
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2af4c8d00so10395502c88.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 23:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795851622; x=1796456422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sWrlXEvllKA5pRtJLqxc6tJXfxKMf5ArtU7M3EbpoFc=;
        b=DFIh3W8+kXLjYiv58MMtZtqP+rpHM7zi+P1jfsClK//1vz4QCgNdPqWmHCXJsNpgcT
         3iizt32sJnrU/flsacMl0bFtyFMYk5komOoIiqBKUzipY0aIU8WLxBimsYaA8LUeIMDh
         03t2Hh/dAFTkf2jxCsrbl2L58jaueelxUnxaMqURu+73UxYVcfkBrCymmindvxa67ojM
         09EBjCjzRvRG41LwIhigMeEV8znmy4PAsxlRkbQPM8d7sHQ7jQx143lfwtT2ISsLeDnQ
         6KORM6YgVC587swDPMQShaKg/j6J58VvrzLhYwtSIVW9mLDFgRcTU//UGSvd1bXEA2AQ
         rDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795851622; x=1796456422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sWrlXEvllKA5pRtJLqxc6tJXfxKMf5ArtU7M3EbpoFc=;
        b=KaCSzmqi5GINsNAVAN7IPYeMbRPRB3GtmgL6LRj17ucWtzFNNuFLqCm7fTG93Ks8KL
         DY3Nnni4dN8fKXHIyIrpewH7Zsi9Bzqc9aNIheGyjm/vIwscSA0o8v23ZURv1u94867U
         xeWY9DJG34h9dnMjLndBV+QGOb5luIPLuQ4Eo2KlrxbD4JCax5eDlpxkjjzR0ddWXi1f
         Wc+osFoyGtw0Ys+Rv1EoGueEFkWGYwErSFx3BFBUDzeeKO2/3W1xMvtYsalBvS4RWp2+
         LFLJKxCmGxohugMiGhWku/z/GnFXFcvGH6LhJzrJUEAW1pt24YGruNNGZquCjJOrMDr1
         vdhQ==
X-Forwarded-Encrypted: i=1; AL+hErGFqQYqjxdRekSSPPWdV3euUr6w6cMi1ITk2QtHsCaEfSpJZ8phhimyltwqeY7TMKCRDNm3MDkKWfT3IhxoPuM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+TqRLZKf2wFYOSejTR9SyxnKISex8KLFgo6QudSiBtL2rumtxk
	IgPGjc5L/4yV9Spda6DucEkbNEBfbf/P+sOqGzxxT5AKWtY+IC6L/R61
X-Gm-Gg: AZFdTZc98B+wenYAW55F/eUpno6q++4PCkgamHBoLM4P423R2C0x/HoihMMudf7Y4TQ
	adDHp46WrrBLi2juQfmS+SdPi7J3L1GmtYfdldZJ47AcXrxmMUNB60rb/BZQJNx0aWfr2dBChKi
	pkUsImWZYGwX2EV6P3nlvRFMcRLiDefKlBGU54l0yxFZBqiHIhtwg3tpsyM0wBTm1BL0/0d685I
	L47JoJFkZ+DU+A4/CcleumhSC93jKQybzIDg+ekk/hVdqCjVqP4/MXvMQHRMEghv67ms8UygkkB
	WeYRkkkyQDr42p5W6aa+8pisLb+bRIHaeIQtCxbSAdWzYLv5tBjbpxRHsWskydhQ94P9CmVF8p5
	0qRerDjSpPA9r8pp6UvIf/3znKEzIkA7PqOYsZ2pjLsBrSCFp6XLh1A1boqSjrzUaGkkHnyvR4d
	xbsD3OvAO/ywUmJCsHxWEvOV7z8fV4C/9e0Eg1wGvX3LnoXb9Y/VjEDtLsWDZGokA+p6sDJ9wHe
	TV4vWcUtXs+/ffML9k6fgx1AV9ue+oiIK5geAg5KM/0PPVHE+9EUWa1zuEbJkNzuZax105DdTIf
	5DSKxl9aDrDiAlD53Y2lxJ8WjckAFojO0/U57idG6gpT39sJ8+kX0yE1d1UCrT1Uqcir
X-Received: by 2002:a05:701a:ccdb:10b0:1b5:9b36:eb04 with SMTP id a92af1059eb24-1b59b36ebbfmr4118375c88.41.1795851621978;
        Fri, 27 Nov 2026 23:40:21 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm60591364c88.15.2026.11.27.23.40.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:40:21 -0800 (PST)
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
Subject: Re: [PATCH v5 05/19] mm/swap: change the swapon lock into a percpu rwsem
Date: Sat, 28 Nov 2026 15:39:51 +0800
Message-ID: <20261128074003.34128-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbWriHftZbyJMNfZ-09KuK0ZgSMwxEC2P5Rs_zGAknndwA@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <4f355219f202e5fce9e8dac7dee75f3ea7c51d4e.1795439990.git.lianux.mm@gmail.com> <CACePvbWriHftZbyJMNfZ-09KuK0ZgSMwxEC2P5Rs_zGAknndwA@mail.gmail.com>
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

On Thu, 26 Nov 2026 10:03:25 -0800 Chris Li <chrisl@kernel.org> wrote:

> This seems to describe a lock protocol change. Very naive question:
> Where is the matching code for that? I can only see the spinlock to
> precpu_rwsem change. Does this description belong to some later
> patches or state facts already existing in the current patches where
> there is no additional code change for it?

That's an existing rule, not a new protocol in this patch. On swapoff,
del_from_avail_list(si, true) already clears SWP_WRITEOK, sets the
off-list bit and unlinks the device under swap_avail_lock. What
changes here is the outer topology lock: readers such as si_swapinfo()
take the read side of swapon_rwsem, and topology updates take the
write side. It isn't until 11/19 that swap_alloc_entry() holds the
read side across device selection and cluster allocation. I'll make
that distinction in the commit message.

> I wonder if there is a way to forward declare it so we don't need to
> move the definition.

No new declaration is needed. I'll leave swap_info[], total_swap_pages
and nr_swap_pages where they were and just update the relevant lock
comments.

Thanks,
Lian
