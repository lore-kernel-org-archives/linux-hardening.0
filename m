Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5520DD56
	for <linux-hardening@vger.kernel.org>; Fri, 10 Jan 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513846; cv=none; b=qw4CFEtk6EorQ4ffru/4eKD8JzGDz/5p31Mt8WrT6MdcosdjeyvRMgi40YRImcwaby4LsUeKMa4nX2cG2LnKbmlx5QSQkxBpS7TdyFNpWt3JUPeUvTNNiNJAfczSkpeLdBy6gfOA8Fk/arXmR03UIfEktUxhpFkX4PT5Y7S5/ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513846; c=relaxed/simple;
	bh=O7s4+YeAaeOezbUQ0uUAF3HuaRoXn0zbYMHRN4K94VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ccelgRyJL6J++ylYMYK5Lvk53VRE/zCBG0FVvDJUj8PJZf1Fvt6zibVpPX+e5l67JGcFYcCW7mQ4P/ZYT6HhVsgXuZP2kp2E3i75A0Y/1C9RelERZHBytQfD49VzS5OD+VfecKHtc5GvKvDFCrOhHyJ1DBFD0hlithdz+ot5bPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UkKQlMQB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkKQlMQB"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso15513015e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 10 Jan 2025 04:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736513841; x=1737118641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuO/PfXVbd8eOsHL6xLYlrc5CHMwEpP9FRyOGs7V7z0=;
        b=UkKQlMQBprwPiUHiXM8r9Q16K05oJlM4GRY1hZjF/gbZfhkubsyXL7rZFL1DbhYmo3
         2C/9n0D2KTzqkUMmjDLpmZAoux12gZUWsDY0v00PPSKC56eaAhW5BDNJl2othY/1odoo
         qQG6d/t6bqQ2FifpJlo2tE1rRGoZn8QxmoaqmuYWyCJexP/nI1sovhaXT6J2xTZEIh4c
         PYwgyNZ0wGk7kJQeU1/BofJPgUQ+p9d+QRF9mRzLEmXzE9oVbqxzsN51Pubm4IBPbTRm
         mkVELCeFAzx2uo4xxBlFLIJ0XEOkJWaRXV42EnN4PveFx6MkcJbse4rB95Wk/T5Ud7z5
         QgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736513841; x=1737118641;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuO/PfXVbd8eOsHL6xLYlrc5CHMwEpP9FRyOGs7V7z0=;
        b=ZBvBoJDQ6LW63LgwGxSs/POSRocvVe5svlVHRaxtqnmBiXowucO1XYdf8DMGVbxELy
         W6NHNXF+eALpO9QteCW8xcVhEkBN1C93RDmlyngIDzwYvBjyfxRMylpNNOS3eh15l7Gm
         o1pkd7xMyajODgwYVZUS/u7f9WUHTpmw61n/ulWJLXaW34c9B37KLNvCQ8E8Gt5ESYzU
         WSiyAKprh9dT+Qr4l98o/vVt0Wr7OhQBs3XE/5cnZKmc6FQfLIGBQzh2wE7j5yXim9rV
         mUY3CQSngfWUpw1dof1CRF/5mQbQkOgvD/6NHs4qutFZTakGlXVJB4D9q9xkH1d6QKra
         9VbA==
X-Forwarded-Encrypted: i=1; AJvYcCW/pvm2T8jDvnW+/zhXthoDifH1a03RUKDzJLTCQTgWfoZcEgHh7+7AfbqTsaLQbYT/GdB+K6qWM2L3/Iju8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cOnecA3dvpS2IYDEBSI9/irt27yWlcCyeKGT4csN+l6+QF6g
	8Pz0JK2jGFBeOPfgAGrgtosp/MawiEHUDhsJWIrFP26p3xf0L8aoRgj5o0Drnqi9A5aC2U0WXAA
	rwgagwQ==
X-Gm-Gg: ASbGncuCLbx+NUHs1VkDT+ihTyUpsqEvKzKvqEm66ieVS93emHiESXYgpBWzgS5viId
	HN89Fd5jZOoDQ7m8wbzhQm7X+o0tV1Xn+DpLv6SSI5mpUYcBsUjzX8ZE6TTtO1xN8ZJd5oUYNud
	CNqjkCxl04RvmaBXlpT/PNurSb/UNQZlR3Dv5YUCurzc6f0fuhis3PrYjDbXY/pm8EqOl5BZ62V
	43D9m5afQXUVc+Lzvx5UNYZvZROIRBRJ3zyHH9lrm9OgmO9A2SHErrdvJGTcapWnoA=
X-Google-Smtp-Source: AGHT+IF1ZIPyhPMIsBOrLkPqMM0CspLLHLyCMAkP93UYVxdRI64cHbeoj+KnpGweyYlZfjm5rQo/Ww==
X-Received: by 2002:a05:600c:a09:b0:434:f1e9:afb3 with SMTP id 5b1f17b1804b1-436e267863emr91888235e9.3.1736513841515;
        Fri, 10 Jan 2025 04:57:21 -0800 (PST)
Received: from eugen-station.. ([91.75.105.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2ddcb5bsm87602755e9.23.2025.01.10.04.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 04:57:20 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: liaoweixiong@allwinnertech.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kees@kernel.org,
	gpiccoli@igalia.com,
	tony.luck@intel.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH v2] pstore/zone: avoid dereferencing zero sized ptr after init zones
Date: Fri, 10 Jan 2025 14:57:14 +0200
Message-ID: <20250110125714.2594719-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In psz_init_zones, if the requested area has a total_size less than
record_size, kcalloc will be called with c == 0 and will return
ZERO_SIZE_PTR.
Further, this will lead to an oops.

With this patch, in this scenario, it will look like this :
[    6.865545] pstore_zone:     total size : 28672 Bytes
[    6.865547] pstore_zone:     kmsg size : 65536 Bytes
[    6.865549] pstore_zone:     pmsg size : 0 Bytes
[    6.865551] pstore_zone:     console size : 0 Bytes
[    6.865553] pstore_zone:     ftrace size : 0 Bytes
[    6.872095] pstore_zone: zone dmesg total_size too small
[    6.878234] pstore_zone: alloc zones failed

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
Changes in v2:
- reworked to check for c==0 instead of ZERO_SIZE_PTR as suggested by Kees Cook

 fs/pstore/zone.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 694db616663f..ceb5639a0629 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1212,6 +1212,11 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 	}
 
 	c = total_size / record_size;
+	if (unlikely(!c)) {
+		pr_err("zone %s total_size too small\n", name);
+		return ERR_PTR(-EINVAL);
+	}
+
 	zones = kcalloc(c, sizeof(*zones), GFP_KERNEL);
 	if (!zones) {
 		pr_err("allocate for zones %s failed\n", name);
-- 
2.43.0

