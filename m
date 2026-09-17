Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6A94E9C38;
	Thu, 17 Sep 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679554; cv=none; b=IXFhpNrzaFg3YrYKQtcYmyrIrADIie2E8Iq254e0/LGqlPahM4IlF8FVANoiTyTJVb0m/lnvttgtpWJEpr3COhUiNbAncHe6d6mG1o6d5T03MbHo7Ys29wMJTpGFsfgvgW/VBDNfyOz4O4n68dfFqPMixV9SpfO4pM08WxzlEhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679554; c=relaxed/simple;
	bh=oFYT7Kwmbc6LPczUh20AEh+ZQyqK+d/Vg/GmAqDMQqA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=URkIMhgC2yMDTJOqhtZAcUNstkpcSYSxmW+qPPa1W2qp1IMY7+WXus0RvoDA9KiYyko4pQO9ztnwuVevVvHF5FOBExXaL6+YO0ny6t+Wz3NM0WAIH+NvV0/Tumbx6ZCO6+tS7Q75KiF6vvFk/2fpWAGBi6b/HuHJwJA0vg+O43Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXxfNkWQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXxfNkWQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8683E1F000FF;
	Thu, 17 Sep 2026 21:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679552;
	bh=d7NXiBXLRGZlN4I1ykV8UxNXs49iRKsGZ5kx6a4c/gA=;
	h=From:To:Cc:Subject:Date;
	b=JXxfNkWQ62ENoyl9TVhn/5n/zzqtvM8ZSeYS6oRW7rCyx9JRGsuZAz7wAccfUWvEI
	 hxPxEaNGIE++TJ7HeCVy62rAknOZheQ4Pc8kz7DGRJh8zuCPE60j7ZRxPxRV9J1X2Q
	 ziymuMtBJwudo6O7fE+VIHW3ZUy5rvXH7LlVsSkqaSI0DJlfA3puAY4u4Ynmeq3pGB
	 X5y2nXToM6UAKkOB2AFdzHT3Dm8wfpnUQ9phA6X6YTnNaUg/onu0tSY2f/OL1pNGE/
	 PDrXqamTo3nDZm2Mp0KTnM8Cgd06STxWviuT8KTGXOM5jB/j04cp12sFQ69IL4wUdT
	 HkB5Eh8mgi6EA==
From: Kees Cook <kees@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] modules/kmod: Allocate argv with kmalloc_array()
Date: Thu, 17 Sep 2026 14:12:30 -0700
Message-Id: <20260917211229.i.604-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=kees@kernel.org; h=from:subject:message-id; bh=odSNcET2EyCPeOBIMr/2o2l2GLVLVoj+OKHx+5WuGhQ=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrwvf5Tt7Ms9xVJ7F1nnHKdEnX+F2BJ8+y2apfYZuwb CPXVQftjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgImoljIyvKiq6KqbdW/5jjKe VqeXn9UX/uz9ZTXtiXax+Vem1kDVBwz/o3nKOwN69W/fD+Fn+7FsQfj9zQHK2hfNup3nrbc+v38 PBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for converting the kmalloc family of allocators to the
type-aware kmalloc_obj family, we need to make sure that the returned
type from the allocation matches the type of the variable being
assigned. (The kmalloc family returns "void *", which can be implicitly
cast to any pointer type.)

argv holds 5 pointers, but the size was taken from the array type
"char *[5]", which would make the allocation type a pointer to that
array rather than the "char **" being assigned. Allocate 5 entries of
the target's type instead. The resulting allocation size is the same.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
kernel/module/kmod.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Aaron Tomlin <atomlin@atomlin.com>
Cc: <linux-modules@vger.kernel.org>
---
 kernel/module/kmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/kmod.c b/kernel/module/kmod.c
index a25dccdf7aa7..c19b14c68de5 100644
--- a/kernel/module/kmod.c
+++ b/kernel/module/kmod.c
@@ -81,7 +81,7 @@ static int call_modprobe(char *orig_module_name, int wait)
 	char *module_name;
 	int ret;
 
-	char **argv = kmalloc(sizeof(char *[5]), GFP_KERNEL);
+	char **argv = kmalloc_array(5, sizeof(*argv), GFP_KERNEL);
 	if (!argv)
 		goto out;
 
-- 
2.34.1

