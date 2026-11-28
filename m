Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852920;
	b=K2RJQfB4yi/hd/9BucdMngkxw5ch5LIMTyx+bbuEWcpq7BU8HUzdU+AUEVwqBVNQFv/Y
	 nOm0ZvKUW8a92Yr2Mod8i67mGKzNUzFi8Zh0ZwOFkuCBkXBY0Z3KQyebsgIL5U4bDAsbD
	 PPoNZS8uy/sBZa90KBpn4X8QeHF+IqkVvbbM3UiidnqxSzmk5+wKYU2Y/+ZBf3UyZDzjR
	 AeD4izCeV9crCgmIbetfXf9cREICJnFEWBpQz6YGe4rAq5pjqwxIkZXDD0ZRBN/nSQLir
	 mqwebMT0RFTr5xQkWC910PaInIySNidr3rqviLODaarRk5W3pi0n38mJJIQh1FZ9spA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2VH8TKNApaWKBTCZsoWJkfGILbIk1yohTz0ELTrOx1E=;
	b=saAezzaRJXJ71jxXEe6Tes4ASqscG5cczfaCRTGs5yREPl2lD1hcW5CY3JvvqBLeYmnV
	 5wQZ7cgIvkhrSaAaJ444phNN3p3R7EYhMjL+Fjs0Qts27oV2/ALItz6zbZkfwFjfs7vXM
	 TQoiFnIG7eeweXac7tBYAcOGL+LIxFm4LBaYYjYPImQGIxaCgfU0HB49YkBWtBQC2bFXt
	 bAPIsZrGPFCwFDb/8B46yoA0G+NVB1mAPEKGh5g1oUpzQElgGH3llqxJfhIp+Ul82BlS3
	 pyaYjtAuwMEUxhVuKSfXBarvr7yDVkRaIJtC+osFmgs0HmNct8/MtY3YCRODfVI52XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBPKvO1Z;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87880606A31C
	for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 08:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87880606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KBPKvO1Z
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386ab9ab619so12461210eec.1
        for <linux-hardening@vger.kernel.org>; Sat, 28 Nov 2026 00:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795852920; x=1796457720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2VH8TKNApaWKBTCZsoWJkfGILbIk1yohTz0ELTrOx1E=;
        b=KBPKvO1ZVWaczlxG13T1esDlBFdx/ATt+sv107mfFcvi6RFKHK9SWbxUABLb9HPmtq
         tmhBWh4cx2ReDN2nFgztQMzDNx+KCwnIZZDSkGB9xm+NPoFqMf7mPKUtz/IHb4X3YJz6
         jBWpflIwPpmCgKPlL4Xdhpf0SC7ltW9cQ8NkhuvSXZ/EqJRqKgkfWHj4le1hWUjloVSP
         IIUWtNJqhTqBa3CbAVD8NuXbNgpf2LW7C7rI0uzhEH5ZIPreSz+p5gEKGZpmPfnw9VGN
         UxfBVTfgXXqV7sYo1d2m1icsc4EgUti7JACIWdTL8tyaf2i/lh/wXY5kxM37IAT/HoEW
         N0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795852920; x=1796457720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2VH8TKNApaWKBTCZsoWJkfGILbIk1yohTz0ELTrOx1E=;
        b=ch0rL8zKoScCcW+2zfX4xxRoJsYCElZMUBI5hz8Qr6FrbBSzlRaaq3o7d7QvDFj1cj
         R+5oRqnseDg/fzQBwhnCeJ8nm8lnKBw8YXTNE7gDXF8pWZlgpEa2F6EfGg2pFS/npNl8
         TA9Zh3mCpNbkCjuXO6qGJeSvd73rXR5eHtO7LB9Nh5EK+N7BHf457+SVBkj+ZWOfOkoa
         egTUeRCmW5JWxsDfjijWKtA1e+5ZNneB2oPKbwvCh7YodDX3NhBgK/HAU4/oAUtwLB5B
         plSyIHwscQSqFXoOy7ZcgCMn5Ob2KvCcdyfQc0hod2iG2mhf2+VL+nwJ7YukY/3s1Dt3
         VQYg==
X-Forwarded-Encrypted: i=1; AL+hErHbhBiNZ0Z/BckdMcDqjl+qPKZ4l2/O5rafXO7eXpu6BgGP0GlGBz+ovCOYzr3/CD+S+AQNhktDtGsfdwYptgU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fy13zvAhc08sG5PbsM8VjK/9g+ORVcip3XWzFK9by0D3f6yDT
	XMTIhKHABPPgWnjTguaEs2t+ZmKYnGezM9ymoBdEZv7tV1sKb4Li1CUT
X-Gm-Gg: AZFdTZcdDrxpbnJ7vf6FfJFkNrlhzBD3ZtEGShZXdpwqI7BakpOdxyv7ybq5/fFGgo8
	tjP01ub3X89847EMfkovrL3uLLLN9Mava/Q6+UHgTtnjE/4N1gSm4XjSlmAH2lfoOdQXdr+rISF
	1YwCOuLAkWE2Re9RplbhHkXHQ4CiLvNl8VYfk7dTqFyv/lHEITbzK9V8f4KFFiH9Ki/Jxy+8XN/
	hWeWgrWjUivWX7V00voWNnZKo6faVuy4ocA+Q/0ktOyvzrHiXE+qOq57n+/+CXFhQ4MuRdyIGcT
	kVoGV2nbgM9xdpcbkwevhiq6XejKKHXI6MWs4N+GwO+Y3gcscorYldWYimzcdBtGlibCfP+s+NE
	aa2tZ5ELZBvAVsM+/YjtIXVcfCnQ7hZ31UnXLrbQmTPFvbcNNjSjwfJCvvU/0yVS5ut1jc80Xzn
	IkB8bZlmJ2AGI1roaBS5u3bNgCYoPmYkMNQse3nDrqtiycdSVkRVPVTc7OXlogvQCe40N52AtbT
	dXVijsUm/wUsUy9eihsPV5zoks4M0oNy8jlaFkNIDGLqRV/KMcP3cwKUrYhHenG6QqRA6PrC4O4
	nOJdm2PdJyjrlc8rjHgShxscvfBmAa9GP658pSnPA4Y2rrCbnnyy+hxUsrVlAzWoAEDa
X-Received: by 2002:a05:7301:730c:b0:381:2114:99d0 with SMTP id 5a478bee46e88-38571415bdemr24847731eec.39.1795852919611;
        Sat, 28 Nov 2026 00:01:59 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm49394859eec.18.2026.11.28.00.01.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 00:01:59 -0800 (PST)
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
Subject: Re: [PATCH v5 08/19] mm/swap: change back to use each swap device's percpu cluster
Date: Sat, 28 Nov 2026 16:01:06 +0800
Message-ID: <20261128080118.36836-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CACePvbUtpY=KD8-yMAr4zxHdv7=R=k+y4jVrQ7B5OB8KTG92xw@mail.gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com> <8d0a8b9726974ec0dc73d2400f817c9ebe193c47.1795439990.git.lianux.mm@gmail.com> <CACePvbUtpY=KD8-yMAr4zxHdv7=R=k+y4jVrQ7B5OB8KTG92xw@mail.gmail.com>
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

On Thu, 26 Nov 2026 10:28:45 -0800 Chris Li <chrisl@kernel.org> wrote:

> Acked-by: Chris Li <chrisl@kernel.org>

Thanks, Chris. I'll carry your Acked-by in the next revision.

Lian
