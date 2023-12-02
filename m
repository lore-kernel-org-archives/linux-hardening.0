Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gr2teot2"
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E51184
	for <linux-hardening@vger.kernel.org>; Sat,  2 Dec 2023 13:22:22 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b844357f7cso1427326b6e.1
        for <linux-hardening@vger.kernel.org>; Sat, 02 Dec 2023 13:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701552142; x=1702156942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=gr2teot24exISStimGuA6uwZHfe8C8GO9of9Yown0wbJwWfmsXN0HEm+HMYnJHXR0K
         9BPA7IobVYUOiNHw64fjIRcAzthG9Yf1rAUaizoN6bbILac2nvdeQFcPYTv/SDRcrsMc
         aFZviUgx0jG0xlgyeAFQpuaji9Z8HASRtWgFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552142; x=1702156942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gj+Y/6VXeJ+r0pgecRkRsTt5zcHlqOxutguYUyMKTVU=;
        b=kLV/PsN1RwlRhNd2ekIVVIrwq2Yr+4wtgys80C5fWkLZUVJE071icYCpLOM69L6n1X
         dZHC3srqVHddD1Xwv61P+3LqgIp5dfdJcEQMPfI/FyEh3hXE3kWMrhNuZk9W/tYvUAUE
         +7jUmkvxGULMOgFcsIw2ER1Ps/KOMpOd2r5HKBEhOus3FpcMb3vC09jR74gjGFwGaFPK
         i6fu7oeZCyadLNpe71Sv8z7t3KgNExi4lILKrcQh7SRFkEgo9z32QngU1n6Tgt7MWhVn
         2g8vYu7xeDOLQu4YKl9faUjl6qY+5an8bZtalnYhT4t26w4RyA114q5TtqEzteB2/kQr
         3lUg==
X-Gm-Message-State: AOJu0YwGr9/66+8HHANYhadkjgXvmYzNVm6TCmbpiePLusMlKi9SlJnr
	cNyn1nruq3h1Ctw8Fgt1rCqVWX4bfBmDC5rMYvo=
X-Google-Smtp-Source: AGHT+IHI/l9YXsb8W4D5DKnvxPxPdidKCGMOauTa2UvDzy+vvVxKcKISva6dGT2AXfYPWma8tUjI+A==
X-Received: by 2002:a05:6808:309c:b0:3b8:b063:6b8d with SMTP id bl28-20020a056808309c00b003b8b0636b8dmr1923224oib.60.1701552142290;
        Sat, 02 Dec 2023 13:22:22 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p10-20020a17090a930a00b002867594de40sm1351802pjo.14.2023.12.02.13.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 13:22:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/5] pstore: inode: Convert kfree() usage to __free(kfree)
Date: Sat,  2 Dec 2023 13:22:11 -0800
Message-Id: <20231202212217.243710-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231202211535.work.571-kees@kernel.org>
References: <20231202211535.work.571-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=keescook@chromium.org;
 h=from:subject; bh=FqMfSJ9tnf+E4NKsMDABD4Hv9XWcLEDAeeuD1HVeW1g=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBla6AGUcAUjxMoJ6U4X0vLxi+fYt1AWVqAhC5g3
 8R9qQmTZrCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWugBgAKCRCJcvTf3G3A
 JqoTD/sEQ48wmQkFhwAOp4TsKfq+vZmWkT5yfGDyxOQ2ucZIBmBzGRljVmzMiuznpXr3hR6RMn6
 CI5L7iPa+hQEPuuIdH4ULzOkZKlNGhNWGY6qT/NysWagTanA2+tPygJoTDa3shFPV8Qg/ktXOmA
 EzaYBnYM32d95qHxY+O7UzeQQHZ+L8mW0w+7Pi4LnpbaEdoxc66d/yrcVqkNxC51p/VeozU/deM
 rk5C2MNd7/VwWxOqHlp1SIiA899X4IXHIaMopuLi/lfj5TGjWQYSw89mtkk3p/zmCoxe0za6uqJ
 5EkmLzOEZ5XC2P4LS/bWhBwNEzOv4Jy7tDzYhbi37IkEM5XnLTEoVRCAB66Swzv/2WOGDhqh3rK
 IWicrRHiv496Kk7nhiqTyyIQ7vTvoRxCEcarCa+abBlzBe1hcVZa3QWkzGBJyXCYxo8Eqh+vspr
 9GNiGEtp4IHwd4bDA7xIm+m36TXHvQTk31FKlch+AdsiZpHPZwxRZ7uslC2pmtV8uCcqoa+MEOQ
 HeLGQpB9Lheyc3q0B2RPlcqX4RCXu1MzGSJV446zBw7SUb5C/OD4rMGYlzWCHvuMwBVo9ScPTLY
 Yvnc9q7XkjLRd9JF0+Bf3QSnvRXDIn8bk1Sv2zb2M11q84weUwdkEaxXXSh3/8kBccf3Vc0s6fO bwrQdBKoi0BSe6w==
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

