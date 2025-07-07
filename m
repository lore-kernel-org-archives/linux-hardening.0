Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9519A288C2F;
	Mon,  7 Jul 2025 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751894650; cv=none; b=TIPwS8rsdJuCk3/jhZLHL+Uw63L1LTX76Me6mRkUmlhlsu/9G2ld0Jy//8N1eQIaUfNUVOG+vc045lJvY5dP3fLz4uYdKDM1/JIZ1SnG2GPma4vLJI+bCED8aViazqGxGtHh7CW3xP2Qk+1yaweOmgkx/zWQPXRSl3XlkWbIfWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751894650; c=relaxed/simple;
	bh=8RjyTvSuow44Pogbmx4RVAaPQM0w6Xn4O6nez3/oVO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bOOHwFJ+ZGC29n1KcgCprZ6CJNhEQZfAAUuRhlMFVhrOiFbvLcnCfMpq6OV9YcxBaSalMj5LtJ+hpBszS/+QReSi7Bx6ypc18nBqknXLqHKEMkMXZr7fe1f8MysXtVyg7bmhvrWX0bmVW8nuv3DQoL/cuSnpCS2Ocqaz8Z+WnSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B5twk7yd; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5twk7yd"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a4f72cba73so2646120f8f.1;
        Mon, 07 Jul 2025 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751894647; x=1752499447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHwATOF4+CjMS6IdiNe2EhFIMS0JQ1rdlybp9oGNmTE=;
        b=B5twk7ydaKGsCAJZhjS9tq5YpaStwL+ejITJbB+VG6viur9W+Kpf5kKvuMCihl4rQ/
         rdIODzt7DFyaQlg41TIU/p9Ntxc9CAIloz2PFW2sQgvyc2E4EQCC+bgNw/AfAD8XPa5V
         yj9jPH2hthRXUI9GcJsMfRlBrQJNwX00qlMURMpxYZMX4CRfixdkt2zy9C+/tDPZy/6W
         PI4sTaSiLAxD5HgXi11pabQXlFcbnrc9DCoYkvd4rXyJG7rnP9B/m2QaXRn8s9b543up
         xVhVGWWZI5pHkOPqje4+pWa5kLIC7WMyjAN6UK6l1khHhAsnLHV4Cz6ZAwjpe1/ucd2I
         TzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751894647; x=1752499447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHwATOF4+CjMS6IdiNe2EhFIMS0JQ1rdlybp9oGNmTE=;
        b=qmD/06EYoDRcZIWcBgtNXWQNVp245qpMFOfTIlFf6LZBrAulIJydFcoEBH8gMLg3i+
         SNMqmCyhrlWQIYaFrA2368mGOWben0wQYPypSDFfilDoA+TPecSS4FwZGzO4GMo4fcLN
         9zQTZyXYwEwwKD+Dh/51NxUvAKTi7CeIJGyRVbJFKp11qyuV7XqScvfWJztFJR0AS8TK
         bW6Ii+YVT6xsSQjEqWumKdfFTN+L/eqlbMN+5mKepYTOcw44EqHD8AYsHWORSZTadFtg
         kbudrC87LTuDegJ2OHiVYGEFadsmOcCndcVfmDo58FqCpd3z6WeiE1Tn8uyiHXvTPyNq
         gDWg==
X-Forwarded-Encrypted: i=1; AJvYcCV82Ma/T4gl/Z3nS9+fY6vhbj90v2/d3gcZrRz74tGSmODCXrUMGfRaZVxWYqG1+6Yv8sDCt3kfkc0VfkJRTu8=@vger.kernel.org, AJvYcCX0mNQApTE4AqKN91NTDnqMbOy+kVmXerH249jaRCZnl7eq1AwzhUdNXYkUSIJ8518QGGnjNTQAqa3QOYFB@vger.kernel.org
X-Gm-Message-State: AOJu0YwngWvJfoX8DK2w5nQ/FFuXmzJhU3+DXIv7bUtmrFh0RXa5TQyR
	f9vlWpRnq1nxj+fHTWGowecWzLeVS59myzWOd4tsj46+Ppq9EQYmPajy
X-Gm-Gg: ASbGncsYlaYnByoj84u+8E5ufxd0E4riwozvzGCKA7SnZvjJkcYkQXpg3lOdbsMqE2F
	tdpBcji0wfQIJkKD2wAfS96aGjb0ib2nXQu/HagHteN3tS6miIoX9/Bgr517E6YuH1h9k0jQ2FC
	kj5V/XAGmgJKxmTPQSLeXqrA5YTzaTVVotvqMzLtkm8WXjBoVnwFZ/jk7YASTgoxa/+dbonrf9f
	rxwM62Vckdbe8bAsxE+VsjkbfxLVR40jd0sfoKzso9TZW8ARzILX9CBzJzfAOMtnbGc+AaD2Lmu
	4n58luBZHW/VoLPH8HM5OU7wrvDmn/4sClix3AiPzN0ZMyWAMMsxhkYJXRTp
X-Google-Smtp-Source: AGHT+IGtt8GxutZ5uOUaaH2YD0KB42AdE6oIi6ARJQVqLaHmKYYqZ3ZDw7TY0JnpeUWDARtw9Y2XMA==
X-Received: by 2002:a5d:6f02:0:b0:3a5:1241:afde with SMTP id ffacd0b85a97d-3b495b9446amr12338612f8f.9.1751894646658;
        Mon, 07 Jul 2025 06:24:06 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b47225a720sm10198472f8f.77.2025.07.07.06.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:24:06 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][V2] fortify: add branch hints on unlikely fortify_panic paths
Date: Mon,  7 Jul 2025 14:23:40 +0100
Message-ID: <20250707132340.1768807-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Analysis with gcov while running the stress-ng urandom stressor
shows that there are a couple of fortify panic paths that are highly
unlikely to be executed for well-behaving code. Adding appropriate
branch hints improves the stress-ng urandom stressor my a small
but statistically measureable amount. Ran 100 x 1 minute tests and
measured the stressor bogo-op rates on a Debian based Intel(R)
Core(TM) Ultra 9 285K with a 6.15 kernel with turbo disabled to
reduce jitter.

Results based on a Geometic Mean of 100 tests:

Without patch: 50512.95 bogo-ops/sec
With patch:    50819.58 bogo-ops/sec

%Std.Deviation of ~0.18%, so low jitter in results, improvement of ~0.6%

Branch hints can only be enabled if CONFIG_TRACE_BRANCH_PROFILING due
to a static variable being declared in __branch_check__ when using
trace branch profiling in the unlikely macro causing build issues.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V2: add fortify_unlikely macro wrapper for CONFIG_TRACE_BRANCH_PROFILING
    build config.
---
 include/linux/fortify-string.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index e4ce1cae03bf..c740114bcbf8 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -10,6 +10,12 @@
 #define __FORTIFY_INLINE extern __always_inline __gnu_inline __overloadable
 #define __RENAME(x) __asm__(#x)
 
+#if defined(CONFIG_TRACE_BRANCH_PROFILING)
+#define fortify_unlikely(x)		(x)
+#else
+#define fortify_unlikely(x)		unlikely(x)
+#endif
+
 #define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
 #define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
@@ -593,9 +599,9 @@ __FORTIFY_INLINE bool fortify_memcpy_chk(__kernel_size_t size,
 	 * (The SIZE_MAX test is to optimize away checks where the buffer
 	 * lengths are unknown.)
 	 */
-	if (p_size != SIZE_MAX && p_size < size)
+	if (fortify_unlikely(p_size != SIZE_MAX && p_size < size))
 		fortify_panic(func, FORTIFY_WRITE, p_size, size, true);
-	else if (q_size != SIZE_MAX && q_size < size)
+	else if (fortify_unlikely(q_size != SIZE_MAX && q_size < size))
 		fortify_panic(func, FORTIFY_READ, p_size, size, true);
 
 	/*
-- 
2.50.0

