Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62641FF61E;
	Fri, 30 May 2025 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748643517; cv=none; b=OxeVYReq5IUAcHNRcywze/tyv+QFtudzjgAFobTGFSWevkgTIqkmq6ajUleWpqG0IVqdLRzPHtijrow8l9Frm7CruOsojQykVtkEEL4QSYSKN/XqWrR4oQQ/mOZnFQnfBMJObs7I9Yzucra6gv0yqZZWzDUCnnV5xpC39Ma7n/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748643517; c=relaxed/simple;
	bh=CSX3lztplHs75s4Uj3716D4/7T0kEsJj/nPzuTRkSZE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AX4T4dJDvspFku/qcnjD6lW7KUabu/9Z2GCBeDvO0GjQKY7+C206eSHRJ/tCo6NEAMk3qrgvOL3aiJuVNBbn27bJP/7dSpBxyUwyZlMF+eiHtVZhGYpBJpvyYgXTPXNfjPNEPFCRILlGq7VZhi4Jf59a3NvqDwgYaea4lCI75WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6TAcMFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6TAcMFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB6DC4CEE9;
	Fri, 30 May 2025 22:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748643517;
	bh=CSX3lztplHs75s4Uj3716D4/7T0kEsJj/nPzuTRkSZE=;
	h=From:To:Cc:Subject:Date:From;
	b=t6TAcMFqAlJHfEFKWykdz4/Gs7TXTRTSVfraDqZi6GY3RdlsWnR+zEyoy0MFuu+07
	 7Pjqdf4pP+0J79h98LWlv/lfrDam6mQNS8LPSpJmsg51oVahz2APhfANWlijVtC+XL
	 w5kVC1ciK9TPsAu8qpHjyTTmXuQdrIVefC5qecaRIJRk25XqbLPYx51AYLz29FdGb7
	 HKEgLvr5c/mfrzQsJrvemuvlNNIru+Fy5C/oIQmECydv+gyQeBUhH/Fe9S1reHRnTP
	 Ad0PLJHIgJ6nSpT1x2rVl8Kh2zIA5DiDNbCj/E4KGUU28DY09preFHjrjwWF6jMO8b
	 BmyF+x3n6dCGA==
From: Kees Cook <kees@kernel.org>
To: Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ingo Saitz <ingo@hannover.ccc.de>
Cc: Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] randstruct: gcc-plugin: Fix attribute addition
Date: Fri, 30 May 2025 15:18:28 -0700
Message-Id: <20250530221824.work.623-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5526; i=kees@kernel.org; h=from:subject:message-id; bh=CSX3lztplHs75s4Uj3716D4/7T0kEsJj/nPzuTRkSZE=; b=owGbwMvMwCVmps19z/KJym7G02pJDBlWepv3VwRfOHibmT3I6Nzmbb2O5kXzPuVnTGCPLo1Uu fO5Y79MRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERMfzH8U8oX1brxq/Oa4tPv M/ZmKj5nYNCoXOB9g2u23MvnfddvBDP8syz0YD7ck/3Zv4efx4/lM2fDhK/yGa8aj50Urdp8OmI zAwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Based on changes in the 2021 public version of the randstruct
out-of-tree GCC plugin[1], more carefully update the attributes on
resulting decls, to avoid tripping checks in GCC 15's
comptypes_check_enum_int() when it has been configured with
"--enable-checking=misc":

arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
  132 | const struct kexec_file_ops kexec_image_ops = {
      |              ^~~~~~~~~~~~~~
 internal_error(char const*, ...), at gcc/gcc/diagnostic-global-context.cc:517
 fancy_abort(char const*, int, char const*), at gcc/gcc/diagnostic.cc:1803
 comptypes_check_enum_int(tree_node*, tree_node*, bool*), at gcc/gcc/c/c-typeck.cc:1519
 ...

Link: https://archive.org/download/grsecurity/grsecurity-3.1-5.10.41-202105280954.patch.gz [1]
Reported-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Closes: https://github.com/KSPP/linux/issues/367
Closes: https://lore.kernel.org/lkml/20250530000646.104457-1-thiago.bauermann@linaro.org/
Reported-by: Ingo Saitz <ingo@hannover.ccc.de>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1104745
Fixes: 313dd1b62921 ("gcc-plugins: Add the randstruct plugin")
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc: Ingo Saitz <ingo@hannover.ccc.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: <linux-hardening@vger.kernel.org>
---
 scripts/gcc-plugins/gcc-common.h              | 32 +++++++++++++++++++
 scripts/gcc-plugins/randomize_layout_plugin.c | 22 ++++++-------
 2 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/scripts/gcc-plugins/gcc-common.h b/scripts/gcc-plugins/gcc-common.h
index 3222c1070444..ef12c8f929ed 100644
--- a/scripts/gcc-plugins/gcc-common.h
+++ b/scripts/gcc-plugins/gcc-common.h
@@ -123,6 +123,38 @@ static inline tree build_const_char_string(int len, const char *str)
 	return cstr;
 }
 
+static inline void __add_type_attr(tree type, const char *attr, tree args)
+{
+	tree oldattr;
+
+	if (type == NULL_TREE)
+		return;
+	oldattr = lookup_attribute(attr, TYPE_ATTRIBUTES(type));
+	if (oldattr != NULL_TREE) {
+		gcc_assert(TREE_VALUE(oldattr) == args || TREE_VALUE(TREE_VALUE(oldattr)) == TREE_VALUE(args));
+		return;
+	}
+
+	TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
+	TYPE_ATTRIBUTES(type) = tree_cons(get_identifier(attr), args, TYPE_ATTRIBUTES(type));
+}
+
+static inline void add_type_attr(tree type, const char *attr, tree args)
+{
+	tree main_variant = TYPE_MAIN_VARIANT(type);
+
+	__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	__add_type_attr(TYPE_CANONICAL(main_variant), attr, args);
+	__add_type_attr(main_variant, attr, args);
+
+	for (type = TYPE_NEXT_VARIANT(main_variant); type; type = TYPE_NEXT_VARIANT(type)) {
+		if (!lookup_attribute(attr, TYPE_ATTRIBUTES(type)))
+			TYPE_ATTRIBUTES(type) = TYPE_ATTRIBUTES(main_variant);
+
+		__add_type_attr(TYPE_CANONICAL(type), attr, args);
+	}
+}
+
 #define PASS_INFO(NAME, REF, ID, POS)		\
 struct register_pass_info NAME##_pass_info = {	\
 	.pass = make_##NAME##_pass(),		\
diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-plugins/randomize_layout_plugin.c
index 971a1908a8cc..ff65a4f87f24 100644
--- a/scripts/gcc-plugins/randomize_layout_plugin.c
+++ b/scripts/gcc-plugins/randomize_layout_plugin.c
@@ -73,6 +73,9 @@ static tree handle_randomize_layout_attr(tree *node, tree name, tree args, int f
 
 	if (TYPE_P(*node)) {
 		type = *node;
+	} else if (TREE_CODE(*node) == FIELD_DECL) {
+		*no_add_attrs = false;
+		return NULL_TREE;
 	} else {
 		gcc_assert(TREE_CODE(*node) == TYPE_DECL);
 		type = TREE_TYPE(*node);
@@ -348,15 +351,14 @@ static int relayout_struct(tree type)
 		TREE_CHAIN(newtree[i]) = newtree[i+1];
 	TREE_CHAIN(newtree[num_fields - 1]) = NULL_TREE;
 
+	add_type_attr(type, "randomize_performed", NULL_TREE);
+	add_type_attr(type, "designated_init", NULL_TREE);
+	if (has_flexarray)
+		add_type_attr(type, "has_flexarray", NULL_TREE);
+
 	main_variant = TYPE_MAIN_VARIANT(type);
-	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant)) {
+	for (variant = main_variant; variant; variant = TYPE_NEXT_VARIANT(variant))
 		TYPE_FIELDS(variant) = newtree[0];
-		TYPE_ATTRIBUTES(variant) = copy_list(TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("randomize_performed"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		TYPE_ATTRIBUTES(variant) = tree_cons(get_identifier("designated_init"), NULL_TREE, TYPE_ATTRIBUTES(variant));
-		if (has_flexarray)
-			TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("has_flexarray"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
 
 	/*
 	 * force a re-layout of the main variant
@@ -424,10 +426,8 @@ static void randomize_type(tree type)
 	if (lookup_attribute("randomize_layout", TYPE_ATTRIBUTES(TYPE_MAIN_VARIANT(type))) || is_pure_ops_struct(type))
 		relayout_struct(type);
 
-	for (variant = TYPE_MAIN_VARIANT(type); variant; variant = TYPE_NEXT_VARIANT(variant)) {
-		TYPE_ATTRIBUTES(type) = copy_list(TYPE_ATTRIBUTES(type));
-		TYPE_ATTRIBUTES(type) = tree_cons(get_identifier("randomize_considered"), NULL_TREE, TYPE_ATTRIBUTES(type));
-	}
+	add_type_attr(type, "randomize_considered", NULL_TREE);
+
 #ifdef __DEBUG_PLUGIN
 	fprintf(stderr, "Marking randomize_considered on struct %s\n", ORIG_TYPE_NAME(type));
 #ifdef __DEBUG_VERBOSE
-- 
2.34.1

