Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k6TzcDHr"
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B61724
	for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 06:02:18 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6c39ad730aaso751628b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 16 Nov 2023 06:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700143338; x=1700748138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OqmubgxtpJpRy+t3jjLZe9v6jbuEY+k/dDeNt+y7ewk=;
        b=k6TzcDHr+oBzspyAKHvS+3GD+SaKRY5kaHSvYQfeQ+Um/Qu/vxo9YjtbNecR9RiOGr
         qzftvqPGazjQ8pHr7/4SGA8vTOlW2ZBWapI/RObyIfmGq45UeV+uIBdql+2sr26Q167r
         6+TCLXlZeiyQbJ8NoQtQqitHz1Jfh3FBujcMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700143338; x=1700748138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OqmubgxtpJpRy+t3jjLZe9v6jbuEY+k/dDeNt+y7ewk=;
        b=HX99meMhPXE465AnpritX2oyRtfHg0WoKZCwC5VCzGfBx8IahGCnR1DbruRLmAN/rM
         BfvV5BnxRZy2tr0fOj5TvTXcHpS3QtpsZ9fzUa1K3o/8A5xEvU5G1BlBzc2THy41iPcv
         ATrEjHjT+wRykgCNKwTGPU5WJeoxZMYBuVqDWeQVl1hdtfQZPg73umy7j/GIAqdHrtsq
         seugzsVBDuOs6XUwzJFGjDjLmZwvxG+oJ9h9wscq5IZmpWrkDAmDsbvgpDvhcGhkH0EY
         ErtNcUS7RTukinUEP1qiTSw2h39cEKOB+eRAMyUC9VMH0qg4O8eKpDd7KKl9k1A3kzYV
         QjQA==
X-Gm-Message-State: AOJu0YzRq/1e/m2anoSP6Ywsx7zTFdUr4u9UTDtzp+U4sS0kotLeM9UV
	2V77zI0c6l+JhuYLqWCsh1Onww==
X-Google-Smtp-Source: AGHT+IGZrZjuqSymisc89L4QV+JjjMZTNiIOsTyYazgRaov9rWMR5PLaervrIuX2YUjmeJ5JJqeBng==
X-Received: by 2002:a05:6a20:7292:b0:17d:f127:d435 with SMTP id o18-20020a056a20729200b0017df127d435mr13937235pzk.45.1700143312099;
        Thu, 16 Nov 2023 06:01:52 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s14-20020a65690e000000b0057c44503835sm2548935pgq.65.2023.11.16.06.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:01:51 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kees Cook <keescook@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] hwmon: Explicitly initialize nct6775_sio_names indexes
Date: Thu, 16 Nov 2023 06:01:47 -0800
Message-Id: <20231116140144.work.027-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2480; i=keescook@chromium.org;
 h=from:subject:message-id; bh=1CBLvb2An+Ij1IqxYo9cQLowHTbR2aYsJsLLfg4xKq8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlViDLcz9aCbUgsJCVyqbFezrdEGpNsti+B37jv
 M346jHjQDuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZVYgywAKCRCJcvTf3G3A
 Jk2DEACUk8rhIfFZwVeiVzXN6C47wYLRjwroswyjiBUQUFOSI2KDXV6a+evv1UEZflmzu6kGZX7
 BfnurrsZklRVxiABl9d22CAQGg6So8+pohy/C2+9a75/jYo61NKNY5Z9RYj66Ky2A0Va5Ticr9o
 Dp8EyJvS0Gpmvk79+1yAhhOeCL/PRxA+rwwPbU+DMX4VjXHahrhm1t4puf2feCR9KNOVCcRo2+h
 /gGWV6rMzysaAUihtxG2mUDojfHE2L+7uISHj90ZJK9U9LHHXFQq9R8aGCKbZlo4mmlEl/ip9wQ
 AsbcXrs0Jd94j+kVkBUrtwT3CjRVn9kwxWBVzeX3SAAu77bqT/G0AN1FvE3WMcAW/0WRdKvDs7u
 eCXPjRIWpnXxVYirBaCDMPg32CGddBAHOlBTh7C2kcSXt8PHiBdumvBVB6rtTikFVwTUxTK/AL0
 sw1y4mW3SJ4cUrPzwvY+h4O8Q0TtkA0VNo4pyCqumeh2A0Bz4Xiq5hTecX/wP7YkR+hs+2WNqnL
 2ieVu9s2tadcO73MWPGDH07liU63FlUAB7LLcz0jBvKOaGlfVxUNpzqxVMV76a8uJpKCCezpgYT
 LRvvDv/JLtVSLwYlN4lGkhs8Rq1BV5DYREPhKLNvwqURK8oitAtHMHceGljgGiMT0Gh43MZfNLx
 LDGKpPP q3yl9hlQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Changing the "kinds" enum start value to be 1-indexed instead of
0-indexed caused look-ups in nct6775_sio_namesp[] to be misaligned or
off the end. Coverity reported:

*** CID 1571052:  Memory - illegal accesses  (OVERRUN)
drivers/hwmon/nct6775-platform.c:1075 in nct6775_find()
1069                sio_data->kind == nct6793 || sio_data->kind == nct6795 ||
1070                sio_data->kind == nct6796 || sio_data->kind == nct6797 ||
1071                sio_data->kind == nct6798 || sio_data->kind == nct6799)
1072                    nct6791_enable_io_mapping(sio_data);
1073
1074            sio_data->sio_exit(sio_data);
vvv     CID 1571052:  Memory - illegal accesses  (OVERRUN)
vvv     Overrunning array "nct6775_sio_names" of 13 8-byte elements at element index 13 (byte offset 111) using index "sio_data->kind" (which evaluates to 13).
1075            pr_info("Found %s or compatible chip at %#x:%#x\n",
1076                    nct6775_sio_names[sio_data->kind], sioaddr, addr);
1077
1078            return addr;
1079     }
1080

Initialize the string list with explicit indexes.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Fixes: 0a7093e69c1e ("hwmon: nct6775-i2c: Use i2c_get_match_data()")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/hwmon/nct6775-platform.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 0adeeab7ee03..9aa4dcf4a6f3 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -23,19 +23,19 @@
 enum sensor_access { access_direct, access_asuswmi };
 
 static const char * const nct6775_sio_names[] __initconst = {
-	"NCT6106D",
-	"NCT6116D",
-	"NCT6775F",
-	"NCT6776D/F",
-	"NCT6779D",
-	"NCT6791D",
-	"NCT6792D",
-	"NCT6793D",
-	"NCT6795D",
-	"NCT6796D",
-	"NCT6797D",
-	"NCT6798D",
-	"NCT6796D-S/NCT6799D-R",
+	[nct6106] = "NCT6106D",
+	[nct6116] = "NCT6116D",
+	[nct6775] = "NCT6775F",
+	[nct6776] = "NCT6776D/F",
+	[nct6779] = "NCT6779D",
+	[nct6791] = "NCT6791D",
+	[nct6792] = "NCT6792D",
+	[nct6793] = "NCT6793D",
+	[nct6795] = "NCT6795D",
+	[nct6796] = "NCT6796D",
+	[nct6797] = "NCT6797D",
+	[nct6798] = "NCT6798D",
+	[nct6799] = "NCT6796D-S/NCT6799D-R",
 };
 
 static unsigned short force_id;
-- 
2.34.1

