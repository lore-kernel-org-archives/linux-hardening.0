Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795853660;
	b=jGONQ0AXpHmeenMLjjZd9D8gGJyNnAmlBzWPqrx5Z14Vs5gDiXExuTdfwZ2QVyY6aOa2
	 WJaGEkQLSBp2hcGSqbaXNaEUriEuxZQo2SstCwZhBw/yI9fXNoN2H0rXCzs1gWGRM/D4h
	 nPjSwM8Toje+gMtsSzjhoDBxZ/nrC3Ye/ZJg92tfEqUmKNDtw0sYln5pHd9VUcljKuTtt
	 Qct46LUlwaRJxmM1LsStojolD99+nYZv7rlExyRU5D3cmBxVnwKMD+bxJQUAXWdXz5N54
	 pzvNJ3k5DQQoTPYxp0hYLQdMer4skWluSnC3XM3f1bLQCNTO6LI2n3BQd0DjZibAmOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795853660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=i5cs8AaJOdV3ZQpL9gyqbXhUnUJiadTuA1kMgyOem6I=;
	b=4OsFXD33C+RCfzvnVSQNr+EY4C1Y36bONM5Yb2I8WIYlmTU7k3AWzITD3sFnIGCFXihd
	 zEchfGDmwZwvm/mLf7R5eroRRE2gepXq78nwNAdO2nhBKFFNARJHJVBNZJBkJka9mXJ6m
	 SdlcW5aCWi2NyjIDj8I7cLn+958osYQisEIsdoqNGR+OC/LGWFvr3ONSDunEMHTpqHb35
	 8Jf0dILM8w1ZdyYV5yVd4Gqp6SNf6krAJeHcGPO5RupLVfu7MwhZEoZnEFQamzHnCpQ8R
	 SbsmbJECcis83cD2QIPbBiWaZfQaOSJrNKI5urwFlDGcj+ognDNZpxBkpwDYdBmJ6Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4gxVgT9;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FC9606A31F
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 08:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FC9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o4gxVgT9
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38699cf08dfso11422723eec.1
        for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 00:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795853659; x=1796458459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i5cs8AaJOdV3ZQpL9gyqbXhUnUJiadTuA1kMgyOem6I=;
        b=o4gxVgT9PASOZ3CuHwluBC9eGkWtpSj9r2tVuYhYhTvpVVktc5ZN0eF+5aKR5sTR61
         S9/h6Z0rVfa7AC/F/l7b1zjgAe+HScJR+iGTRFT/1AnTib0rpd8l7uBlCzi39tG6oN/o
         D/nnCR2sOqc4nNusEDkqjvS7rMibTIP6t7xF4ID8Pni32Jcd+F89yUISlcLhjxYkr74k
         wXvBtFXjhhSM2nGXR5oVDaVvB2Jpqy/uUdap0QTb5esD8tug/xUgCi4km4ChChd5dMqF
         09E9hd8vmEbEBkAM4kd6MT7+RN0hV+hrItnkg2F/IBOwaz98kODuGDqZJBtgsyoBnAZv
         tKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795853659; x=1796458459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i5cs8AaJOdV3ZQpL9gyqbXhUnUJiadTuA1kMgyOem6I=;
        b=djfdpQmYWjYoSun6uqVNaY1Olk9t1b4Wol5jalXZlpXWnkT18qlgoMl8kq86EIN8dj
         nMdB7FSPVjq3Sh0mUJqe8qySFCLst2wfot0TpJvWduClm7/tcZFNgdMDDN1SSBMKuN//
         AhheSrI+NVafuAlE0eevANRqOgi1LN6yZ9r050Ira1oEQseP1sx0Rau7d3e1tG+kwWlE
         lZYLN9bCEyYafWpqinyUREiWlj3XdjMfCo+lfMD4Y6x7qEIC3DTBne/sD/A3PqtlhpSo
         jIRjq7GtPIsPU2kiG/lR5OVu4nkuhtiV9pDUY8KwozTEnz4ITJuTOyubXPZRfY0hrb9k
         A3sw==
X-Forwarded-Encrypted: i=1; AL+hErEyvxRNfTHlCBhUlZo0cpDTIlstDuKm4eTaNRd5OJArWP8342ZDZhV/MixETwo/Sm6lvG8X4MckeFsbwUIC8fk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9TvSzkL1HqSzI7FO1f5061/GbzPu8j+v3zXW1tVcMmPPQT8wui
	u2IBWZ+xc55SKnpqB+X8LxrSf1BZQcpnxsZd9FKDpMMchvMm+o2IsfXU1HR4SA5TSs8=
X-Gm-Gg: AZFdTZdmDhfufU9mEPmMw9QTKXlI5Z+datg78gdlfGkjGdczFPRV91CBP1bb8qsp3mF
	8g9J+qBDYSW/4L2p8gy6OFZ7PBra2kj7U5BTDWFNYEb3goi1tk68yJP2qZua9dWGfHgc4x4uZyH
	9HIo2r2TcXc6UZwmyw2UhWelJa/sziiuVSXXwg0VctlOGEiIpxTK1Nkf4pJes9MyOjRgHpStf8M
	r7OayPxuHCNu+0CP4M/YAG8aVuUH3zLvoah4H6KFnA6a2XsMDUMCuO77voz1QVBQCwvBOg9/PxH
	YzL2i6h7yAiuojmJ9INI2OuRWBXQ8yYQK7D0THs/rL7rlMDrV7oZhYu/fN9zgXjcy9dEDjjEoiz
	EfegdMAcuy8eIBIuZn58JXhRt5QaK6BbQwM6eC4SUTB/oBfCezlaQC6SZZLQ7h+XlgRjdom6oR4
	DYuv1gQztnd7/GCVe8D8URcBROx5sekt+6gH82oiOuA2OB1LEMkEuDfJBkqksASQIa+ozs1ED8H
	cM6YuWBSFhFUrhn0StjdFWy1gw2CV+ESZYL6+Xjha8BTLjzx6Hdz0br8adzcxWfe0KFtQG5qj1l
	QdF6T9812SZ1AjdZ68rU09llO2hx+B45uqTg8lIsCy2ixes1d4NKi6NkAcS3Y7eqcO3Dcm9uXJp
	7jRkJ6P57lwO7PQ==
X-Received: by 2002:a05:7301:2108:b0:386:b99:8ff9 with SMTP id 5a478bee46e88-3860b999354mr23638515eec.40.1795853659296;
        Sat, 28 Nov 2026 00:14:19 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386f6651e2asm5676959eec.27.2026.11.28.00.14.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 00:14:19 -0800 (PST)
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
Subject: Re: [PATCH v5 10/19] mm/swap: mask the off-list bit when checking whether swap is full
Date: Sat, 28 Nov 2026 16:13:48 +0800
Message-ID: <20261128081400.38292-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbWk-TK+VtiD_0ByM_pxXzyHhZiW=C0LB_mH2FtBXH99FQ@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <0d61898075921b05c626accfa34a60e16472b556.1795439990.git.lianux.mm@gmail.com> <CACePvbWk-TK+VtiD_0ByM_pxXzyHhZiW=C0LB_mH2FtBXH99FQ@mail.gmail.com>
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

On Thu, 26 Nov 2026 12:09:23 -0800 Chris Li <chrisl@kernel.org> wrote:

> Acked-by: Chris Li <chrisl@kernel.org>

Thanks for the careful review, Chris.

Lian
