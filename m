Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D20vB1XU"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A03618C
	for <linux-hardening@vger.kernel.org>; Tue,  5 Dec 2023 10:26:28 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1d048d38881so27749105ad.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Dec 2023 10:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701800787; x=1702405587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=D20vB1XU6llsWmRtYeRb+7tHyyu03VkhL4zTEBRbYPx3qnUQ6kXjgv1j5jPc4T0PK8
         6HVDbi73p0GTLNlU79dknLYL8pZ3aeo31e2k7XyQowrU4MfkkHrJq0zJ4DPpkF6Gn/5j
         GniI1EAPn4ZeArqCsLQUBpCelH8gXtnw0IGEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800787; x=1702405587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=tLJ0BpLG1uTDp7YAUA84xi4CxwbALn18k8pdRm5fkd2M+EF0YGG/cnBCfoM6SF1/YB
         DYmhMZOVOtEBYBl8Fv3M5tx79evzCiGCNQNVtc0pjef7o5wbhbKGMeo0fOLLdOcDUFzS
         f1aAaOq4Gm1I2cfBo/kFdKP6OPOwf9TeIBmt0Md4JKVqt1OIE/B6NDeScl2KG21geiB+
         I1R9LecOnk8vsSX73P+qwTxzpuBwwJK1EVWiRLqci7aOQtGDoEBFdEqGbwOxj7mEuQ1b
         7z6BabTOz14ksc63YgnMCnsunWXJmuazyaCaJhaCdEGYpi50Grh9jt55ZNO7uYY1pqDa
         km8w==
X-Gm-Message-State: AOJu0YxhV1LwlEBgXdgzJoR7l61EOG5MNzf+d1D8RQe2QibCC9V6Q/r2
	Nip+FaWr4FyCWqb1TluFiza+6w==
X-Google-Smtp-Source: AGHT+IH2Uowmzrvs0/hFAJeLe2bBRPGCrI+wFvyd3EPO+VDeMZnOhPy9LvBZ3OyihXLzXpiRCc2yuQ==
X-Received: by 2002:a17:903:22d1:b0:1d0:83bc:5649 with SMTP id y17-20020a17090322d100b001d083bc5649mr3507541plg.33.1701800787406;
        Tue, 05 Dec 2023 10:26:27 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q1-20020a17090311c100b001cfc9c926b7sm6932210plh.75.2023.12.05.10.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:26:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] pstore: inode: Convert kfree() usage to __free(kfree)
Date: Tue,  5 Dec 2023 10:26:14 -0800
Message-Id: <20231205182622.1329923-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231205175449.work.110-kees@kernel.org>
References: <20231205175449.work.110-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=keescook@chromium.org;
 h=from:subject; bh=FqMfSJ9tnf+E4NKsMDABD4Hv9XWcLEDAeeuD1HVeW1g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlb2tIUcAUjxMoJ6U4X0vLxi+fYt1AWVqAhC5g3
 8R9qQmTZrCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZW9rSAAKCRCJcvTf3G3A
 JjghD/wIsxOIyOzMtLfhNlUVRahUTySDQm9IoANjLGPQpTM0t1M8cwKeOjqfoL6alstZ4SNMEtX
 aJRZ28bbOztu6npnVmPlUtnUB4WVY2Bz7k4tpXjWx33VDzP5Z0HTcofBhJHGnv6441jMZIoBxdq
 kJOTFjwX9aMXL04GktAdix5olQ9MlRXUPPfBVITMabidz3zl4uWgxPYLOJvTdVdHHX+6iFdvyAQ
 u2csi5n6tzxerwZgHQDP7ETWPo61URuwGJcVZBxrCZ9VC+NrvOwx7aawthLBtWuF43TkpD2tguH
 ZgLJp7jma2D7WzIsJLrYSWrTlABHt1mACNT/u4FPIYsY/VA/Xk9j36ks1rKr+SqGRA4cWfIEYbw
 Ak40uD77bKYKRhdToOqk2W9Zt9cAR/QGCniYHsGveA958RkKZbkvm8zRmlrdnnhDeq2Pryyrcwe
 ExJAhOk1Y3nGeKC82pXbWX7lBazYlywHADTscKEz5hedwrJp0URz8E9ZWnfvXzh+lOGzE4zGm3a
 4usnTUGodSc8P2ax00DqkMuGzVUfZScxELHGfdki5KoeeigEQNKF0DAE54BJTMEIYnq8Ul1EoJH
 Ajo4h7C54I3kOS5qQ6clsgyIDejsoQQWoMRRW1JkkuTcDVRO2xHlIBrPN/bJIronulIZcSob3xZ ZlAj3lFpzoj3VkA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Mostly as an example to myself, replace a simple allocation pattern with
the automatic kfree cleanup features now exposed by cleanup.h.

Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/pstore/inode.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index d41c20d1b5e8..20f3452c8196 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -23,6 +23,7 @@
 #include <linux/pstore.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
+#include <linux/cleanup.h>
 
 #include "internal.h"
 
@@ -64,7 +65,7 @@ static void free_pstore_private(struct pstore_private *private)
 static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 {
 	struct pstore_private *ps = s->private;
-	struct pstore_ftrace_seq_data *data;
+	struct pstore_ftrace_seq_data *data __free(kfree) = NULL;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -72,13 +73,10 @@ static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
 
 	data->off = ps->total_size % REC_SIZE;
 	data->off += *pos * REC_SIZE;
-	if (data->off + REC_SIZE > ps->total_size) {
-		kfree(data);
+	if (data->off + REC_SIZE > ps->total_size)
 		return NULL;
-	}
-
-	return data;
 
+	return_ptr(data);
 }
 
 static void pstore_ftrace_seq_stop(struct seq_file *s, void *v)
-- 
2.34.1

