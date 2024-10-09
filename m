Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C111946AA;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480074; cv=none; b=pK9aeOkpYqoUcBWcFHysyUNyzWrl5RWwV5TgE4nFZoFAhDJTO8W8lmks0fIwTLOPO6wGo2MlGgel1Ua1Qizr36zRXK2mvbAIVh9GwBfIVGEZpC+QFcKzsT3+/VUI4fYFLENEX3HQwsfGM/b6ZgY6uNV70l0IlJGdX0vaFdo6ARk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480074; c=relaxed/simple;
	bh=tNZGbEZF4Exmspvj9tewG9lbswuRNTWCnITw4IhQQkA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ItUmYfsNTpDmdFiG/5JZAbkCZwHbFHLMXbE7L9mRO2qAOQFHXyUxP1IMsqoeRzWrZP4idKN9XfPx6lCBbeJ47rvAO/tfrO7iA6nYR2LyqwtSjI4UgNS/r6wDQHk1zTu4iYp3AWES8IUpZxfR+ux/oUS0MaxTHD96nLFL0cD59dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7841AC4CED1;
	Wed,  9 Oct 2024 13:21:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1syWcx-0000000176L-41mA;
	Wed, 09 Oct 2024 09:21:19 -0400
Message-ID: <20241009132119.818724987@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 09 Oct 2024 09:21:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>,
 Justin Stitt <justinstitt@google.com>
Subject: [for-next][PATCH 2/6] tracing/branch-profiler: Replace deprecated strncpy with strscpy
References: <20241009132104.470687911@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Justin Stitt <justinstitt@google.com>

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

Both of these fields want to be NUL-terminated as per their use in
printk:

    F_printk("%u:%s:%s (%u)%s",
      __entry->line,
      __entry->func, __entry->file, __entry->correct,
      __entry->constant ? " CONSTANT" : "")

Use strscpy() as it NUL-terminates the destination buffer, so it doesn't
have to be done manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/20240826-strncpy-kernel-trace-trace_branch-c-v1-1-b2c14f2e9e84@google.com
Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_branch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index e47fdb4c92fb..aa63548873c3 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -74,10 +74,8 @@ probe_likely_condition(struct ftrace_likely_data *f, int val, int expect)
 		p--;
 	p++;
 
-	strncpy(entry->func, f->data.func, TRACE_FUNC_SIZE);
-	strncpy(entry->file, p, TRACE_FILE_SIZE);
-	entry->func[TRACE_FUNC_SIZE] = 0;
-	entry->file[TRACE_FILE_SIZE] = 0;
+	strscpy(entry->func, f->data.func);
+	strscpy(entry->file, p);
 	entry->constant = f->constant;
 	entry->line = f->data.line;
 	entry->correct = val == expect;
-- 
2.45.2


