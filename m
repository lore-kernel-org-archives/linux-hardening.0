Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDD621764B
	for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787470; cv=none; b=t1gIwlhS4jjLkK6gG4D4xxLIY6AHKxzHUnGdiibdfzzmgKtbuAICizMocdQelxPrSbcISPXYtM8EgDuQ+hN8vMnGnjX2HP0ZzyE1xqu8Wx+FITyEE2ZNksDRU2GV+0efIhKF9NItPU05jfXu/mnWjGnGGMNo1KsBTr7drfiDsQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787470; c=relaxed/simple;
	bh=/cVyc1rh86otJZ3wkWGcQ4N27XkUc752xM+g69NmlEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWtRuWC+fJnZ330bCeCM87yzzqK2WVyZHLtS130bpUubZ1tV2HdSTzJthd7443LzPRZw47RmEvItAAUFK27NRQpwsOi6nGBTX5lbGXADvLYBKrZZ4geiN/N1VjFS7ALJUIZ0N5GQ8TWxGUASPp8+oAEhuzjKzHge/vuX8Ow+DJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zwToEZ5d; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwToEZ5d"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so531357566b.3
        for <linux-hardening@vger.kernel.org>; Mon, 17 Feb 2025 02:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787467; x=1740392267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6BYtQ0vagWpucItzriIw7qjC34OuqzM5CfNcTita1Q=;
        b=zwToEZ5diBI6TG5Yp7XbbbcR8h7sfZJNrVqOlFEIdGyENZ8PjZXze1+6sJggc62EOr
         +VPtaoacD1FTJcjXLTiyHjCLUYDKQePfaCWicY2V5fp8RDpkbfjl0HfJlQxLw8BOYxuX
         w8RBwdAozE7aGJRV7v2aIyP9hMGjjsJtUoGIQfnNCMKvcc2/PzDeEAowEd0+znlUNglJ
         hQ1FxOnc7YyFsAansc328Do7loPvoCDgdDS+uCz986oKumrg7P+lp6jvyYlAo7KD4fvX
         s8cZuyYhZr++xg4iRb4qK0UlNJXpUvINFjPT1YuJvN6m6EvN0fXvmgvnBFhbF+ibEghd
         J1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787467; x=1740392267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6BYtQ0vagWpucItzriIw7qjC34OuqzM5CfNcTita1Q=;
        b=oyi8FPZpy1Dh0D03xfLSdD1qZaDMcjrTNNrEANQJNFVcY0tn9hWrqwYIJxzh44Eqrf
         zA/1o/fEqLObGFBOFNuoQtveKnoGROy1fyj7sXMjrphOq+wmYS+3DTFPmL9H3aFOKdX4
         3OU1LYEl/dOjQRHezj9NBAUMhZQMObvBWz2ODREsXi96ME8Jh9FoDblAU8PT6T9vppeh
         tSa3L/PzLNeUsy6kKpmDA+ShDIU5wnPVLPUfujyKM3E+m3utwBt+l7c5zEp+q2XSdyDM
         nT5D50JzgnaSZgQdmOKzYdx1adeEtmm5w0FNYPkYI05tD4Mefr4PeWtp1UcSKPyMRbFP
         QfuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe2n9cpdAQTV9O4MS+9zTiMHB/Eq9RiMvWa3GaN4eLi502ZqiJC9Mnht6SPumS4io5Inv9u1ydDHAJj7LxzvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz468uU7DYoJesQ+eqj8DbXzKlXo0/LKP74Q+QbtVYAa36l/iGo
	RWQcGVL2lhP6SLvqvEgtfQ5PIfuksrybpr7D7Ig+pRwVlbbsj1zMEH5s5dybps5rP6hhbZ3UQEp
	yidc=
X-Gm-Gg: ASbGnctOk1HF4/pVxuEf07O8hU/eX27V9sHsooSTjfPxlJeW4plHJnc/kKD9JjcU8ce
	+XDc4wU+llPcDif7LlPFnQaOcNzQQzfHT+HHGGLIh5ywOUQwq7bgmvZHBpWr0i/qNjkw8TSD63Q
	4eSOpy4F9OqL+Lzw5xDJagDSymUz7VMGW8YghHcQKA0fLEKbaHIz0vre7RyCTxR0JId7kZBVo2D
	KYhoSdCZMBcUeMbiYbz+LcZ5ZNrFeDoNaQfeOgsQba5QOeRq9Fw9k2DgKj5Oz8YaZIAS5lO9j14
	FQvY9e7bduqe7kQH5/8zc3cX
X-Google-Smtp-Source: AGHT+IFgDnivD1OBw8RBeqZ1T3wvlR/UtXkBn7pRJ5OfcJBMf9SgRGM/cdk3Igb/07dwRLGbAITBVQ==
X-Received: by 2002:a17:907:1c85:b0:abb:6ea6:161 with SMTP id a640c23a62f3a-abb70e4e28cmr925547666b.56.1739787466832;
        Mon, 17 Feb 2025 02:17:46 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:46 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 01/10] pstore/zone: move pstore_device_info into zone header
Date: Mon, 17 Feb 2025 12:16:57 +0200
Message-ID: <20250217101706.2104498-2-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217101706.2104498-1-eugen.hristev@linaro.org>
References: <20250217101706.2104498-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Struct pstore_device_info is used in pstore/zone, and it's
not really connected to anything related to pstore/blk.
To further improve on the pstore zone and allow other types of
drivers to connect, it is logical to have this struct into
pstore_zone.h file.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/pstore_blk.h  | 14 --------------
 include/linux/pstore_zone.h | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/pstore_blk.h b/include/linux/pstore_blk.h
index 924ca07aafbd..d0c8fb40c46c 100644
--- a/include/linux/pstore_blk.h
+++ b/include/linux/pstore_blk.h
@@ -7,20 +7,6 @@
 #include <linux/pstore.h>
 #include <linux/pstore_zone.h>
 
-/**
- * struct pstore_device_info - back-end pstore/blk driver structure.
- *
- * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
- *		linux/pstore.h. It means what front-ends this device support.
- *		Zero means all backends for compatible.
- * @zone:	The struct pstore_zone_info details.
- *
- */
-struct pstore_device_info {
-	unsigned int flags;
-	struct pstore_zone_info zone;
-};
-
 int  register_pstore_device(struct pstore_device_info *dev);
 void unregister_pstore_device(struct pstore_device_info *dev);
 
diff --git a/include/linux/pstore_zone.h b/include/linux/pstore_zone.h
index 1e35eaa33e5e..284364234162 100644
--- a/include/linux/pstore_zone.h
+++ b/include/linux/pstore_zone.h
@@ -54,6 +54,20 @@ struct pstore_zone_info {
 	pstore_zone_write_op panic_write;
 };
 
+/**
+ * struct pstore_device_info - back-end pstore device driver structure.
+ *
+ * @flags:	Refer to macro starting with PSTORE_FLAGS defined in
+ *		linux/pstore.h. It means what front-ends this device support.
+ *		Zero means all backends for compatible.
+ * @zone:	The struct pstore_zone_info details.
+ *
+ */
+struct pstore_device_info {
+	unsigned int flags;
+	struct pstore_zone_info zone;
+};
+
 extern int register_pstore_zone(struct pstore_zone_info *info);
 extern void unregister_pstore_zone(struct pstore_zone_info *info);
 
-- 
2.43.0

