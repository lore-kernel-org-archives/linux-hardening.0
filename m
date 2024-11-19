Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39B013A868;
	Tue, 19 Nov 2024 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982672; cv=none; b=LGEBeXzGrb86V0AsuUw/SWKsvk5Frv8qggPnjkvdKSQgEWob2BzObMfpmInxuzPpLzMU2o7+FhgDYtWWASz80GCs920rfVIFffJvy1FrHC4AZ+dWMH4k5qBNskQhEJGw+9m6TC1uxl4TFMuxYcBxjng2Ja/UYBpawWTBa3Z7tss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982672; c=relaxed/simple;
	bh=7L6ua5/pSShMdfVFfn+0WaKr22hV7sw589mcoOtSbEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7A3B7e84prpOwfnjhjxENHQHmfeptVMGUdRrNcWFHani7A9LRAXuIeQn0gRe8aZ4ritvQg075mJtZyAG+vdAUILmFYlGrWovHt25zLzunRw0z0wMCuMmqW7MF8a3quya7o56SYgz7NjNN2ta+I59PtEgRas4jbyQiRpb9GdH6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpSyhPzU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpSyhPzU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ea456f1029so162502a91.2;
        Mon, 18 Nov 2024 18:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731982670; x=1732587470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QhTqy3e/Sj/U+p3Gc3V7kqvNZvj2Ji0rTvyB0P5gl2c=;
        b=JpSyhPzU1BFVS+hC+ye21HDCWt6VY+wTT3F/FVLHvrUXoRPaKO/zqzOvJRfQD+mh+w
         JOhMnRbi/WCPjRwVTu40yzaKClXwov4BDyYbjG6I0/UHIH7yi7S+vKNfHgnvLUhwzC/4
         U0ceTmQTXelXehnA6LEkfXVMav0K/rr7cv8XUVlYhJcvw2ycw7o1M/IIs/FdN/Hac53/
         VDZDbuz8jpcEc9ivhDp3trlzKg9I9RM1AKnz1x/V3RmPfxr9MHkpeAWqxn9WxoasY48t
         FMaCXYZcceC5xwlp2mE9+fz5uhcUhVxYhfQMCFzgo377cBS3cYKlCHemIj/O5UCaCCCV
         2rCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731982670; x=1732587470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhTqy3e/Sj/U+p3Gc3V7kqvNZvj2Ji0rTvyB0P5gl2c=;
        b=lRpA7LX2MIRlyu3SyhuVoWPmutYaWI+ZxOE1KezlYDPl8nB8XbkF66pE5XqWEjBoDu
         A6greFzvqPlvJS/vTCHlAYKuqzCIsoEBn/hpFK4Z2Z579ktjAqbwIaI0kZEPEEhtUcxv
         GUu2AK5qH8BFCcI3n5YTKGHguiTLAzZy+PBb8UmAfTobtpvPR+MNxp+kxZgCtqsSfqtl
         25GzI8+7tadhW76RXBJgXNmVNpNjFpRauFsVa6TjRnaQLVw/UlJjJjY8yqpDuVzVmZQD
         spEafgLYofAp7EE+vVvM4DzI9lUcSN2epwL8X7+wR7QgfJ3f4QB2APKdM/dWiMyg2DNb
         547A==
X-Forwarded-Encrypted: i=1; AJvYcCWRfEibxDYUQCZB90xclLnZhTQNym0ID5HokUDa4Rb/l2HIDdvzwLm592AnlCzfBJUKEQ1Pyqype9SR4Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhM3dtDN6GHiFMP1XmK+mWpHZjZLiIHwj99xaB8cd/xGLeJ60
	2dMqwzo9AAhCrgthYlrwjh5GKNkWxPLKpNB0ghXyzWQ1/BWYE0ED
X-Google-Smtp-Source: AGHT+IHfijkBqoan0rEFjO2OXxS5pt61GvLBYzkmcel+tYUWbNVEnbOYcpS83JH7mpm0kKLgzXZsFA==
X-Received: by 2002:a17:90b:3b82:b0:2ea:8aac:6aab with SMTP id 98e67ed59e1d1-2ea8aac6be0mr2153020a91.1.1731982669918;
        Mon, 18 Nov 2024 18:17:49 -0800 (PST)
Received: from dev.. ([2402:e280:214c:86:d61a:bb21:5b09:2d6b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea024b82aasm8244129a91.33.2024.11.18.18.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 18:17:49 -0800 (PST)
From: R Sundar <prosunofficial@gmail.com>
To: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH v2 linux-next 2/2] lib/string_choices: Add str_locked_unlocked()/str_unlocked_locked() helper
Date: Tue, 19 Nov 2024 07:47:19 +0530
Message-Id: <20241119021719.7659-3-prosunofficial@gmail.com>
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

Add str_locked_unlocked()/str_unlocked_locked() helper to return
"locked" or "unlocked" string literal.

Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index f3ba4f52ff26..a6bbf4e42c13 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -41,6 +41,12 @@ static inline const char *str_high_low(bool v)
 }
 #define str_low_high(v)		str_high_low(!(v))
 
+static inline const char *str_locked_unlocked(bool v)
+{
+	return v ? "locked" : "unlocked";
+}
+#define str_unlocked_locked(v)         str_locked_unlocked(!(v))
+
 static inline const char *str_on_off(bool v)
 {
 	return v ? "on" : "off";
-- 
2.34.1

