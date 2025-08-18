Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8B2773E9
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 18:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540837; cv=none; b=j/otRi+T0H7wpgvA1rNXj3HWvhOI0JI2/O26BpblTY88/MPTZo3z6EznoWSo1GBRKGXs6BrqcSMn1sru3LVhPPD5d0XHpdmjIqAlTxMr5kmpZMqqS2JbibuCJaCvaua/BfDsWMFKQhT+L1mPPbbpeA6uFsAY9Sm8WrzYdAlv4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540837; c=relaxed/simple;
	bh=9Bx9GX4Ak2Q4ZFkwLWikHTj0E/sU5FgSiXmufxThwtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8Gaiz9YS9qZq5OxOWXErJk2BIUfh8vkXsBd0QakIwTw7ragW/jma06GU/3RqBg1zQLhCkY5vrOwzHJDFjZSIMiWX07vZRUM0UWqzY+Gut3gEMrLr/wCUdlT0wqQK13WluhI78jqHAk0Dq4C0aq5FSFEbc9a6loAhgDlXkNaKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgSCAIgI; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgSCAIgI"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755540833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f0U0WedRgobk8ZDmbWpWadtFbV5VpHYNx6DgdKVrYks=;
	b=vgSCAIgIt2IoUaRmRHYQPIh75B3Pd0GvLyk2WHXOF3taTFyAxe/8UiHiQk7xp86eFfZC/m
	gsAJxzIkp9wP4LxjzkzU6A29HquV6Z6CdmCZh2X2mzMK54rAMb8iFdhQ0FRSE5Fs5wGICp
	Qsqy2o5C6r3g18USwPCArxhH5hh7qK8=
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
Subject: [PATCH 4/4] kdb: Replace deprecated strcpy() with helper function in kdb_defcmd()
Date: Mon, 18 Aug 2025 20:11:44 +0200
Message-ID: <20250818181153.661431-4-thorsten.blum@linux.dev>
In-Reply-To: <20250818181153.661431-1-thorsten.blum@linux.dev>
References: <20250818181153.661431-1-thorsten.blum@linux.dev>
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
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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
index d36281142fa1..b42dc54f5a9a 100644
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
+	memcpy(s, str, len);
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

