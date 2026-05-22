Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4892638C2D8
	for <linux-hardening@vger.kernel.org>; Fri, 22 May 2026 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779486267; cv=none; b=ofhKbH1Ef6juK8D6RDf0vwDtEoOEuUWk2vel3BTciIfJsoGyyauF92+RBjqLALNtXLtZdTAMzG0aEsj8i7IMcbskdTmA15oyI611X1DTEAo24hp2QxWWz/8Mq5VfCVLewtL7aGQUa2AdAI/qCNjr6LsujR5MGWShjYJHu6garjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779486267; c=relaxed/simple;
	bh=p0D0SvAiOiNPeriwNwY4FWBYY3sdeg5voF6KW2g27tE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YBq+fQgCY6VX2Rd0Fgeg5LNFsnmanKNChzzToV4dD163OStR0Q6gbIJQtslDGmKGMw90KE46xqHStxjcbKWL7b6ui2/gP6dSnZsgHbzmI91q6w6PHG4aPZ5zbygcwTEfyLpqgvOhJBF+8HDPixTQ/S6SUKdb7n+kheHlRw/48TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwLpEvTL; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwLpEvTL"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3698e34a567so6979358a91.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 May 2026 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779486265; x=1780091065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0a6+9FSkd4CAvkhrb+PFN6/wUARChFwi4N+F/39VGM0=;
        b=DwLpEvTLoqJjuEz0UqBazmZVWL6k9IHJGqD280ZZJlRAV7r7jZpNsz+h2DQa4c51Ul
         2QJo1U3f609RCjKSCCbjTaj4sedh4m6hZ64yMXxa2AuqgZ16m6vtUneKlobACEPppVux
         S6fj9yfhzN07m5HunFd3E4wU78jBdxjQbPceHhL2WRLjhWGB709J4uNckMHWPThU3TdS
         pBYgWBqk69m33dydg3um6gZX54EOdy3KQqHjZBf/h6deEYd3JHV9cpV2H7STzgkdze+I
         8O92bIvyJI5Y9YV9kqTASMeyMGcHQa1XSRwbMWVJOQ2VgyOKVQm173HtCI4ie9kUDtX0
         VEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779486265; x=1780091065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0a6+9FSkd4CAvkhrb+PFN6/wUARChFwi4N+F/39VGM0=;
        b=HDROpnuQHwW011Evsp/UTdxV+xkQUrOPM/FUH3eh3YBAQuR0REvckVdxCTNTRLaQaW
         rCa3+4exbbXMcThbI7XQMcbC8XMIXXAwr4oBkoteBaOmeaETDIkpw/+OMWi1Mf6RbZ9O
         0ofcXF539KB+KySTsRofs9rmunH9Qz+iNBh6wFnT0WTIPYeK9MGfrF1XVuldcfSzHV8U
         vv2tsKEIOQxSQz9Vymp3OqsmXrdSwSzdH5bhisTHp5Tl8yQrWHtVau3yapnWTosxCLBd
         A1TwdgS8B+WlYknA2pfShw8mkRMi0pT5XcnotWs4pd5TrEHmblmq7471hCBWrcZr1xQ7
         YpfA==
X-Forwarded-Encrypted: i=1; AFNElJ+D2P32gZ6P3dPIurPgUORTrFpuWJn2WD38b4Q5kFhR4fR/6WjhZgLZvLXgLW9WCX8+gW2bhIogKZAKwWE/M94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLmj6mYgqiwOmj7zRFfLLZ7XYrCzuClYLIIupTUb9T4Z1MPjO
	qBx/z5TJjbsd6Ws9hnACYCBuyUwqIYfiTb0bb/1MHOi5suSzvds6J/W9
X-Gm-Gg: Acq92OGdbpuHDck7PnZi2TBVlXPecVcRdeACP52tSv7hzucn9z6UJ0E3gbhWPP3TLTb
	oPvk3ihiaQUGRJgDHI/Wkg9OGWE1IvqgAhQaSl/KqFq8kqix1jcVMG2lYdLLYyfiNxGy2B0koWh
	fsfYl5oURkQ/kMhwn2UgBz66zEDu3KSip8EnAtI9iyNDsqHJiAZu9kygHcV5KTk5DY99Ih5y7Ut
	nPmMezgrpiRCFfIHoXK73WWKe24kDPi2Ozn7MzGLzooxVuRgK2ySBplaULRVriVFLEWCk91cX2K
	h/om0t807Pc9oa07TvqbhRGQojqCDzcDK/yvh7Zoh7hempyq9bbPeRuzvnci+2PtXDnE2wSgJ/M
	kTdUkBOrRnIr+rHyXt8USmlxGz0N18g5nV7/2EOTAPozB28RWAfLRtl+EglC+dazyiTE3eoRA29
	wNn2zKzt97ELh8UmZ2T12WWg0z7ETWefuhtbbCgFZzBDflqp9QXKuHAkIWgbylQ8sW71cUomO8E
	nUPnowyTMt416sq3H9XxVRGBKD7WyOveZpShjVEePeGzg==
X-Received: by 2002:a17:90b:3cd0:b0:369:a962:8cca with SMTP id 98e67ed59e1d1-36a6771bd1cmr5194148a91.11.1779486265449;
        Fri, 22 May 2026 14:44:25 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a721c858csm2812300a91.11.2026.05.22.14.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 14:44:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] trace: turn hist_elt_data field_var_str into a flexible array
Date: Fri, 22 May 2026 14:44:07 -0700
Message-ID: <20260522214407.18120-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The field_var_str array was allocated separately via kcalloc() with its
length already known at elt_data allocation time.  Convert it to a
flexible array member and fold the two allocations into a single
kzalloc_flex(), reordering hist_trigger_elt_data_alloc() so n_str is
computed and bounds-checked before the struct allocation.

hist_elt_data is only reached through tracing_map_elt::private_data
(a void *), never embedded, so adding a FAM imposes no tail-position
constraint on any enclosing struct.

Added __counted_by for extra runtime analysis.

Assisted-by: Claude:Opus-4.7
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/trace/trace_events_hist.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a64c76f6905f..1fd0899c606c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -683,8 +683,8 @@ struct track_data {
 struct hist_elt_data {
 	char *comm;
 	u64 *var_ref_vals;
-	char **field_var_str;
 	int n_field_var_str;
+	char *field_var_str[] __counted_by(n_field_var_str);
 };
 
 struct snapshot_context {
@@ -1629,8 +1629,6 @@ static void hist_elt_data_free(struct hist_elt_data *elt_data)
 	for (i = 0; i < elt_data->n_field_var_str; i++)
 		kfree(elt_data->field_var_str[i]);
 
-	kfree(elt_data->field_var_str);
-
 	kfree(elt_data->comm);
 	kfree(elt_data);
 }
@@ -1650,10 +1648,19 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 	struct hist_field *hist_field;
 	unsigned int i, n_str;
 
-	elt_data = kzalloc_obj(*elt_data);
+	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
+
+	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str +
+		hist_data->n_var_str;
+	if (n_str > SYNTH_FIELDS_MAX)
+		return -EINVAL;
+
+	elt_data = kzalloc_flex(*elt_data, field_var_str, n_str);
 	if (!elt_data)
 		return -ENOMEM;
 
+	elt_data->n_field_var_str = n_str;
+
 	for_each_hist_field(i, hist_data) {
 		hist_field = hist_data->fields[i];
 
@@ -1667,24 +1674,8 @@ static int hist_trigger_elt_data_alloc(struct tracing_map_elt *elt)
 		}
 	}
 
-	n_str = hist_data->n_field_var_str + hist_data->n_save_var_str +
-		hist_data->n_var_str;
-	if (n_str > SYNTH_FIELDS_MAX) {
-		hist_elt_data_free(elt_data);
-		return -EINVAL;
-	}
-
-	BUILD_BUG_ON(STR_VAR_LEN_MAX & (sizeof(u64) - 1));
-
 	size = STR_VAR_LEN_MAX;
 
-	elt_data->field_var_str = kcalloc(n_str, sizeof(char *), GFP_KERNEL);
-	if (!elt_data->field_var_str) {
-		hist_elt_data_free(elt_data);
-		return -EINVAL;
-	}
-	elt_data->n_field_var_str = n_str;
-
 	for (i = 0; i < n_str; i++) {
 		elt_data->field_var_str[i] = kzalloc(size, GFP_KERNEL);
 		if (!elt_data->field_var_str[i]) {
-- 
2.54.0

