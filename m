Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237F37F8A5;
	Sat, 19 Sep 2026 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779593; cv=none; b=G2SV8hDRRndhsH7OwqMaWfVvKmSAIPaBKZClDI2FcF7r7+sl14+YWyf4pyw4F6vFCymjgtUtO+TPCen3bIhI5tus6hwwEkn6tBIeCAielAG0TkVck98pYWH8jiZQp8J/BBrhnrUk6vC6lJsw/rkuEG3ywq0fllyOXGYbjjgnFdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779593; c=relaxed/simple;
	bh=HKXdacwKF78HLJ3vx6uOkZcF/tYHFHrxL5JCDQ7Fu+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ES2fuTeWQZgO3FbmOfxLOP8WRpG2wJ2C9nE3EIuIVlwfCKrGJmcP47y662CmrZAzJ52ym6LFafFjx5vM5o/NJzkH/tE4x5oqB1LFSaclnWym4TfUvEhIV5bsKntVkupKC3tP57gjxKq2e5nJWvb1fomWRAcRRRLAaUFwkv96nsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVcKbvSL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVcKbvSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CCB1F00899;
	Sat, 19 Sep 2026 00:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779570;
	bh=axOp/C8x8rmpmJka84d5X5AXSviAh/HL35lA9rMyd9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bVcKbvSLHmji9zLRvYSx++tpaVCO/j0iTnU+IXBN8dULA63bt6NYBZWd7xSIwC3lh
	 tHpXnj1U0KT3pi7EZV/C+jJQt8uOaJ1pSHJbBwhSqnokVhLSkophmRBKY/EBsZWiXQ
	 jPcyXoKtUzG+IZGRdKpwj8pCTK4zJkUEPD1ZdytLYUnZ5NTQSFDLkdUAwoLKPgzxv2
	 rTnSxBmerUQGPZ6zLcrIr4abgts8w5tzuD9VvXvAVF8ur6wwGvIGRowm+TeaDUHw0O
	 in68VtSKrs6u4i7eP6Gj0jXxIO8R/hNrF2Z2cvaFt0rq9lE3P1kx8n2dD+9FGtbgai
	 3n1RLg8g1v4PA==
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nicolas Pitre <nico@fluxnic.net>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Nauman Sabir <officialnaumansabir@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Matthew Maurer <mmaurer@google.com>,
	Graham Roff <grahamr@qti.qualcomm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Gary Guo <gary@garyguo.net>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] kconfig: Add "def_string", "def_int" and "def_hex"
Date: Fri, 18 Sep 2026 17:59:25 -0700
Message-Id: <20260919005929.4077729-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260919005923.i.879-kees@kernel.org>
References: <20260919005923.i.879-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8993; i=kees@kernel.org; h=from:subject; bh=HKXdacwKF78HLJ3vx6uOkZcF/tYHFHrxL5JCDQ7Fu+0=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlr7+Ud37NBJahBLMI6yWq54ulTL9brC9nmL80Qjw9NL lc6HsvRUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJFSGUaGntdd0lVHdty/PfN4 Tlb2bvvN/4p3bnsTdZQr/ud+vgM6axkZ1qTZCbf2dPVvm6+8ZT3HQ8OwGoOQuJfpTB3Gp72fmb7 gBwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Kconfig has offered "def_bool" and "def_tristate" as a shorthand for a
type definition plus a default since before the git era, but has never
offered the equivalent for the other three types. Conor Dooley ran into
this gap[1] when fixing a symbol that had been given the wrong type:

  Unfortunately, there is no such thing as "def_string", but in this
  case we can use "default" to propagate the value of ...

Nothing in the grammar requires the restriction. The rule that consumes
a default is already type agnostic. Add the three missing types. No
changes are needed to existing diagnostics. E.g. declaring a symbol
"bool" and then assigning it with "def_string" still reports

  warning: ignoring type redefinition of 'CONFLICT' from 'bool' to 'string'

Added tests for the types.

Build tested ARCH=x86_64 with GCC 16.2.0. Tests pass with "make testconfig".

Link: https://lore.kernel.org/all/20230111104848.2088516-1-conor.dooley@microchip.com/ [1]
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>
Cc: Julian Braha <julianbraha@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Jones <andrew.jones@linux.dev>
Cc: <linux-kbuild@vger.kernel.org>
Cc: <linux-doc@vger.kernel.org>
---
 scripts/kconfig/tests/def_type/Kconfig        | 28 +++++++++++++++++++
 scripts/kconfig/tests/def_type/guard_n.config |  1 +
 scripts/kconfig/tests/def_type/guard_y.config |  1 +
 scripts/kconfig/tests/def_type/__init__.py    | 18 ++++++++++++
 .../kconfig/tests/def_type/expected_guard_n   |  9 ++++++
 .../kconfig/tests/def_type/expected_guard_y   | 11 ++++++++
 scripts/kconfig/kconfig-sym-check.pl          |  2 +-
 scripts/kconfig/lexer.l                       |  3 ++
 scripts/kconfig/parser.y                      |  6 ++++
 Documentation/kbuild/kconfig-language.rst     | 13 ++++++++-
 10 files changed, 90 insertions(+), 2 deletions(-)
 create mode 100644 scripts/kconfig/tests/def_type/Kconfig
 create mode 100644 scripts/kconfig/tests/def_type/guard_n.config
 create mode 100644 scripts/kconfig/tests/def_type/guard_y.config
 create mode 100644 scripts/kconfig/tests/def_type/__init__.py
 create mode 100644 scripts/kconfig/tests/def_type/expected_guard_n
 create mode 100644 scripts/kconfig/tests/def_type/expected_guard_y

diff --git a/scripts/kconfig/tests/def_type/Kconfig b/scripts/kconfig/tests/def_type/Kconfig
new file mode 100644
index 000000000000..fbee37a63179
--- /dev/null
+++ b/scripts/kconfig/tests/def_type/Kconfig
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0
+# The def_<type> shorthands: a type definition plus a default value.
+
+config MODULES
+	bool "Enable loadable module support"
+	modules
+	default y
+
+config GUARD
+	bool "Guard symbol"
+
+config DEF_BOOL
+	def_bool GUARD
+
+config DEF_TRISTATE
+	def_tristate m if GUARD
+
+config DEF_STRING
+	def_string "guarded" if GUARD
+	default "fallback"
+
+config DEF_INT
+	def_int 64 if GUARD
+	default 32
+
+config DEF_HEX
+	def_hex 0xdead if GUARD
+	default 0x0
diff --git a/scripts/kconfig/tests/def_type/guard_n.config b/scripts/kconfig/tests/def_type/guard_n.config
new file mode 100644
index 000000000000..ed9ad6c1a2d4
--- /dev/null
+++ b/scripts/kconfig/tests/def_type/guard_n.config
@@ -0,0 +1 @@
+# CONFIG_GUARD is not set
diff --git a/scripts/kconfig/tests/def_type/guard_y.config b/scripts/kconfig/tests/def_type/guard_y.config
new file mode 100644
index 000000000000..afe35b084542
--- /dev/null
+++ b/scripts/kconfig/tests/def_type/guard_y.config
@@ -0,0 +1 @@
+CONFIG_GUARD=y
diff --git a/scripts/kconfig/tests/def_type/__init__.py b/scripts/kconfig/tests/def_type/__init__.py
new file mode 100644
index 000000000000..1ebaf5da07c8
--- /dev/null
+++ b/scripts/kconfig/tests/def_type/__init__.py
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+"""
+Set a symbol's type and its default value in one line.
+
+"def_bool", "def_tristate", "def_string", "def_int" and "def_hex" are
+shorthand for a type definition plus a "default" property.  Check that
+each one sets the type, and that an "if" on the shorthand does not
+disturb the usual default cascade: the shorthand is only the first arm
+of the list, so a later "default" still applies when its condition is
+not met.
+"""
+
+def test(conf):
+    assert conf.olddefconfig(dot_config='guard_y.config') == 0
+    assert conf.config_matches('expected_guard_y')
+
+    assert conf.olddefconfig(dot_config='guard_n.config') == 0
+    assert conf.config_matches('expected_guard_n')
diff --git a/scripts/kconfig/tests/def_type/expected_guard_n b/scripts/kconfig/tests/def_type/expected_guard_n
new file mode 100644
index 000000000000..14719720a8b9
--- /dev/null
+++ b/scripts/kconfig/tests/def_type/expected_guard_n
@@ -0,0 +1,9 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+CONFIG_MODULES=y
+# CONFIG_GUARD is not set
+CONFIG_DEF_STRING="fallback"
+CONFIG_DEF_INT=32
+CONFIG_DEF_HEX=0x0
diff --git a/scripts/kconfig/tests/def_type/expected_guard_y b/scripts/kconfig/tests/def_type/expected_guard_y
new file mode 100644
index 000000000000..b2844072d0b8
--- /dev/null
+++ b/scripts/kconfig/tests/def_type/expected_guard_y
@@ -0,0 +1,11 @@
+#
+# Automatically generated file; DO NOT EDIT.
+# Main menu
+#
+CONFIG_MODULES=y
+CONFIG_GUARD=y
+CONFIG_DEF_BOOL=y
+CONFIG_DEF_TRISTATE=m
+CONFIG_DEF_STRING="guarded"
+CONFIG_DEF_INT=64
+CONFIG_DEF_HEX=0xdead
diff --git a/scripts/kconfig/kconfig-sym-check.pl b/scripts/kconfig/kconfig-sym-check.pl
index daa5285fdefc..c8dd07f8b27c 100755
--- a/scripts/kconfig/kconfig-sym-check.pl
+++ b/scripts/kconfig/kconfig-sym-check.pl
@@ -90,7 +90,7 @@ foreach my $file (@files) {
 			next;
 		}
 
-		if (/^\s*(default|def_bool|def_tristate|select|depends\s+on|imply|visible\s+if|range|if|bool|tristate|int|hex|string|prompt)\s+(.+)\s*$/) {
+		if (/^\s*(default|def_bool|def_tristate|def_string|def_int|def_hex|select|depends\s+on|imply|visible\s+if|range|if|bool|tristate|int|hex|string|prompt)\s+(.+)\s*$/) {
 			my $s = $2;
 			$s =~ s/"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'//g;
 			$s =~ s/#.*//;
diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index a6155422b4a6..1fa521199d4a 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -105,6 +105,9 @@ n	[A-Za-z0-9_-]
 "comment"		return T_COMMENT;
 "config"		return T_CONFIG;
 "def_bool"		return T_DEF_BOOL;
+"def_hex"		return T_DEF_HEX;
+"def_int"		return T_DEF_INT;
+"def_string"		return T_DEF_STRING;
 "def_tristate"		return T_DEF_TRISTATE;
 "default"		return T_DEFAULT;
 "depends"		return T_DEPENDS;
diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 5fb6f07b6ad2..2174baf2b3fd 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -53,6 +53,9 @@ struct menu *current_menu, *current_entry, *current_choice;
 %token T_CONFIG
 %token T_DEFAULT
 %token T_DEF_BOOL
+%token T_DEF_HEX
+%token T_DEF_INT
+%token T_DEF_STRING
 %token T_DEF_TRISTATE
 %token T_DEPENDS
 %token T_ENDCHOICE
@@ -309,6 +312,9 @@ type:
 default:
 	  T_DEFAULT		{ $$ = S_UNKNOWN; }
 	| T_DEF_BOOL		{ $$ = S_BOOLEAN; }
+	| T_DEF_HEX		{ $$ = S_HEX; }
+	| T_DEF_INT		{ $$ = S_INT; }
+	| T_DEF_STRING		{ $$ = S_STRING; }
 	| T_DEF_TRISTATE	{ $$ = S_TRISTATE; }
 
 /* if entry */
diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index d9338407c1c6..00402d43e0dc 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -113,11 +113,22 @@ applicable everywhere (see syntax).
 
 - type definition + default value::
 
-	"def_bool"/"def_tristate" <expr> ["if" <expr>]
+	"def_bool" <expr> ["if" <expr>]
+	"def_tristate" <expr> ["if" <expr>]
+	"def_string" <expr> ["if" <expr>]
+	"def_int" <expr> ["if" <expr>]
+	"def_hex" <expr> ["if" <expr>]
 
   This is a shorthand notation for a type definition plus a value.
   Optionally dependencies for this default value can be added with "if".
 
+  The shorthand supplies the type once, and is otherwise an ordinary
+  default: it is the first entry of the list described above, so any
+  further "default" entries still apply when its "if" is not met. Since
+  that leaves the type definition inside one arm of a list, spelling the
+  type out on its own line reads better for a symbol with several
+  defaults.
+
 - dependencies: "depends on" <expr> ["if" <expr>]
 
   This defines a dependency for this menu entry. If multiple
-- 
2.34.1

