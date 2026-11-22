Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795360417;
	b=eb8sODggN4Fmg12ybQk1SvOlxulTAYztrEL6gr1YAReyoY7DaBTFzcgBdK0PHyjMYdkP
	 9bR2WjG0qp6JedjjklceXVXNCBbNeZu0MedQj2L9i6ZvjbGenEMUsnmDMAyiYg47P9a44
	 XzV4NHUKnEpAepJJQb+M9lIgzck9oF8cFUDgnPUnx8WKK+WGheLRWjOliNmyciGXsONLH
	 ZBDe3LkHyInY8xvs68AvsadXw5mPAN/LoMiuwcGGiODupCKAQLM0e84QaSagA2M9+mq2Y
	 3HerxN0vR9WxnRtmA/kuDolqI3k83NwAoiIWFk1bmmiwJ/aX9R2Hp0xOgrMja0imanQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360417;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Gup+vM7qnK85QKR1mb397R23AX4QXpqYh5VwnUG1Mg=;
	b=EffcvKZZTvT+3gIXXsR5mL84SPT0VdKZEOB5+cj316J78bkmqG7APP/IC/a4FMzfTZDV
	 Z7SPZRsM1Vev6Wj26QQL9vY4vE1BSvJbGwlMSA46S9X7R9Vq5jjqOAG9pK5x8kDCqGO4v
	 WUv8jg3fDe/XBIq3z+BfLkIj/dbwiqI56xre7nA+thN3a9aDboqedZHjWyIGkDocb+/9N
	 vXEaS5oPZvr2D1/i4uqk/DTwPQlbfnBlg3+ucbnKB/766bbxiiVV92hBlongkCBg8LwEg
	 SxeGNxnHzKZDHh8HvW+h0gL9QefeGXs7hUqX3oAm9OOmPDyeHKGNmQcS18zbGfhSfLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5sXFnGI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.44
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33205606A320
	for <linux-hardening@vger.kernel.org>; Sun, 22 Nov 2026 15:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33205606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5sXFnGI
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7d2e1abf3eeso2195807137.1
        for <linux-hardening@vger.kernel.org>; Sun, 22 Nov 2026 07:13:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795360416; cv=none;
        d=google.com; s=arc-20260327;
        b=i5ICWScahURhXQiTteGUD/C0bVAj6/Vxl31PcolfH9rWwiGbHM+xES73oAcbDEzmfZ
         NCjh2xRLnMTYfZxuc6DhcTF1NE9/vkqJAIX7XfJ8SGqFWJsXVL/udM32vI4dc8Ooj/Jm
         EJW3O+DMl5HnKudA5KamJ751DYkkSvy3lNX8ZCHT5AR53Bp74S1AEDDKMKDrYCW2oE1H
         kqw4ZNh5gGxgEtBrUfmKudcGSKis0wTXHw6LEywrKUWtR1XtTzmLVogwLrSJQ8bSqyGv
         QysdWRS2q52a1IjWBADFO14jNm0RIdiEbIWFdzBSEiLDGPGQhobuHuWot1I8EDtFxQVE
         soDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=4Gup+vM7qnK85QKR1mb397R23AX4QXpqYh5VwnUG1Mg=;
        fh=cwK4rRt+/Js4c+3VEmbPJ1e8WzcGR27MpunX3j3EkDI=;
        b=PI47Vq/G03AxtjsHg5rdUuH0fLvzxT2r8EOc4tlJymwubn2HLujeiY1p1tcJemRwPF
         0MmmwNtOHWFBEcqSWBy2komZiFk/oidYXDn5d2Hhb9R0Mekq7lcwtRlMcy8f+6FACGM3
         un9LYcPBzmZLom/uLFD2a9FtjLiGHALm2d6qZ9wV+5cJDPhRxhizsAF7Cj03I820FdPT
         R0TZlwMzEaTEYzsniAW5NaUfPur6cRdsxbbaivv1mbBcru3sg7y/zWaFKyIRE86XIylT
         WBchupyJ9WJM/jrf0+7DnU4nktIXKBQi0UBlnSQs34RKOctVmp4u+UL2dczVh3LMoP4K
         5/9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795360416; x=1795965216; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Gup+vM7qnK85QKR1mb397R23AX4QXpqYh5VwnUG1Mg=;
        b=u5sXFnGITJuyoiTr1Yxd87N2AObGpY2EwZMIAkeb2l3upM5aoHbSGdS7dqQ7VNj4pc
         Y/CSB1A1WlZ18W5wqQDyb5VU0dwGxrWQoKlARCHhjqVWOpD6jxtXh1ZNs2FGcxRdisIZ
         R2uQX8P23EM6JjZ3pQf9PAHkDOOzq85rjifytATgVEZKRLlAIlxAhbGAh8M//Sd1zJkk
         /k/RKM3mNh1SM/LuavFTwdspHLGYUkH1bmyVADLGkeB31kFF6vbbo/AlLOstER3eFx/Y
         JkTxeHde4dbIiqs9g2jLegUZCvOsoX9dRJpnE/lxEht/a5ecjcOi4vJZ0N0QPgBiV0X4
         VH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795360416; x=1795965216;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Gup+vM7qnK85QKR1mb397R23AX4QXpqYh5VwnUG1Mg=;
        b=MTQccFdA9mI/F9Ty/Sx+yi24QT1A7J7G1hG2BPHIEA4PKZW+oLxhilzUbWr1DAVGE2
         3VeaTet8N34icRaBKvTqR9zk1p2uelbEGmpntpke1ganZwPm7STFqY1+Sl2MylWEE77Q
         NmiGK7Bixq8nnupHqKR1ddrh9LcRwnMrt9wnzBoEOQuuVhHWzy/xytNsw/Iun83za7iy
         m0FbWnB4aqIkz+BUU0wR/mcvNYplp+Tai4gw5gLC0rwRygtOvTSNR+jr16O3ckuvJuu+
         gqGmTYd9VL/r2UWwDr51HmSB4NIWAOro0PQCdv2WPuAy/zLnnTS8VokhJUKkXfGWloN1
         gLBQ==
X-Gm-Message-State: APuU4Z8AAoK5pji5gBqc8mk1aprUr1IBZk6UNjVdYgM6gPzk1FGq67mZ
	xJKLmURWuUCyko9hD8xTNSTJJbac+z9D1bIb4e2gf2wWlqHWZIZgOEYCsanNyKsxJdmTsN4r7IB
	GbV6BMsRHg4hRugUQlE9pF+6j5dfHU68HlHW3a7wT2A==
X-Gm-Gg: AZFdTZe6EHC0X3ODdAvuq8PnuC8wDX9pXsfmMdPHl+iQlADAEKrP0GNuTTTa5sLWqmc
	ICwxkFc8ZOI+GUV0hR0SBkVnP03Xy40UuW9y4c1M8RaoucUwIuIl8ySII443CV9uPJNR4LwGWyw
	o2XV/fX46vXxfXAnCKA48+RdZTJJZP/LkEK0CC3UqLwc5OR5ANjV0mvHi25UIsmdUfaxQor+24g
	0P0PoCtjs4GiqrGlonD3vWqA0rUsGvHmOY3jivx2Jr6qavBsv8orajdRuj2XvZS5rcd3XTxr+Q4
	BAx8Y9lDtvbKuhWNqhkH4cS3OXc2I3qZg5mP8MthwrSyMwA5Z9EzCtsAqlf8lGCADk00ADLY7FJ
	Swrk3lyQqLbZUSFdERyfRMjEnSNjmaMOKJ7kt2TkJIoE7vwABz3BOzniASivHtYuHREf/MVLvEN
	HkdlgbX3AG1eOSFTxN7+BAGdlB+t6ZZWRq+FUtWpg/cPiHX4X+SdJfSemUKLEDycsn+hq5vRO1I
	8xW6vex0g/ylJs8M8BCnFrmwz5vRMVTLys=
X-Received: by 2002:a05:6102:524a:b0:7d2:d876:fb3c with SMTP id
 ada2fe7eead31-7d6dba2a942mr3582255137.35.1795360415989; Sun, 22 Nov 2026
 07:13:35 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Francisco B <chicao.estudos.12@gmail.com>
Date: Sun, 22 Nov 2026 12:13:24 -0300
X-Gm-Features: Aa3M54pvqG16LX7E52bltviGGV4uQme_KJw0uxgkJV5HLuzcNp64n21oP5Mf5iA
Message-ID: <CA+KC=zdKChdya3wBwQCKRXLBGQ3gLTs+0LxuaXZX2v5CmHH9Mg@mail.gmail.com>
Subject: Request for 100% Post-Quantum Cryptography Adoption Across the Linux Kernel
To: linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux Kernel Crypto and Hardening Developers,

I formally request that the Linux kernel transition 100% of its
cryptographic protection mechanisms to Post-Quantum Cryptography
(PQC). Since we cannot predict when quantum computers capable of
breaking current asymmetric cryptography will exist, proactive
migration is essential against "Harvest Now, Decrypt Later" and future
forgery risks.

Standardized PQC techniques already run efficiently on everyday
consumer hardware=E2=80=94for example, hybrid key exchange like X25519MLKEM=
768
(X25519 + ML-KEM-768), alongside ML-DSA, SLH-DSA, and/or AES-256,
etc., across kernel subsystems, module signing, WireGuard/IPsec, and
dm-crypt/LUKS.

Complete PQC coverage across the kernel will safeguard users ahead of
future quantum threats. Thank you for your time and dedication.

Sincerely,
Francisco Barros de Aguiar Pereira
