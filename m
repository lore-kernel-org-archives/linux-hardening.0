Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC129D28F;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763775785; cv=none; b=egQpV0FR55Wemfof2xbRWjFtzKiEoS5k2ekLDBJnzrpsAfxBuejCHoswX8Ldc2XsN7/nvOnR/LQTgl8eegwbQUCVdOSu0d3fZvo8l1v3EAnIMFw5dvsSqGfBoU74tLMKfpXkUyiCRunhV3XEIqv3vEZW8cNCtPhAQcpXR26hyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763775785; c=relaxed/simple;
	bh=+af9Qrl81jzQeC8vw0DiKskxnHYHklRLaViyotNOrs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WxftCPycn6MdssRi8O7TB08FikM6qDDeFX23yD2B8p6yIqk21flly2ukoOIeZ14J0YAgnePvhjNiorb4rqEmgxLONj5SJ7LVggrLDth2KHUJOG8FP+VHieZauzAumYmCFwjLUtf1LRC4recNEU/p94NUtCL5R/uY5UUmv7Z45ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ut/vgIOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ut/vgIOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42879C4CEF1;
	Sat, 22 Nov 2025 01:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763775785;
	bh=+af9Qrl81jzQeC8vw0DiKskxnHYHklRLaViyotNOrs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ut/vgIOdn9MIzV/rf1IxTxbVnSgS9e4p/4JDkKH6Ttyw2xh8qWROfZrRa6re07wQB
	 7SD8h59GPGZ3R4KcKAAkLFEsgbssGufG7lc+4/hU4MMThVIFJHAAs0QIjDHHVnq+JZ
	 Kqj8mh4UTV6+9dKfeD6d++C+lU6CVK5vz/VK814AfArFk8VGTu6Is3xCVMB4WnVt8O
	 J02kTYAhcLCYSzmh8XTvtt5M6GgGCpc0l5Myx0zPetaQ2ACat0Tihv2HyFBSUIRS9w
	 9RdCWBP0aB08rzsv9lXKKukwLvyrCki4976g8/MPdUxc8EwnNLH3+d/2ScRwJQEAl8
	 DowxFCRPFYzOA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Lameter <cl@linux.com>,
	Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 3/4] checkpatch: Suggest kmalloc_obj family for sizeof allocations
Date: Fri, 21 Nov 2025 17:42:59 -0800
Message-Id: <20251122014304.3417954-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251122014258.do.018-kees@kernel.org>
References: <20251122014258.do.018-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3354; i=kees@kernel.org; h=from:subject; bh=+af9Qrl81jzQeC8vw0DiKskxnHYHklRLaViyotNOrs8=; b=owGbwMvMwCVmps19z/KJym7G02pJDJmKosp3epdrijLyCujd4PaQXXXunBN/fZo0p7z7gojn2 8se50/vKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmMimSkaGiYzhbomvJug35Ogl n12+4vI7AZuW9obj9xKOsNxu/jXVh5Hhf0E2e7Swoq/0hKn3vdeVOiq2NR9izjS7t9KnZePheXX 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To support shifting away from sized allocation towards typed
allocations, suggest the kmalloc_obj family of macros when a sizeof() is
present in the argument lists.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Andy Whitcroft <apw@canonical.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 scripts/checkpatch.pl | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d58ca9655ab7..a8cdfb502ccc 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7258,17 +7258,42 @@ sub process {
 			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
 		}
 
-# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/kvmalloc_array/kvcalloc/kcalloc
+# check for (kv|k)[mz]alloc that could be kmalloc_obj/kvmalloc_obj/kzalloc_obj/kvzalloc_obj
+		if ($perl_version_ok &&
+		    defined $stat &&
+		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*,/) {
+			my $oldfunc = $3;
+			my $a1 = $4;
+			my $newfunc = "kmalloc_obj";
+			$newfunc = "kvmalloc_obj" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvzalloc_obj" if ($oldfunc eq "kvzalloc");
+			$newfunc = "kzalloc_obj" if ($oldfunc eq "kzalloc");
+
+			if ($a1 =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/) {
+				my $cnt = statement_rawlines($stat);
+				my $herectx = get_stat_here($linenr, $cnt, $here);
+
+				if (WARN("ALLOC_WITH_SIZEOF",
+					 "Prefer $newfunc over $oldfunc with sizeof\n" . $herectx) &&
+				    $cnt == 1 &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*,/$1 = $newfunc($a1,/;
+				}
+			}
+		}
+
+
+# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_objs/kvmalloc_objs/kzalloc_objs/kvzalloc_objs
 		if ($perl_version_ok &&
 		    defined $stat &&
 		    $stat =~ /^\+\s*($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
 			my $oldfunc = $3;
 			my $a1 = $4;
 			my $a2 = $10;
-			my $newfunc = "kmalloc_array";
-			$newfunc = "kvmalloc_array" if ($oldfunc eq "kvmalloc");
-			$newfunc = "kvcalloc" if ($oldfunc eq "kvzalloc");
-			$newfunc = "kcalloc" if ($oldfunc eq "kzalloc");
+			my $newfunc = "kmalloc_objs";
+			$newfunc = "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
+			$newfunc = "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
+			$newfunc = "kzalloc_objs" if ($oldfunc eq "kzalloc");
 			my $r1 = $a1;
 			my $r2 = $a2;
 			if ($a1 =~ /^sizeof\s*\S/) {
@@ -7284,7 +7309,9 @@ sub process {
 					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
 				    $cnt == 1 &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . trim($r1) . ', ' . trim($r2)/e;
+					my $sized = trim($r2);
+					$sized =~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
+					$fixed[$fixlinenr] =~ s/\b($Lval)\s*\=\s*(?:$balanced_parens)?\s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' = ' . "$newfunc(" . $sized . ', ' . trim($r1)/e;
 				}
 			}
 		}
-- 
2.34.1

