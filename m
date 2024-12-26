Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905AE1369BC;
	Thu, 26 Dec 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735223918; cv=none; b=ZWmtmy0iwaB5LhOjLgPrgr204jibbFEppjkn2qQxZFotSUjKItWGpH+gUCOWw4a8n+O58+eUf/mqKIUlAflhygpIOpaHC+wD8ITOxpZ8fhwQtQwrFtwJu4ixb977Cz0PUldPBbRdTfgEcAYtqbq/aSh4VafkmCgLBoPbkmLnm/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735223918; c=relaxed/simple;
	bh=V7VfgRgo9EDOq9sFvBIj3sWEc06L1QrW+/lZAYMjCHI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MbGKVLmNvtaDhW29Iej0jAd7ZZmxncuyUOG7/UIj0fC0C2aod2E0LUWIBQDYqzNpcH9vPKHlfbYQKYpByjcDKhENFAZVwCgCkEnJeErd4iOcXnSPI35KmF/AyWvIHYGSsB2UIAeNhhgzvaU4s8T2UnLBc3AdOFRECpqltAYk58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF8EC4CEDE;
	Thu, 26 Dec 2024 14:38:38 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tQp1V-0000000G1vp-0ijs;
	Thu, 26 Dec 2024 09:39:37 -0500
Message-ID: <20241226143937.023136340@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 26 Dec 2024 09:39:28 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org
Subject: [for-next][PATCH 14/15] tracing/string: Create and use __free(argv_free) in trace_dynevent.c
References: <20241226143914.397394975@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function dyn_event_release() uses argv_split() which must be freed via
argv_free(). It contains several error paths that do a goto out to call
argv_free() for cleanup. This makes the code complex and error prone.

Create a new __free() directive __free(argv_free) that will call
argv_free() for data allocated with argv_split(), and use it in the
dyn_event_release() function.

Cc: Kees Cook <kees@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/20241220103313.4a74ec8e@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/string.h        |  3 +++
 kernel/trace/trace_dynevent.c | 23 +++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 493ac4862c77..86d5d352068b 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -4,6 +4,7 @@
 
 #include <linux/args.h>
 #include <linux/array_size.h>
+#include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/compiler.h>	/* for inline */
 #include <linux/types.h>	/* for size_t */
 #include <linux/stddef.h>	/* for NULL */
@@ -312,6 +313,8 @@ extern void *kmemdup_array(const void *src, size_t count, size_t element_size, g
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
+DEFINE_FREE(argv_free, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
+
 /* lib/cmdline.c */
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..a322e4f249a5 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,24 +74,19 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	struct dyn_event *pos, *n;
 	char *system = NULL, *event, *p;
 	int argc, ret = -ENOENT;
-	char **argv;
+	char **argv __free(argv_free) = argv_split(GFP_KERNEL, raw_command, &argc);
 
-	argv = argv_split(GFP_KERNEL, raw_command, &argc);
 	if (!argv)
 		return -ENOMEM;
 
 	if (argv[0][0] == '-') {
-		if (argv[0][1] != ':') {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (argv[0][1] != ':')
+			return -EINVAL;
 		event = &argv[0][2];
 	} else {
 		event = strchr(argv[0], ':');
-		if (!event) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!event)
+			return -EINVAL;
 		event++;
 	}
 
@@ -101,10 +96,8 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (!system && event[0] == '\0') {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!system && event[0] == '\0')
+		return -EINVAL;
 
 	mutex_lock(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
@@ -120,8 +113,6 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	}
 	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
-out:
-	argv_free(argv);
 	return ret;
 }
 
-- 
2.45.2


