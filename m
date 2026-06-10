Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650D9352006;
	Wed, 10 Jun 2026 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781126066; cv=none; b=l+nWcKcnFj/BZUMctQsQ7h20o3nhW4Os8UiWAQgnEEg8S7VrYMb9DxgfvuI0NsbO6E/Rgp/d+nqNLDToeiG5D4zvoBCEaudqRrVBWU94mvG78oL0UfP9OaNTK5Bd8zTInBrIhh9O6imHcd6ww6X01GeMoHd20O/2aDH+WGHrfXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781126066; c=relaxed/simple;
	bh=kcCMHdyrkQwBLN6mFPKLshNLPrl7OiWk3AXp7aNCZ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHEGVDwvROZodgOHv8sBlbCqvCj/18TH55hyYFVwm+vp6zzJmPpDqEFLJsXFA2kkixnW9IgxO7WQq3mmYLUDCWA5+98XGLqnf4jhY7RHKMXdixHS/EKBhUuYpVgyl6R0nHeBODf0/f39/IQ1SA+1lnIWBXtynL3cl3qHW/gVyLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTmBc4uT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTmBc4uT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218EE1F00893;
	Wed, 10 Jun 2026 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781126065;
	bh=tX9c4IBtxmqpNWyTX19jGFou1ivW/Xvjn151g5nluKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aTmBc4uTEFvbTMWmm33jECSvNIr1TxD3HKmve7j1VseblnFT5EjXu1MZkSZ3jAXq/
	 +HkiCZrDVLJvCHr8sVquTGbnWcj25jkJomN7htZqa7ReAjL3TIfiXIMOrZZXdDLT6w
	 8ZEnD3Qb8Osm3m2SYmWJLM6X8yvRf58MIwgLW6MTgr8HFOo46gbQgj7AIAoqEZEmxN
	 42AW6ZpmuzJfBXKif6joatK5KysPYRi9M9VejDkviWrLjKidIee4ka7Vz8vgw2YeVG
	 dQpFbRXN+xP+JqifZ+sdu2ZsXdjEU9BpihCfAIFrZckOl6uUkHEn9T3aIRLjwc1vg3
	 bOVTVO9T58ZYQ==
Date: Wed, 10 Jun 2026 14:14:24 -0700
From: Kees Cook <kees@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] net/devlink: Use strscpy() to copy strings into
 arrays
Message-ID: <202606101412.D1AD83829A@keescook>
References: <20260608095523.2606-13-david.laight.linux@gmail.com>
 <c6eb816c-3f2d-4705-82ea-8c2c0ad70ded@redhat.com>
 <20260609161338.2222ff26@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609161338.2222ff26@pumpkin>

On Tue, Jun 09, 2026 at 04:13:38PM +0100, David Laight wrote:
> My aim is to get to the point where the calling strcpy() is invalid
> unless it is used to copy a string literal into an array.
> If/when all the .c files are changed the .h file change can be committed
> to stop any new potential unbounded copies being added.

Here's what I did a while ago in a test tree of mine, but for strlcat:

---
From d09759b1e51dbf784b503c9b9f5136b81b58560c Mon Sep 17 00:00:00 2001
From: Kees Cook <keescook@chromium.org>
Date: Fri, 5 Apr 2024 11:08:41 -0700
Subject: [PATCH] fortify: Refuse to use strcat() on dynamically sized strings

Limit the use of strcat() to things we can determine at compile time to
be safe.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/fortify-string.h | 6 ++++++
 lib/string_helpers.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index 171982e53c9a..8797c06b46e1 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -57,6 +57,7 @@ void __read_overflow2(void) __compiletime_error("detected read beyond size of ob
 void __read_overflow2_field(size_t avail, size_t wanted) __compiletime_warning("detected read beyond size of field (2nd parameter); maybe use struct_group()?");
 void __write_overflow(void) __compiletime_error("detected write beyond size of object (1st parameter)");
 void __write_overflow_field(size_t avail, size_t wanted) __compiletime_warning("detected write beyond size of field (1st parameter); maybe use struct_group()?");
+void __fortify_refuse_strcat(void) __compiletime_warning("Do not use strcat() on dynamically sized destination or source strings");
 
 #define __compiletime_strlen(p)					\
 ({								\
@@ -411,8 +412,13 @@ __FORTIFY_INLINE __diagnose_as(__builtin_strcat, 1, 2)
 char *strcat(char * const POS p, const char *q)
 {
 	const size_t p_size = __member_size(p);
+	const size_t q_size = __member_size(q);
 	const size_t wanted = strlcat(p, q, p_size);
 
+	if (!__builtin_constant_p(p_size) || !__builtin_constant_p(q_size) ||
+	    p_size == SIZE_MAX || q_size == SIZE_MAX)
+		__fortify_refuse_strcat();
+
 	if (p_size <= wanted)
 		fortify_panic(FORTIFY_FUNC_strcat, FORTIFY_WRITE, p_size, wanted + 1, p);
 	return p;
diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 169eaf583494..27b9d97c60c5 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -1019,6 +1019,8 @@ void __read_overflow2_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__read_overflow2_field);
 void __write_overflow_field(size_t avail, size_t wanted) { }
 EXPORT_SYMBOL(__write_overflow_field);
+void __fortify_refuse_strcat(void) { }
+EXPORT_SYMBOL(__fortify_refuse_strcat);
 
 static const char * const fortify_func_name[] = {
 #define MAKE_FORTIFY_FUNC_NAME(func)	[MAKE_FORTIFY_FUNC(func)] = #func
-- 
2.34.1


-- 
Kees Cook
