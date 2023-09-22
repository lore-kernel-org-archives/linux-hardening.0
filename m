Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F843AB8
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:52:06 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FB1716
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5cd27b1acso21946515ad.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405103; x=1696009903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJoQ4rDttwSQzl+h8GPO+G7mapr3BtySN8HDbnxSAIA=;
        b=AVnjaPfNtxZiQeTDab+hYDn/Q7HWede/UtWdyr9caUwqQ8HcUnDEytBMCF1euy0Qfv
         hEiW7tOe4CbInHmrzcsf6dqbpgcJRhn4lrj8nTGCT1LgXXvy4BoES2oZDUZ+SCdMr/d2
         p0jT0XC6dRP0nMH/SbVJA/qVcd9SbUOMNcGg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405103; x=1696009903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJoQ4rDttwSQzl+h8GPO+G7mapr3BtySN8HDbnxSAIA=;
        b=i6DVzVYEooWFwO2yVKYp57gE7pwpEhpwVgBNsgJimQxYBuasjoRqMRIHJ5nYTZBDyd
         O0+3tcOgXlu1NFwu/TTggZS838NLJvx7xG3GMc6LPAnXOY2OAzWrIxmmNOuRJyiP7igE
         Fkbwjv7z2qkvpaUZznXcHNaezv+dVwWQeHOQBKKKK6QgAVtSHv28+xeyWbI1v/hASUut
         LqvWPZXcuiQAhBlEEDkO5C5xXd3El8F/ROSmJHqk8CJ22DZ4xze17aW5BSC5zsXShE2E
         3TQ3cGItga2hzdTCVpDS3sQrDovkwFVJQL+u9l2A6AtINHfVMy+7EfMLQT8oSS7EkzUu
         tmkg==
X-Gm-Message-State: AOJu0YzZ9lxC1oq6p5yXNQYcV71aZCQ+p338nuavtW7KPcBdSy5q87OP
	CgAu/Lisg2nCrn8ON3KpAGaPtg==
X-Google-Smtp-Source: AGHT+IE0vw3tENlyJ7OADDBoRIfgRk/i//iN/tovYi2O/PZ45AZp8cZKFhBRGB/lpULSf1SYlKBaxg==
X-Received: by 2002:a17:902:f7c7:b0:1c5:dd24:f0bb with SMTP id h7-20020a170902f7c700b001c5dd24f0bbmr158735plw.63.1695405103381;
        Fri, 22 Sep 2023 10:51:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ji21-20020a170903325500b001b392bf9192sm3789240plb.145.2023.09.22.10.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:51:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Helge Deller <deller@gmx.de>
Cc: Kees Cook <keescook@chromium.org>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] video: mmp: Annotate struct mmp_path with __counted_by
Date: Fri, 22 Sep 2023 10:51:41 -0700
Message-Id: <20230922175141.work.450-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=keescook@chromium.org;
 h=from:subject:message-id; bh=H1/vE1vzDEkKr/pR9G2TlDq8I/0Pjxfcmq4WIBG2rX4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdQtbAyYSxB3rtoiVITScXMw9/igQbzzli6cd
 9NaF66HGJGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3ULQAKCRCJcvTf3G3A
 JgFvD/9aVhNFMXOLfYvQuvtNWdczuksf82WmWUjZ3XxnXA2fVtRIrmINsMubWXN5BqlzWb54JAd
 2JvpfxjAjclOiZQ1TaC+xCzUTkoEbnWszJAT778l3qNuM+FynSmS8WJqcyfFWae6qACzw/UexAD
 JDEdStWGpO05F2Y+sgcCmf6rvfJS8A3MiilSGKaXl+xUHsXWS2iEBwRa4eiIE70ykhfR0HAMdXS
 L5qBSDWbXjlq0mui0yKkhE6H+xAA95ChwfuiVfcSp3s7uA5qT12D1BC9Cxy9TwGWQc/gzstl0q5
 Act4VdII0lEJtWXvl4Sj9czaYZOIflGtUky/NbxfaXdyCXBldJ15O3hex7Gy+a7jRwaFIO5lP1l
 VrXKQwNlknIw7kLZsuScN9wJEkwbAkNtn2dNeXWJRIVDRZlEDYch+nmd1ma+pDKFjLccKHNVCyn
 srI+NBBV0w6HIUUfyqXhVfXNhpxbawfW88qpoywu/N71xmeTIdAbcNhW4F7jFKwwFPOz8+ib6PB
 htPR2uKXF1fwz05xPScZwFqkbtuiB5nzGhfpttxqXo6HjJpg3OuRsjckExbw4ipKW2dbuANjPVL
 n1Saavvp4yFM7FKZDSNxqVP/nSKD8kjtleMkQzEEJwmM4S/b0Fm0MbxtSCIKC/ed6tHkllPeipu
 NODokxp /mmGU/PQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct mmp_path.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/video/mmp_disp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/video/mmp_disp.h b/include/video/mmp_disp.h
index 77252cb46361..a722dcbf5073 100644
--- a/include/video/mmp_disp.h
+++ b/include/video/mmp_disp.h
@@ -231,7 +231,7 @@ struct mmp_path {
 
 	/* layers */
 	int overlay_num;
-	struct mmp_overlay overlays[];
+	struct mmp_overlay overlays[] __counted_by(overlay_num);
 };
 
 extern struct mmp_path *mmp_get_path(const char *name);
-- 
2.34.1

