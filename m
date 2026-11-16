Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827511;
	b=j8FIey62GLetkDZupyDUMm8WhElPYMHUdt9PEs3HtA6jr0VET65O3idySf/epXxPOAyJ
	 AiPtLTLOeoo8H5iGRaoJUwwmCtIhnT26HgUKjv/bQK0eNs5a2NgrI+T3IAN2sVwCK5fVu
	 0la7hjOrVeQcRvDQoMUksAmfAZUeK8KwfyV/aTo6I33Ls6VoHtkZW6IqLUBUpYL/Z7vot
	 zoZNeYLDit/B93ba5flbEV0DLF5AL2M+iDbwSVD4rjMgg4sN/43GxsLWO5mNoh9kBOC7Z
	 48LvwttbScO7iRDKuck3NJMEoAk7H7u3muX4yFeEmdRLnSZRXoMVga+zO4TllqfgyYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=X92jc3HOiTUE60p5qYpnfogS3YHWVykNZQDGs9aRJi4=;
	b=auOakV34rO2yJO/wyreh+ZvluUGfxiEiSJWOJX3WsdN91OvCcUbC86dg5dr5AtVrE1ed
	 cIVdnuzEn5yf/VYcTnY6XBqPPohlsMXeuiOEWpgfMqeLKFKphqk3755B+NX4GzLAP/AYf
	 D0tCrV0C4imdIdzbA6IZ4X8NDR+RjrUYs+y1wCXVZDDAfxarKn8y2vmtimusmAtelycvP
	 LSaoZPrOUIdD7f0cukq42Vr9DWOagiTs9qza6ToLbLX9jtJtVdqkXgph7V7ygJKss05ex
	 1ZeA4cA9mvXEzaNadTxjH9x0f1r+scKaWj7aP5kbmwU7wRVH568ajFbWeaqGkmYN2aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvhRGNuE;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543DD606A8AE
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 11:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 543DD606A8AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XvhRGNuE
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso1518643a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 03:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827510; x=1795432310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X92jc3HOiTUE60p5qYpnfogS3YHWVykNZQDGs9aRJi4=;
        b=XvhRGNuEpRT2Zo/9mCTTw+7gqHSe/jmEHLoj4sZ2Nz9qBgmisLHpN0Z2GLasVLDop6
         l9cqpBtTirK20HFfEsHPsQ0SdJUooUZQkCIcVO0AgQhsK/feqV5erCY+H0YXBGxVY9fd
         ZPxAEvAVFShC9ISFwdzjOWF9JQn9dB+AzWWFdGqnkvgFdwWqVK2U0D4JAe/5gE603gz6
         CkFYtKOfFRhytnd9ZJVbeaqJMpTL0mynNee74STyJ5CV61c04JuI8wos/H8vqboon/fT
         bSh6nirirpDg2yHS0Jsq4f20njD+hSODNZ4aq4jSdsOlLuUodhkT3XAl04EecEn5fnA8
         qLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827510; x=1795432310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X92jc3HOiTUE60p5qYpnfogS3YHWVykNZQDGs9aRJi4=;
        b=wOqA7XNq23VFXO8XNk5V/vT0Kq5pBTVCvqPHjEnEnkxquLLfX3snBK0riWDZOrpUFF
         aXN5twHkxwJhXLrgaqcuivDMuOF7YmrvEMUK4ghm4dQPMzcFmCqnFhWc9WrU/EdITLgy
         IOQ5Q0UMjHSHkcg/ZZaszO5Px0vzOIwKwT47qoYUwBxSH/V7vFUek0WIpK8yimb8tjKJ
         NlMkfx0OBQDwNoKEMghhIH50cuegT07Ok25uavLdZEDDE8S4zUGXxHenVv535xOiIxfR
         riw/6AuHkcSXoNMylQ/Zxs8+F4BcIko2WFyH2GcWolgZfojnTlWqt5UAsDjkHH5mAtFQ
         w85Q==
X-Forwarded-Encrypted: i=1; AL+hErEiVO6MqsF8o6wLRLzuzZZ7uUpCYsoi2pLgTWB/iQ5jTKalBA/ZmKdBFDv1h1ZLW0wuPWnwEaWpUy/Of445l7Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+79cdo6mpRw3wrsxuzeaS1KVIDNdhPvk44ec31vU6UjvgKIQ50
	USMnx2J4HgTMLq7XlAMV5qdE6vxHYQlbe55KtPKNtyzZXbYUQTpxgDVN
X-Gm-Gg: AZFdTZci0mXOf7iAFaSREgNxK10YaF3M10twLbxLXZnVR6tokQQn4BrgQXPw2itI5tX
	MZ/RPJumXzizJiEtm6XWJhY3kTfIF8GaFzgSiYtUHH+uSJX3RMd9lpJbCKmkaAx5NObBVJXYXsl
	kCXJygBWMmJ+98RsT5fZ/CBhNWnw2Vpo788iJv0ER0bgS6zZbHyzSQDhk/pxyrqq71kdVgnw+av
	Scu4tHPp68X+srO5Wdpn4sM6G8FR9Do1tC3u3/LuNnP1R8jOIShYfaLH0uSUB//yS7mD3Rq7yY/
	RYSiWttz7PzSuxYjeLRci/rJROqV6E1ghTA0pC4gYEpMpKbew5H5Dk70qIesoUQS72UH9Ry/8PH
	EHQjsBwgr2N/6rrAng6+HE8uYVi/Bg8xxQ+k9DP2cbr1/owYOhcsuYpCfAhwJODXaaleVgOAQjl
	35C2gmYe/eJlgrvrmgdAG2bEUPUjjagf0A/3CrdGu6c10HyntUo0YBWtHHNfjb4LVb+gzKKpc7n
	kMs7IQQGTEP9KfDiR/KPPS1sMJYQ4eJgLroVtHohG4kexp8jZ2oitlu4iafLZVYDik3at6s/7pp
	tkcFrXsRwSX77Zf04vY++yagCSw7M95uSJwqsIJbT+LQYkjM1+/1BimKehB/Z8V+xUd0
X-Received: by 2002:a17:90b:4cc6:b0:3ab:2737:3392 with SMTP id 98e67ed59e1d1-3b1b0ba9108mr10216941a91.53.1794827510403;
        Mon, 16 Nov 2026 03:11:50 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efcfd7e302sm1080965ad.13.2026.11.16.03.11.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 03:11:49 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v4 10/18] mm/swap: add priority queue for swap device allocation
Date: Mon, 16 Nov 2026 19:11:23 +0800
Message-ID: <20261116111136.28790-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAMgjq7BnyM76DR8cdaz4o5PEg0=4rBAcGvWwoHqFDfPpoqu4BQ@mail.gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com> <62dce3641b589e9cd42edccf0d4e9b31e7d91e36.1794666741.git.lianux.mm@gmail.com> <CAMgjq7BnyM76DR8cdaz4o5PEg0=4rBAcGvWwoHqFDfPpoqu4BQ@mail.gmail.com>
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

Hi Kairui,

On Mon, 16 Nov 2026 11:51:22 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> Hmm, this patch is now quite different from what I posted in the link
> above, e.g. there wasn't a "struct swap_queue_cursor", and some of the
> naming in it is quite confusing:
> e.g. "ring_only", I think what you actually want is "fallback_allowed"
> or "no_fallback".
> 
> And since there are three iterator-like structs, we better reorganize
> the naming; 'iterator' vs 'cursor' is confusing. e.g. maybe reame
> swap_ring_iterator to swap_queue_reader_head.
> 
> And why do we need a "cursor->valid"? I see a following commit dropped
> that, so perhaps accetable to keep it as intermediate step though.

Thanks for the review. You're right, this patch has changed quite a bit
from the original. I'll give the naming more thought.

I haven't explained the reasoning behind all the changes clearly enough,
especially with the adjustments following Sashiko's feedback on v3.
I'll go back over the changes and make the naming and intent clearer.

Thanks again for taking the time to go through this.

Best regards,
Lian Wang

