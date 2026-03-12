Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF41B3AD508;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=pX/PabCRf3yqsEOzk6Ug0ZILuODSk5yIcAVHilu2v7T4b7kkNB5GqcAWQG51t0306zpE6tM/PMSVi1pxayi+L5r4QcLXiY0OHW9lZYFuBLBG6U6dyeSJ+gTqviNR6kGlJx2Ygq8D8FEdV+6VCRIYMg3ekCFDzUmSKOTKFC5IEAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=xYvjmm/ULlst4Zx2kl8I7sdtVc4O1AC5AGaMbPXe+bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZh1c2FuXSVi0x4gJPX9piliqsdl2PJzA2vAS+KSh5PbrVgYl//FQoAikqxFPhpxYYURdyShlWPmvpvp+OUgzjiVIHBS6B4T+Stf4pguMjhXYa/5uh8x3zj052SykrIaVsTr7ul+R2DbM4s8CegRc7axeBgD58Tm1wmz5M3ll5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZCwd75c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZCwd75c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7323BC4AF0E;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=xYvjmm/ULlst4Zx2kl8I7sdtVc4O1AC5AGaMbPXe+bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZCwd75cklJHweNbgCPIRWxS16Tc7Zylq4VOQ3+NyqbaJO6zW52rgMkDfrtLQl11o
	 fcnPQ9gdWUQioELafgA6Nos9iTNTFBAZzS60OeGVQ7cs/ifahxnZQZJ/WVc0HWjxDQ
	 aY2Iva18OMHBo+mHCaUi+TtYZCjJ/Q4Rsnu/ZQwLQ7V9p9kwaWoyR9ThrfXNZqkEot
	 nwGVReJ0cZ73d7euGnoZG0jnL8sBVIV+B7OemfgQbE8z4NzlJsvzChZcAnXIR8MbVX
	 S7EKPLSeqxmpUkwodLeRcg12b2uAPXZW+XZnwiN/jlr6SqyWJL7swSUVTT7SYMYdAD
	 /eEPLgJJD3m3g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077hV-3GQn;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 18/20] docs: xforms_lists: better evaluate struct_group macros
Date: Thu, 12 Mar 2026 08:12:26 +0100
Message-ID: <a7b64b6ac6454bf16d5c66b2e22834c6ee875856.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The previous approach were to unwind nested structs/unions.

Now that we have a logic that can handle it well, use it to
ensure that struct_group macros will properly reflect the
actual struct.

Note that the replacemend logic still simplifies the code
a little bit, as the basic build block for struct group is:

	union { \
		struct { MEMBERS } ATTRS; \
		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
	} ATTRS

There:

- ATTRS is meant to add extra macro attributes like __packed
  which we already discard, as they aren't relevant to
  document struct members;

- TAG is used only when built with __cplusplus.

So, instead, convert them into just:

    struct { MEMBERS };

Please notice that here, we're using the greedy version of the
backrefs, as MEMBERS is actually MEMBERS... on all such macros.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/xforms_lists.py | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 98632c50a146..2056572852fd 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -61,10 +61,16 @@ class CTransforms:
         (CMatch(r"__acquires_shared"), ""),
         (CMatch(r"__releases_shared"), ""),
 
-        (CMatch('struct_group'), r'\2'),
-        (CMatch('struct_group_attr'), r'\3'),
-        (CMatch('struct_group_tagged'), r'struct \1 \2; \3'),
-        (CMatch('__struct_group'), r'\4'),
+        #
+        # Macro __struct_group() creates an union with an anonymous
+        # and a non-anonymous struct, depending on the parameters. We only
+        # need one of those at kernel-doc, as we won't be documenting the same
+        # members twice.
+        #
+        (CMatch('struct_group'), r'struct { \2+ };'),
+        (CMatch('struct_group_attr'), r'struct { \3+ };'),
+        (CMatch('struct_group_tagged'), r'struct { \3+ };'),
+        (CMatch('__struct_group'), r'struct { \4+ };'),
 
     ]
 
-- 
2.53.0

