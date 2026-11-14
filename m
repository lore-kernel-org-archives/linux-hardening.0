Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667981;
	b=JOMOMWW7GYmbXALOydVbFleigGVmLHnLpvo5kfXX2PihY500MvpnZpWFyO87rSdgQISd
	 om7Rj9hI5OacJhzK5bS5nbPQ06v+fbKhSe7stjU+Q07QEe7IRPmxkWKLdZRMmrko0lS2j
	 7A5bGsyaQ4D7I4U8Au/2BS+uur9N7ULtJ0fiAAyJesVCFciy27Wkd/KqNkXWQziMaJ1v0
	 E0iMr3gJC4j++Gtbgw5vCnWpy4vTsuQjdptyzQHvoLZzcEPVoeTEs8vmd73pdZOeXiLOp
	 CQFJZQnWP3uU6zb5IkehjOpT9kF8w9HGB4DywKA4qEwXhZSr89OMEbrwg2G77xNQ7SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o7h3UUVVN+MbLxa2NoBAv3sszap7em80pqhV/AUuWc8=;
	b=QI02zhF8o9ryCLBFRfZ6hqRgWb2Lau724zt5uQaJ30B3rgBkv/xLkjY2IeTpchIPyqna
	 wtwqRPctEuio+jTQsA/jC2chITr7aelGoxzvu2/epXFRxqGO/z1G2jmeOdh7gVuL6LQjb
	 zLX7iGZ97uqnVnUjqmPYMhdQKh9kEZ86HP9qFgQhIezdiOQ1Ff1wRhGt0okBRR6YTxuT1
	 NvQUPn8D2TlVRfJByLKqIi4iJh7W+RcwxWpgUpdPb2YTnQzj16v2JbloHVrAOGRJ1aXHr
	 BfTUZUzEabWlvO1W6ANhE+rMlHrJN2m8SaH9EaiKFCaikQXEA//DL0pgI62HPTupk4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uF5YoANA;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C75606A330
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8C75606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uF5YoANA
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a60f90a924so799093b3a.3
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667980; x=1795272780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o7h3UUVVN+MbLxa2NoBAv3sszap7em80pqhV/AUuWc8=;
        b=uF5YoANAFA64zaiXNADV9DMYhvnbXnscC141DZITTn4ad5CTpQnGuP/JCcqblPNZPe
         15Gl/kvXSCT8YfUw33Ux8pEdxEFqKzLzwiwjlc9b7pVSv2Jh3L/jkAuIJCTQBqUiufsT
         CKF3rDnNQU/pw2FQEWMOEAIxd9SUw6fpkjykjVCgnuTC8VH+SD8E3PT30HjfWIWnUTws
         f/rstAfI1xXM17A261HaMtrVbIoLqdPMo+vehrhuodBdxjJTlo/hD7SJBhzhuaLM9D/Z
         zHo6DTfd1KI43IEHqdjEOstlsNVCRMO2khdjaRDy9Km0UacwljgumelYtsUT1SPxPG8u
         XWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667980; x=1795272780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o7h3UUVVN+MbLxa2NoBAv3sszap7em80pqhV/AUuWc8=;
        b=iJ0fUhaMVDKyuJVT14K0fg0hOV0LCTE3gAydDROdtp0hSwhEWLdp6oVwmMsH3V2kdI
         dLns+S4Ma19lpuPFII8P3ZeqbpGTK51b+E2fLhrc61fkBhnIIkTfqkL+0UwI5aJ40VC2
         i6OgxX6s1iYKDxFac8efbs+KJ9WmUUywoOf4u2/o2DbRcKZ6TOehXPuoXeSkevMStR/m
         abjFtjexZXWlsnzxzU8j/HcxU8TvJfYijjuxhVkEjzgOrJkyfrMskCIeSBu/cxm4pzZd
         HzsZ7nvQs3kTagHZJDwhExcwjdx0AHL4SkPyPf8uh3mho45j61oX7VAfUh6km5J6XT0v
         h0KA==
X-Forwarded-Encrypted: i=1; AL+hErF1kFWDjxFR155GyK3nHd4Lb10a+l8uPmxQy93HUOvl8pQJY1DOZNPlOxSFX5hQEtVsoVOAm4rkfz11q7dBFtc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JiQhdH4GXQ1995x9vlfl4AK7cjrmXKvNYEzXzho6Tw88pJuEr
	5RM2iJ1y+BUTG3lPKjXAfRQJ7rpzlBl6wzuo58vrqbgMXj4ENEtXmcqp
X-Gm-Gg: AYBFou268Oda0d6rhkIo6vuHDSdNv5AeLEz6lKeRMVmQDGAqoej+4o/lBcLrogF0jPr
	Jhs8R6YWyvBS9ZHukq37/yfLH8uxdj9oWZhEfrVD8/iL4lHqNgAINs19j0N2o3rBBncEuSOurgg
	uJyb6mgA+KK6DzRO4Wmf3tExNqc+a6g6bID3vfuDlBxHs6S/rTFNjK/F1GSLWTD4FYksN0iGCK7
	05LjPKl5iU/eZybF/3SkcHqYq8fuHh+Lao0ySNX/glPEqqa9N0IoXkF117b0dHtij5I7n5ZVe4q
	GCoD1hOuh8tExR8xpf7pmngQHWA2s/U2YzJZCfJberOBA72V9Hn+46CPJyyv3ArKqL432pL4peT
	BFiDbauYuNzAabI4o24vEZa2o6o/46ikFjaqTu0NZ55bA2M0ea64Pz601plas+/mQ/5JT32plBM
	lzlGRe5fBWUh9qs5NPLrYawgSq179k9ScyNSYvlLQEaIPPdqT6hHGC0KDS9XIVK5IhL7spa6uuc
	iXlSCo7FPFTN1uyzSUHxLyQGkguC00vOthX+6WOwHvCZ13q/5G/jQhwF7SpNpPW4wLE6zqyGLyd
	zxzLNWeZaSiCsAHoY1Zbay3Fz/mRZxXUV/SddNBbSrkjnr0+J0cGNf13CWrmbhdS8J+g
X-Received: by 2002:a05:6a00:1ad3:b0:881:e266:c3c5 with SMTP id d2e1a72fcca58-8beb2e7dab4mr5713326b3a.2.1794667980260;
        Sat, 14 Nov 2026 06:53:00 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed2d0f473sm2113512b3a.53.2026.11.14.06.52.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:52:59 -0800 (PST)
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
Subject: [RFC PATCH v4 18/18] mm/swap: redistribute queue readers after membership changes
Date: Sat, 14 Nov 2026 22:52:48 +0800
Message-ID: <fbb87083afcc51fce533308d723edc55263bdf06.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
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

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0c192844b121..eb2128132455 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -497,6 +497,7 @@ static int swap_queue_add(struct swap_info_struct *si,
 	spin_unlock(&swap_queue_update_lock);
 	memalloc_noreclaim_restore(noreclaim_flag);
 	kfree(old_ring);
+	swap_queue_reset_readers();
 	return 0;
 
 failed:
@@ -569,6 +570,8 @@ static void swap_queue_del(struct swap_info_struct *si)
 			swap_queue_install_readers(NULL, 0);
 	}
 	spin_unlock(&swap_queue_update_lock);
+	if (swap_queue_len)
+		swap_queue_reset_readers();
 
 	kfree(old_ring);
 	kfree(old_queue);
