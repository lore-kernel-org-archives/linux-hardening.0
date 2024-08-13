Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780C1A08CC
	for <linux-hardening@vger.kernel.org>; Tue, 13 Aug 2024 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562367; cv=none; b=QT9KDXI0iqnfRdwcbMrtC4eYBG1jW2zgfHuAd3VNQVwI9gVrNnPLmppBLLVwgf2d7s6u3j4pcCg+jA/34aXU6yFn1E0esXSq9HqnaFn/9JaMNLZ1KervG/uLbjvtznmtXCep0nAFyjzS3i5xqPU6wFjpfl7DL851Wj7S+B4u++8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562367; c=relaxed/simple;
	bh=WEGOV/eNmS0JwTGq95TbV76XsATL+GH7esD7KLSP5Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kihHX57QUo37SXZwEthYpCkBu1xxQOn18cat9CJGRRLOadZqxEy9CGTnMndyuhGl9Ctby239qJRsxtjGi/xb+OezqyX5S0A+5is7FWRKGZkyIPZwQQjzhRhrwkkSrKM+ZlnPs6F8Iflq9+CLS/+LW7T2D9LnEJBI+Hb82G0rhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=LtBVlUoA; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="LtBVlUoA"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f1a7faa4d5so49312961fa.3
        for <linux-hardening@vger.kernel.org>; Tue, 13 Aug 2024 08:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723562364; x=1724167164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLy7GIRQMaObsC/QtzsBD1LKVmCMkjVFm0GOFd+PCLQ=;
        b=LtBVlUoAR2tgEEzSize/rtLSaP7N+bx3ohzWCB2d0aj2ACq6InTygnmpcaaCSVmE4o
         enA7J2+d/1kBNwrRXuDr9+4O4ZtGiWz6SpFtpMTCt8bIWL4hRhdWutyuLHC2LweeCIQm
         XK21H0Hq9KhLqdCU3nuumQVXWUVIwkRPpeMaKYYJUlIHnGwozpiJT3oAaj19qOntN26e
         I1LmGD4zGL60EpT3IWALewNz9922wEPZVZ7AEFT1JvGE1FFFR+bKW2hsID37YuxNYzMS
         7dYkk/yERk3NvfwOUs7sGnmzs8vvmMcYv2eUQ9gMaRfwPIspGOWzQEsgvC07C6RARpm4
         zUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562364; x=1724167164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLy7GIRQMaObsC/QtzsBD1LKVmCMkjVFm0GOFd+PCLQ=;
        b=wFToimOYHxQqibqyLCdpiAbddy+NZgz2FfTgbaKWbmCA3P+x+S7by+mQCtvUiUP0G4
         gtyvlDD9MQ9u+toL6tR3AagSiiuSbNH/3BlAmX5uqRg9k9Po6RWSjBAQvXfUzi8wK5gs
         9jtBVRx3FOKx1oYnYpZHcV9wIxia9D8DtiSqg4mPkxAKQ37dvJCxG+B8kh+FlxyD9OkQ
         s3+xNTAE7t0Hd1p7Nf6cZ9dwnnW9oFzqw8hEfsRr0rLrqtWLP9iyD5B8WslUTnDIC6Ex
         lIL2Q0Qz+7c6aPe2gec7uVKT8ZxGtUga5yoyzKONPTGIKm1dEGYZiiy7ZCuFE5Yf8ySC
         ZiGw==
X-Forwarded-Encrypted: i=1; AJvYcCX0NrXoyPefCsxvdx0gyR31tsvJLTXMm0uehGV5CF58R+WgKdbb37tJDCHmkhsNdfswCSnbRXo+0vOXqLzK61b1s/kWvxULrRrW9gTks0CD
X-Gm-Message-State: AOJu0YzNVQP16J1jDHf9zYGbn9uKb1htmHViszAQStw5dctSBBAQrToH
	sARBmG4dsIs6/wdX7SDAbhvIm3aD2A9J6Mzf0MLX9q3OqWQ5REQ0hdaxa65WFVM=
X-Google-Smtp-Source: AGHT+IEQB9NVlJBHy3poayI8faoI7ySKxRBVnFDVKOGewt3x4rzWQUAPonzs+++1KgfNdJo0I641nQ==
X-Received: by 2002:a2e:611:0:b0:2ef:1b1f:4b4f with SMTP id 38308e7fff4ca-2f2b7178671mr24425421fa.34.1723562363831;
        Tue, 13 Aug 2024 08:19:23 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd196a756esm2977597a12.52.2024.08.13.08.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:19:23 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] bpf: Annotate struct bpf_cand_cache with __counted_by()
Date: Tue, 13 Aug 2024 17:17:53 +0200
Message-ID: <20240813151752.95161-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
cands to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Increment cnt before adding a new struct to the cands array.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/bpf/btf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 520f49f422fe..42bc70a56fcd 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7240,7 +7240,7 @@ struct bpf_cand_cache {
 	struct {
 		const struct btf *btf;
 		u32 id;
-	} cands[];
+	} cands[] __counted_by(cnt);
 };
 
 static DEFINE_MUTEX(cand_cache_mutex);
@@ -8784,9 +8784,9 @@ bpf_core_add_cands(struct bpf_cand_cache *cands, const struct btf *targ_btf,
 		memcpy(new_cands, cands, sizeof_cands(cands->cnt));
 		bpf_free_cands(cands);
 		cands = new_cands;
-		cands->cands[cands->cnt].btf = targ_btf;
-		cands->cands[cands->cnt].id = i;
 		cands->cnt++;
+		cands->cands[cands->cnt - 1].btf = targ_btf;
+		cands->cands[cands->cnt - 1].id = i;
 	}
 	return cands;
 }
-- 
2.46.0

