Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6023B364EAF;
	Thu,  3 Sep 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477880; cv=none; b=pQH7xdlbQKjj49szeEu523THf0PYNrZOWURtuhBLVuPOYosjmgFcInaFXrRf1zg6+mCLnD3pZvTTrAZU6/6bXZ/8ucXvYqk9QJbMe6xUgynQvH8VvuuhOxoixJxodsZngkfQVVezRcwgE9wZ1Eg/n62oixTzaoCRpkCkcvZx0jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477880; c=relaxed/simple;
	bh=7Fw6XpoEYxP+6q7RreDjmWqwEL2mZhyx41ZjWBSsbvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9IlP+jpXHx2hNK4n83gNkhgMtt9jrFkG7Nzn/iQXf9HBYVdvcrgsuoduAqexYZaYHt/cSMI7OdXHQiSBgV4FeK5xH91WKxk2DafEWVB9mw8OHSjRWVOabk9Eya2fInNQUKAp0R17aBfFSWBoAGVNI9DTCk09JGQE9jnSzzDQrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn9l52MY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn9l52MY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1519D1F00A3D;
	Thu,  3 Sep 2026 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477879;
	bh=o5mhh7f1v3xro5ujmd0JNWm/om76tra95+gEwAI9ekY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fn9l52MY8x7nJzZOrX9R0v3oIP97l5bMMV+uVTi8DPrgx1i5lbAkcnzyEScrGh2+u
	 SNhjWiQQ7e3nVLb8/luOyZAPyQ1bTZmJsPYtByVvuPawl/K9GNAKq3P3czri7lJyBk
	 gtYQnOCPZ5iWGatLgcD4dTy1q88tSyh65BhxmF7iHA0GJSKgzWG9NFy7JBVni2OT2x
	 ZUHnhjW/eFWTYTlK0BPsrvs/eq29F5BYl6chNN7GPAaNLiDKILp1lbkmvmmiJpa58t
	 5hXRoRGadaioOot6jCDcw6AXQEmQSlCPMPURcC+TKXr6ySPaahIIk31MFbfKWmRmPL
	 PVO15LwAUIV9A==
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Kees Cook <kees@kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/2] randstruct: report bad casts as warnings rather than notes
Date: Thu,  3 Sep 2026 16:24:36 -0700
Message-Id: <20260903232438.60394-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903232428.i.323-kees@kernel.org>
References: <20260903232428.i.323-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=kees@kernel.org; h=from:subject; bh=7Fw6XpoEYxP+6q7RreDjmWqwEL2mZhyx41ZjWBSsbvM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmzGLekckrcTvsT4JNXdSHoeDJzYOrU95MmRh+T+dJYv 8NsIo9yRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERU7zP890myrL0iu34vt4Hw x5j4c10MD7i+8NfMk+w4tXC3qiDDS4Z/BrkPs+KTv601bLiZP+1AnSDv7aJ2J3uVTZtPnpolebi KDQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

find_bad_casts() reports a cast between two randomized structure pointer
types with inform(), which renders as a "note:". It has done so since
the plugin was originally added, while using error() freely for attribute
misuse, UAPI structs, and version mismatches.

Clang's implementation of the same check has always been stricter:
it rejects such a cast as a full error. There is no reason for the GCC
side to be effectively silent about the same problem.

Build tested ARCH=x86_64 with CONFIG_RANDSTRUCT_FULL=y and GCC 14.2.0:
allmodconfig clean, and defconfig clean under three different random
seeds. A deliberate bad cast is still reported, now as a warning, at the
correct line and column.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index e2bd9ba08089..1e66f45fe29b 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -22,7 +22,7 @@
 #define ORIG_TYPE_NAME(node) \
 	(TYPE_NAME(TYPE_MAIN_VARIANT(node)) != NULL_TREE ? ((const unsigned char *)IDENTIFIER_POINTER(TYPE_NAME(TYPE_MAIN_VARIANT(node)))) : (const unsigned char *)"anonymous")
 
-#define INFORM(loc, msg, ...)	inform(loc, "randstruct: " msg, ##__VA_ARGS__)
+#define INFORM(loc, msg, ...)	warning_at(loc, 0, "randstruct: " msg, ##__VA_ARGS__)
 #define MISMATCH(loc, how, ...)	INFORM(loc, "casting between randomized structure pointer types (" how "): %qT and %qT\n", __VA_ARGS__)
 
 __visible int plugin_is_GPL_compatible;
-- 
2.34.1

