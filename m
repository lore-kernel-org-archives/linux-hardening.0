Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E42E093E
	for <linux-hardening@vger.kernel.org>; Thu, 14 Aug 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189390; cv=none; b=NYsMKs8lIQcBKB03NO8roQDtRazTbJQrvETpLf7rbhkjAEVZ7Fs7RNn7QNg3OVaCsDPIirY++y/dZKNqKKSpDjsCgbJXRF5lVeNMMjBIf0dCLGl3EjBDuDx2t6bC6r1g1+waZCi0W9SPyUhvCiwCNYyGLzEYkgpxjSS+k+cewig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189390; c=relaxed/simple;
	bh=yHqjlwVr5vDwnZ7kvQR0+bT5SJ4ZaeXU4MeDJ/5rHhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlvY9w++9qitcAQhX1tggBwybtyviWWteQdU1by+BMI/kzhxNgfJge4R7QyuU3LipRNuBR2R0+qYMiyezS9pIWDusf5eYRWK4eW+jEqGQUNki7nkmugKJFbHg9fb2UfBM2XmzvjYg7IU5DG+iAtG6dzsm45RUOgpScSffY/2fCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M/2cn49I; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M/2cn49I"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755189381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qVhFd637Brqbn3HW8M52D+C4kErHTBTUzFv24N1Db9U=;
	b=M/2cn49IoKBsQUy1dSZeswcrS9JEhHcUEWSOq/dNnlE9iOCDGKlZK+vJ70cJnmtHE/15L9
	ZhnFfBqDzZEREAqBl16QVuU7lh0d1i/3Q/Ir4ASrdh/XaUVXBsVOoZ71dcLWWLC6rfCy85
	7edyGuZf+mhNrDM06yaBMTIx27JAp3o=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Nir Lichtman <nir@lichtman.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Yuran Pereira <yuran.pereira@hotmail.com>
Cc: linux-hardening@vger.kernel.org,
	Daniel Thompson <daniel@riscstar.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	kgdb-bugreport@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] kdb: Replace deprecated strcpy() with strscpy() and memcpy()
Date: Thu, 14 Aug 2025 18:32:34 +0200
Message-ID: <20250814163237.229544-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() and memcpy() instead and remove
several manual NUL-terminations.

In parse_grep(), we can safely use memcpy() because we already know the
length of the source string 'cp' and that it is guaranteed to be
NUL-terminated within the first KDB_GREP_STRLEN bytes.

Since the destination buffers 'cmd_cur' and 'cmd_hist[cmd_head]' have
the fixed length CMD_BUFLEN, strscpy() automatically determines their
size using sizeof() when the size argument is omitted. This makes the
explicit size arguments for the existing strscpy() calls unnecessary,
remove them.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use memcpy() instead of strscpy() in parse_grep() as suggested by Greg
- Compile-tested only so far
- Link to v1: https://lore.kernel.org/lkml/20250814120338.219585-2-thorsten.blum@linux.dev/
---
 kernel/debug/kdb/kdb_main.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 7a4d2d4689a5..048dbbcd91a4 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -727,14 +727,10 @@ static int kdb_defcmd(int argc, const char **argv)
 	mp->help = kdb_strdup(argv[3], GFP_KDB);
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
+	if (mp->usage[0] == '"')
+		strscpy(mp->usage, argv[2] + 1, strlen(argv[2]) - 1);
+	if (mp->help[0] == '"')
+		strscpy(mp->help, argv[3] + 1, strlen(argv[3]) - 1);
 
 	INIT_LIST_HEAD(&kdb_macro->statements);
 	defcmd_in_progress = true;
@@ -860,7 +856,7 @@ static void parse_grep(const char *str)
 		kdb_printf("search string too long\n");
 		return;
 	}
-	strcpy(kdb_grep_string, cp);
+	memcpy(kdb_grep_string, cp, len + 1);
 	kdb_grepping_flag++;
 	return;
 }
@@ -1076,12 +1072,12 @@ static int handle_ctrl_cmd(char *cmd)
 		if (cmdptr != cmd_tail)
 			cmdptr = (cmdptr + KDB_CMD_HISTORY_COUNT - 1) %
 				 KDB_CMD_HISTORY_COUNT;
-		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strscpy(cmd_cur, cmd_hist[cmdptr]);
 		return 1;
 	case CTRL_N:
 		if (cmdptr != cmd_head)
 			cmdptr = (cmdptr+1) % KDB_CMD_HISTORY_COUNT;
-		strscpy(cmd_cur, cmd_hist[cmdptr], CMD_BUFLEN);
+		strscpy(cmd_cur, cmd_hist[cmdptr]);
 		return 1;
 	}
 	return 0;
@@ -1285,19 +1281,19 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		cmdbuf = kdb_getstr(cmdbuf, CMD_BUFLEN, kdb_prompt_str);
 		if (*cmdbuf != '\n') {
 			if (*cmdbuf < 32) {
-				if (cmdptr == cmd_head) {
+				if (cmdptr == cmd_head)
+					/* Copy the current command to the
+					 * history and let strscpy() replace the
+					 * last character with a NUL terminator.
+					 */
 					strscpy(cmd_hist[cmd_head], cmd_cur,
-						CMD_BUFLEN);
-					*(cmd_hist[cmd_head] +
-					  strlen(cmd_hist[cmd_head])-1) = '\0';
-				}
+						strlen(cmd_cur));
 				if (!handle_ctrl_cmd(cmdbuf))
 					*(cmd_cur+strlen(cmd_cur)-1) = '\0';
 				cmdbuf = cmd_cur;
 				goto do_full_getstr;
 			} else {
-				strscpy(cmd_hist[cmd_head], cmd_cur,
-					CMD_BUFLEN);
+				strscpy(cmd_hist[cmd_head], cmd_cur);
 			}
 
 			cmd_head = (cmd_head+1) % KDB_CMD_HISTORY_COUNT;
-- 
2.50.1

