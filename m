Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795443628;
	b=jIHwdwI76jcjzgV3WzmRynmyO/djudQ65uNkWAZWse4RMWTJRz5+yZoJLI+yEFJNFmuX
	 RmY5uwjIDiRL2kK3mhYbJW2nKwGo0ltYTkQUU3DEQzqprA6thjPsu8Er78QklIoob7uMd
	 VJnWcJC/bQ0cIZqh1YuL+/CRJI8agWTb/B7Mq70VKdd9ftV3UYRlCk8ZI7C09Kg0K8MQ7
	 hJVis9PL5c1n68GXuj6+9/lOG+8tftdamCtccynjSqlILQjcatU9tvLHe0SdcZTxSPGiz
	 s3nMcIY1SARa2ZLHFUAcxgzacSvNdN3Fpae9BYHflDTIenEbb58ozGJRNGxFukxR2Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795443628;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IAzQq1DJpSBO+XxRF6Vp7LxmR7KfxskrkHM0HAoL/tk=;
	b=KKZnCB8UYgBzj4OsoBcXcMZ6R1ku1NwHgjPiZhtvCOWIqx+RvCgMNuAlzxESpW1QDZGt
	 LL9si+BSL/ACS/fXzJr2IU+hikjZaQM9muwWiO8vhx9ZYCzoyC8IHmSvhd+BqZ3xg+pGT
	 winSefRXcD8dRD/tyQDxbDr/NlZyl4ydtZ8G/69jK6N+QsCh/XyctBMZg9gxBf5/Fk6HW
	 uOIyuRV6GZ800F9qJ2NySGKc5g6fAZNlQYExvg6SNDb7895PmH4AzBA4iQ4n/8zehkUSt
	 +hcNAEEyWB0YPqS/PEttmKneQImt2/0dJDVNtAm6+7ahbQliVXDHydHYDEgBCEpJZpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rnxolo2A;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A56E606A31E
	for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 14:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A56E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rnxolo2A
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-385d8a00598so4609110eec.1
        for <linux-hardening@vger.kernel.org>; Mon, 23 Nov 2026 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795443627; x=1796048427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IAzQq1DJpSBO+XxRF6Vp7LxmR7KfxskrkHM0HAoL/tk=;
        b=Rnxolo2AuqFjwFHQ+ncS+zjZac5WVgLKB3nOM4CSR3T9FDIDv7sbwyjTEj5hWzhdxq
         xks25cmqtbYvlu8pfcnMyKhJdaDLA7DlssJYIWc5hHVKHaXekAoXadx/Tfu5YmZSdgB7
         L6w+fIr5K6djLsdfZaD6eudvcnlupRy4o6JNHgT/cuWMNIEMXmGVkpDZJHt0/Lg0ZIMo
         VrcwmmKkBYmb3+3iL+bMJP3mTdocGjsdXDl1fC+3jmTt6oTI/ye3zP6uqYwUCSlT9kky
         H3Ncrua4lKRImP6N56ldnTmIOhH98p7y33ShuJ32kwRSBkqHTWGvwS106bvUuklfj3mU
         v8Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795443627; x=1796048427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IAzQq1DJpSBO+XxRF6Vp7LxmR7KfxskrkHM0HAoL/tk=;
        b=ymx7gz1Er2eM0gmQJlZvhAo2roGJMuRALJkFISXAzrad2g/oDTSdvawtxxf/qBjVbB
         svef5qZ04ZHQ50ph53a+fn1jrc/UbuvIzkH2qUM2na7rcPUcpal2Bw/W9L0YfYjq6Lca
         YsxRvgruE7vmWQ7vQo/VDrgYi4aq1fdWLmSLVt4dXr9cr5P/0dZdViSsG971XeAG+ZC2
         YFaBh13/8EEW+hOEf7iA6aBE+7IF8yBj7tXImRl7xne5xxH8VlJRdsiqUd5dlyv7yQni
         TlHEKz1kleg7HjGE+jgJ2iu/4BYCM8nOQjJD9527HbioIO7kzGWI/2P2HpgScrxPxsZ/
         mhTQ==
X-Forwarded-Encrypted: i=1; AL+hErGP8gywmueLxnD0il6dL2YIBTzWt74+tmJA9EPm3bgltIELXLSsawNgs7j+IZPFiIgdeYvawr3WZEiK5K980Og=@vger.kernel.org
X-Gm-Message-State: APuU4Z9W7oq+/rBrqMQc2Tjs5PTFwv4iMcWTiF0kgJQSnOkdSUch/xyI
	LjsLONBhUzDNnKmlcemKxPqvaGw6rCO2Eqeu2dAgy8EOxO0ZCKj9Jwqq
X-Gm-Gg: AZFdTZdRqcfPLiViOM63pUs/O5uXnsHCrm41YCwGsPt8/IlRqPR8gkV1W9mVPHGpTAY
	NCz107Qr0JsTPeHFyIRtHUukqSGitWavVBAMhmIlFeyTld+kTmBBomn1JapsvibQlBoJEQMFGw9
	p6jiJp3LedbyfpHZMaPYlRaXp0bxB8nrZ4rxMjX/UEi38Odkp0pIe1IQrwh1s0rj08kpAOsgCTF
	0iwTxGBYNGc/6TaW7SyGgesQhqoExHFt9oKgMWlZNwAnaB1047t28PCFjeh6iP3YKK7Ds7XXAEb
	npxcxOZwSlr1efBOvoL1/ao8TJcD0/aBOdxMv/JjbAA58NzsIX639Zqlx8LdWvd+hz9qISiF6cx
	OG8AbaKtZFYefEAytQynTwvUwtHyToQKePVMhSf6DrBS8jnIw6pQitwP/7a5iDuy0P9HvN/yp88
	h45yGXhELXXuk+EjMncpz9F/vvAmOBguZxmJdQ1rAyW3ZXmxcRUacdrZHV1ZNPOShBWK0G2gPU5
	iXvqOedCgrILVEz/Gw5rR5Sc+WgeCQBpy4qkUuFis9py+MpbPLkZDFovAvG4xMEG6ydTyuZxFEu
	rd+jMd7diCubLWzeo13Wyu0AXVZqpUeWC9DzNdgbVFAc9KQhZotGUnOUA5lo6U2uHeE7
X-Received: by 2002:a05:7300:6881:b0:386:9ffb:33b4 with SMTP id 5a478bee46e88-3869ffb51abmr7378341eec.33.1795443627312;
        Mon, 23 Nov 2026 06:20:27 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm3091208eec.9.2026.11.23.06.20.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 06:20:27 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
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
Subject: [PATCH v5 19/19] mm/swap: redistribute queue readers after membership changes
Date: Mon, 23 Nov 2026 22:20:14 +0800
Message-ID: <fc69968abaa133c855fe71ee4394251e67b5d905.1795439990.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1795439990.git.lianux.mm@gmail.com>
References: <cover.1795439990.git.lianux.mm@gmail.com>
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

Adding a device to an existing priority ring reuses the per-CPU reader
storage. A ring that previously contained one device can therefore keep
every CPU at the old common starting offset after peers are added.
Deleting devices or rings can likewise leave offsets and quotas that
describe the previous membership.

Reset the valid per-CPU ring offsets and quotas after peer insertion and
every nonempty deletion. Run the initialization helper under the topology
writer, which excludes allocation walks, without allocating new reader
storage or adding selector hot-path work.

Use cpu-id modulo placement for a fresh best-effort rotation across all
valid rings. This does not move existing slots or guarantee strict balance
for every active CPU subset. Mask and availability transitions do not
trigger the topology reset.

Reviewed-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 91de93043500..f6a6df8c2595 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -495,6 +495,7 @@ static int swap_queue_add(struct swap_info_struct *si,
 	spin_unlock(&swap_queue_update_lock);
 	memalloc_noreclaim_restore(noreclaim_flag);
 	kfree(old_ring);
+	swap_queue_reset_readers();
 	return 0;
 
 failed:
@@ -567,6 +568,8 @@ static void swap_queue_del(struct swap_info_struct *si)
 			swap_queue_install_readers(NULL, 0);
 	}
 	spin_unlock(&swap_queue_update_lock);
+	if (swap_queue_len)
+		swap_queue_reset_readers();
 
 	kfree(old_ring);
 	kfree(old_queue);
