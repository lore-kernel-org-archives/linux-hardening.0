Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559920;
	b=AU8U+DPYCQnF6Ig384ePVkwmHjvsxp/2zcFxxCj4sK+z6EY3Vj3xsw8XNHsYumxLRd/c
	 3XwMt29uHsu9KQR6eo90QQ4QwtGRqw6sKb8XU1V8IyFyacoX1CfEpSxFNKkVno/v9KCbn
	 lGaVCn7zz8kemFEJDCSuwJWMHBChKoZZId5l4Ky+CjhzkJLaoPDxjcm8hEKFM3ft7Kjdl
	 2pX9rXU8sMu+p8ytJLihyL2V2mbFQZbVNb9nVAD5RnHcmFkI3PzRl9KWmc4GuoaLPUR/B
	 jGm3LB4WYPIwEGXuyCrNI5i5r7nm3U22NepMr270cEnmAJg9fCkrLCuKWZHmQ8Lo+IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=d8ixB8K8R172rrdk/LmhJTXU2lsskw0hIUmehvKI8Xk=;
	b=yMFZ+HF+ZDdYovm1Di/sOAI435VNfHeAnrm7CK9c/Ko68Rc/QcyotHtQ8VWe9tN5lACK
	 rjGi6reEvXzy+uG+58257C9QQTwZwaqDMSwy6IKHSX4E+mP1NIJ2NkMci7Hai+07N/USV
	 /If1qqV00IPJAU1tOcj8IJ4U8gAwpYw1aL/sLJXZ5S+F33MXZK++L9oiDX2bPKN0hdoGY
	 JpYNH3HR59IEtIM+6STU5P+hVXS/jKMbbiBW8QBhNqyWWXfjIinm5FT2BX4+dG0z8D35H
	 XXIQdOaL7mS5BpHw2Q15o55J3hzXwp8t7y6Y/xERtgvh27seR+33HFmIKTROKSdTW0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=wo3tKroa;
	arc=none smtp.remote-ip=74.125.227.197
Received: from mail-pi2-f5.google.com (mail-pi2-f5.google.com [74.125.227.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07331606A33E
	for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 08:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07331606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=wo3tKroa
Received: by mail-pi2-f5.google.com with SMTP id 41be03b00d2f7-cdb9382f3baso214941a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 13 Nov 2026 00:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794559919; x=1795164719; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d8ixB8K8R172rrdk/LmhJTXU2lsskw0hIUmehvKI8Xk=;
        b=wo3tKroanTXQku0Q5OnfqMKYq9yZNuO+X2W6SNK/K+KqSIfeJq373T/eDUMzD8F+qW
         OTb5E8QNC8pMyltEE9uat7XEZhHW3BimWbhRUIriZmN9YvErn51CndJIq1p4y/4bQBll
         TE99QnuUYAnr6Qc5BzQga+/sZqg5s55Lntf3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559919; x=1795164719;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d8ixB8K8R172rrdk/LmhJTXU2lsskw0hIUmehvKI8Xk=;
        b=uFIi7WHoUI9WbUFBAnEWzCWquBLbaN8+LWNjd0jAlNW/oCIDZ3axzwRhGv6GDbUCe2
         Ch9BlK0xxQ9sdg0m9cToXpVbnIzNF+lRMLNqiIM0miwP4bD8UM3BLIcnaWD8icJEc0tR
         Fm0ioPncNy4QD6AR/lcPf52opeJ12GNLnih7xJQp3nIKGnLexaXKmEreyt00KyZm9dPG
         2dyuM5B3IOr8GxDwUE6OPupz6/4WSdAVxS6UYkXT3a6R3KA3pG4VBkTgcHiwegdLGS6v
         i8m0UERZZGBoFL/yw9NUbwLH5R3joeIGajFl1VyUrNSBpHTB4qvQLi0mTWsRIeS70+kA
         3KLw==
X-Forwarded-Encrypted: i=1; AL+hErHfv1SQtAWAVO5caDrQfLV8Z1hx42LU0vS9suQjaIDgsBsbd7yXDIxse08bfzza+Zq6EW6gcyVeOzFo6yCUYNc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0YmvphXxcKRnialMAMqf2hQlxrc4F+Pa1uwxxetRe3IYEurot
	Uggg+yHlWh/xUoKvVDDHVcStJMjfB3wrD6BZdTOwiS6InTDloNdKEo86aBEc9b7g0UE=
X-Gm-Gg: AYBFou0DsYcSZeAx4qEQ5qmVwJAew4iIbsFNujUszSCaMN0BloLQCnB2EyKfCaUuyuh
	3/EOFU/tRbbaCaoy5ckmeOt+vr9USSkyIJWjXBge3M0/9LBE8NPO+rck+WhhbAeZUPMw9WqufKe
	yobxPIQVONuZYdyQGyAIaGIE5LlbPOtPfpZ4nBeH2A14WOScQJ3UKT416sPdVIgojgmHjqTEovr
	dfHUyJCAkJRMDtVnRDNh4bQ0AlzeII76y2ISQCY0mZUs71JgDTTvl3eqs+zU4KqvqZIDBgZDmiM
	tp0kW+kbvm7knJ6B1UygR7alvAA8q0XIMuM67G/DoomjXojTXk6MJU6EaucDe1tWOmJYNEeEPPm
	zuc81X7d7XkV3bR0NRni+9mNBwnFmjqO4tFA54s2SNrM+3RODuGZCgcOhQ3EjqNibKatEUOMH7D
	Pxs3FOBEkXNBsR0colHFFRCJczlVem55Pb5rwF0R9MK2BXMAy3pJLB19JBL1Dm42C+28bsOCltv
	aIZIWaiKOU81iG++eSEA8bUoTK1wo9GLF0qRY3u/ZiE6swl0ZJgmWbWfhrRdKaMgxmCQ+QDtWsS
	RGc0zVb8zYtheSycyYzEPVI5lqk39FqNq5CeaIi5yKQZLSb5MplZFEX9DN+JPCOZ72eoPcYJXGh
	Gzs4Vz6wHvRe88Jn+O8o724qGkOu9MuNyI9mrUHlZpvnrVJwwieUd1n+QkI/EtKgsGHfTp7fXcP
	bLiY6FP1TL+7thU5n0r+T5XHmfDula3sPPdIXdckkq65l43Z5/U+FoatAo6Pg=
X-Received: by 2002:a05:6a21:798f:b0:3e2:1a24:fb85 with SMTP id adf61e73a8af0-3f7a4dbd84bmr1333192637.1.1794559919456;
        Fri, 13 Nov 2026 00:51:59 -0800 (PST)
Received: from [172.22.0.2] ([50.175.87.158])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cddc186f472sm907794a12.6.2026.11.13.00.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:51:58 -0800 (PST)
Date: Fri, 13 Nov 2026 00:51:54 -0800
From: Chris Down <chris@chrisdown.name>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/6] mm/slab: Enable SLAB_FREELIST_RANDOM by default
In-Reply-To: <202610302113.FB347BE5@keescook>
References: <cover.1793253633.git.chris@chrisdown.name> <6bdc161bd869ead04b3b9a651ef6a83882ecbea3.1793253633.git.chris@chrisdown.name> <202610302113.FB347BE5@keescook>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261113005154.79ad6432034bf65c@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Kees,

Kees Cook writes:
>Again, just like it should be. I wonder, though, don't these 2 changes
>undercut the goal of making these boot-time selectable?

I don't think so. The goal is to stop needing separate images for hosts
with different needs. It was never to make every option switchable for
its own sake. For these two, the only real argument for leaving them out
was CPU cost, and with sheaves that cost doesn't show up at the system
level [1]. So turning them on everywhere removes the reason to build
without them at all. Anyone who still wants them off can still say n at
build time.

SLAB_BUCKETS and KMALLOC_PARTITION_CACHES are different. Their cost is
memory, which is real and doesn't go away with sheaves, so those are the
ones where a boot time switch makes sense.

[1] https://lore.kernel.org/r/auITixAJMfLtfa7i@chrisdown.name

Thanks for the review!

Chris
