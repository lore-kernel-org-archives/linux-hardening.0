Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D3E4E9C35;
	Thu, 17 Sep 2026 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679666; cv=none; b=OtSrdaDeGBEGfS5KsjOQR+zm3q9vIeCcYj9a9tGNEBdtniGfdMOPiQEvhJ9EMWM0Cxysk8weQo5lUecsOPn5+ww2+BdC4B13TnhCKwGX9jIpDxI1rwrpzps7LeIb4650yduhLHrTy+GYH28rTaA2ibvSd1aXGOrApU/+iXN7B1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679666; c=relaxed/simple;
	bh=4RhiaecufB0pnoProExGcGpi0NYYEhqeSGCNwQZfzwA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNZlpL24U+4iL0PFXpEWQcqbUoaqt0X4SgY8HYJqBHs4wLJzNdqjgNzCQab8QFVXfo7AWwHtxk45j5CU7SJjTqd9ARabcn7r5HnZNGMNXrIoQQhaL/tuqWt08bDt7EWGQK9QduaVIAqcg4ppbX0Wym4WWVNS8pvx0R6zzoqXw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2UnK5yc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2UnK5yc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F91F000FF;
	Thu, 17 Sep 2026 21:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679665;
	bh=6jQ8alNMNzjXc44AfDuzyiqgtKQgkvjjAj1TDRUER2E=;
	h=From:To:Cc:Subject:Date;
	b=J2UnK5ycLVE6aF4OUlE7bxaTq/zi85F6gC/C/KSwuHpfAGGYUiRBo0/RoTmjmoDJE
	 uSKbKbAMcjBBwd3tKNs0nSFuJv3oHjUba2TR8TUQUu+eGN0QqBPzTU9vvyCv6DTI8I
	 Ye3Owd2G2bXhGec5iCaoVl4D4GlqNTLTRK3vLTIZ/xrK7RdCe0ZYpxL5rezEMTCMcO
	 7caVabr4Xwl6BqFk4cvjEsz18gGJM7Q6o7pIpqloZEw3i6WLe5paGoeFoermB5ZB0D
	 ZXriIQycYfNuPPBYkoBngSuGYTDagG3xBExEsdJs317Y32Li7ge+Sga7IAcgaxojcQ
	 071kqhkx3t5yg==
From: Kees Cook <kees@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] nvmem: core: Add const to pattrs allocation type
Date: Thu, 17 Sep 2026 14:14:24 -0700
Message-Id: <20260917211423.i.786-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; i=kees@kernel.org; h=from:subject:message-id; bh=0MSp+1ONmTFQU9E67RSn/QPFlbo2oChayjzdaccxotw=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrIvTfKqqczfp4dZGTNX/myoXT3lSfkwqui4zont465 9PNc2cKOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACaygY+R4ftj38l/dL+lHEv+ 7OP00isswlohTFtAwISBzdyq6tPHGIZ/xuyX3i/wPfdJ+FtOqv+zmds7crz1N87fu+PLksqd0+e 78wAA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "const struct bin_attribute **", but the converted
allocation type would be "struct bin_attribute **", which is the same
type without the const qualifier. As there is no general way to safely
add const qualifiers, take the size from the assignment target instead.
No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/nvmem/core.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/nvmem/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 0556d140170a..19edc9ab0282 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -485,7 +485,7 @@ static int nvmem_populate_sysfs_cells(struct nvmem_device *nvmem)
 	/* Allocate an array of attributes with a sentinel */
 	ncells = list_count_nodes(&nvmem->cells);
 	pattrs = devm_kcalloc(&nvmem->dev, ncells + 1,
-			      sizeof(struct bin_attribute *), GFP_KERNEL);
+			      sizeof(*pattrs), GFP_KERNEL);
 	if (!pattrs)
 		return -ENOMEM;
 
-- 
2.34.1

