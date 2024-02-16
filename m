Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04913A88B
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 20:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116275; cv=none; b=rKTucGfNUDqEF+bn+2rHsONT8cr8QC+ENjvXKVSy5VpzM9W+fed9dp9j++yxVytro0CRbmaOnVivYYKlBbPQ+Gc6DjBu/oIAns8/T4lrpcvjTuY+lYriaNr7VUt+s2aaHnM8+pPdoHLl/1ayKjkh0B2fo63+HguK/0KNnDE3JvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116275; c=relaxed/simple;
	bh=dcgKF8UiBBz34XJT7VHWm6Do34FT3jmf0XIZ/Dyw5Gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N53DoLsLlstVh8jcUW2ea0SJZU0JncPIC8AfsZl3MXX788wYSUJJjuvmSMlHubm+KB2YeEiJlDgj6oOLbWCCpufX5jP9sYAjnxgTsd5GUcW8qjFY3ng7x+w5WbZeohKMbVwPW0PvJSYj2WIJrZCIa5bYhZuBArKso0haSdxxExQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a70QFPIy; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a70QFPIy"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e104a8e3f7so2077188b3a.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 12:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708116273; x=1708721073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KfdPOM/mYc/pJQP93wRUe5zkjH2nJXn1uubLQkwefXU=;
        b=a70QFPIyG4/o5/xtmwXYobO4aNYt4Vr1abmDz2KqPg3ykNeFldET8fWLAR3kDwVwiW
         WBKbf6o6Ktns4fTlQHDySxUm/+Kke7cy0gDmSUoE+iEiNAS5WF2uD/EHpbIYFFgPEMDr
         BkioCPp2YnG3mQDmYrkphCZQLDW4yg/K1nLBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708116273; x=1708721073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KfdPOM/mYc/pJQP93wRUe5zkjH2nJXn1uubLQkwefXU=;
        b=X4A+d/VUGdhV+BIao/OZb1n2x573il5IBowhhdargTrCPRQaOBhth7EmNF7iCyjlp8
         3JvmB+hXHJU3hoE/AgtrPFaZo4tD/abk02RFwhCFCSEqq3kNqYqUosQU/P4MQn7pow1D
         K0SAMI2G+jgbG2zTuc1VgUp2/mqDKTfvx5jOcdcPgPkxHg72XbprJiM0kebq9t9s06rQ
         BclgBdlMIQF/8y6S51uE4Hn4Q7WYtPW5vNAi+BN6+zbHTttYzMBXTEyOxQlz4eyqfCJq
         42YFUrGxYQrgeupi4Oq0lSW5b0mZDKjwG4r+jLU0vlzkDy+2L/JDh5UkDI0EqjaAaJq4
         CDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrG/Fur4wJKpSSxZ/uJPxnznAIbw0MIuHszQeHHZQXjjfGVz2Kp9rlljtr8QCoTq96hSmCd6LT/p0nNnSVt5RJzsiDaaNC8YBDDyDU9LOg
X-Gm-Message-State: AOJu0Yz+i+gBgZ4XtC3M0+7PIvGRIhgoZZklOY1SJKOFRFsNniWt0OJL
	UO+SsMIjJT3Gnr4cyUb3z+CeBLZcKMfmNRbeVHfzOSBEaFwJjn9dBeUJ5v3ndg==
X-Google-Smtp-Source: AGHT+IFMp/+uwtXoTt8ZTB7NzHGsxYYLBqDWpyM5s8tBLrts/aiShty1PMRbExqYCcV/V7ylknMcZg==
X-Received: by 2002:a05:6a00:3d11:b0:6d9:b4e6:ffb with SMTP id lo17-20020a056a003d1100b006d9b4e60ffbmr7107600pfb.0.1708116272797;
        Fri, 16 Feb 2024 12:44:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e3-20020aa798c3000000b006dfff453f8esm366899pfm.75.2024.02.16.12.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:44:32 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] sock: Use unsafe_memcpy() for sock_copy()
Date: Fri, 16 Feb 2024 12:44:24 -0800
Message-Id: <20240216204423.work.066-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864; i=keescook@chromium.org;
 h=from:subject:message-id; bh=dcgKF8UiBBz34XJT7VHWm6Do34FT3jmf0XIZ/Dyw5Gc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz8knIiqX0gNushGFi5tcu+b6Z2huNDqRuDpnD
 7OBa/E/fjGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/JJwAKCRCJcvTf3G3A
 Jka2D/49xf0HEbfzzY6ewPuxOsgLo3p19BQFaeQdlEVmWTaTYVIkRIeAWuEM4tucWsRNjfFhtwL
 6h3b29oXEkNy+gSDIPriR9wiJ22Wc1ZNZitIyF5f6Vw6JdPJIDULPiAIF5SIEAJJCLOgbW+9kDG
 ZK1tFnFSilN3mdrPd+RaXPlGxvAfrGTb4Z13bkYd4odPAq/suwjVfTFnIGZGh+Dw7f6YWzEkKhd
 FW+B/PJ/EXxf+tQD2nVLFBZwE/iGUKYROXMrQarGY9On+dW/KZzVYK1Xm3ku9MUDeF2kBlqwIqN
 +v37IyAiiVTpM5O9Hmvdkm8J1AT9kWx4LMGK1TyQwwUpfgBrFs6MLmj+rRlubFGDuFJCRscbTY9
 EqysezRvgwPS68ntriQ2+6J6Gprejz/KiUneDnklbHYHoD0O/iopV0CqZUItKqH+ZEg2fHx0yHK
 2x1f1c7Cg8A9zVRy/fS77XTqQTLDKzVUKCV00Ug68xBain4Htb7k7KocPnSGgD/twCM5QioXQkj
 G5jg31qGUDwOMmWJMMG7MTjkHUEoxzRO+MqT0LBW+8kHR1M2zDSakXjZcjkSvlkWu8LegHqTIdG
 vFpt7rr5iY4esTyi0IA3MfGnzTMPkuM2BA3sVo+rZUkepnNhuVIQAmZHj/7j2ntVSzc+9fApR8G
 XtCi7K1 Uu1NLRFw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While testing for places where zero-sized destinations were still
showing up in the kernel, sock_copy() was found, which is using very
specific memcpy() offsets for both avoiding a portion of struct sock,
and copying beyond the end of it (since struct sock is really just a
common header before the protocol-specific allocation). Instead of
trying to unravel this historical lack of container_of(), just switch
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
---
 net/core/sock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
-- 
2.34.1

