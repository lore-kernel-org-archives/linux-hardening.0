Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852641;
	b=R0YNm24rD5nHk2OdU9DMdvYzly2uWODWKFcMxmRAtwOgBqw9BiY6P4SXgpIoGlbThpUN
	 sZkeHU4nkC2lSAcneiK/rGDgJvrnvL5PrmHZv3vHXO88uZAtWiHjVp56OevCXmyxvjpeZ
	 s01CkjvkCnklst2VPIOmeRF7P86dhm4P+PYHjHzrxoGVDpN1df8zo2Lm+hF2p4wbBMzek
	 IvJFfb0FOke3gy3Zi6SaEATlYidg0IRxXONDp4EVemgVXwwPl+VJE99qvabfZWM+kj0C8
	 c7P6ZgvHR/WwYVobBftjf29DY5wCTrFLquMOUZeTrq1xFSbocPKkHu5svM2SBVi3amg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852641;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3YRc+oLAH9CSMjzqL5DaXtGZiCmjzwmhJmG8W8jBwCo=;
	b=ltG58b2KUKlYUEWrMOBGKBRYTGiDeQSO/wl5qCtNcSHAy5VUmyvZ5ZiDVAYsknck7hc0
	 f2bfzFFceU1Rv7nGjHeJYMyaZaBmGVjN5pkvTZjpCtK+2+Z/SjjSwVrgqjCLBHW067QuB
	 Bt203QL8vV/7L5jfNqdrCuOX1iFem/P81o9r3NzPZzKXkQ1w0L2sc1gfnNlM5ZAgHCril
	 umLlfPEpDg99e+45PZW3cdicCn+Db4MpoE/8W1B4Z8uwVqQY5mN0Q9FTCP75aSAhpzmqB
	 mbx1hiufueaRDI+F3LZmj5vRVDZdm4UORd6tXkRRkziLZfijuFXzJpMIpA8Plp2qjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mstEU8RA;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D227606A31C
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 07:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D227606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mstEU8RA
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-3866a784546so12254751eec.0
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 23:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795852641; x=1796457441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3YRc+oLAH9CSMjzqL5DaXtGZiCmjzwmhJmG8W8jBwCo=;
        b=mstEU8RA5nPzUW+HtM/x3MO7+YviSGCI0+a7bsHHrwCV+zfsDccIDgwjXCUn+yrTwZ
         WEmS+zV4K8REfZnNqJTAVeBVdNoe0rHLSP3QkNtQedI285RZ3E2ZbPPJZ+Canne5JHuG
         CMx6pZE98ZFGVKEJJWy/fT0gj4Y104a3Q/wCaNL/yAz7cj/D8clAbY7NmHk8gwjD+l1U
         yJaE0r/PAMebIwgr3daE1bHk5HDJP8z4SxrvAL9beQJkuamswrpKCwX2M5BoxyM9pDRa
         WwDz7Oe6XlBnCIBv6Bxvw0U3us1innr8k8j63UuNKyCBzAw8Ht6s55P4dsVQ+/J92jDi
         cGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795852641; x=1796457441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3YRc+oLAH9CSMjzqL5DaXtGZiCmjzwmhJmG8W8jBwCo=;
        b=c5CaarGekm8Lp9MJmaskR29U+Hktg9Q3Sd1c6vmQOx8mHywcl5E90t2Y0vyIOn0b1O
         ePJdczzY7oPxllAh3VJoqHOHuDxnW38kBgFfY+Pd2a9tRvYtG8jVa75JuA7psM+C0oN1
         aF0O6lQjupabpFCW0kP/sT4orwa70+1jgsgdA3BfArtvMl+BBynh6p21FJUMlAmEKkCH
         OzoUReLRC0eWfGeGIdkfGfPZ6bLmDb5KxZt3M1igqcxF07C9UF+4sgB4wgeNcIjzEadw
         bDg4GLlNUouOHLF+KI7f8jfjknLE9dHA/5Tt1ldCUwt7+N+/ZukUFObreC0VnW+icAAy
         Llcg==
X-Forwarded-Encrypted: i=1; AL+hErGPAlxpRIEpuD2wjsh4SgxzGN5SKfEXt+ytU2Ty/cr+No/19Chb3quaUWzBBy4jffzRodVOCQaEyAcBdxM2qNg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bt5Eic7QHhL/imB8NyNjx3fGoEfPZp0Z6QESU5kiNyqb83B7Z
	lvbSLQISkdBR+jJOsdKQWM4tryz1NqY64i6HeM5iFiBNKomB/F/HxjAE
X-Gm-Gg: AZFdTZeSlfuUEdoIzIaGfIh+SHqWNOXyoOByj5Si9BaHGxC1Ugcs1bAScLDxyz3dDKU
	IczPZjZphkvWdAZhIQYt3jdMYVfwRXHBFh2v6+sGZU5erum9ljJuf8qD0vQ4s1T8/e3a1i9Chg8
	rP3UAhRzCraP8pe/FMRiJlCj3IqSkRBaSGdT7CZwi7sV/Ry84ogJi6kgji2dSVFwZOtuKaMhA2L
	G29BF7zBFKSIVqrAugL0yyuqbeI4dZYOirY5QHAZHAEMpEECj0EVaaA9vrHUjtJBRPem337D66P
	gus52BF34s7j/KfNllgvF9khZKYfSuVc2U1asCbFMRGuuHUKlCJmYc3z+p1v+y/OuHGfRCN0NlM
	baYxmWhNzJ3GpftmZl8HSJSjo7eV5tP/d08TCSJ4kCVGaWeE5T+xzy9UZs65FQKeAZrcv0d2xSR
	uTxnsWhvVL5xxowNgynEbsXPbAq5TPTZdXNMPZ66JrrfMf87PwLwbCkQNcUC2V2Jq6p7MJGMl8t
	mW82GcvMgouAMKbTu4ba5VFESujHQ7CvmIUjHcT6z8ikf/8Z84cd5w+dDvq2kQjcTz0iQQnmfnS
	NqPHHT5NKvrrRoUj8m0Wv//HvAhsZnN+esbvnsPrBlsgft3JUywM+waJSzgsL0ZClXjEsiRDXaP
	GjJ+JtV3aI5yZeTA=
X-Received: by 2002:a05:7300:1486:b0:383:6eb6:5730 with SMTP id 5a478bee46e88-38570e24c0fmr32195217eec.32.1795852640554;
        Fri, 27 Nov 2026 23:57:20 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm69117082eec.19.2026.11.27.23.57.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 23:57:20 -0800 (PST)
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
Subject: Re: [PATCH v5 07/19] mm/swap: consolidate swap inuse accounting helpers
Date: Sat, 28 Nov 2026 15:56:52 +0800
Message-ID: <20261128075703.36392-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbXsmTWf6GNXi6W7HabdskuGRO8gfUtVgzmr03+oi20itQ@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <21e7cb1a16aed56568fa400f5385acd36513aa46.1795439990.git.lianux.mm@gmail.com> <CACePvbXsmTWf6GNXi6W7HabdskuGRO8gfUtVgzmr03+oi20itQ@mail.gmail.com>
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

On Thu, 26 Nov 2026 10:27:38 -0800 Chris Li <chrisl@kernel.org> wrote:

> Can you confirm this patch has no behavioral change? It is only about
> manual inline and rename functions. If so, add that to the commit
> message. It can help the reviewer.

Thanks for the suggestion, Chris. I'll clarify this in the commit
message for v6 so the patch is easier to review.

Thanks,
Lian
