Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACB2364C7
	for <linux-hardening@vger.kernel.org>; Sat,  9 Mar 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709972688; cv=none; b=EqUcJzYrGAI+v09km0aYem065TWDl8e4S6zSGqIK6IgM4XnsYPceEHGJNA9riD9J+oHXZ73KbQ84VWDPtxWtkamUDq6/jAjS1L2ZKUvXjrhnBqoQdTShfmoIOxQ1U250Q0zEtFNzIr8XTyKLeLG62kO0ozSePWxH2wwrf12v2Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709972688; c=relaxed/simple;
	bh=7tkM/0JbbXyVkdtIU4Si0Icg1L/BSNtCJO0oOS2f124=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RLxYVoHaaquF+QXTFZylBNF79Oqz3fPwjJ8FZwBSOg0JQ8qpQZ9UQyEixqvpf7TRcpTMuPJ0OnDjtxMiVNPZ+xicQ/qcDavUsnZv/y+JgwTqfVMBFwOXQvAoIQFCWwbP8C6VVlmjJrwE/M03M9t4OWtsHSBSqcRtGZU3JePH9iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=GC1Kgc0o; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="GC1Kgc0o"
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id is0Prj31ztrdZis0PrrHzN; Sat, 09 Mar 2024 09:24:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709972676;
	bh=gVcBB4b2goouePWzmRKHvoTzqcQB5Oy5FKzQOYSOsEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=GC1Kgc0o7FHTJ1pc0ke1tYRbBWKh+99jZq+P+pZh2zKK1dhPxt532FcwrjvpEQyPa
	 Je4QNMHO1I16tVsJAFp+Na54kHEaOvmSKa2HkVjY28n0zzrVEwj2bDUL+P1WEeEL0u
	 ymacvNonC7JCi5FsQ7QT0v4Kk8wbnrb0z7koB2vm6SVxVJdG4lE/zW+o+x39m33sJr
	 9rzs3lz/UKgMv8w2vUvShFGcZPyzhTOsubpgYW4stuoJTsRuKT9MTJ4xCsOEX42nd3
	 o6G8ROhf80Q8P22xsjOk3M6weWqwmj98UeEbPi+x5B5UcVvqWDJmlGtO+9OhnZPmCW
	 xZoqyKeBODW6Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Mar 2024 09:24:36 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pstore/zone: Don't clear memory twice
Date: Sat,  9 Mar 2024 09:24:27 +0100
Message-ID: <fa2597400051c18c6ca11187b0e4b906729991b2.1709972649.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to call memset(..., 0, ...) on memory allocated by
kcalloc(). It is already zeroed.

Remove the redundant call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/pstore/zone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index abca117725c8..694db616663f 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1217,7 +1217,6 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 		pr_err("allocate for zones %s failed\n", name);
 		return ERR_PTR(-ENOMEM);
 	}
-	memset(zones, 0, c * sizeof(*zones));
 
 	for (i = 0; i < c; i++) {
 		zone = psz_init_zone(type, off, record_size);
-- 
2.44.0

