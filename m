Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117683;
	b=YLyMz43kpvIYlVnHZCY8W4KlMpxtbD5oFX4PYGYi7FO81ET3+fvo9IZHP5uNEldS+19x
	 tib83ywfR+ZsAN2lt3XleQgu4fvC5Wq2sm50PAal2c/+DtQWEnhbD+q1Zce8++TtJkiyl
	 527qy9lxJxGrA0QguXnc6ecXSUzW9cuhGL7FEpvIz0jvRT5XJ7co7rSlDRLVUAsv9hGxl
	 WudDi0OlvvqIIEjG+3BgdfFhPaUlL85j+uU7UPSQL2IdZxSL/iH+Ny3hnNbVNJzZ/HTTp
	 c+/fvtNd6aoLgxguhHTKxDJfnOmXswp1/lnTfkbB4OPQL6wd7ZmJfrPmepc0+XUfkQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117683;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Mh1RMsnqXeQn3jeCo8IP85tEqAtoIfacyuqQryaWR/c=;
	b=URrsqQw4CEXf9qRNYx7PbTgQmOA6zz7aNslYF4+fiCoszyFCiD4ZkE679yGw2SpUenkr
	 QVFSx+kD8e/pGZpBnAmFINhdHqQUiTdO8sTzea2NVIGngMj7rKnKqrxX+OEAoqA/KelIE
	 EvRm4Bo4iysO2aebUIPVggrE1JWncTZp8rxpxsyH8EsmxkfFMrXMKCEMvHjTbKz/kkxA9
	 O1KYz80eV5AC1dTQnl8wXsX6zH6c1+i0MRvnp+baMQcYeSC8L48jm5QtiB2HoqpQD5gIX
	 usYOlpRxLLXc0LjeRsoSmKxQJhuYw9vVA8zjQv0T1RmTQvuJ0z7K3Q7fwtVdn4EGZ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xP0JVMPP;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC02606A31B
	for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 16:14:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAC02606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xP0JVMPP
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd6acc50b8dso65444a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 27 Oct 2026 09:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793117682; x=1793722482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mh1RMsnqXeQn3jeCo8IP85tEqAtoIfacyuqQryaWR/c=;
        b=xP0JVMPP6bOu0/DSCVmAsgcluWlYDPXi+fPvRnabo2azGAQ77IYaotXd/L4k8D8Uk8
         QxFlROSdIKAfprywf40DcaLDd3jA/iKIMTmB+FuIp1DnZuBgLIPrSDOPhsnBMD4NoFTJ
         pNw8vGcsxBVgdepL1SEBMBWRLBVl2Wh/Z1dV4//vTMgKn7ZMd4/ABiHz1a2HWXrORWCq
         hCmmouBIpdjQ2u/9TLQmUZ0ZFwBqsfV85Qc5BWKARFsTYHVygnyC80C8lhwHF/l6Lp/u
         8qRwRcSO8F6OJSNuGlJGwGcdMrGegi6TV4XfWhbYfrKB0zSFWExY49p1Cwr3i9eYdDWe
         LY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793117682; x=1793722482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mh1RMsnqXeQn3jeCo8IP85tEqAtoIfacyuqQryaWR/c=;
        b=q4nDj/X0QWQCCKmZCYxhP65V/efRteT5CxA4tNd2Gg2aqFiOxl6F4qLjjtX47EEWLP
         duBymXPpaQAAN/GXkW+gd0FScZogo3M/GGCFa3Ewtk47f1QsWUByGXkpcBRdbKo7LLHn
         mKenvP6p/41SLWo9uSmalj3D3Pl7S7eLywe0hh8ZTGj4ZOlUCZfPUSegrpOwddFtonnw
         GySt+nA26OtXz14qE8XSemYydb7PJbiBDxJHku3XS/ortsUQ6gyBQ0XEG0oF+qF2Pr1R
         H5GlLMKELb+HWtb7qfsnXHkZUvtzeeve6s9xjtua01Fn2NZ2ymFQq8ABqYbgjU23f389
         UkJQ==
X-Forwarded-Encrypted: i=1; AKwUvByF+tnSVak+oeu1xNNhEmTFEHlcTUbsYYqpYWZcxKcTmZxmDpfdtlWKk0pA9oIiEjhTKW1tcJ6KkEFi4T2d8yE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKOJhnqwPSt0xQo7XTPoKUnoCFf0rb2JXpeZTt1WoFCCxjD0eY
	jwP6zRkPd/L/+/X3fTqtFXf+SyQdfjKERWN/JeSQrIheOQT9QTXdCOAi
X-Gm-Gg: AYBFou3wkrYXuD7GlNBAGwIHtfbM8sLsRwsUB/zw+Bg1tijlJ6tCVDO1nliKkAFozGu
	sO86hdC+D6DR4KDsE+uLtiiJykLkMWvQqweS7iIZ3sm9R/sc4oPRnjV1NwpFgpz44IhLK+VIdeS
	EQGBgFRXQfzXFaWudN0f9dobhMrBjYbOyrWmrn0aWfaGT2W8EopeA7oyAZ0iGV/33gBS88xjBtm
	Y9mG1IwIM1kz1mQZrGfBEF3yepsCgS6x5to8YOgrH30RhZGuWIinsZ+Kl7XM8teF8MCKi5x7Y8z
	RLOS0+zmA1K0lLQom/WDUpb5qDjAdNk4yOVf0KN0VU5NsMUgKypKwpuNM1Bg5DDYN4PVaVlOGRb
	MTdX8FJFxJRQWIlA8zTxjR7qwjT2/MSN/kX7Izb2qWBK7NBwt/XbnbiRRHbEJURCwi4HKSxVFGT
	qiUCklaPeNNzxYA33JiyXUtPHeL4MYnUmnbHj0Zyw/CpYT2RvzrOuy+8/wWRogbmRGP9LXXkIrN
	o5Bj+fKB0Av4pjdlbS49b5owzg+UKKFe1WVtpqqna9WZkVxYFGXsS6dgUI3zqAm9/pqyWVmQ+L6
	/OqxeO7X/L5oX3n3X8e45NT6PPiwZSxwZ/C/SMEJCpGHRCnzMn+EJkuPbmxmsyuHYTCKcg==
X-Received: by 2002:a05:6a21:1bc7:b0:3e2:9025:5c50 with SMTP id adf61e73a8af0-3e7bfa34054mr7840427637.24.1793117682133;
        Tue, 27 Oct 2026 09:14:42 -0700 (PDT)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8cccbf9a3sm2976375a12.24.2026.10.27.09.14.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 09:14:41 -0700 (PDT)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	chrisl@kernel.org,
	nphamcs@gmail.com,
	baoquan.he@linux.dev,
	baohua@kernel.org,
	youngjun.park@lge.com,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	linjh22s@gmail.com,
	kunwu.chan@linux.dev,
	kees@kernel.org,
	gustavoars@kernel.org,
	tglx@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v3 18/18] mm/swap: redistribute queue readers after membership changes
Date: Wed, 28 Oct 2026 00:14:14 +0800
Message-ID: <fdfe5fac0d5b73f5b93424070bfcc8290d1c7902.1793106426.git.lianux.mm@gmail.com>
In-Reply-To: <cover.1793106426.git.lianux.mm@gmail.com>
References: <cover.1793106426.git.lianux.mm@gmail.com>
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
index 9e90f815f99c..d659afb574b3 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -496,6 +496,7 @@ add_to_ring:
 	spin_unlock(&swap_queue_update_lock);
 	memalloc_noreclaim_restore(noreclaim_flag);
 	kfree(old_ring);
+	swap_queue_reset_readers();
 	return 0;
 
 failed:
@@ -568,6 +569,8 @@ static void swap_queue_del(struct swap_info_struct *si)
 			swap_queue_install_readers(NULL, 0);
 	}
 	spin_unlock(&swap_queue_update_lock);
+	if (swap_queue_len)
+		swap_queue_reset_readers();
 
 	kfree(old_ring);
 	kfree(old_queue);
