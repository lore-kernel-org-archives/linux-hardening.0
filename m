Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C171442B1B
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786394493; cv=none; b=HT3cxenauXvVPfafkz9aR9EsfvSbdZCh1NC1InMoLHZ0hoBtmjkC86n4QBzRoH4UWAvaTr/JTyTf06hDfpC7kQav3n0XAmuE8r2LqNoGDzJl9FghgC2/kEXZhsLXVUwdBF59NpCyd9bWG0af0I+92MZH9ccbG8kVgLoiCwZVw8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786394493; c=relaxed/simple;
	bh=pFQD9MFc4A7vMMm3znX2ZQ/fMcPWFpch65waZMmi/CM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 Cc:Content-Type; b=fdxDAzisQyfwjr0KvOLPREU0a8ZGV81VWWKjSjo4UBLDeDb+OBueACpdUDqwNw3gUCg4ll2roweb2LVH2mGtBkjXjJ3W6Yo19Tc/o7d2nJc/z7tR5hiJ905Cbjij6ANR4o1YS4XohKM76f/a03oRkyDDme4jMER7XXCt4cXMdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ix1jsaBp; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ix1jsaBp"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf1c86963bso2757715ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786394491; x=1786999291; darn=vger.kernel.org;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TEfuVEjGYGEogEAHeBDsRpCxcd7/D4XhwfU+1h+Q/ks=;
        b=ix1jsaBpWEe//RJdvGX7Lyiirw4HtQN2Ym/FEDxpBrxcJAuiRcUddZSSwgnMOLMjDX
         8NJsrlNX71uJ1+d5SORB/KPATmtqow+q1+qkLDITGgHlGCZ4nTi9EI8DaabgxE+Z6TOO
         vw/d03PwXJ18oPJjD/NFZu8TGMR5kWhCzCubGcrOKiMaUTuJJKiPh17Cj41SwwgxMzs4
         pFxIgLDI0raULDzYSYTdxepsQ5REf3icghHcEKXZ29g9/xM7mcU1MUmQecLOgwW47v8Q
         diUTm2KvHwx6RCdHqJ10NnbkDhR0YB3JNjd50HSDmDlUJC1zkO54iI8EY7dZsyp1bYw+
         8wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786394491; x=1786999291;
        h=content-type:cc:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TEfuVEjGYGEogEAHeBDsRpCxcd7/D4XhwfU+1h+Q/ks=;
        b=TbvUqazcyIgDZxSP/XTRK1aqQXCO8TlokL7Oy8Fz2msfd4SXTlYNNI9iuRBWbpYJKh
         mK/EdtZvrKdj9Cf2zB3WRCfFgIjvFm9pkY+ChHR49K19c/PC2iorQCp4N1S8JMyctE73
         gJ76ayGUaW8KQ2jPv3AfmJXg1QpGSvEjK3defmLaj7X+7xLpjz9lf0FRbGHPO4DHRZ2o
         GqWZSRhAFQBMaiRUxgNBFXAd6uGoFde04qE53XA1bTP1coSs1oB6w6OXoyG4f5mXFmxm
         mdZFy5JDQo6vrelJfh0I4HtPyuOgvfI/0kGTA/aAB7LPBHSfpVCBUF/4dhSnRO20K2CR
         tyFA==
X-Forwarded-Encrypted: i=1; AHgh+RoxEtJbNqm/QwIQUgOiffoGVHd5amn/cIE9MuKcPbEILc7N/9zXiVuCNs5vxTEcH4mFAymuXSwoMXDtkMXnrHw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy943LFRCtD1j5v5nc9R+OBEkNH9Bd+wjm7eG8+uNFiMOzKSitf
	YoymSmB+f3On82xQe3PG+9ydgP+67SO/9Lv3WcGV8IYM99fsy5BFnow/l/gG2aFrO4q2htvnYkY
	+
X-Received: from pjab15.prod.google.com ([2002:a17:90a:100f:b0:381:171e:961c])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0e:b0:390:b3c5:e2c9
 with SMTP id 98e67ed59e1d1-392d61cf225mr489608a91.17.1786394491093; Mon, 10
 Aug 2026 13:41:31 -0700 (PDT)
Date: Mon, 10 Aug 2026 20:41:12 +0000
In-Reply-To: <20260810204118.1981755-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260810204118.1981755-1-morbo@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260810204118.1981755-2-morbo@google.com>
Subject: [PATCH 1/2] vfs: Annotate struct fdtable's fd field with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
Cc: Bill Wendling <morbo@google.com>, codemender-patching+linux@google.com, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The 'struct fdtable' holds the file descriptor table information,
including the current file descriptor array 'fd' and its size 'max_fds'.
To harden the kernel against out-of-bounds accesses, we can annotate the
'fd' pointer field with the '__counted_by_ptr' attribute, referencing
'max_fds'.

The compiler uses the '__counted_by_ptr' attribute to track the
size of the memory allocated for the pointer field, enabling
runtime bounds checks under KASAN and fortified functions. There are
three places where a 'struct fdtable' is initialized, and in all of
them, 'max_fds' is set before the 'fd' pointer is accessed or assigned
in all allocation and initialization places.

No accesses to 'fd' occur before 'max_fds' is set, preventing any
potential runtime false-positives or panics due to uninitialized count
fields.

This patch was generated by CodeMender and checked by submitter.

Cc: codemender-patching+linux@google.com
Signed-off-by: Bill Wendling <morbo@google.com>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
---
 include/linux/fdtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..3a5c88291125 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -25,7 +25,7 @@
 
 struct fdtable {
 	unsigned int max_fds;
-	struct file __rcu **fd;      /* current fd array */
+	struct file __rcu **fd __counted_by_ptr(max_fds);      /* current fd array */
 	unsigned long *close_on_exec;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
-- 
2.55.0.679.g6767b8d81c-goog

