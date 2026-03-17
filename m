Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5C93F99D4;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770990; cv=none; b=EkloYx8CYAjYx6rE51IrEXcIWjT1J3z6LDIYr0la5XdQaUrHlyHthCpcM7ZOJb3RtYbCplHhaPpIzIJX1UqwmH6/2HdK6PjXzef0KH29BBEYpnzG5lDvrPUo9lyXiIjSjbmLvaHuljerqcpLneCTTWoSC0V1eM2i+JcSNkAsOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770990; c=relaxed/simple;
	bh=TynJuQcxbqp8IlXZpmYv2V/i59/dnDGfqmHay7W37mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG2TLsnHFm0dEN3cm2JPfQTi1odFCbi3yDEtZnw373Ef4YrzNZIPqh2MOftyJ/uGWKBfDymLQpFz6EEkI77IBsiI3O3uhv1whP1FNBY7pQc2fwMRfWfb1dl/6FCwkknXIiS92NL7WVitpbmXbkipnEf8O2yysgYbNFEfbrZQ+xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcB1kI89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcB1kI89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 718C2C2BC86;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770990;
	bh=TynJuQcxbqp8IlXZpmYv2V/i59/dnDGfqmHay7W37mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcB1kI89Lk4hpwF+Yljz9qEld/+V6+ErS/F0xFpZs7RXOQOQ0dlQ7V7voj1DxzT+O
	 eFrVKzqV1/QhotZO0899gc1UdbKNhOsBad0pEKFIu9kpmAMNpFEK7NvBw7OhQ4rLlG
	 gPVTpSvzEc9dEsc6mSKX8zgRt8GLBvP1X+ZVzKwOMGHUMsD690wSlXMxfllWp/5+M0
	 Lr6YtOC0w/08ZXVAB/lsv/xIE7a+8MnAIfLPp9v/oZ0Nb9cXCo+Qz/XhQsUmbopXOn
	 yHnfQMGi7IVFxwmnrkrNv13ea5wS6hCEt6n6gYAaY0h5Aw7AluKGV9vFErECcV82xi
	 aim/doIaQ4aoQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrU-0000000H5ZD-2y2l;
	Tue, 17 Mar 2026 19:09:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 17/22] docs: xforms_lists: better evaluate struct_group macros
Date: Tue, 17 Mar 2026 19:09:37 +0100
Message-ID: <24bf2c036b08814d9b4aabc27542fd3b2ff54424.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
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
2.52.0

