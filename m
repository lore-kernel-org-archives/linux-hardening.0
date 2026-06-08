Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAFF3B8BB6
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912550; cv=none; b=PZlxeLLkXocDY+sSX8CCRQmEK2XkO8turyQ6lPZbYNHVmZgzudA8jzfYHiomIS8PhOo374SVSXbJkOMx6iziQ+Di3bp+hCLueXKmMfOWI3ggbRn8OhJZlLHLeFYzYDp6WBMZHSeXR7GqEyNDXyAf3z1MrI8KQoZ+mlXHNxdOmPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912550; c=relaxed/simple;
	bh=Sx4Ze7AgX5RJCC8XRCD64N/GIkt8A6C2cwwFknSZMa4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPIH5McdbxCvpfOYb6LbANgfX2JKZKu5U6g3XYDppAltOvpt3kyFaSVLd5PxerhMPr9QVJ8kxPtLBeN8+/RIPnvbgYs+kdPd5fDvWiGyoxF4kJLiM5xUoIv3rvh/daLrcjkW4EzwR5sQSuzGfjRqQiTze8Uo6vEVnzF5rd/F4OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=XfdPRi1k; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="XfdPRi1k"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhq-00BrCU-Hr; Mon, 08 Jun 2026 11:55:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=MEGRMbuHpposeCciz6uVAu3BRF1Ammi62WRqbPW3TPk=; b=XfdPRi
	1k/72dcTjk4m/Bgp0cm2XtwE5qP/bkGx+ZcxIfZ2d09qb/yDuxDou4E+exWgQggybZTmAj1s1P9Fd
	AgUX07kkvGBBZPOtz9XxhtC8oySm/pSfQuUkfLVTEdcz/Nj2xrwvUKMJ1czcNPwjGtJdM9Da4m9TF
	x7g3xvtDOBUxt5Z/Bs4PJWM+84G0rWAo+rxcJNS5BmfWmFRJyJO3OdS+IknYS0jvER7ebyg16yEY/
	SSfJU0iAeDqenYWJkRpWY02UCw2x1TPcB4ZAhcKGKs8soJt3LUiIRBTXBKRZqLhFPPr3RQS27XClc
	gjItoyXB6LA0S4oxnOn1CJJQbXnA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wWWhp-0000GY-So; Mon, 08 Jun 2026 11:55:42 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wWWhf-00Ag6G-4O;
	Mon, 08 Jun 2026 11:55:31 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next] net/key: Use strscpy() to copy strings into arrays
Date: Mon,  8 Jun 2026 10:54:58 +0100
Message-Id: <20260608095523.2606-14-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Replacing strcpy() with strscpy() ensures that overflow of the target
buffer cannot happen.

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 net/key/af_key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index a166a88d8788..625822d19071 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1195,7 +1195,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 			err = -ENOMEM;
 			goto out;
 		}
-		strcpy(x->aalg->alg_name, a->name);
+		strscpy(x->aalg->alg_name, a->name);
 		x->aalg->alg_key_len = 0;
 		if (key) {
 			x->aalg->alg_key_len = key->sadb_key_bits;
@@ -1217,7 +1217,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				err = -ENOMEM;
 				goto out;
 			}
-			strcpy(x->calg->alg_name, a->name);
+			strscpy(x->calg->alg_name, a->name);
 			x->props.calgo = sa->sadb_sa_encrypt;
 		} else {
 			int keysize = 0;
@@ -1234,7 +1234,7 @@ static struct xfrm_state * pfkey_msg2xfrm_state(struct net *net,
 				err = -ENOMEM;
 				goto out;
 			}
-			strcpy(x->ealg->alg_name, a->name);
+			strscpy(x->ealg->alg_name, a->name);
 			x->ealg->alg_key_len = 0;
 			if (key) {
 				x->ealg->alg_key_len = key->sadb_key_bits;
-- 
2.39.5

