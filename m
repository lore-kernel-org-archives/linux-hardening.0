Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33803B27FC
	for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 18:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484021; cv=none; b=B5KwcekeuK9jv7OHVuF88CJnU5MhyfN/hHUSuguPy5sOvqeFnpNTJyzZnEgF+h1AURGAXq6YiDZ2A/EvLPop6pv9x+Wci6bvo9Huf+faGCdQMw4xSRtiveuxrcEA+aJ0fpzUfej52ZIKRow+zuAcOsujTUkxQS+cW+y4KkYceWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484021; c=relaxed/simple;
	bh=IWl/rQwPGM5RLLR3ae5FmKgiapEO5Ii89mk7y4WpFec=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=je98KjbS8QJmvhaNZgyYgs18R0gFHupGZxtmpW+96R25tqXHKQrs9G7pZzoHH6UL4T5ceygZLQNw6R7E7vb8iHUZRSA4dxULB1N25XgCD+reF05VviSUlTtaGhPaTmZc85nOJD+F3avjbzydu2x6bZtdHSFnkDmCSNM2cwchHaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRSyNP3n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRSyNP3n"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf50c6f235so9776345ad.0
        for <linux-hardening@vger.kernel.org>; Sun, 19 Jul 2026 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484013; x=1785088813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjFgwGrb1ClX/kve0vswPTA8/2SHmC5jDANL46Jtr8I=;
        b=gRSyNP3nbOy92ndFyGq6aP6JDaV8aAmOvPKk6h4ZEMEh+9n1MXRhN/KjKJ00rxs7Hd
         KLoCPSoxZwgxWI8xls30M7eYHu0FOR0MiRmNjhrmI4shqvn0WxeheUew5dXh0r/H5jan
         0IxTL/ohLXUqGZMkpFHvdBOTcinVnPoIVaOcMaRr2IPYLFLYYFgLlqHPsqeAwbnsHO1S
         VZUwdmWN9uuM7msnE8QYvaQyhoc1V2It5aYl8p4y/k/4i9I9UWou3ISu6o61KBH4lxv8
         l8qlx0+WDF36IK4OuqpytHCzwq2lJEnG6i620BEfTNIsK2p9RjAtq1NK4kTU4dfFluTF
         oNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484013; x=1785088813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OjFgwGrb1ClX/kve0vswPTA8/2SHmC5jDANL46Jtr8I=;
        b=I8I6I8a3UwU+cHbTakuwQY5vDdpmxPJBS+gx8sNrzQHcEfqH7BeMtDOKfi+XxUuNW6
         /CiDD3XfZJxQCw/ys43UaCvvc70i8GKyQsIH8wbAXUd3DQEL8/HoF3ANGSI01OXA7XzE
         dnFpmw95LFVeDUXwSzlJcrfJiBS6K/gy4bksfbjEXEGHc3UjaZdPNz8klQDP4LyKyRDC
         YwAFhhsdn2WNpcxMLjQ3rq1OBxIdLK4B7oMkhwXwKxLmcO1cP1XQEjU/R6pFmswl7cUr
         tOKvxE/TE+fOygabLG54Ink1rBFery8dPZgOJs7r9LH30xJI8rmtycAHilUCz95z7dK6
         3Meg==
X-Forwarded-Encrypted: i=1; AHgh+RrKeVMjOBni4oSgmFE3Lustnatrxt87tQ7gnTUAVM4B0IzHkWS2UNjZ9Oc3prhKrP1dXm3FVG7nMgxG2pDKFmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzoILqzpswNxuqHZw07EoiXxZpm/J2StPxksfhg6WJ+7Kr5tRL
	uHg7HumfrdRNm1tXA42oLAoJJxELOcNWaKP8Zl+mjxkfC6t4gektfVEa
X-Gm-Gg: AfdE7cnGmymwi8SWKG/2Gr8H6tOPpQ1/Nun7WbpKqXuPMKNfr6RIJ1XgYskVqapHxhi
	3QvFoAykfm2Wku+MKm0VIoQbIdQLcEJmTkJsSmCmigqUXEcdoRz8Iq8n3pPFqG1kX+xyfjwtgBd
	N614g2UYan/MG3c+UqvjaJ/NN7FOabG5suSgFjdAiHDCAaX/vzXETesOQVjcdwnX+MNYWqHbxND
	hMx0DtoQsMq6kLnVjZPEQluntoSj91CzfZuGWfbmN4SI5+sLByvVv8WK5hRxqgchyLwhzvIIuzn
	Hnm5N+RkWWTkSR2nTOOBErgweeOAvoaxUp8eNvEJ+fJGPkZBgPn67zbCnmPn2NN+Oi4nE0G5FUy
	lKzdV2XLfw0IbMRPZP3Eq2EN14MS8g/5wv65lxyYLVANvyaMty8/uC2gPJNxP0xl+PA==
X-Received: by 2002:a17:903:988:b0:2cc:f5aa:9513 with SMTP id d9443c01a7336-2cf34821a87mr130472895ad.10.1784484013524;
        Sun, 19 Jul 2026 11:00:13 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf34769bd6sm43511065ad.74.2026.07.19.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:00:13 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	Alexei Starovoitov <ast@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Andrii Nakryiko <andrii@kernel.org>,
	Bill Wendling <morbo@google.com>,
	bpf@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	David Airlie <airlied@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Eric Dumazet <edumazet@google.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Hoyeon Lee <hoyeon.rhee@gmail.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <kees@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	linaro-mm-sig@lists.linaro.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	llvm@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Nathan Chancellor <nathan@kernel.org>,
	netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>,
	Simona Vetter <simona@ffwll.ch>,
	Simon Horman <horms@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Taehee Yoo <ap420073@gmail.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [RFC PATCH net-next 03/13] net: core: add XDP_MODE_HW offload hook for knod
Date: Sun, 19 Jul 2026 17:58:47 +0000
Message-ID: <20260719175857.4071636-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260719175857.4071636-1-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Route XDP program install/uninstall to the knod accelerator when a
device is attached, so BPF programs run on the accelerator instead of
the host.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
(cherry picked from commit 9689730acf7d6e4d34cd677e4615be10856c709c)
---
 net/core/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7c21bc0a1e34..5ba1c969029b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -10334,7 +10334,7 @@ static int dev_xdp_install(struct net_device *dev, enum bpf_xdp_mode mode,
 		return -EBUSY;
 	}
 
-	if (dev_get_min_mp_channel_count(dev)) {
+	if (dev_get_min_mp_channel_count(dev) && mode != XDP_MODE_HW) {
 		NL_SET_ERR_MSG(extack, "unable to install XDP to device using memory provider");
 		return -EBUSY;
 	}
-- 
2.43.0

