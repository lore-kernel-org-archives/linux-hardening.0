Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FA6FC3;
	Sat, 26 Apr 2025 06:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745648490; cv=none; b=isQQEIMK+LuanCQJxJ1yHtmjWco3jdsf0CoaSbYMb17Ru0zjMNH8tKvjrZtprbX6ZiPMOCNORIZbB7liJzcbu1O5PzAAR5SoLkD9uzvM2QG4rVn9S0EhaVo5/jG1t3QizQ8RxKx7S6J6F6Gam2dMRrA7Jks28QTqy6r0O/F8WTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745648490; c=relaxed/simple;
	bh=U1JTFWLpoYixsK8KAsNfSNSPN6Lvv7EYl4tu2dmAvyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H13T1GxSQprj9AnjBYh9FazAeGAxB+TsjBzeHGAeMYXdzBC52Y85HLL863lvW1RKypN8K7hUKVlb0aSrGS1+STSYAOWJNDsZALp8k7onSAkGDw0vjK7Q/0TWlpSJomkUjy2/wH1Kbt3cOywccBJ5hxgGJw1r6hEbOeSlj/nV2k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkDjT54f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkDjT54f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA56C4CEE9;
	Sat, 26 Apr 2025 06:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745648490;
	bh=U1JTFWLpoYixsK8KAsNfSNSPN6Lvv7EYl4tu2dmAvyc=;
	h=From:To:Cc:Subject:Date:From;
	b=CkDjT54f6zxUclmB6EDiGxL11PmzdN9vFXgEl3HsSsJYfEQ491N8Mdiuymdas2TCp
	 +lvklIF7LUt/X40xMxifZM/F6ahrKelbSh0Ga5G+HcVvL/gGaehr+1H2jxFvw6t0eA
	 qGVW62hsDxjla6/sphTLUFxoZIBplTEzf89D2dg9mNyGcffb2MLlUbX6hWJC5N3v0q
	 3rVlaOKIfHj3DhQYTczuXd2gq0zMsaWxaZqRNyJKrYuhPW0FN0X1ma2Yh9l4S6K7PV
	 mk3KjZvyAM9lbWkYoapF85Yu4ffYf9F1wdneR+AV3kk/u5vvm8BrfOTIxmXFAjJVJJ
	 76UX3JDEuY/PQ==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Wei Chen <harperchen1110@gmail.com>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] usb: gadget: g_ffs: Adjust f_ffs[0] allocation type
Date: Fri, 25 Apr 2025 23:21:26 -0700
Message-Id: <20250426062125.work.209-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=kees@kernel.org; h=from:subject:message-id; bh=U1JTFWLpoYixsK8KAsNfSNSPN6Lvv7EYl4tu2dmAvyc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk81akyiw50CT+68SBtrmtOicCJ5JxjgUtY1k4MEn8l+ fIJf4ZRRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERsXRkZptZENzxtkc5VmnBO 9Ij7R6V/89I9plf95lQW6krYZKxxhOF/kLj9lSWKEx/LrH98SlRf0rU5YHOB9IbMz8qTyx0/V6d yAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making the kmalloc family of allocators type aware,
we need to make sure that the returned type from the allocation matches
the type of the variable being assigned. (Before, the allocator would
always return "void *", which can be implicitly cast to any pointer type.)

The assigned type is "struct usb_function **" but the returned type
will be "struct usb_function ***". These are the same size allocation
(pointer size), but different types. Adjust the allocation type to match
the assignment.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Chen <harperchen1110@gmail.com>
Cc: Linyu Yuan <quic_linyyuan@quicinc.com>
Cc: <linux-usb@vger.kernel.org>
---
 drivers/usb/gadget/legacy/g_ffs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/g_ffs.c b/drivers/usb/gadget/legacy/g_ffs.c
index a9544fea8723..578556422ea3 100644
--- a/drivers/usb/gadget/legacy/g_ffs.c
+++ b/drivers/usb/gadget/legacy/g_ffs.c
@@ -188,7 +188,7 @@ static int __init gfs_init(void)
 	/*
 	 * Allocate in one chunk for easier maintenance
 	 */
-	f_ffs[0] = kcalloc(func_num * N_CONF, sizeof(*f_ffs), GFP_KERNEL);
+	f_ffs[0] = kcalloc(func_num * N_CONF, sizeof(*f_ffs[0]), GFP_KERNEL);
 	if (!f_ffs[0]) {
 		ret = -ENOMEM;
 		goto no_func;
-- 
2.34.1

