Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F4320A2D
	for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689834; cv=none; b=qi0NskMpBHVTfBHRz5u8hQLzR3PvqLwIU137PXNDz9WmyM442WMxuNOpBPPq/EnqNA0j8q9be7U3RU280DnWRPZX+7JLLXAf/1yF+in6PpnMCht+4uHqR6R5ugkWDOvoiND7aVw7qY2Pr1J307edi+D9qJ5FoJCFLNtclOMjgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689834; c=relaxed/simple;
	bh=k5/I3UYTWdnJjKzBx+/VZfwmc+jXcyZQNgYc3CqZv50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAZ6IwvPsokDncRSRa61qsMNVkgVRDjCriq7d8baqnRrdmVQ2n+f91MisDxn7iw+kelHD97f/duaEaJYZGMBCQBFjKa3GsMN1p9AlU6rbnHE5GgurSCYWsRbCu+uPjvR2E9eIdPqZtXKrxwITMaEnX/0nTRnom7a6HUWZWIBktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sWZ0DllT; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sWZ0DllT"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-ea1679ba47eso1448094276.1
        for <linux-hardening@vger.kernel.org>; Fri, 12 Sep 2025 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757689831; x=1758294631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1ubFmujdan3yUawwr3ZvZLjd/mUy6/pR3VRzzGBTTA=;
        b=sWZ0DllT4BQ0jI3qqkg+XD6RTzjidkX4MxjJia4EeeNc5bXrnz+bG3bw8URL9PUYWO
         +sSP1xwl9ipPyC9kHfPp5/11hMMugNY55NggwsdyDYgt6OONEMiodLwMFjkAoJmyT597
         r0Bt6FE7vP6ZcYipiv0ddHKggikm9iHpIF/bzZ8NovLIeq2DwR+P5xIanNGeqGDi+4O4
         alHKWBpiQPCvlncXdI79f/JA2hpchOfrcTetMi43L20OmVTbzd+FbOHnF0DfZ5q8do0I
         b1JSnkdNq8Zgy7f07l+0Q1C5Y3hrXb4Nmyv4A2gKyIqWT0Ru/niXKF1+6AwFQYsekmsP
         4eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757689831; x=1758294631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1ubFmujdan3yUawwr3ZvZLjd/mUy6/pR3VRzzGBTTA=;
        b=VYmTj/6fWoeUJpOCGXx42bRs1NNnu/iViKrz6GzRBH23XMN38aVoLdtIayBTpB/4ld
         3GO8GazE2fk8ZX8jSEGcUjbfqkHaUlZr9SimMfp4mF3mAzUD8udY1/1J/gReSttGFT8H
         TDRJv+RgvSXRcBxiXijvH1ircH4WQmJL3bry2TLY5KTnAbX7lk2rjQNRUlXBK+Tq7Od0
         kIm5n6ye6GxvoAI3VlTx1r1ER5u67h+B1E0X5aXf8EFqwhOhRyenJKRhMpQBtvXnlTBD
         gjA/00iQ68VZ99OVX1F+IIhdqg02KFtqG/53VEYX/GlquIUPumgXl+LUTUdgdfdeuzTC
         8ccw==
X-Forwarded-Encrypted: i=1; AJvYcCV0jukbLT1KkgQsdg6ADiA6JorlypVt8tyBjFslc2YsEJKuRk676NtEEHSvT4dmblJX/yVnCYrKxRarcpc6MUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44gqGsiHOzh5fyjypelYFjU0TiIhhXmXdTIQTlu4QwhkMiE2E
	qZeLzxSNGVJiXxJXvmew0gfG91K+5t8Ag5Etn781/HQRrt6+3jY93COMXW3O/MZLhUs=
X-Gm-Gg: ASbGnctkJ6Go2JWFjx6/LOP29mZWTtmbupPznz03Mx+FL2c8Wxve1eOlySIMzUZgcDp
	ZxnD6ECT9HLxkIJ+wdjXqOrWmFDU4avp4kF+cJb6KpIv9Xch4ZbLXJwd8BvHEJ1izZBwgbRGwGM
	zzWUvI0o+nhC51NdxMAhLRRt9TXB1ONlhbEm7AaSVX5o5+I6AALE90rjTAVKn9zA7ASDkNOnVq2
	6u6egwpyQoagRIde7p8K4SDws0/GRHnRREhKkRTWgAK/vKWUbjmnE6gNsGtebYLNrbjHirSP9bq
	EvsDyBkcgCaZK9k0uD8neby5mnTqo8pwshHosZMumZFSeOW9vaJQVltOV+opPNFQxXBBPXs23L0
	7VvrDV04CgcCOrAuwiBrR8Bdke+3Hgn789NannoUHOFvv
X-Google-Smtp-Source: AGHT+IGQPX6y0JKi888sfyXxAah3q3fQIwu7cpMyf9JJWf5Y6/yYrim06D3kAGSOfpN7Gh01tRPdkA==
X-Received: by 2002:a05:690c:c08:b0:72a:2d15:a2a2 with SMTP id 00721157ae682-730627c9015mr33553397b3.11.1757689831515;
        Fri, 12 Sep 2025 08:10:31 -0700 (PDT)
Received: from eugen-station.. ([145.224.119.89])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-624841586c1sm1302244d50.6.2025.09.12.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 08:10:31 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH v3 08/16] init/version: Add banner_len to save banner length
Date: Fri, 12 Sep 2025 18:08:47 +0300
Message-ID: <20250912150855.2901211-9-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912150855.2901211-1-eugen.hristev@linaro.org>
References: <20250912150855.2901211-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add banner_len to store banner length.
This is useful to save the banner into dumping mechanisms.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 include/linux/printk.h   | 1 +
 init/version-timestamp.c | 1 +
 init/version.c           | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 45c663124c9b..5bc617222948 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -12,6 +12,7 @@
 struct console;
 
 extern const char linux_banner[];
+extern const int banner_len;
 extern const char linux_proc_banner[];
 
 extern int oops_in_progress;	/* If set, an oops, panic(), BUG() or die() is in progress */
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 043cbf80a766..1fdd795be747 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -28,3 +28,4 @@ struct uts_namespace init_uts_ns = {
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+const int banner_len = sizeof(linux_banner);
diff --git a/init/version.c b/init/version.c
index 94c96f6fbfe6..68d16748b081 100644
--- a/init/version.c
+++ b/init/version.c
@@ -48,6 +48,7 @@ BUILD_LTO_INFO;
 
 struct uts_namespace init_uts_ns __weak;
 const char linux_banner[] __weak;
+const int banner_len __weak;
 
 #include "version-timestamp.c"
 
-- 
2.43.0

