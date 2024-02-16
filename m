Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA31487D8
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125752; cv=none; b=t/RlH9GLLYOKhKSnJNEkjS14eaCuxz+7Y1D3yJsy2w6leqdcby28Ks6MQbycDoF6j4DbjHLXzAm1I00VAj7F2tuJPgZuQsqIpOQrIEctT4wdu7FYzOGzKGcvxXxhJP7pYi3QLwtvi8s5iowU9iSdt9yCkbXb1Z4+et7wm3NJYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125752; c=relaxed/simple;
	bh=AfToehbazLkk4D8atJ2IeQiatl0vfo2gPuKKeEbzT0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kEiJ2bgKkO87Y6H4mIFh0Vx87WXwslQ6OOfdIR7h1AsU1M3krRVZeL3AvnWGf02jqd3SX3VctKJmFUy0DK5ZtKi4+C+s39KNRypa+7mQ1zOsdA0TLZzJsIQCzW0OhY/Mf49Y8zmyx6Ex9egkOfbq9o4U/JeuKERQSUy6MsHcG4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mxFuPjy+; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mxFuPjy+"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c1404d05bfso796393b6e.3
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 15:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708125746; x=1708730546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cySFSaaMS+dXgwcEMJ3GUQwT0nia05ir6tsszW4Yyu4=;
        b=mxFuPjy+4EyPa1lp3qyaEyBzEBalHk0TPCYA5sROZ3/0QmO2VGf49fsRbhlnzfupgm
         qAqJ5jrGeAhcN98B839PELAh5ZIMzlqSY3zTGHbIvruB+a6wwbg4V6e4Dx0IFacsJlK0
         KUzsp24MAZ4R1FvM+upNdfajX7Rj3nOcB24lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708125746; x=1708730546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cySFSaaMS+dXgwcEMJ3GUQwT0nia05ir6tsszW4Yyu4=;
        b=Im8BsdBXQQmov55KrBYPMTtek9wJfgsI8fKt0wxl2QiS8hlzV7CQIIFrPvDYip2rfo
         WjDXI1Ysf/lY76f6spiAbCZ8+pOWirghFulGEcx2Noriuh2cZWMeKS5X0/PrKObvIIqW
         qq94az4dejc8kmHaZb8P6IR8tvamgms9KX72hIxyN9xtoyKqyTkuNU67sFR17RidLIYJ
         SkF1KsaaYdSTXZ/iZs0dYusEBP/Dm+3SXB62UxvX2ARX50xtPA24hByC1mPUkQx1KCE5
         ENlZNLysaJHRi8xTYwZIi/BClwhoWjjwMuFz2s+MlSikSbzkeZ5MFlLucPEpNRj2c+ED
         alOg==
X-Forwarded-Encrypted: i=1; AJvYcCX7OLRbJcYRU9b0QMRpnlNYpI7roh9RXJ7xiO29iG4LFtRttd/1bdPGL34RUNvyFadcy8IEnEzl0UCtRN2vA5PU+HQwaXXOno1XPHkqSdC9
X-Gm-Message-State: AOJu0YzgYQ/C4E6bUB4QDZL3ZB/WPJmv1JiVU3h+p9TiRdVJK3iJbBS5
	3w7XWq7zRNgQrKjJKOzi7yj04YFJnhnkBKN2ppef5JxF34ljOafM3Q4U/qWTBg==
X-Google-Smtp-Source: AGHT+IFJ7BJQmwIMICkPDlvj2/02BvzkvmoecpFuyBPJXIAzmHz5zxn1mLoQ0cD6kwU9B+oBT5SI6w==
X-Received: by 2002:a05:6358:478d:b0:178:c943:d2d8 with SMTP id i13-20020a056358478d00b00178c943d2d8mr7301354rwn.19.1708125746167;
        Fri, 16 Feb 2024 15:22:26 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y14-20020a62f24e000000b006e25d4085b4sm160890pfl.27.2024.02.16.15.22.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:22:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] sock: Use unsafe_memcpy() for sock_copy()
Date: Fri, 16 Feb 2024 15:22:23 -0800
Message-Id: <20240216232220.it.450-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895; i=keescook@chromium.org;
 h=from:subject:message-id; bh=AfToehbazLkk4D8atJ2IeQiatl0vfo2gPuKKeEbzT0c=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz+4vtP9XZ8kb58vJFJPFh9mWGtCyoBdybB67c
 vfYeLhguQuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/uLwAKCRCJcvTf3G3A
 JgOBEACWWQWMGqzQ5TszpLZqznvaGGgzkjAXu/Q5IAR+0mPMA8Zh4Hx4w411JmzASDuZmA4RLIp
 SidMjd5Wbg35DLnr6ncwOxByfpgh5YdOrlHaHFbnP/Lyg3IIDTE2pstAJiCEg3aDX7/Usmvnm2T
 11etazgXJQXuHXf1gZsD5grxVjk1FKX8GAFul0+UYv/VzZLBOe+W9V2dR+2LvUrdDr+++OwDyos
 J1B/7yKzw6UVtvnx41hKacMM5WoOknJ82MbQYFuzSWLgl+WEmlXm8tRijnC5sn0PO0YmTQOaPuq
 MssOQYoUkIFE/mxsH70FrMlgZSkd6KQTJB7BLjQl9oOv2dovBC4dTbYhC9IvRpcazrXJleTZFyA
 GlQ3otlVg89xz+njrGCyqKefEK8a67G/stqm9fDmJZUql0/pqGJqz8G7LEtOQ6+r66ERZ6/he+M
 s7DGi+I3fWlmpHIfZ4s1TNZ5eIawHlnt19jLnOdD1c27V7nP2BvIb4ovgvLX4/JKNqleqfMjeE/
 oHdD6ANNlDCinWsHK+QDIh7hjvnM7DWDG3yluAwD8ichFbqi2ANXojfklBkqJ0gCZb13ufqHZZs
 r5dpl8CJABQalqKVMj2auUbh9vgJDAl72Ck9BM15MOLfRc19qrCvNv4HMe/FAmAAX+UWYapVSrj
 kkwSRQe +9Fye++g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While testing for places where zero-sized destinations were still showing
up in the kernel, sock_copy() and inet_reqsk_clone() were found, which
are using very specific memcpy() offsets for both avoiding a portion of
struct sock, and copying beyond the end of it (since struct sock is really
just a common header before the protocol-specific allocation). Instead
of trying to unravel this historical lack of container_of(), just switch
to unsafe_memcpy(), since that's effectively what was happening already
(memcpy() wasn't checking 0-sized destinations while the code base was
being converted away from fake flexible arrays).

Avoid the following false positive warning with future changes to
CONFIG_FORTIFY_SOURCE:

  memcpy: detected field-spanning write (size 3068) of destination "&nsk->__sk_common.skc_dontcopy_end" at net/core/sock.c:2057 (size 0)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org

v2- add inet_reqsk_clone() instance too
v1- https://lore.kernel.org/lkml/20240216204423.work.066-kees@kernel.org/
---
 net/core/sock.c                 | 5 +++--
 net/ipv4/inet_connection_sock.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 0a7f46c37f0c..b7ea358eb18f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2053,8 +2053,9 @@ static void sock_copy(struct sock *nsk, const struct sock *osk)
 
 	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));
 
-	memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
-	       prot->obj_size - offsetof(struct sock, sk_dontcopy_end));
+	unsafe_memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
+		      prot->obj_size - offsetof(struct sock, sk_dontcopy_end),
+		      /* alloc is larger than struct, see sk_prot_alloc() */);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	nsk->sk_security = sptr;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 459af1f89739..4a1d96ba3ad1 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -906,8 +906,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 
 	memcpy(nreq_sk, req_sk,
 	       offsetof(struct sock, sk_dontcopy_begin));
-	memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
-	       req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end));
+	unsafe_memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
+		      req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end),
+		      /* alloc is larger than struct, see sk_prot_alloc() */);
 
 	sk_node_init(&nreq_sk->sk_node);
 	nreq_sk->sk_tx_queue_mapping = req_sk->sk_tx_queue_mapping;
-- 
2.34.1

