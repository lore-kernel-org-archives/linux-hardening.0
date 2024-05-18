Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC481A2C09
	for <linux-hardening@vger.kernel.org>; Sat, 18 May 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715991442; cv=none; b=NpumBJ4ogsEvc9wV0lzsbR7v7WSLMtjLyu2Ztc7BLqgxmYG5nAhXHPFjt1t3uABW3E8OboIp6zKrj9agCodtvP1KFkSuMLYuqoZ9dFjWawsahTquAwtNvTgwzng1sL16S4KyFvBrHMPy2trP0b/WwuBJLgHyzKLynhb3qbLCaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715991442; c=relaxed/simple;
	bh=Ns+G8cIhe6RmVb+HVSbykTeCqAmMxrZ97rwaVohwt5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Yz7Xxi8vbPN7QvmBOUz82b/TGka8CmO9uZWzMPFMaF/YkiOkJKTPonJCERLpz1fAZBMD3t2GU4tZrIyraXeHEcgIFbN01f8sl+Axk4CEfQ2YIsyJEv7EtF+yJo2qov3k7p4XPlG0/5aawVIblv7Gv/4RscREfDP3E2AG8WXfFjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lMUePSnb; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lMUePSnb"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b278cdfad6so356386eaf.3
        for <linux-hardening@vger.kernel.org>; Fri, 17 May 2024 17:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715991440; x=1716596240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9uz2Ul+URJ48Z5Jx7gMVO+5xGSwUIqgOXMNbHju8Pw=;
        b=lMUePSnb4ZLjYlwcRNMrOv9l6chcHbRsetb85sTqYaY6R0uPklcW4TEvq6d4pb9UZQ
         xg/U9TPqPtDAY2edJ3GnBmcHKnK4DTIdE6OiATD1ZUI5HPozJGnJmhgq1muZ5EO4TTvg
         vmD2ADVwkiKkyYU8BFtmmiGmWqwTAvVMRuf64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715991440; x=1716596240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9uz2Ul+URJ48Z5Jx7gMVO+5xGSwUIqgOXMNbHju8Pw=;
        b=V8/DgEhJeRS+3WB9E8ZuHNpvIhn+qwod5bHaOdAdrD8LachSiwyNT6eucpXDxfat+6
         6VHhvnfSOC5eXGLwoOxdW+egjQRoyBJ1+xz+nyMuDl+a9qB1u+vfjYnPocYXe+97w7N4
         MBChoy6WV1fu2z1U93jjzSp0QX9MILte6tFko4RZK6Sc4IRhtqfkvQVFr4ls/Oxd+u3c
         DgszytscnPkncWMwtq5b6sRblEV/ogMhdhxt9YAo7V6BXqczNFC5B9k/g+l1fUwrFoUJ
         kCP9TVJuRculO/XkDqaD1/5oFbBVBb110at/m8Gi3cb18qP00qpofbtgjTkOWb3VUZ+0
         vzNg==
X-Forwarded-Encrypted: i=1; AJvYcCWU4jgR/KpejsizvS/iVKDrjoM9yw7TcvzRVudXvEdVwpccNH2xYDkppdWjhjxZoS/Dotm/VXQbROvPAR5JQb3VbPAXXTJ1OkVVK0GMn9mo
X-Gm-Message-State: AOJu0Ywy1OogkKkoRsUa1sU7x/snpdDKEoqsZGh96tBXaloy4cusXM0U
	NGf/8hK6d/MgcibYSYN/8ptEZ6dl/RkoB4/rWfDEGkSLps6I7Cj68DUkOz75zA==
X-Google-Smtp-Source: AGHT+IGkwd9uH0wGwcMxYF5ilve69uK7EUyk8Nm8aqaKGpupfm5tsNPxwjiWxHQwx+6ecqpoiq+xvg==
X-Received: by 2002:a05:6358:724d:b0:192:6a66:63fa with SMTP id e5c5f4694b2df-193bb3fc727mr2661027055d.5.1715991440326;
        Fri, 17 May 2024 17:17:20 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63d9a97247fsm11586021a12.36.2024.05.17.17.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 17:17:19 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] selftests: hid: Do not open-code TEST_HARNESS_MAIN
Date: Fri, 17 May 2024 17:17:16 -0700
Message-Id: <20240518001715.work.698-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1268; i=keescook@chromium.org;
 h=from:subject:message-id; bh=Ns+G8cIhe6RmVb+HVSbykTeCqAmMxrZ97rwaVohwt5Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmR/OLA80fqaRGBX/36O8wyiGjoPwOVeOd9ptC3
 MGG6b2Ugf+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZkfziwAKCRCJcvTf3G3A
 Ju8UD/9pg/NJ7jGrKd81q/3/ZDtc2AGfZ45BLounkSac+UTpI9uCv/ndnDRxYx6emDItyNIZqKP
 LpK3xTUzPVSGcxkiq0R9SKrSF54gZfNutwM5CyFKQ9/p/0g1/4krpOBZNIgV2vszsdMY0EZqVvj
 5hzqz0n9RvOzpHYlkPAKoZ+Y/IQdXL8kh90VFqrOSkVFjPX32V7Fw2B9COoEfciPPYAAhx0PZ7O
 aONMXVAZBKSdrp4y1jjZprF6y40y2at9BP6lKtdIKMv0xoxyLSWyVT+0W/WoZK7GLWquONBO6xu
 T3kolc3gHYo5uYK09l3LD0HBEBAgiVkBcOOMdbU9zsPHkLJfX05AYI5Aj1VwXUivuC8PKZRwXP6
 zklQ8F05oLfPx0dd2RFG4AFl8P6Ls9V1NjdZjgtdAawU4+LQ3r0AJeSH+1ozbn+7VayiOOQ8xUx
 9iFf8RXtIhdmKllLOCn+SMCiklwT2+shmwcBL77HTNPLzCVcb6h+TIbJAM2FDrljEzq7DjJvXzm
 VIgKFT5HFm93snLTm9BOZGBs+Boh8+MOtRxZYLKggabV5Rxr6wI7xLnr3pmVeWpekuG5m2xhP0U
 Rjc/5ZLIG3u2KdX7ujZcPc6Cw9uqjm4Rf3tTMg2RbGOJ/0UVbjlEavS0YHtE5CQ4/r3zWBszBuN
 B4BtEWN 7x/h6wDg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Avoid open-coding TEST_HARNESS_MAIN. (It might change, for example.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-input@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/hid/hid_bpf.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index f825623e3edc..943fa62a4f78 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -961,17 +961,11 @@ static int libbpf_print_fn(enum libbpf_print_level level,
 	return 0;
 }
 
-static void __attribute__((constructor)) __constructor_order_last(void)
-{
-	if (!__constructor_order)
-		__constructor_order = _CONSTRUCTOR_ORDER_BACKWARD;
-}
-
-int main(int argc, char **argv)
+static void __attribute__((constructor)) __one_time_init(void)
 {
 	/* Use libbpf 1.0 API mode */
 	libbpf_set_strict_mode(LIBBPF_STRICT_ALL);
 	libbpf_set_print(libbpf_print_fn);
-
-	return test_harness_run(argc, argv);
 }
+
+TEST_HARNESS_MAIN
-- 
2.34.1

