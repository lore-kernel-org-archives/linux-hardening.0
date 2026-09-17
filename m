Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F294EDCA2;
	Thu, 17 Sep 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679577; cv=none; b=G806QbhHeMGwInOFxFzwUBPIO/DIP7byF0Mdskek9ezA6GuVAbH4syLX0TYMNE0SwzIV5vM9AJdaPcbJRCEm65LzmAI/1vs1H2DydiSG/qyDlLFFDwwXMLdrLd5a9Pd5jd41dXEwGASWEGzuLeYZaifD+oQhXE7vDqevJ+tTx3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679577; c=relaxed/simple;
	bh=A2SvxGznZQLby+4CJSYwh87UlotwnqlW/EpjicUe4m0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mb/MDicXWaSApIwziqDEuoZahCCkKPDtHQwTkkAwrpwdu7NjSCYb/qrO2POD/dpeBew4lAfeynNoZnm+rut3hRbalsG/JKKYQpFb39ZFAt/iaXhINILVOhrI4z19fYsKCD15jIlDP7dXfo7zcfMKWI4dhtOTnpP/RngjyG4c+Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AV1e4R7O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AV1e4R7O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE111F000FF;
	Thu, 17 Sep 2026 21:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679575;
	bh=hp/sX/mrzUT0yo1d5xNjhzdQFAh6Qxo86+w8ZSWKoTk=;
	h=From:To:Cc:Subject:Date;
	b=AV1e4R7OlEtNKtcSXZX2I73FrA1TLRSx4UFG6u8KD8E1RI8YhjlZDUyBHAoSXemwq
	 IqD1G4vCK6xrDdl3bbHIS6pZxuXrJkClNW+THRVp3dt9e55oPfjAvCzjJfIW1ouQof
	 xW86ord+2vsh0BBz5mcQda51XRrfL3TnpGsGiprtCTBihVAhiXJWTZA4ywcBrOqweA
	 enLepp8u1cEK+rK3yWGGwynMT9rdJRLNPgThhHbT2GqYzp/L/9ewmLYSfYwjsW7KuJ
	 k6bw1SGoTqrJgQx/NswOW6H0uvwNcg7V0qXVaZC2EduS0WcjmaucUofcoKQryohLIB
	 wlsbMU+JrBHdw==
From: Kees Cook <kees@kernel.org>
To: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] memory: emif: Remove const from min_tck allocation type
Date: Thu, 17 Sep 2026 14:12:54 -0700
Message-Id: <20260917211253.i.532-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1655; i=kees@kernel.org; h=from:subject:message-id; bh=aGh5HjBMyLhHucIrcvqACl6Dllxh+NtTZuYK1s8u7cg=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwq/elV/WUusWN73pRahizQxT2xIro5UXxaQ0nvvZS B4ImWrbUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJHfTgz/s2eE/76y4b7yip6T b9VmTlK62bHh4uMjViv9jidouf6M/8Hwzy4iucyn+c7UF4Vsqr17jhxJ7JvBscqqj//eBcFv9+S eMQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The size was taken from "*pd->min_tck", so the converted allocation type
would be "const struct lpddr2_min_tck *", as "pd->min_tck" points to
const. The allocation is a writable copy assigned to a "void *" and then
memcpy()ed into, so name the unqualified type directly, for a converted
allocation type of "struct lpddr2_min_tck *". As there is no general way
to remove const qualifiers, this keeps the allocation type matching how
the memory is used. No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/memory/emif.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/emif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 2fadad0666b1..1be543a5b1e5 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1062,7 +1062,8 @@ static struct emif_data *get_device_details(
 	}
 
 	if (pd->min_tck) {
-		temp = devm_kzalloc(dev, sizeof(*pd->min_tck), GFP_KERNEL);
+		temp = devm_kzalloc(dev, sizeof(struct lpddr2_min_tck),
+				    GFP_KERNEL);
 		if (temp) {
 			memcpy(temp, pd->min_tck, sizeof(*pd->min_tck));
 			pd->min_tck = temp;
-- 
2.34.1

