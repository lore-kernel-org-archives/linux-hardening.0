Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9B29E107;
	Sun,  6 Jul 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751823459; cv=none; b=rKwZGsplrxhlgPQFOAkd2YtmGZYjRVFaJaeMXMrBecabl1PIB+VfL4mKNq3Kr4LYjBFv8o4uYk2fPrnI43GLpXKgj0cqq5l05ErQEEaU+ZO9LAnbzxY3rtLkvy+2PVXXRBFf47gP6WJ+Hr5y0BmAyppvca4xIMroJEd6diuHQ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751823459; c=relaxed/simple;
	bh=UnukMHnFrNRdetsFMcw3prQ/v4qlktaL9HMhPaNQEX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRBTCVmBLJDNqh61F6HoOJrbfIZxWp6FXO7MCcWBzNrkcrGRgun4Pn1kVBzKGeQ16S5/x9Oa1OJ+IqTlTCEmz/ek00IGZfZu7o7bpHumOv+dyH7W8ux4XXHO0B2VODlSgFIHDZnIIbg4JM7lk1QwSxUn95lTY6jIlYzNifOHNrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+0fEEWh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+0fEEWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB8BC4CEED;
	Sun,  6 Jul 2025 17:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751823458;
	bh=UnukMHnFrNRdetsFMcw3prQ/v4qlktaL9HMhPaNQEX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+0fEEWh9MJ6JFKfYxoBMdO22bAvSQoipCY0TnxmtCAoa6FLL9qyOXFWbJGOj4EXo
	 klJx55P/GGzG0UvTYhk7wyvwGE+iB1JWnE4v8f31Q0QUPccSmghsq1PZHDy4+IHCkB
	 qY8GJgZlcUxBFWFhFL86qrDo3bzzfapdPvQCoaIKp6kIXkYcnWIpRCQ69JEY4XtQP9
	 3ZCl6wmRE2JxPtSI1pH4JlXEisY0sK4FHcIqgIGBp0TV/aS+YaxL67X9Nzh2Hw/Wpt
	 jD0x+IZT/s4aq8rCGZ8e76I2nE3Fgrt728mxNrqGUkuYSu2ikDHqflY4owJ3sCl3HD
	 8uRGUvyKYqKTg==
Date: Sun, 6 Jul 2025 19:37:36 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-mm@kvack.org, linux-hardening@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, Kees Cook <kees@kernel.org>, 
	Christopher Bazley <chris.bazley.wg14@gmail.com>, shadow <~hallyn/shadow@lists.sr.ht>, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Clayton <andrew@digital-domain.net>
Subject: [RFC v2 2/5] stacktrace, stackdepot: Add seprintf()-like variants of
 functions
Message-ID: <9c140de9842dd34096928a7c87dab4f45ef18764.1751823326.git.alx@kernel.org>
X-Mailer: git-send-email 2.50.0
References: <cover.1751823326.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1751823326.git.alx@kernel.org>

I think there's an anomaly in stack_depot_s*print().  If we have zero
entries, we don't copy anything, which means the string is still not a
string.  Normally, this function is called surrounded by other calls to
s*printf(), which guarantee that there's a '\0', but maybe we should
make sure to write a '\0' here?

Cc: Kees Cook <kees@kernel.org>
Cc: Christopher Bazley <chris.bazley.wg14@gmail.com>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 include/linux/stackdepot.h | 13 +++++++++++++
 include/linux/stacktrace.h |  3 +++
 kernel/stacktrace.c        | 28 ++++++++++++++++++++++++++++
 lib/stackdepot.c           | 12 ++++++++++++
 4 files changed, 56 insertions(+)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 2cc21ffcdaf9..a7749fc3ac7c 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -219,6 +219,19 @@ void stack_depot_print(depot_stack_handle_t stack);
 int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 		       int spaces);
 
+/**
+ * stack_depot_seprint - Print a stack trace from stack depot into a buffer
+ *
+ * @handle:	Stack depot handle returned from stack_depot_save()
+ * @p:		Pointer to the print buffer
+ * @end:	Pointer to one past the last element in the buffer
+ * @spaces:	Number of leading spaces to print
+ *
+ * Return:	Pointer to trailing '\0'; or NULL on truncation
+ */
+char *stack_depot_seprint(depot_stack_handle_t handle, char *p,
+                          const char end[0], int spaces);
+
 /**
  * stack_depot_put - Drop a reference to a stack trace from stack depot
  *
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 97455880ac41..748936386c89 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -67,6 +67,9 @@ void stack_trace_print(const unsigned long *trace, unsigned int nr_entries,
 		       int spaces);
 int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 			unsigned int nr_entries, int spaces);
+char *stack_trace_seprint(char *p, const char end[0],
+			  const unsigned long *entries, unsigned int nr_entries,
+			  int spaces);
 unsigned int stack_trace_save(unsigned long *store, unsigned int size,
 			      unsigned int skipnr);
 unsigned int stack_trace_save_tsk(struct task_struct *task,
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..65caf9e63673 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -70,6 +70,34 @@ int stack_trace_snprint(char *buf, size_t size, const unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
+/**
+ * stack_trace_seprint - Print the entries in the stack trace into a buffer
+ * @p:		Pointer to the print buffer
+ * @end:	Pointer to one past the last element in the buffer
+ * @entries:	Pointer to storage array
+ * @nr_entries:	Number of entries in the storage array
+ * @spaces:	Number of leading spaces to print
+ *
+ * Return: Pointer to the trailing '\0'; or NULL on truncation.
+ */
+char *stack_trace_seprint(char *p, const char end[0],
+			  const unsigned long *entries, unsigned int nr_entries,
+			  int spaces)
+{
+	unsigned int i;
+
+	if (WARN_ON(!entries))
+		return 0;
+
+	for (i = 0; i < nr_entries; i++) {
+		p = seprintf(p, end, "%*c%pS\n", 1 + spaces, ' ',
+			     (void *)entries[i]);
+	}
+
+	return p;
+}
+EXPORT_SYMBOL_GPL(stack_trace_seprint);
+
 #ifdef CONFIG_ARCH_STACKWALK
 
 struct stacktrace_cookie {
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 73d7b50924ef..749496e6a6f1 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -771,6 +771,18 @@ int stack_depot_snprint(depot_stack_handle_t handle, char *buf, size_t size,
 }
 EXPORT_SYMBOL_GPL(stack_depot_snprint);
 
+char *stack_depot_seprint(depot_stack_handle_t handle, char *p,
+			  const char end[0], int spaces)
+{
+	unsigned long *entries;
+	unsigned int nr_entries;
+
+	nr_entries = stack_depot_fetch(handle, &entries);
+	return nr_entries ? stack_trace_seprint(p, end, entries, nr_entries,
+						spaces) : p;
+}
+EXPORT_SYMBOL_GPL(stack_depot_seprint);
+
 depot_stack_handle_t __must_check stack_depot_set_extra_bits(
 			depot_stack_handle_t handle, unsigned int extra_bits)
 {
-- 
2.50.0

