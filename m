Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7551CEAD5;
	Thu, 31 Oct 2024 22:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730412519; cv=none; b=kS9g7ftexygLY6Q/s0+aLed0FC+k9koRtpe1CVS6iYkhtPIwfdk+sXPDKmZdmoYFuA84tj2luMCd0003Sq3nIaOSw1foRkxezUc6/hlDP5Wzd6CYIyhG+ovW4cGjou8ty0WVNyr8zgPxa40XD1a3xC6/yGeyjgtbkk/wO88q0Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730412519; c=relaxed/simple;
	bh=UnoLOCrmq2XmlLlCmxVCVE/svYfwton2jjCIiqM0Ac4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JErY7/Ze5v87ai/BrcNObyMRsjwnptsEtN2f57HLW8kuiGnE8GVFObpsaYI5RUVGaGBsStIPt46QlzaWly+XKU5XGAlZSeC/RVftNFQ3wzlSEQxJ6/XFkyX99+nHCEGWf1yhpuifrWLreRQqziyKvJB+imFYKJ/kYQxHzNSKl/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJI/K4Hq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJI/K4Hq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720C0C4CEC3;
	Thu, 31 Oct 2024 22:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730412519;
	bh=UnoLOCrmq2XmlLlCmxVCVE/svYfwton2jjCIiqM0Ac4=;
	h=From:To:Cc:Subject:Date:From;
	b=VJI/K4HqiShv2zuSt/At+pv9DlSHkDOVlM7X+uxe4QdAsQZlspdm/oGizP5Hdf379
	 3zU4mCeu6te6qqrAdZ/+s2o2Aaghi0EwUYQy20J1VQxG4cNei/U34KOO5eAwQBf91Q
	 gPy84g6uYMl4XU25lp0oxJ+eHNLKzaGl2pYvi4ICdZtZWmxucr1cFx4PptqBSKQJ/g
	 os+LZG/UpjK7YcAm7H73dAWIA8IstdEXoU0jSt3H947PLOV/8SeKjA5+HCEjz/3amK
	 4e4Sq7OMZFqWGH53DMDQpNAM3AchHvLk87KtM9m2n6531NepPOk5dCA3djwA46qmWR
	 Hi4WwpiYX+0tA==
From: Kees Cook <kees@kernel.org>
To: Eric Biederman <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: exec: Add auxvec.h UAPI
Date: Thu, 31 Oct 2024 15:08:35 -0700
Message-Id: <20241031220833.work.539-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=662; i=kees@kernel.org; h=from:subject:message-id; bh=UnoLOCrmq2XmlLlCmxVCVE/svYfwton2jjCIiqM0Ac4=; b=owGbwMvMwCVmps19z/KJym7G02pJDOnK/x+ZLL+aVrOl1vGs0b77qyuYNt+yjYiau/F6rqh4Z px9NceFjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlcVmb4X/vK0jzl4dKAlpis a82zOuJCi93tt29Zv6O69VCRwGbBr4wMM955meWyfzKyZLn58/k2dn2+u0IpVYecin6nae5xfZP MCAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Changes to auxiliary vectors would be best reviewed by the exec/binfmt
maintainers.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: linux-mm@kvack.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..009501905386 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8501,6 +8501,7 @@ F:	fs/tests/binfmt_*_kunit.c
 F:	fs/tests/exec_kunit.c
 F:	include/linux/binfmts.h
 F:	include/linux/elf.h
+F:	include/uapi/linux/auxvec.h
 F:	include/uapi/linux/binfmts.h
 F:	include/uapi/linux/elf.h
 F:	tools/testing/selftests/exec/
-- 
2.34.1

