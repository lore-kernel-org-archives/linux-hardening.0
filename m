Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4231C2E
	for <linux-hardening@vger.kernel.org>; Wed, 31 Jul 2024 04:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722401671; cv=none; b=OYOCEx2UK0Pl7jMnZ8+x4sei758Ms2TZVIxu5XP3cmM/iEy/otb+Dcal9m5yUHnmDbza1OYoNdlO+Lnnv+3SUT1LqPx+RYkXyvkfo81h5woHFop3SlsypBE7HFxePsYkb0CQusyHG4WX7Gs7aO+VNXugHqrQ6G8gDR07yxN4g48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722401671; c=relaxed/simple;
	bh=us1Sqamgk0WwEE5daT8sWu5uRpLHAlEQI/r5jzRZXxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlNzyQKi6ArGP/rQ/jKA6anCGvkcoFH0Eq6fU8yGZ62c3pwiyPCNeVqSISkHErH7195c7CngzZ3SRvt/2VWNYX8DUUbpUiDippp7pbME1Uz8C58c/atAJO4oNKWg/m0fGbHlo6ZebyrOTn2xx/56PCAAXG9VLkeR2CIS/HmJP9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=DgbWrk4X; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="DgbWrk4X"
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id 8BA3B6860C
	for <linux-hardening@vger.kernel.org>; Wed, 31 Jul 2024 07:54:18 +0300 (MSK)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id 72B1767401;
	Wed, 31 Jul 2024 07:54:18 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2789:0:640:f3da:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 69AD860D11;
	Wed, 31 Jul 2024 07:54:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 7sNVbBxIWa60-rPptLQc3;
	Wed, 31 Jul 2024 07:54:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1722401648; bh=J8EwQBkcSTdrsmEeI8exxNgh424gbAD05v0aJfSCzHc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=DgbWrk4XDqMNX8Qy/ts2+2NlY7amrBVBHu4uUdMyIQk27cJF4cODJdArjKq1mAuS/
	 Zhxcx9Li9TDS8QXjKY6NgUyN5yyM+Q/DaRpWdrU1NIi8vDfxOh+ogyYGXheNwvGCEJ
	 xQ/NJ2h6QDrd92FnmV8Gxfr5KzHLvcoNLYsPuPxQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-46.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A . R . Silva" <gustavo@embeddedor.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v2] net: core: annotate socks of struct sock_reuseport with __counted_by
Date: Wed, 31 Jul 2024 07:53:46 +0300
Message-ID: <20240731045346.4087-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730170142.32a6e9aa@kernel.org>
References: <20240730170142.32a6e9aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to '__reuseport_alloc()', annotate flexible array member
'sock' of 'struct sock_reuseport' with '__counted_by()' and use
convenient 'struct_size()' to simplify the math used in 'kzalloc()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: style (Jakub), title and commit message (Gustavo) adjustments
---
 include/net/sock_reuseport.h | 2 +-
 net/core/sock_reuseport.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/sock_reuseport.h b/include/net/sock_reuseport.h
index 6ec140b0a61b..6e4faf3ee76f 100644
--- a/include/net/sock_reuseport.h
+++ b/include/net/sock_reuseport.h
@@ -26,7 +26,7 @@ struct sock_reuseport {
 	unsigned int		bind_inany:1;
 	unsigned int		has_conns:1;
 	struct bpf_prog __rcu	*prog;		/* optional BPF sock selector */
-	struct sock		*socks[];	/* array of sock pointers */
+	struct sock		*socks[] __counted_by(max_socks);
 };
 
 extern int reuseport_alloc(struct sock *sk, bool bind_inany);
diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index 5a165286e4d8..79f2456e27a5 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -173,9 +173,9 @@ static bool __reuseport_detach_closed_sock(struct sock *sk,
 
 static struct sock_reuseport *__reuseport_alloc(unsigned int max_socks)
 {
-	unsigned int size = sizeof(struct sock_reuseport) +
-		      sizeof(struct sock *) * max_socks;
-	struct sock_reuseport *reuse = kzalloc(size, GFP_ATOMIC);
+	struct sock_reuseport *reuse;
+
+	reuse = kzalloc(struct_size(reuse, socks, max_socks), GFP_ATOMIC);
 
 	if (!reuse)
 		return NULL;
-- 
2.45.2

