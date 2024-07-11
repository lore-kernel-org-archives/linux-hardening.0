Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD05450FA;
	Thu, 11 Jul 2024 17:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717991; cv=none; b=I7HpscrldIdx2tcTH5JvqO0Deq5p3fcIDGmy0ci+dYkQO9/6AIwO3z0SlBuO44L96E85H+Y6ZJS3sB/MBm7mvqC5T9UF5kGMuJMZdIhk4RBjPqNqs9uvuhZSiiiYw4gC2Rutvqx1ulK1fZHw4F6cbGntHQoHHXLZ11l47zynZBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717991; c=relaxed/simple;
	bh=xaKsQpF71MSFmC0xsITNp3M5gYzUZlBQesDbEER8aRE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z2QwcZzUw0c+OANfUiHVc28XFOKZWyTjfVfQwjNho04NoInx2LVYTDiCnzqeKecGe895DyqPUj04FgG2kiDSMyjH8M+waCf3e8++kT50xj9teN/Ru870YWGJkh/mtRTYHacDK90IxJn1IMKsrVMzUi19B8QcXwcC1lfRzjt2XMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUngXAXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUngXAXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A419CC116B1;
	Thu, 11 Jul 2024 17:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717990;
	bh=xaKsQpF71MSFmC0xsITNp3M5gYzUZlBQesDbEER8aRE=;
	h=From:To:Cc:Subject:Date:From;
	b=nUngXAXlBPFuZAJ7YrQh1lA8I7U2wZ3rMquELhfTAjK5H6al2vkjY35knKCZizZp8
	 FrtoBKgBSM7mpfRTA/fT2musgNKf9ncvxZkFNz2vwUcLuAyN8dsQTEq0OQiuWRkpXG
	 4HpQK/2vyT03C8XqX2Kknw89oNeYf1cxNuvy6ZgoGwQnFSuM8HY421g+1+8hnnjgoW
	 ToI91YFhcpY0ydPlqhK/SW/8+iuT+P8BUcT5RPKm5/qb70elLGDnX2NVT+lhtMpum7
	 seBacQqZEZ9oKLaI6OzjwRtm51Q3V6jAqAmU2aCtsTdaS/5phcI2yZbCzOPqJbeyjY
	 qNeQbX5Jw9nTA==
From: Kees Cook <kees@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Peng Liu <liupeng256@huawei.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Ismael Luceno <ismael@iodev.co.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] tsacct: Replace strncpy() with strscpy()
Date: Thu, 11 Jul 2024 10:13:09 -0700
Message-Id: <20240711171308.work.995-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=kees@kernel.org; h=from:subject:message-id; bh=xaKsQpF71MSFmC0xsITNp3M5gYzUZlBQesDbEER8aRE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmkBKlYLWBH+hNVujXhbheeiLsYWDV5guB5thjH umH2hIqAcSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpASpQAKCRCJcvTf3G3A Jok0EACNE8GTbsRAEKnflQ2G8v+TvQZ62CugkWiPe6oYsvwxU/nlLWyxp8x6JchhoSeag6R5Bfl l8rte8qbEAZejHnWR2Jk6hCvBqRzjRV1WyPAEr5h16yIhHrgzUiYt/3dR+FZnCI+LNFECDOGrhf aOUhG//mvSvf/82+qNGQrpG/viMWn4r7aDgyqM12tHaZjlwdBX080NrC3RoaI/IQLiMvVHFlPFg aNJJ/Zv6T6J6CzWnUnkIAbUL1+MufQcMbYb4+HZCydJkHUvg/0UlFMTUIJwY6rtzreO59taW2er yjZ+H7dVqcd4ivgv5/grkNjGeCTz02EPA+LMrsiSbNwsif3ZG49AFyOr0tXClJ5guv2iBXhpT/O Vw+Myv6USPnK6m+hit3DOEjYp++wyH/gr4oZV1+JnNgFRv0py8n9jHDqQXp6FfosyRu6T5bgyA0 Xc4GLd5pHkyHuLHSgDOvd1Q2kkj89bFuuPOy+LNZbhn1MrxOKNYKj/CNc+Vdlwx7QycVbPUQguB 0qsld82RCzqzZlPVrp7SfNlfvQkd2N8ymJz1DquhN/ppz0O/0h339VpeECvmYpJ0a46dxnqK6Ja uIENPbTD58USqSWxVwAk8ELPKkqsswe4E89199K5ADzgxlIvGgQftTSSvcZpHTz+P8g3F9gAx8j UJKnZENKvww8zq
 Q==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Replace the deprecated[1] use of strncpy() in bacct_add_tsk(). Since this
is UAPI, include trailing padding in the copy.

Link: https://github.com/KSPP/linux/issues/90 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Peng Liu <liupeng256@huawei.com>
Cc: "Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>
Cc: Ismael Luceno <ismael@iodev.co.uk>
---
 kernel/tsacct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/tsacct.c b/kernel/tsacct.c
index 4252f0645b9e..16b283f9d831 100644
--- a/kernel/tsacct.c
+++ b/kernel/tsacct.c
@@ -76,7 +76,7 @@ void bacct_add_tsk(struct user_namespace *user_ns,
 	stats->ac_minflt = tsk->min_flt;
 	stats->ac_majflt = tsk->maj_flt;
 
-	strncpy(stats->ac_comm, tsk->comm, sizeof(stats->ac_comm));
+	strscpy_pad(stats->ac_comm, tsk->comm);
 }
 
 
-- 
2.34.1

