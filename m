Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782966;
	b=eWOnD3sFcFFFPFsKwrUiJQJKVCudDa2NSLjm3QyFNcIdC0U+2MOHnl1KG48cguOqbwIO
	 LqxNELBVNdVZdZAo9n9IY3f2uieZgTI8cDojunW7vFLP50aN+DGYU7MKpyxChdeKq49SK
	 xF1RICuFxoBylBXEKqgZ9cG2uLFT385QyWBEuVFbopWSa9JAgxo0IOa8VvDg42QgCW46Z
	 RGYpc1X1cV/+qcA2sgZFvfOOE3Ce/7k42/d6Go7rspgTrBWqRU2Nbg/MbHJe6u84LFlOp
	 2mq3bFbKvL/iH//w7MA8DDk0d/ADa7Bq+9QVP+Or16k3r67PYNLPxeiHVZejbj6P0Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dqcRixLJmkkcy3eiIFpsvvSqFHhQ30OHANn9yneJXuM=;
	b=eHQo93Faw0hpIClfE+nyg4iHRDUyU9oNDYyhktgTczzaCbKOZ1Z+wDDrJJuCYokWNvDm
	 Y+NBzz8z51Mg7XBSm5uLzV8Ip/dj1eHlBIde5wyp/OI1+LXN/bMdefNUGCmtksh/o9ysa
	 ZoPz+fwSlSjftKCnY68V/JwU7ba9SOjEYqK/lazGAUMkL9fXT/sLxiejIrn6j3hR01mFi
	 c1W+oMrqyOA6POC2j3Af5TXfG2+c28y+3ppOTKErLdooP/YYDJhGgbqHwzu5AHEO81uZL
	 TBBZYsQlRORd7mrSqwjbI3jUvyuGVEyVbOwhVv28UQ/kstv3zK+0uCSXCoghDGBaO8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdHj2hcj;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A5606D808
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 09:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 007A5606D808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sdHj2hcj
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-35c76e9614aso559870eec.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 01:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793782965; x=1794387765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dqcRixLJmkkcy3eiIFpsvvSqFHhQ30OHANn9yneJXuM=;
        b=sdHj2hcjewu/pJjLV1f5snSmqxrqj5pa+YnHcZCyKRhPc2yThYFp9l4BVSfBQBWT1O
         oYH+RsVaoYO3KDk6sK28SloHyXxEvzVOtW7kkmZTJL6D0y+rlZTeS17A/tkKe2LRTjeq
         NjtxLteDJw25juRUYKsPtM8v1im0cqA2Qronv0T568l6Y5RfM/zqWe/65FZkPRB+Ok5p
         9twJOwmuZ+YTQwBDUl2Bshvh1461x1DDHOO88x4VarTg/p5irmBSzP2TN8o01mhrhR7e
         Fp3t5N9bm0GoApWLiXZCuCNKHhDQY/7EI5yf+bclgTcgtaNwkY359quU6U4thsbTZmgI
         hZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782965; x=1794387765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dqcRixLJmkkcy3eiIFpsvvSqFHhQ30OHANn9yneJXuM=;
        b=XziL8hOHIO0iuzXWlIiEaTykad30fNJnzCTaU9tKOUFOw/7FzVHp0fJ9LAluO9F3lz
         5JTKmThunWv7lgvIN4JHr6/w/cayDrw88DIT8iMIZO9M+WWVs+VmGx4/S+uPQJ0ps158
         22Wm2c8XXpA6XDojD9xJZCm56AMooPNk0HsOwjbBLdUsgoJMxkD17x6LAYx/ogr6yGId
         pelSZJ63UowQDSJ1+hmus8EjFGGyVXZndpRSvHzDalG4or+0j6uyQy2XxWldhN4dCSWH
         CBRsLKf2fis3e/Pmwj2ne7mYj7ON9XuO7UI98/PKVGaS+YmnPDAFYV674/VSLWPbKYyg
         95DQ==
X-Forwarded-Encrypted: i=1; AKwUvByZ/5228PJSv8qbrBBrJsaucD+19WKmvjqz5AaxEVh4H/wEon2iiCER8eDcLToDbzCoimV5MUkOoJSPFvlYrqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YbmxzgagqSHNvn97YlZKBI2c51Sg2I8aLvJQE6Rzu8iJx7WSZ
	6uUeMSNKqQBoSo0Gfisqd8zUCiaQm5P5cf7irIxDM9RGdyXWHEiAmk0jmFnBgTuN
X-Gm-Gg: AYBFou2CO1dVK5qisO7Q04KZCWMbQHwneNKOjDgg7whN1Xj8Yu3KOuxfUSMQo/w/15q
	MZcFX2MheKDIXH99+rPq9UV97+w9TXgg6Jb8XTFcx6c6Bcb2zzYE+k3QvRo1BhAs95O9TlUow87
	nJUsbOd4kwXGxtM/ZQ9GmP6/8v5NBrMT9n2ApX3n9eHjIWLBY8l4UXcFvFk3DJKKmB1ODFDSTs1
	EAe/t8o63saEjdoW9ITC6MyiFKposFoF4ogh9oXzFroEixfYLeR3w3drjXDU7bXKOoOryNqOWlA
	A6TLJwSkIBMSN8tn4RpyZP/TAkx/lbBPJsZ2zJkgs5Ug58xRs3E0/g9aJY7R7HsSNC8kc0eUgdk
	o4IvLQwJDnO1njnLIPDvQye3USt6vohBsUaZm8t4l57rkwZrxoMEYrRuC7MBuTteu5PNBAH8zn5
	a5R4XHRcsWKk+Uuo8K6DEQaGPu8bUbX8kNnS2ZwNjQ4oFzeG0uPG2AIFY3ps26YqR0vQ8uluy9x
	S1GP3nqaD4PcS3xNF+HlhPch6BB5MUxhYslzx9hlKBoqUsoQxCNi8hzuLpEqrZ6hXOc5JY7ai4N
	d52ieTaf0L3p6ixhuGZ+KbZ8vjdY5Mde7T347Dj3iomIMDlQG6pv0ikTzzc=
X-Received: by 2002:a05:7300:c00f:10b0:36a:1470:da0e with SMTP id 5a478bee46e88-36a423bececmr28116053eec.29.1793782964775;
        Wed, 04 Nov 2026 01:02:44 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:37bc:b892:b6fa:fd6e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39c5f0csm5182375eec.29.2026.11.04.01.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:02:44 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH] media: siano: Replace strlcat() with snprintf() in sms_ir_init()
Date: Wed,  4 Nov 2026 01:02:39 -0800
Message-ID: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
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

In preparation for removing the deprecated strlcat() API[1],
replace the strscpy() and strlcat() calls with a single snprintf()
call to construct the IR device path.

Both the source and destination buffers have the same capacity,
and the return values are unused. This preserves the resulting
string, including truncation behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
---
 drivers/media/common/siano/smsir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/siano/smsir.c
index 283770d583d5..636ff228108b 100644
--- a/drivers/media/common/siano/smsir.c
+++ b/drivers/media/common/siano/smsir.c
@@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
 	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
 		 "SMS IR (%s)", sms_get_board(board_id)->name);
 
-	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
-	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
+	snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
+		 "%s/ir0", coredev->devpath);
 
 	dev->device_name = coredev->ir.name;
 	dev->input_phys = coredev->ir.phys;
-- 
2.43.0

