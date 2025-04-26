Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3E6FC3;
	Sat, 26 Apr 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648446; cv=none; b=NCpN/ails3q5LEevHyxsNOszoLP1+F2BU2bBUXjXYVXwpWlM/KAqNJQB27dLSF28CUf0ZmYtJssfCromkR8fyv2b5d7SkIMOxNIFkSYwx6JAsbvWCmT9nOtLo27UBcQMTl5CkEzc5bz3ipmkj3Fmfx0pZYEwXSGx6tL1Q5jCdXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648446; c=relaxed/simple;
	bh=EuZdc4J+N9m/JbbBsyBVqTEk6tsczDB+aFkCtyPfgrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Iv0iKTY1kxJbYUf3jFe2N4wPAbuKISqT1EmL/a3aJJwfsDjPEA5emd23b8UncvFy+DcmhCR3/BMdQN3pfeMtxZJOSby/C3OqGRkTAQ7mmWwPaF8Xf7M9WddWJg5G1/aAJGt1rpF28v/oXI+o7pSLuj56WMQIkToKtaJMFMcHamE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0CKb8Gh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0CKb8Gh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553F2C4CEE2;
	Sat, 26 Apr 2025 06:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648445;
	bh=EuZdc4J+N9m/JbbBsyBVqTEk6tsczDB+aFkCtyPfgrg=;
	h=From:To:Cc:Subject:Date:From;
	b=J0CKb8GhCyu89m8WLk6wgl8fGUla0vi9Pe2HOsorNfOjSAM5L4kLv1Q3YXYknTFbp
	 FuoUq+2gNoShdMjnPjkLgKTaxMp6wmoyzM0xUwQGeJ+UrGR9v57r4pO19kQwyI0vMB
	 n9rGm/xINtg9G32RPmFNsKpzB2Ad8QESzzIbxiOA47OwNf11o6lN5P83wQIbrPcTeg
	 o+Sv2Jyy6APE/QqvueAqvkzynle5Y/nmSskgrWgJDGq8edIj1TJLSXG4KJh0iffQ+l
	 UDgsrDgM/Dotxtt3dHg0kSfd6+P0mDtmAhqTk3itKXQIxSZovAbj3Q6Bz80PL8wPih
	 m3xUeCtmY0aWA==
From: Kees Cook <kees@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kees Cook <kees@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	Camelia Groza <camelia.groza@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] soc: fsl: qbman: Remove const from portal->cgrs allocation type
Date: Fri, 25 Apr 2025 23:20:41 -0700
Message-Id: <20250426062040.work.047-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=kees@kernel.org; h=from:subject:message-id; bh=EuZdc4J+N9m/JbbBsyBVqTEk6tsczDB+aFkCtyPfgrg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk81ZZf9c6mN37K3TlZ8NlKx19Hu/4zST1oeHL4eaOol 9vC7k79jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkcD2RkeHJ+ypGWe59nP5wo FDX9f2tg8tH/+yL5I6/UOM/7PS33dSnDP0XbhDsLHsx+rCsgm1F1sj7zepPEE/sTk7rtb7hJvly 7gR8A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct qman_cgrs *", but the returned type,
while technically matching, is const qualified. As there is no general
way to remove const qualifiers, adjust the allocation type to match
the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Sean Anderson <sean.anderson@linux.dev>
Cc: Camelia Groza <camelia.groza@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/soc/fsl/qbman/qman.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/qman.c b/drivers/soc/fsl/qbman/qman.c
index 4dc8aba33d9b..9be240999f87 100644
--- a/drivers/soc/fsl/qbman/qman.c
+++ b/drivers/soc/fsl/qbman/qman.c
@@ -1270,7 +1270,7 @@ static int qman_create_portal(struct qman_portal *portal,
 	qm_dqrr_set_ithresh(p, QMAN_PIRQ_DQRR_ITHRESH);
 	qm_mr_set_ithresh(p, QMAN_PIRQ_MR_ITHRESH);
 	qm_out(p, QM_REG_ITPR, QMAN_PIRQ_IPERIOD);
-	portal->cgrs = kmalloc_array(2, sizeof(*cgrs), GFP_KERNEL);
+	portal->cgrs = kmalloc_array(2, sizeof(*portal->cgrs), GFP_KERNEL);
 	if (!portal->cgrs)
 		goto fail_cgrs;
 	/* initial snapshot is no-depletion */
-- 
2.34.1

