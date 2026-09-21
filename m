Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D54547060;
	Mon, 21 Sep 2026 00:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948829; cv=none; b=NUD9cq2zjpIrQoHlIrzdZRJeaykK4lqLJc3v7rDI2PRTr+5bsur/PCJrpAeBgKcJK5kxR3o/3rsRdTDyw07iZaFJFnXOxYkPHErtXCKwultLvTi9MVZty4uVbdF4qv6hJj93k7YDRLoIGDISkRV/2cA7lx4GgjjJD/cRAJImq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948829; c=relaxed/simple;
	bh=InItdX1ICOBQXhRYq3jSCGpRPeXn8TAdtmpzt6TUsBY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jNNu4aqYg1OvA1Ikd1DRKIOJZh2KXDemi7Z9uQn7K5/jOQYoU2ZRbJOHZB1UWFe29gIFwgNhZrHvV0my9aGZvouKc5OOTJ3wtYpjdruoSuGAttSc27LkSiqR5dv1k8bdGDrlzvHMIbUNA9Xd9OSevyU5JcB64sm1DiLUaUEu6Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FBdx/rsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBdx/rsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8FC1F000FF;
	Mon, 21 Sep 2026 00:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948827;
	bh=uJzBON1oNfkCyQm6yQ46wOVr3sGWKWTX/NUlGNT9iX4=;
	h=From:To:Cc:Subject:Date;
	b=FBdx/rswKc88hrsl3kQ/3/S+FzoFLSuDRCFyWtxeV7RGFSyGJF0WBxGwXkbjK7gvQ
	 MRvnG16fUqS1XQ3eFliKmPUR/hbrf/LUg5J/h0kz8WfqVpM9smeFgwENDeUJ+eoLdd
	 tWWrackZSs93s0Kf7Jv+UCoH02YZ+IkJxAPH54z3KcNgcjbRhfiRYqHI8O6enNuM0J
	 yOLEOjyisR13G81DaezoY/cUQZ2Qy3wMxlVQTUFM6YXzt1tsJqb0p8H+/NEZKPL5eu
	 r9I1fftEDp/UkHQczdJV1W7+Kr+4qp5eUCjJqVyAK5GK4GVYTSzxT82PDdjxcO5dWZ
	 8qGR+xR321LuQ==
From: Kees Cook <kees@kernel.org>
To: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	kunit-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Documentation: kunit: Fix KUNIT_DEFINE_ACTION_WRAPPER() argument order
Date: Sun, 20 Sep 2026 17:00:25 -0700
Message-Id: <20260921000021.i.218-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1424; i=kees@kernel.org; h=from:subject:message-id; bh=InItdX1ICOBQXhRYq3jSCGpRPeXn8TAdtmpzt6TUsBY=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkbimfWnKuS/Fa1RPtA/pvvcSk8q0MTgnMZ/vvsv12ke J/7Q+XkjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIkkbWJkmGtdUrl/57xpNaUH LkzULDmy5at1+Ocbr7ySl0QV7CorPs3IsPWCy7y3az9s9M6ZfbUh5H/PAp77svlnzUXWX5OTsnw pxQ8A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The macro is

  #define KUNIT_DEFINE_ACTION_WRAPPER(wrapper, orig, arg_type) ...

so it defines "wrapper" which calls orig(arg_type). The example names
them the other way round. Swap the two order.

Fixes: 56778b49c9a2c ("kunit: Add a macro to wrap a deferred action function")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <david@davidgow.net>
Cc: Rae Moar <raemoar63@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: <kunit-dev@googlegroups.com>
Cc: <linux-doc@vger.kernel.org>
---
 Documentation/dev-tools/kunit/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 1c78dfff94e8..8fec131f8ee7 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -1028,7 +1028,7 @@ with the ``KUNIT_DEFINE_ACTION_WRAPPER()`` macro, for example:
 
 .. code-block:: C
 
-	KUNIT_DEFINE_ACTION_WRAPPER(device_unregister, device_unregister_wrapper, struct device *);
+	KUNIT_DEFINE_ACTION_WRAPPER(device_unregister_wrapper, device_unregister, struct device *);
 	kunit_add_action(test, &device_unregister_wrapper, &dev);
 
 You should do this in preference to manually casting to the ``kunit_action_t`` type,
-- 
2.34.1

