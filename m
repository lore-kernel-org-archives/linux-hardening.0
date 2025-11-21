Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A10302774
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754028; cv=none; b=QOC0InMSNDSANm7/oH5s5EScVGv1N9cvoKkVOnbHu1cdE0xNrTYJDwsP0IpOxfIatByAf5/4iuoxuKaVOwriTYfgh1K7uGsRnq+0cVWRL3emWlC7BqvQyStsv+CogsqMplk9kKfDF92dsANyhrUIha7WOuiqbhmXYNaisMOw/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754028; c=relaxed/simple;
	bh=sY+GLnH/NB6QUi9wxr+aVON0cHdYrC+5LV2ZVdrO4kc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Luq9Q1g14gQNC5U1L1b+eE71LV7DXKEp6ZmokCRZLUyfHODEJus9pU6GME1RdD7PcNQGY9Z+0eo76j948ThV3U1azWB0m76qW1XMM8xucjrAG37yU4WZUVsX45zVv7G5KFauMngnO5yFOllhVThql6p12uHgrvEN7HaxFlTsXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=joCIlGjT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="joCIlGjT"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3437b43eec4so3940208a91.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763754027; x=1764358827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ObV+Zk4UGl+OHKUlzzzuAGKm0snV0PrXsMvOzsuqro=;
        b=joCIlGjTXlSM/zdKWkZ4/+N/IzZ02BQstIWwN/Nct5XHXa+dxswi+lYAGKavtoDFUb
         N60f824/ngrBybRPKaTVWF/Z0dnTqxul6cXgyjN/AMU8l9ta7wdXvYs8Jz81WqsE0wVl
         01wnoUiDUEU5SQeGIZJ5TB30dcgSUEEwpNjMOy1rTh2f8VEB34+l+hiEh8CqazquAUJV
         uH6Rf5eLkyfgOYcOWGy4ukDeyXg2I37tDPDarANnTCQtcQOeXSsD19h+vcdmMEpt+ii6
         JCGK/+I65BF9K43MuZNZuqIpeVIb8bPo4NYd8PpyfByRA4SKfZeZz5uG5z3/f+41lElv
         +fXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754027; x=1764358827;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ObV+Zk4UGl+OHKUlzzzuAGKm0snV0PrXsMvOzsuqro=;
        b=NEp2E/V49dcpiQh/G9opqqMJbzPrteupU6D6hAwnjER/idZJYR9YDh7dqfIxHKPGMe
         gAmLOKeyKIu1eVUi5zazx964ravBcPtA0LNJGnQVedclUTg8eTLgWIJ2v6rDGJYtR2qc
         osijRaDN3WSP9ma2Yo65NXnqFTETEeo4g14v6cpW4PtKlMvftMnaMjYm350H1miWZiBC
         c4ba0Qa87u7VJLseVZvW2vcOBWUQnNEE1GzGqSrLkcMkDs0AUBZVbfNe+KUYYG55kRpQ
         gxHRzVEZ6u/duH9MMDMrQ10aliU0CzcAbUyT8wkYlQGiNZSygmAKTodhoMnbHWGoVjjv
         oHOg==
X-Forwarded-Encrypted: i=1; AJvYcCUAiJMg1Ug2t4j3bF/iZFfxZrD0ykOjCe730VR8XlbNrhnN4DHgSxBgQeJXccv2CAdPmgbzqzD4R9I+nZBsDQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqsK461BLUoKQeRTkWHIrmeTGw5RcopJaJCCTONUZMkZ5PJC9
	oT3+h2jtUz/kaL0MdlwHVE4Yf4z08XkCllTFaLhKowkvvlsTZ3PAweCEPt4Fcap0DMwFy9LbN11
	M
X-Google-Smtp-Source: AGHT+IHYGh5zV/fY6RILJsIKpbvv1F1nIeTXt6YbFfyOedqnc8pj8XMUszI38AOKmYkoqII6p7rKJtxK2Q==
X-Received: from pjbch15.prod.google.com ([2002:a17:90a:f40f:b0:33b:9e06:6b9])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:274c:b0:32b:9506:1780
 with SMTP id 98e67ed59e1d1-34733e60873mr4100051a91.9.1763754026636; Fri, 21
 Nov 2025 11:40:26 -0800 (PST)
Date: Fri, 21 Nov 2025 19:39:44 +0000
In-Reply-To: <20251121193957.1655580-1-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121193957.1655580-1-morbo@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121193957.1655580-3-morbo@google.com>
Subject: [PATCH 2/2] memblock: annotate struct memblock_type with __counted_by_ptr
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, John Stultz <jstultz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add the '__counted_by_ptr' attribute to the 'regions' field of 'struct
memblock_type'. The 'regions' field is an array of 'struct
memblock_region' and its size is tracked by the 'max' field, which
represents the total number of allocated regions.

This annotation allows the Kernel Address Sanitizer (KASAN) to detect
out-of-bounds accesses to the 'regions' array.

Cc: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Bill Wendling <morbo@google.com>
---
 include/linux/memblock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 221118b5a16e..ba7f7c999a45 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -91,7 +91,7 @@ struct memblock_type {
 	unsigned long cnt;
 	unsigned long max;
 	phys_addr_t total_size;
-	struct memblock_region *regions;
+	struct memblock_region *regions __counted_by_ptr(max);
 	char *name;
 };
=20
--=20
2.52.0.rc2.455.g230fcf2819-goog

