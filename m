Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD6F20E026;
	Mon,  2 Jun 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878737; cv=none; b=uTnpHGdEN4fVNESbkW6JET4K7V8aR8EEswOzjx9BAnTQay8ZV3xcoWQNsnF9ALdcxD3vCFgTCJSqjgyzJJVvk/f+KmbZHVBMEh2jAV6YHag0Us6S138vF5OO/u0AFX7uHOhpSLq4QbuO/QkLNMooLtWgHtNg3xJOZ1fVrxP0tMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878737; c=relaxed/simple;
	bh=X+E1oAHuMGqBToj3jAeeM8hGE/nfxaFldIcCYaSnIys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPc4fEMNjxQd9XxQOWQU9qbSizii2voLb48iBigGn6eqMycchLy9cY+sLwp3hPa0awPqCl5/q6Z3uZRwsbFLNLtOkefMjZh1SaedjAJtGtEL53ukGI3E/w/H4ZJGeDApAf+Z2NLW07xAIwrCFRM4ZaRyWsrsm7CeNKbB3PP4m5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzKY6x6z; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzKY6x6z"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso4980239a91.3;
        Mon, 02 Jun 2025 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748878734; x=1749483534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7WwE2szzySMaSbvnDjlIKqzFYgvBzLvgLKYcMgSkS4=;
        b=DzKY6x6zXNPgPxGjayTKSa0Fp4jIXZm553BmIcV3zlo74Vlj7KO6hV9msv/98TyHBa
         l05K3dpncCb+8vBvOCwIFQcgUeiH2s0ho3rGkIYjoVq0Yt77XuEy0k3YD1Djwpgr4Nkd
         3D5ZMiOGWGGrrJkEnJaj7AQFElC9wuYd77dnUHkzC3UzfmBeVtwI+ARf/Q0etvgeMLWc
         zg9/re+ko5n0xrAR1RkfARfAqhVLrjvp3VlxXoMmt8GloK+tMLtlsxGw+PD9rJKISmKA
         PQFoCnbFuPuXa0D1naSVqUNffMAP//vtFFWU7kNzO3ucdHWmUf/6vILATJrvHQU65+8V
         KS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748878734; x=1749483534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7WwE2szzySMaSbvnDjlIKqzFYgvBzLvgLKYcMgSkS4=;
        b=ZCRSLPbezVuInY5U6zww14TxA5uB1iHttgCvfV0hKX1UXb+cQxWgxQCifu2v56IDfN
         btILF1QQwqFvhbVr6hk9mNP/KG0Rv18BoerU3gy2Bzehm43+Qj7UI+kv+6KEzjrP7ywx
         8t11BHMwBSMSSilVFxI9KmXi89WKDD+lTzKCyY3dupNBFUN01+IcxPgYwkli2Hyy3Ggq
         e1HkaD04Q5HGGjdzv0HSTVvxOmoyvzKum/0vDyuSH3osmXA3Iv5F8Zhiwclwcn8L+cBp
         i5Ayge1rdpIV7pxXBamVHnAgOPeJMteya/MKyrcjKnPtPg/i0WHFt6r9Pe82CtzL/nGf
         +ywA==
X-Forwarded-Encrypted: i=1; AJvYcCVOP0qmQZvJ1AjI1weE9JsfzD59d8+1EhwrUs0JCEFUsB4pZtq6jrDn2AKlpV7d8k2GoKimqEbadYCQJScl+0U=@vger.kernel.org, AJvYcCWfJX4kw3xrH4/bJGunBQ/Ipmn70YIE3yFJnt/KJ/DgtqXMwEU5LBQPHIq5MPFScipxUmaQ8TR317H79YFo@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+6spbGDA09Uq1qB5u1nqEeMGBoik25igqQ0Z4hxu0S/uMMpF
	bdxBgVOlBWyEU+kEMXCVHnrh0k5hpGvx47/2loERFTxzuJlZtujsu+xn
X-Gm-Gg: ASbGncvMr0yH1eCx2ixawWzMlNQxx6WxH+mnRePc+77TK5cxL4cvOdDOB7yq/RWsqe+
	2brWqrKwRFTzmOtv0S7hiwP+5AD8pnTJE0+fmIcCztG4WA0EPsqA6WR5Cwub2LJhkTMnBmMWnMx
	Zj0qqH55dr+0v4ZsYpf19V5caiYpMeFr/WqcBxC5r9CKbWEjhhrIDdtYA/vyUolyBQDvtMNR/sv
	do80fwfGsxwoA4v0x6zUvHzhLAqTS/H1zXyHBwcIQZtrQrn+84FYo6mjUwgrY0KGFTb80RsGjww
	AwFr+Q8yMqRB0a9xzY9vc9W3FHEkl4ASEnrmp2fJ2CjSg/dbDRBPL+k/gbfQFhysN5pViaGKyEC
	Ko2wCga5eDVTQLlKf8J3TCASg+6I7uEoKft1Cl6CLgizeLQsSumw=
X-Google-Smtp-Source: AGHT+IFgM04J1ixGhBjY/yBdwy92JEZIfIDZO9+iEzcpVQT27xSxfUAe21gWN7DqRcoN3poq5CvmHA==
X-Received: by 2002:a17:90b:268a:b0:312:db8:dbd1 with SMTP id 98e67ed59e1d1-3127c6bcd95mr12754409a91.5.1748878734517;
        Mon, 02 Jun 2025 08:38:54 -0700 (PDT)
Received: from va11o.lan (n058152119137.netvigator.com. [58.152.119.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb9d1eesm4980157a12.54.2025.06.02.08.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 08:38:54 -0700 (PDT)
From: Junhui Pei <paradoxskin233@gmail.com>
To: kees@kernel.org
Cc: elver@google.com,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Junhui Pei <paradoxskin233@gmail.com>
Subject: [PATCH] ubsan: Fix incorrect hand-side used in handle
Date: Mon,  2 Jun 2025 23:38:41 +0800
Message-ID: <20250602153841.62935-1-paradoxskin233@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ubsan_handle_divrem_overflow() incorrectly uses the RHS to report.
It always reports the same log: division of -1 by -1. But it should
report division of LHS by -1.

Signed-off-by: Junhui Pei <paradoxskin233@gmail.com>
---
 lib/ubsan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ubsan.c b/lib/ubsan.c
index a6ca235dd714..456e3dd8f4ea 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -333,18 +333,18 @@ EXPORT_SYMBOL(__ubsan_handle_implicit_conversion);
 void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
 {
 	struct overflow_data *data = _data;
-	char rhs_val_str[VALUE_LENGTH];
+	char lhs_val_str[VALUE_LENGTH];
 
 	if (suppress_report(&data->location))
 		return;
 
 	ubsan_prologue(&data->location, "division-overflow");
 
-	val_to_string(rhs_val_str, sizeof(rhs_val_str), data->type, rhs);
+	val_to_string(lhs_val_str, sizeof(lhs_val_str), data->type, lhs);
 
 	if (type_is_signed(data->type) && get_signed_val(data->type, rhs) == -1)
 		pr_err("division of %s by -1 cannot be represented in type %s\n",
-			rhs_val_str, data->type->type_name);
+			lhs_val_str, data->type->type_name);
 	else
 		pr_err("division by zero\n");
 
-- 
2.49.0

