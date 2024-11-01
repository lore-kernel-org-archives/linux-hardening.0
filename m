Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF081714D3;
	Fri,  1 Nov 2024 10:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457369; cv=none; b=tk69Bnvdh8rkiG0hJdjHol5/foWLYnJyKTeSra5PT7sgrm/MTHY51x7JU4ujw8SpajtRWL0+xhKaie5JnSJ6sOKXr4Nrwa8SOhvIooZB9HV+6GUtQo/4AOYBoNxFn+uLnsbNpJr8EhmgyjCCGKuL/oSqrc72tuYexz0ovpBgWoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457369; c=relaxed/simple;
	bh=r0HBzAMNW4cdfSo8/EYXNRnjNpcS4i8uBOVnnKDm0bc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AbLm0iebXzisyKUb6qqggoa7WVSotcRBJCDdhPaYQoPegUZ+0XSx8N+lELJgMTLeC6qhC0pFLrauONWPTQLIMdXAgWQqjSzzyYwkETVlW8DoeOQaUBH3ojq8zwr2navrRnd/r0Os8BFzdQOG2cKSbvWy+mgcg2PeRSc1Svm5Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58BBC4CED2;
	Fri,  1 Nov 2024 10:36:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t6p1f-00000005S57-18Bj;
	Fri, 01 Nov 2024 06:37:07 -0400
Message-ID: <20241101103707.130624298@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 01 Nov 2024 06:36:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>,
 Justin Stitt <justinstitt@google.com>
Subject: [for-next][PATCH 02/11] tracing: Replace multiple deprecated strncpy with memcpy
References: <20241101103647.011707614@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Justin Stitt <justinstitt@google.com>

strncpy() is deprecated for use on NUL-terminated destination strings [1] and
as such we should prefer more robust and less ambiguous string interfaces.

String copy operations involving manual pointer offset and length
calculations followed by explicit NUL-byte assignments are best changed
to either strscpy or memcpy.

strscpy is not a drop-in replacement as @len would need a one subtracted
from it to avoid truncating the source string.

To not sabotage readability of the current code, use memcpy (retaining
the manual NUL assignment) as this unambiguously describes the desired
behavior.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90 [2]

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-hardening@vger.kernel.org
Link: https://lore.kernel.org/20241014-strncpy-kernel-trace-trace_events_filter-c-v2-1-d821e81e371e@google.com
Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 0c611b281a5b..78051de581e7 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1616,7 +1616,7 @@ static int parse_pred(const char *str, void *data,
 				goto err_free;
 			}
 
-			strncpy(num_buf, str + s, len);
+			memcpy(num_buf, str + s, len);
 			num_buf[len] = 0;
 
 			ret = kstrtoul(num_buf, 0, &ip);
@@ -1694,7 +1694,7 @@ static int parse_pred(const char *str, void *data,
 		if (!pred->regex)
 			goto err_mem;
 		pred->regex->len = len;
-		strncpy(pred->regex->pattern, str + s, len);
+		memcpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
 	} else if (!strncmp(str + i, "CPUS", 4)) {
@@ -1859,7 +1859,7 @@ static int parse_pred(const char *str, void *data,
 		if (!pred->regex)
 			goto err_mem;
 		pred->regex->len = len;
-		strncpy(pred->regex->pattern, str + s, len);
+		memcpy(pred->regex->pattern, str + s, len);
 		pred->regex->pattern[len] = 0;
 
 		filter_build_regex(pred);
@@ -1919,7 +1919,7 @@ static int parse_pred(const char *str, void *data,
 			goto err_free;
 		}
 
-		strncpy(num_buf, str + s, len);
+		memcpy(num_buf, str + s, len);
 		num_buf[len] = 0;
 
 		/* Make sure it is a value */
-- 
2.45.2


