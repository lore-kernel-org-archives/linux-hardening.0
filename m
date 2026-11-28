Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795853262;
	b=WNlElQTZhLFvRe5dRx4MFGSy11yNOi8Y6bFHsZflsIFkALz/u16Lap+h5Biuzcn1dEJD
	 Bw8V6NtfwSfHLdW+vHP98R116qjYcb+TN4ISpsiOq1F0dB284wJhcKfDX56KZ0TNnYFpk
	 2eTgyBL+zcIgjdPowjJfxc/RVkI9D1el4P5qDCS2+8RFQgzmOxty8+V7zEI88AbLThFBA
	 HaVVW2BQmg6sptgKZwHYakbXDT7hoZ3xdwG58gDY670CmtF/bmdReY3rh5P9XZcBwY3tM
	 2qOudri+YAT0rj9vFU5hTheo3zVSZVom4FCjShLs53zN0GMfJdrTaLJt9n11pQZSZHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795853262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=weWIpAhr3amneDG34J839D6yvW6FBK43ztqdqUfv7tA=;
	b=bb7WaZGfnt41vGPgz+1UFHf7EdtUNKP3o+zdmFgws6EvY5azwdlogSNEGPqwNBcrJZ+V
	 xldvFWQjWwhD3+IRRHVRsxP7B9Mbpjn6eWxHvzJNKLZtI7aykIZ5IIGFNhjK70bI86cQr
	 QoBVMAnLKUQEpTawvGmDH1zimHSXUNGYt5ViYObaPHSzsk+gh0MSymn4j37OVjptUMtoa
	 ilsdOod8KfsoUokAgMKq8wKKVbEl8cIhdDCZdT3ntCRY25wu6/e57j8V63azLdrfPi3TR
	 TYEWTr2JYNrpPFM07gCLnFVGz+kwCNrLb36fOLHTXS7RAnZ915DDJLdVkQRiVBB+7Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="S/7QQlrj";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037B4606A33A
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 08:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 037B4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S/7QQlrj
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-385d8a00598so14019346eec.1
        for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 00:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795853261; x=1796458061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=weWIpAhr3amneDG34J839D6yvW6FBK43ztqdqUfv7tA=;
        b=S/7QQlrjf5c+5GLkeifjfXwL26EyvWZYxdMbgQAZraUOuwo3rZPLQGc2TTFzqW8P8q
         FeQjTWQ/6J87HVBvIzXd0s9n7Z4S8OOrLWuKfaBpV2e/vhpH5mmh1jDAxSa2TH8qqKzi
         mLnWx0CY4iblEE7hXDN/GXO2GmtTxUM23yfvC1adq04yY/qeaLw1eDUDddyVNWlBgvkd
         +eG7AhDglYXjgU4erTgJVNoEv7QX52CstCCtf99+I6Vd5A2QGLMcdJrinHHsQDJy8MvD
         kOIWXJCi4ewGZoEKqbmn/eTWPXCKetV9l/4uQYbqeAdknxfo4ujoW6P4zRPmd008obEN
         qZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795853261; x=1796458061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=weWIpAhr3amneDG34J839D6yvW6FBK43ztqdqUfv7tA=;
        b=fSC+5+0Gnsf57MEfxYV/tZPmdjia3J1e7x+ZgGZKa4kApks19tF/L8pOwgMPaqW8BL
         qwWfZ93300EugWQsLgBFeo2TqAwg7LKZfneSxMoaYdL2Xp1wMDqj4JP8KnT9XQHCKgrJ
         QVH1st1fnY0M+KBO+abgU5KLrBcZ+DmYRbaY0+Ab6Hsa401QQTJuXg8MMxSMuWBVB5K7
         ytpiyi3y3McPEQFl2COGANb39Zfr567VQC1hkoGRtEH+NAkCK6RXBGFFEWRb4eKi3nde
         0j43Iq88U3+KN9BbfzVSMD3vhx+YBhHKRHFJWLLZH/bqsLlNtZy5pgkOR2lgC2QHYXG0
         Jgaw==
X-Forwarded-Encrypted: i=1; AL+hErF6+6zZkOmyi6sSLfCWsd4Ynqz2x03HDcVlrko+oXwYzqkQG2qHjOSsYZuuoufKZ7hpGYkKt4cat57dmCrdImk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yPsPZoHG1ig/4eDxmu5MvIyJFrMuw0BRMLONsiNgtxlJ8Mcqx
	IF9mJ2sqoWDtgefm5ia2KRJoSpyzxxFIVxZw/KaB2S/0hut4L6FdG941
X-Gm-Gg: AZFdTZd9PiYBKS5UvpWFwFAgvGrde6LmwQ1AUTlSyXHh8YcOr74Bd8YWE8ej+NjIkSP
	n4CbJh4jty4yW1PuLbhldk8mvRikTcsZUopV+9XzeH1ogG7CWyDAOf4lkvT1MvtadMZJB+op72W
	Y8OTEGYeRhxUNen+3oAy3hsGgAI1c0TnbTpmNqv4WwbZLHSKuxIeBlZJJzY8G3Lsa3BCZsp4bBs
	+vJUoMJ8uh1QadG2jsBc1zovN74eGvOVme5En0lO7OdKX8tjoLZJ5unekcXxoopPdzaWDEUAq7k
	+Imn7DKBKSGqSdcLs6CXRxBbu8b5paUnKxmneYDC98f5iHHDdsKo27Gn+aocefM5LCtaDlSPrX+
	LiJNNTn2KOTY+Q+Y9BP9XIwKi15ad7aUR3SdYd2R6HDY5wH/A/m4X5Wrw92zgs3Vt9v4IX7qBhQ
	ATRpzbG2kGS2pjkAVrYNkMSNI/qQ0ZyF8k8f9uHjrdgxkzbirlbmhjt8Ye38o2ckw8wUyFMRC+f
	gsz4PQUXOOHPprfEdQy30BghfNfdKAtgEGMexIylWh9sld4bDQHhT5SliedGR/szw6N3llAvy1w
	jTLioCl4K9Gg2rtpFyluJ3Suh1pDR4M6Ya50VyJehtgDTIjzQ1c3+SkvWdbK/ctcDuWI
X-Received: by 2002:a05:7022:3f07:b0:19a:8e3e:530e with SMTP id a92af1059eb24-1b5568650c0mr28575922c88.8.1795853261129;
        Sat, 28 Nov 2026 00:07:41 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55681301asm62581012c88.8.2026.11.28.00.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 00:07:40 -0800 (PST)
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
Subject: Re: [PATCH v5 09/19] mm/swap: avoid direct reclaim when populating swap cluster metadata
Date: Sat, 28 Nov 2026 16:07:10 +0800
Message-ID: <20261128080723.37536-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbVr7A91ya6P9Sbx9s+V6cVqba-avHCBnJDViKW2f805zg@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <e920cffdb3a65905dbcf51fa3520785a8c49fcb4.1795439990.git.lianux.mm@gmail.com> <CACePvbVr7A91ya6P9Sbx9s+V6cVqba-avHCBnJDViKW2f805zg@mail.gmail.com>
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

On Thu, 26 Nov 2026 10:34:19 -0800 Chris Li <chrisl@kernel.org> wrote:

> gfp is assigned and used only once here. You might just as well make it a const:

Great suggestion, Chris. I'll make gfp const in the next revision.
Thanks for the review!

Lian
