Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306EE31CA58
	for <linux-hardening@vger.kernel.org>; Tue, 19 Aug 2025 09:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597599; cv=none; b=kKdTlIZ/HDfNdjsY/i2VQoY8vjCkq4vUkGuw89LV++WjBuzobmND3IXD5zB35gXHxpSJ4L5QMjsJ/qaq745lEPCfLx9NaK455sEIsiv6b76xp87kwezwP5wrI0MpNLxaSjYk+6JyxN9QRUTJ4se8IQXQbZJFXX6cSocDgHjVt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597599; c=relaxed/simple;
	bh=tRWhdp7rONDt0Z4ygIKJOPB6BP+gSazSCO2jVPOp+0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RkKlUyHo0QFoW0b9sR2AilvO2Gy/N2Qq5sk8CXbQMxtQvEKsqgDjR50ykdaOHAbT+eBk0lSvgkg/sfrreHMVM45kVKp3SEapZNJ4V6rtPdMUsj5/XOuPfy2ndlsoUI2jGEAifDUwNhWcc+3985v80AiDQAJXDCWuyjwUJaymjek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t2UpmDn1; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t2UpmDn1"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755597595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AmP/nYN5bOTbWz+MCSydfAdHczvwFcuvFpVelEglPj8=;
	b=t2UpmDn1Q5AJmOoOxWJ9xXBv+L80TEE/qRVgJojGJIkxvWZ+L3NTe+Ps/5oYKkr8AbXm4w
	aRhrz3jvnqEG5enKh3O/dDtGy2f6z2w6IYP8lY+8farYMnIkjN0hWOO6wKQAFyTFjshdSr
	2/+SAyHLy4CYz3tSu04Xd6q5plaGhzk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Zhang Heng <zhangheng@kylinos.cn>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Daniel Thompson <daniel@riscstar.com>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] kdb: Replace deprecated strcpy() with helper function in kdb_defcmd()
Date: Tue, 19 Aug 2025 11:59:06 +0200
Message-ID: <20250819095915.711085-4-thorsten.blum@linux.dev>
In-Reply-To: <20250819095915.711085-1-thorsten.blum@linux.dev>
References: <20250819095915.711085-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use the new helper function kdb_strdup_dequote()
instead. In addition to string duplication similar to kdb_strdup(), it
also trims surrounding quotes from the input string if present.

kdb_strdup_dequote() also checks for a trailing quote in the input
string which was previously not checked.

Link: https://github.com/KSPP/linux/issues/88
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Copy 'len - 1' bytes using memcpy() as suggested by Doug
- Link to v1: https://lore.kernel.org/lkml/20250818181153.661431-4-thorsten.blum@linux.dev/
---
 kernel/debug/kdb/kdb_main.c    | 12 ++----------
 kernel/debug/kdb/kdb_private.h |  1 +
 kernel/debug/kdb/kdb_support.c | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index cdf91976eb7c..dddf2b5aad57 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -721,20 +721,12 @@ static int kdb_defcmd(int argc, const char **argv)
 	mp->name = kdb_strdup(argv[1], GFP_KDB);
 	if (!mp->name)
 		goto fail_name;
-	mp->usage = kdb_strdup(argv[2], GFP_KDB);
+	mp->usage = kdb_strdup_dequote(argv[2], GFP_KDB);
 	if (!mp->usage)
 		goto fail_usage;
-	mp->help = kdb_strdup(argv[3], GFP_KDB);
+	mp->help = kdb_strdup_dequote(argv[3], GFP_KDB);
 	if (!mp->help)
 		goto fail_help;
-	if (mp->usage[0] == '"') {
-		strcpy(mp->usage, argv[2]+1);
-		mp->usage[strlen(mp->usage)-1] = '\0';
-	}
-	if (mp->help[0] == '"') {
-		strcpy(mp->help, argv[3]+1);
-		mp->help[strlen(mp->help)-1] = '\0';
-	}
 
 	INIT_LIST_HEAD(&kdb_macro->statements);
 	defcmd_in_progress = true;
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index d2520d72b1f5..a2fc7d2bc9fc 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -110,6 +110,7 @@ extern int kdbgetaddrarg(int, const char **, int*, unsigned long *,
 extern int kdbgetsymval(const char *, kdb_symtab_t *);
 extern int kdbnearsym(unsigned long, kdb_symtab_t *);
 extern char *kdb_strdup(const char *str, gfp_t type);
+extern char *kdb_strdup_dequote(const char *str, gfp_t type);
 extern void kdb_symbol_print(unsigned long, const kdb_symtab_t *, unsigned int);
 
 /* Routine for debugging the debugger state. */
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index d36281142fa1..56f7b906e7cc 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -255,6 +255,35 @@ char *kdb_strdup(const char *str, gfp_t type)
 	return s;
 }
 
+/*
+ * kdb_strdup_dequote - same as kdb_strdup(), but trims surrounding quotes from
+ *			the input string if present.
+ * Remarks:
+ *	Quotes are only removed if there is both a leading and a trailing quote.
+ */
+char *kdb_strdup_dequote(const char *str, gfp_t type)
+{
+	size_t len = strlen(str);
+	char *s;
+
+	if (str[0] == '"' && len > 1 && str[len - 1] == '"') {
+		/* trim both leading and trailing quotes */
+		str++;
+		len -= 2;
+	}
+
+	len++; /* add space for NUL terminator */
+
+	s = kmalloc(len, type);
+	if (!s)
+		return NULL;
+
+	memcpy(s, str, len - 1);
+	s[len - 1] = '\0';
+
+	return s;
+}
+
 /*
  * kdb_getarea_size - Read an area of data.  The kdb equivalent of
  *	copy_from_user, with kdb messages for invalid addresses.
-- 
2.50.1

