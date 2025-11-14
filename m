Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A989248F62;
	Fri, 14 Nov 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763128400; cv=none; b=hf01gxpOHL8zxZ052Q43z6K6djJVD15FqIYIg534jHlYqeWlERfATpx8aHnBX9uDp4VHlWpK+YZBRbPQmaEuHR0tuPvW5P1wznvZBh39SaIehl7eH78f5YkUzkAbOCABblFhiCd4PNht31AcwlJKXAUk7W8jznSED/KrVNMDbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763128400; c=relaxed/simple;
	bh=w4CZbAIyWcA31+nqQKhqOmJmSX5rlJdGd5Jb7G9+aLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lY8MvTy4HqcANd/zFjvXlr4QGsjBPJVxbQqdmsZr+LQK9u92Y3CuN7xmYyrfs4FIlP2rpf6vPZOnr578U4mWeT28Vx7VxJtmEl2CnT6CT903h+VN5kuLxa6CF45tkqcOhqc/iDq/+GjiDuj+g05EcUZ9n4w8dWj29kX5HSCLz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 260AD13ABB1;
	Fri, 14 Nov 2025 13:53:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 57A8519;
	Fri, 14 Nov 2025 13:53:15 +0000 (UTC)
Date: Fri, 14 Nov 2025 08:53:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] unwind deferred: Annotate struct unwind_cache with
 __counted_by
Message-ID: <20251114085332.396aff85@gandalf.local.home>
In-Reply-To: <20251114084346.6469edc0@gandalf.local.home>
References: <20251114122748.222833-1-thorsten.blum@linux.dev>
	<20251114084346.6469edc0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 57A8519
X-Stat-Signature: tqwudmxoyd4zz9aerds31xjoi1xkg5qn
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/pYNJ0ewjg723tYFoQy/BdvpQOT5bZmgY=
X-HE-Tag: 1763128395-867731
X-HE-Meta: U2FsdGVkX1/nXWQaZZqA4usyt84nFps4gChuc9eAzXPg/lkBrktv7dXN9+jSg/JrS8b2lBTy2MjJn1yI8pWwN10tqXqdcq7Hubhuf4niiw5McqjI3U928KyXBVZPbJBpmzPqIz/Y6TzuU+pq0SUxLzkTCUQ3bfKViE8l1jNh2mHZSkfKLbSw2H+pQzvzU13sgDXbuxiuqAbf021MHMjyqnjAL+mp0hlIAFgGji4TzJ3TApvT36j+OleYWk9fHywFY+p+ZL87pplR8qYK+1W+oU1IVLjhsmRxILnnh4fwJTatlYoLYlXU/TC3CTj99RyV9o5ikwHvTBx+pHWIgVATTsr7ElREGcdab0XGpTFzlXnG9I4OlWS5aSLw8H+jHJRKUK02a5NZCfjRwJCP+QPDCw==

On Fri, 14 Nov 2025 08:43:46 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> I need to add a comment here that entries is not bound by nr_entries.
> 
>    https://lore.kernel.org/all/20250730093249.4833be14@gandalf.local.home/
> 
> Maybe this?:

Or better yet, if this compiles (I haven't tried):

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index 33b62ac25c86..253a69b21e76 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,10 +2,14 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+/* Make the cache fit in a 4K page */
+#define UNWIND_MAX_ENTRIES					\
+	((SZ_4K - offset_of(struct unwind_cache, entries)) / sizeof(long))
+
 struct unwind_cache {
 	unsigned long		unwind_completed;
 	unsigned int		nr_entries;
-	unsigned long		entries[];
+	unsigned long		entries[UNWIND_MAX_ENTRIES];
 };
 
 /*
diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index dc6040aae3ee..5dfd0ac264d1 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -37,10 +37,6 @@ static inline bool try_assign_cnt(struct unwind_task_info *info, u32 cnt)
 }
 #endif
 
-/* Make the cache fit in a 4K page */
-#define UNWIND_MAX_ENTRIES					\
-	((SZ_4K - sizeof(struct unwind_cache)) / sizeof(long))
-
 /* Guards adding to or removing from the list of callbacks */
 static DEFINE_MUTEX(callback_mutex);
 static LIST_HEAD(callbacks);
@@ -118,8 +114,7 @@ int unwind_user_faultable(struct unwind_stacktrace *trace)
 		return -EINVAL;
 
 	if (!info->cache) {
-		info->cache = kzalloc(struct_size(cache, entries, UNWIND_MAX_ENTRIES),
-				      GFP_KERNEL);
+		info->cache = kzalloc(sizeof(*cache), GFP_KERNEL);
 		if (!info->cache)
 			return -ENOMEM;
 	}

-- Steve
