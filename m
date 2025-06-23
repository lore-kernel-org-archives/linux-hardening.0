Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77E718B47C
	for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 07:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750663376; cv=none; b=YulKL6Z/Hfup0QLaXvPFtvovmzfsl8X+tPdkH8ECPr85XpjcYh2mFSJ07x1bxt3YEyL34gnWtVEK7Yztn/+Y1jeKOY2TLmbd1vNzkagqnozzpNzBL6sDLVUXH8d2l9SfLoSAe99t8fbxTbOqsNBX4TAt0sVTY0T2bPcGTpC4WxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750663376; c=relaxed/simple;
	bh=tVPLtvullvNQjyX06AbIbSTUgnJpCt5D3bAGyBfQVFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LDkHJhQ4vanYcCeCJw8pLE6RaBWPw9Ql9WLmZNpCQtcZ4kRxf2MDqQiD94WJEoC5QGoz1AKYkoIkq2U6AHbG6ew32f3g5zRujO5FPUTNZLiYRVIGiV0xObY88hLwNIz5HY/GrDDoaSQRNyKjkxQviS/LlkNOMxli8Dw/HXhYWqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wz823JMb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wz823JMb"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2349f096605so56996975ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Jun 2025 00:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750663374; x=1751268174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1ER9fq2t0eg8l0t3Hf1In7ziuJr8IwFhvzCavbCoJRs=;
        b=Wz823JMbaHUIoZ2/7YVEJ7vwv6VmfFr6rR8nfaf1h7Jau5/JvzoU/Xww6K5SunMQLo
         jJJwqvtPhVmluPkO5BDAyg/tQSXs2iFnWnOY+M2OqOltTWaFvxL1eWn8iRjjozWUTIv7
         WPxxb3TBk82yRVAgJoxGBOQ/yAOelpcs9h7XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750663374; x=1751268174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ER9fq2t0eg8l0t3Hf1In7ziuJr8IwFhvzCavbCoJRs=;
        b=c4nw4SDt5xJG6JLUnbHNY8ICyYKFmqQLCtsFwufkni7qLxDhaCmgtxqRtMVTgoQc4D
         hp6WT8ftnoBdysgX9zcn/agKtkdvkh2sxxj9Yz1NyuIzaP5y1ypSoFcUjplqtMsgySyk
         TF/BIqlBIlfiNSAVllXEyHKTJee+uHrEUT3V+Tsw/ai8KJR2t/9mKvzsRXNB81KUF76J
         uLFXGu6UOgUiGprlCoOgnKT56jMYf9etLGHaYBeeFCcsFG/h+LDV62rjhpRbwbZI3bR5
         +lMy2ubtoUSUcfRS4yytjOkgFHWeyHGYqKEIl082jk0xVvCdWDggWGGb52q9/AxSGJNH
         t8mA==
X-Forwarded-Encrypted: i=1; AJvYcCVD8H/eREX3QM/SYgQ8NnUzkpbwMc7weAcFDblHWcfDMyTgqwErtjSje0SQlkcD3Zrj+fXb9PFhAlq4C4H/KeY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKieT7pqXY3SW+db2ydj748C1xD5gHfk2Erb1pqWOGDEIbg4qD
	v1tm0OLvZ8nZSSpK+fmDzax74G3cDTtN2gc7CuM2ZQ4G4YPQFrYpzzRqufe1CJqsNA==
X-Gm-Gg: ASbGncsW5tf123UMCnzEaMMglgH1/sYd29QDjzIG0nYvPCBjQmuW1mBN2qfX8R0fITQ
	bUQrRbB3vXD//2VSFqFndO7s5ofmzSkQsyDAvAA22lDaKXU02aK5o5UVtazMxvmvniHBwPy22zk
	Yh5uo4l43QJJWymdhBjhXFtDI4pip/WE3uMpiYokJK1vMYfvVUkntkJtfFD2BM6ZqPRYoiu6DFl
	HKS10vtY3sP1K+hD7qWH1gmaz6bAiEgyam5ViPIWGy4JwkBkbymy0MpuXEJHZxYqK/x3XvUq4NH
	EvqQ3pSAb8njjHXx10ienzNOE3FAY8eJfj1bwJ1w2wakhIOBBhtqe+IjuyhjVNacdCsqvlqolnp
	kcqga3Lhe9PTIFg66l9w=
X-Google-Smtp-Source: AGHT+IFIWf+eX6Jha0d5myVggnQw78e8hvpbhp8ZINfD3GjMTiVzWryPYj08pzWUXUldpNI91QeNfA==
X-Received: by 2002:a17:902:fc44:b0:234:e655:a632 with SMTP id d9443c01a7336-237d9b19e2cmr194435735ad.51.1750663374310;
        Mon, 23 Jun 2025 00:22:54 -0700 (PDT)
Received: from naoyatezuka1.tok.corp.google.com ([2401:fa00:8f:203:6507:6b94:dd66:3c4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860a8b4sm74796595ad.90.2025.06.23.00.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 00:22:53 -0700 (PDT)
From: Naoya Tezuka <naoyatezuka@chromium.org>
To: Kees Cook <kees@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naoya Tezuka <naoyatezuka@chromium.org>
Subject: [PATCH v3] pstore/ram: Validate ECC parameters against Reed-Solomon constraint
Date: Mon, 23 Jun 2025 16:22:44 +0900
Message-ID: <20250623072244.368902-1-naoyatezuka@chromium.org>
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Reed-Solomon library enforces the constraint `n <= 2^m - 1` via a
BUG_ON() [1], where `n` is `block_size + ecc_size` and `m` is `symsize`
for the pstore RAM backend. A driver providing invalid parameters can
trigger this, leading to a kernel panic. For more details on the theory
behind, see [2].

This issue was discovered during developing chromeos_pstore driver [3].

Add a check to validate this constraint before initializing Reed-Solomon
codec. On failure, return -EINVAL to prevent the panic.

[1] https://elixir.bootlin.com/linux/v6.15/source/lib/reed_solomon/decode_rs.c#L43
[2] https://www.cs.cmu.edu/~guyb/realworld/reedsolomon/reed_solomon_codes.html
[3] https://lore.kernel.org/lkml/20250610050458.4014083-1-naoyatezuka@chromium.org/

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
Signed-off-by: Naoya Tezuka <naoyatezuka@chromium.org>
---
Changes in v3:
- Fix missing closing parenthesis in pr_err() format string.
- Use [3] instead of Link: tag in commit message as suggested.
- Add Reviewed-by tag from Tzung-Bi Shih.
- Add changelog for v2 submission, which was previously omitted.

- Link to v2: https://lore.kernel.org/lkml/20250623062827.133373-1-naoyatezuka@chromium.org/

Changes in v2:
- Provide a link to BUG_ON() in commit message.
- Refine commit message as suggested.

- Link to v1: https://lore.kernel.org/lkml/20250620054757.1006729-1-naoyatezuka@chromium.org/
---
 fs/pstore/ram_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..64fa55daa47f 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -212,6 +212,14 @@ static int persistent_ram_init_ecc(struct persistent_ram_zone *prz,
 		return -EINVAL;
 	}
 
+	if (prz->ecc_info.block_size + prz->ecc_info.ecc_size >
+	    (1 << prz->ecc_info.symsize) - 1) {
+		pr_err("%s: invalid ecc parameters (block_size = %d, ecc_size = %d, symsize = %d)\n",
+		       __func__, prz->ecc_info.block_size,
+		       prz->ecc_info.ecc_size, prz->ecc_info.symsize);
+		return -EINVAL;
+	}
+
 	prz->buffer_size -= ecc_total;
 	prz->par_buffer = buffer->data + prz->buffer_size;
 	prz->par_header = prz->par_buffer +
-- 
2.50.0.rc2.701.gf1e915cc24-goog

