Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC64D6C2E;
	Thu, 17 Sep 2026 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679417; cv=none; b=fptrHXtIRcEVzm2TpEtJO/6+gDYGKfXs90KdLNaUaBG94Q9qiQETzIrw+6UgPwmbnJ4r+lCDxOvJEqdDABUKv6aXxgmghjL7cTqwVfsgwOpZApL8hFhBx+/5H427m1q8CeYWbRN4LyDetLhgYrv6fIf2BPrxXtcbuoDqoSBh0/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679417; c=relaxed/simple;
	bh=YyplxO1FYDBoCwkRYxrG9GoRFXGjMFSJ719nyMvuXvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZYkByJqRG8Y238Imw/B20HP1PtoZOm9BGKZx3VcXY2FeSwIQcQqi/A53rhBMHh5eBdQUaOhtI/3d1PP6Lw5eHEYI35NsfvsK0iUiqBbOQx0Hktua3uEzN5u2ocT+dli8Ov3LQp7oZNFP8VDHuiV0Y+LbPPey1hPTMtPHHhKT66Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnjdYy9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnjdYy9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB481F00898;
	Thu, 17 Sep 2026 21:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679415;
	bh=nBIBAHF5QiEYD6khKyc7wkw4VjrKtirq8vqbGK1IVw0=;
	h=From:To:Cc:Subject:Date;
	b=XnjdYy9jMY/Yn3tCO9xNLsKxzM3XzuWOndhRhVbMrYEUBQb9DjCmDbxvwzkkVhO6o
	 iqIh3s9qFeBPOoOiReskvaxc3aRx8wDb/0UtLyB79iEOgMuEI9rxLsCAV8vnV+rMM7
	 D6NajpWnb9Gl0Fiek4glWqf7D/w6AJX0v91RMZiAYosgWTll548NpQe2EP18StEKsn
	 uK0zg4uv2DB9a2xjLdxCjORmAcmDSfZEGSq6Aten9Ka20PGXobQzOlWLZAPRHpY0T6
	 OeEFTrtoaIc0e+UV7BTAxjxim2v6O9BdaK9soQvSkiAQae1gB8xHIToLSEuhfmxBxA
	 QLocO5SZchS5Q==
From: Kees Cook <kees@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: tlmm-test: Add const to reg_names allocation type
Date: Thu, 17 Sep 2026 14:10:13 -0700
Message-Id: <20260917211009.i.312-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1581; i=kees@kernel.org; h=from:subject:message-id; bh=eflgxqLQ3jvvOFsS5xysZVN91V4zzRm1RYFz/ZEtyXk=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwk233dk3Q7HsVfX0Oge1rPMRxnuutU+3OXV6pkRwX YSLUNP/jlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlYr2Fk2OvyqsXX6+SNPXWK 9w/NaO/3s2qNqdj6x8O/Z803qai9Nxj+18k7/DJ5Evev47T7eeapkp87RB2LHe49eP15jefEYx+ C2AE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

The assigned type is "const char **", but the converted allocation type
would be "char **", which is the same type without the const qualifier.
As there is no general way to safely add const qualifiers, take the size
from the assignment target instead. No change in allocation size
results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/pinctrl/qcom/tlmm-test.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>
Cc: <linux-arm-msm@vger.kernel.org>
Cc: <linux-gpio@vger.kernel.org>
---
 drivers/pinctrl/qcom/tlmm-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/tlmm-test.c b/drivers/pinctrl/qcom/tlmm-test.c
index 13c417731be7..8bff92dc0d0b 100644
--- a/drivers/pinctrl/qcom/tlmm-test.c
+++ b/drivers/pinctrl/qcom/tlmm-test.c
@@ -587,7 +587,7 @@ static int tlmm_reg_base(struct device_node *tlmm, struct resource *res)
 		return count;
 	}
 
-	reg_names = kcalloc(count, sizeof(char *), GFP_KERNEL);
+	reg_names = kcalloc(count, sizeof(*reg_names), GFP_KERNEL);
 	if (!reg_names)
 		return -ENOMEM;
 
-- 
2.34.1

