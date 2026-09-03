Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601AF3630BF;
	Thu,  3 Sep 2026 23:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477880; cv=none; b=OZWn1qv5xret3+v3QTPrT3qPxvd5Df66S+nS/0k4jOazF67psBkVXAFicOBiyUCvEwu1D0hT6SLjo4YBYUoZSCDCgnd/uUQORsI+9ur0jmpQ9cUOrTOt/q8OpWNsj8fypqv1CRzuV4RXibqGTtH0uUKOLU8iTRcTah2Jkm+avCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477880; c=relaxed/simple;
	bh=r1vurSscIyny3Yx0Jf+hbRvdDU8fpobXkuTGkEBoLkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnzUhUitRRRUcp8bfUpT+Hmud9/btGWedPTJ5p6/gb7cv/e+2XBc2DV2RYxsDbgzsTSOlXLQcmeUqDOzXI7sC1qE6AYzzz40Uf+TvgKFijy26y80eQm0V/08kK4BmiHVrSg1FMxlaEfcQLI5mY6zbFMt6E7gByeOki5w/8AE3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQqdPpF/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQqdPpF/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172C81F00A3E;
	Thu,  3 Sep 2026 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788477879;
	bh=1LW90y13IOdbJfNjSUxpwj36Qi9PJAz/jImCqGzw6do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PQqdPpF/lOhYgVvPkGqlXNzXFu1bi970wQZ/QPDMV8HwXsXHjR1H1bSt17Tu85lGE
	 hcLYqkJJ1z+UqpvZZpPbBBPyfBOSk8/MhtHqxoUSW1qVzCuTvXh+SqULNUOhZ6Q9ix
	 AMdeYlrhJxIi4w1q5a1QTBS5p/cXhF2iL7kovLs3TyblFspLgK9TZVLGLd4a+cAvzW
	 I+gp2KscsMUpPKH+RIoMgkt9rY4EmyHYyinwtHixZtGRkxTDNoW04qHdMEJAXvK6X1
	 91yVBXKKV3E4Y8Kx1wldVQCb4GraKp9sbd5JJGpCQ2Jz7E7yYkOsShvfdgPSDLc0M2
	 hBVtYKOcURbeg==
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
Subject: [PATCH 1/2] randstruct: fix container_of() false positives after __mptr removal
Date: Thu,  3 Sep 2026 16:24:35 -0700
Message-Id: <20260903232438.60394-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903232428.i.323-kees@kernel.org>
References: <20260903232428.i.323-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5737; i=kees@kernel.org; h=from:subject; bh=r1vurSscIyny3Yx0Jf+hbRvdDU8fpobXkuTGkEBoLkA=; b=owGbwMvMwCVmps19z/KJym7G02pJDFmzGDcnXm7xnJZlf8y2TG5+oBOj4fnSpz4ycbMsXiz7/ 4yPJUSoo5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKTexj+u1lw3Dvs5p9yI839 yhfmDd8Mb6293rnDOfVI+7PqJSoZcxkZ+pPE7tefebqvKmWB8a+zzIfnHA1sOLHup45B6nqNZTr vOQE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Commit f9e7a7564834 ("container_of: remove local __mptr variable") dropped
the "void *__mptr" temporary from container_of(). The randstruct GCC
plugin's find_bad_casts pass recognized the casts container_of() generates
by that variable's name:

	const_tree ssa_name_var = SSA_NAME_VAR(rhs1);
	/* skip bogus type casts introduced by container_of */
	if (ssa_name_var != NULL_TREE && DECL_NAME(ssa_name_var) &&
	    !strcmp(DECL_NAME_POINTER(ssa_name_var), "__mptr"))
		continue;

With the variable gone the suppression never fires, so every
container_of() whose container type is randomized now emits a note:

  include/linux/container_of.h:23:9: note: randstruct: casting between
    randomized structure pointer types (ssa): 'struct ocfs2_triggers' and
    'struct jbd2_buffer_trigger_type'
  fs/ocfs2/journal.c:524:16: note: in expansion of macro 'container_of'

The pass runs on GIMPLE, after folding, and for a member at offset 0 the
whole expression collapses to a bare copy that is indistinguishable from
an unsafe cast:

  to_ocfs2_trigger (struct jbd2_buffer_trigger_type * triggers)
  {
    _2 = triggers_1(D);   /* void * cast and subtraction gone */
    return _2;
  }

Match the type relationship instead. A cast from A * to B * is a
container_of() if B reaches a field of type A at offset 0 through a chain
of by-value members. The chain matters: container_of()'s member argument
may be a dotted path, as in ceph_inode(), which is container_of(inode,
struct ceph_inode_info, netfs.inode) and needs two levels. The search
is depth-bounded to 4 just in case, since real paths are generally one
or two members deep.

Requiring the cast happens at offset 0 is done because any other member
offset the subtraction survives folding and the cast's rhs is still
void *, which the pass already skips a few lines above.

A cast between two randomized types with no containment relationship is
still reported. Verified with:

	struct cred *f(struct file *f) { return (struct cred *)f; }

which is still flagged with the patch applied.

Clang's implementation is unaffected. It checks the cast as written, and
both the old and new macros cast from void *, which is always permitted;
a genuinely bad cast is rejected there as a hard error rather than a note.

Build tested ARCH=x86_64 defconfig with CONFIG_RANDSTRUCT_FULL=y and GCC
14.2.0: randstruct notes 52 before, 0 after.

Fixes: f9e7a7564834 ("container_of: remove local __mptr variable")
Assisted-by: Claude:claude-opus-5[1m]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 scripts/gcc-plugins/randomize_layout_plugin.c | 61 ++++++++++++++++++-
 1 file changed, 58 insertions(+), 3 deletions(-)

diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index ff65a4f87f24..e2bd9ba08089 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -698,6 +698,63 @@ static void handle_local_var_initializers(void)
 	}
 }
 
+/*
+ * Does @container reach a field of type @member_type by a chain of
+ * by-value members? That is the relationship container_of() expresses --
+ * its @member argument may be a dotted path, e.g.
+ * container_of(inode, struct ceph_inode_info, netfs.inode) -- so a cast
+ * from @member_type * to @container * is legitimate rather than a
+ * layout-confusing one.
+ *
+ * container_of() used to leave a "void *__mptr" temporary behind, and this
+ * pass recognised such casts by that name. Commit f9e7a7564834
+ * ("container_of: remove local __mptr variable") removed it to stop nested
+ * container_of() shadowing itself, and the cast now folds to a bare SSA
+ * copy when the member sits at offset 0, leaving nothing syntactic to key
+ * on. Match the type relationship instead.
+ *
+ * The depth bound keeps this cheap; container_of() paths are one or two
+ * members deep in practice.
+ */
+#define CONTAINER_OF_MAX_DEPTH 4
+
+static bool is_container_of_cast(const_tree container, const_tree member_type,
+				 int depth)
+{
+	const_tree field;
+
+	if (container == NULL_TREE || depth > CONTAINER_OF_MAX_DEPTH)
+		return false;
+
+	if (TREE_CODE(container) != RECORD_TYPE &&
+	    TREE_CODE(container) != UNION_TYPE)
+		return false;
+
+	for (field = TYPE_FIELDS(container); field; field = DECL_CHAIN(field)) {
+		const_tree field_type;
+
+		if (TREE_CODE(field) != FIELD_DECL)
+			continue;
+
+		/*
+		 * Only a member at offset 0 can reach here: for any other
+		 * offset container_of()'s subtraction survives folding, the
+		 * cast's rhs stays void *, and the caller skipped it above.
+		 */
+		if (!integer_zerop(byte_position(field)))
+			continue;
+
+		field_type = TYPE_MAIN_VARIANT(TREE_TYPE(field));
+		if (field_type == member_type)
+			return true;
+
+		if (is_container_of_cast(field_type, member_type, depth + 1))
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * iterate over all statements to find "bad" casts:
  * those where the address of the start of a structure is cast
@@ -799,10 +856,8 @@ static unsigned int find_bad_casts_execute(void)
 #endif
 				MISMATCH(gimple_location(stmt), "op0", ptr_lhs_type, op0_type);
 			} else {
-				const_tree ssa_name_var = SSA_NAME_VAR(rhs1);
 				/* skip bogus type casts introduced by container_of */
-				if (ssa_name_var != NULL_TREE && DECL_NAME(ssa_name_var) && 
-				    !strcmp((const char *)DECL_NAME_POINTER(ssa_name_var), "__mptr"))
+				if (is_container_of_cast(ptr_lhs_type, ptr_rhs_type, 0))
 					continue;
 #ifndef __DEBUG_PLUGIN
 				if (lookup_attribute("randomize_performed", TYPE_ATTRIBUTES(ptr_rhs_type)))
-- 
2.34.1

