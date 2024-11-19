Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4886CC2C9;
	Tue, 19 Nov 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982666; cv=none; b=q4i3cj2rpTJ6DymNToV58KWSTKaWiKcQFbnDNFeJclS1dbsDNz8FQ7auA5SSDThtB4KhRU8i8W6ufSUYF/t26/nFkpiVAHuwmSHcSZmDcDeeMuvexAQRh2DyDgnw8JbEvqRK0QR/8bTLnX1/gisNgFjnMS//y6kL3YGfdqQKitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982666; c=relaxed/simple;
	bh=9wuI4mEgP6H13OXOjsu4pZ4pTGkwGX+J0IjVJJt1fdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MmZ4a1vvJko8pWhqomFGWR8tJRGiSO+qrc4/nv37gy/wh8gwNKXLz9Ap5Lj8f2sT+vLM2EJU1bS6VzbDSp6uA8T03z1ZAOx8Xa7jbCXkbZKBkGWh/GWLTvsGfT0E1tQ2MJrtRAulC+7ubjCUENdU7l5gTDrCc6LBcJ80c2zDGac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLP+tgoV; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLP+tgoV"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea2820efacso274135a91.0;
        Mon, 18 Nov 2024 18:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731982664; x=1732587464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h8leqeB02RcmUoIWGIg72v1kV1jtT+oDx9zz9IaSK4=;
        b=BLP+tgoV5NYvCboqHCf9mv7yZmqIZi9eJjFgJF4kbVnAZHQKhtf7BcB3wsRXDaNHEf
         Bg2EkEKS18c/Dt/VfqYO0NAfahKD5qZ1c6K/JayFCX25ri+CqBqUAt6LRzr1Jv9oW+T+
         oO23uRuGG15Mz8mvSwaOfIhpFHSQLcuem1ZWn36Wfs0vdnw64ythtsBwmcQ53koloLXc
         vXcuggcn4CdmQA2h27QkDm76Sui7ZFDz6ZNyElhQYJcg+HuoSYFoWDSUuE9aW/NJ9nX3
         QB6tpulCcvhZFp+NujyK6silBDajBj5samxB0apqQzZ4ctXW0MkLmIooPA/DkV1KqRZ3
         YoJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731982664; x=1732587464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h8leqeB02RcmUoIWGIg72v1kV1jtT+oDx9zz9IaSK4=;
        b=WrjhKavMHdQIkGHQc0Tz6Abnrw4wxJzc7XFJVV7VQfFXOvn2D0eyJSoyeB94DByk1+
         VZrX1eZIDe+k9qtC37T7VXHseZr85rMONq1p/zkU5dmIgX8S6BknQrZ2hx4I2PnyhaS2
         i7eSob0stRRuM6LgmTIgDTu7goe7xt7ijzsKncQfKbcjjwSROxMmkBjnKTV/NE21D0wf
         68nPyx3zbHPNGQovEEFrsV4aQFPie1GpzU81LN3HroCbM8D0clBC87gT4cFoqXsDYSWA
         MPThBQVvQle+Qnbu6eVvi/cLVRJNdg5g0WZQ7zJjqXAC0tr+R6O+kuQx2TD2ltAGl/XZ
         Mdbw==
X-Forwarded-Encrypted: i=1; AJvYcCVpCV0vFu+3IrzqaPcuwV1dBaOJg6uZZD/FAzcKzAA6O3klPEhmHNRsb58kv9OJ7y3PURvdQeBjzJfYVhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsmm4QS5lvh6f5o2DinV/APnltiYlH7dsDYgS5B8MY3GS1L9RQ
	fO6gt5C8pL45jMbEMjByZTgvwf2aBW7/9WkUt634d24G59VtOAhh
X-Google-Smtp-Source: AGHT+IGnGqne4ryFm0yOIbMsXEIXE0qhpMeiCkxb2JIje5687jm22hPY/4hPnaOKfjh+NSUNu3/1OA==
X-Received: by 2002:a17:90b:1348:b0:2ea:2bdd:4433 with SMTP id 98e67ed59e1d1-2ea2bdd4631mr6511614a91.1.1731982664546;
        Mon, 18 Nov 2024 18:17:44 -0800 (PST)
Received: from dev.. ([2402:e280:214c:86:d61a:bb21:5b09:2d6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024b82aasm8244129a91.33.2024.11.18.18.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 18:17:43 -0800 (PST)
From: R Sundar <prosunofficial@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 linux-next 1/2] lib/string_choices: Rearrange functions in sorted order
Date: Tue, 19 Nov 2024 07:47:18 +0530
Message-Id: <20241119021719.7659-2-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119021719.7659-1-prosunofficial@gmail.com>
References: <20241119021719.7659-1-prosunofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rearrange misplaced functions in sorted order.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 include/linux/string_choices.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index 120ca0f28e95..f3ba4f52ff26 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -41,23 +41,23 @@ static inline const char *str_high_low(bool v)
 }
 #define str_low_high(v)		str_high_low(!(v))
 
-static inline const char *str_read_write(bool v)
-{
-	return v ? "read" : "write";
-}
-#define str_write_read(v)		str_read_write(!(v))
-
 static inline const char *str_on_off(bool v)
 {
 	return v ? "on" : "off";
 }
 #define str_off_on(v)		str_on_off(!(v))
 
-static inline const char *str_yes_no(bool v)
+static inline const char *str_read_write(bool v)
 {
-	return v ? "yes" : "no";
+	return v ? "read" : "write";
 }
-#define str_no_yes(v)		str_yes_no(!(v))
+#define str_write_read(v)		str_read_write(!(v))
+
+static inline const char *str_true_false(bool v)
+{
+	return v ? "true" : "false";
+}
+#define str_false_true(v)		str_true_false(!(v))
 
 static inline const char *str_up_down(bool v)
 {
@@ -65,11 +65,11 @@ static inline const char *str_up_down(bool v)
 }
 #define str_down_up(v)		str_up_down(!(v))
 
-static inline const char *str_true_false(bool v)
+static inline const char *str_yes_no(bool v)
 {
-	return v ? "true" : "false";
+	return v ? "yes" : "no";
 }
-#define str_false_true(v)		str_true_false(!(v))
+#define str_no_yes(v)		str_yes_no(!(v))
 
 /**
  * str_plural - Return the simple pluralization based on English counts
-- 
2.34.1

