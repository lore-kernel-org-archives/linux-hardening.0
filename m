Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B849E5ED;
	Fri, 25 Sep 2026 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341345; cv=none; b=QxBlKk4F8b1LdVyboJxMkMGOCvpRvn2NcVfrzZJw4B/+bxl6heT22jQN7kmV14f0Tj4V/Oamgo8uk8ctzX0kJGbK4+rr14+Hej/NwCF8Ry8cCTwjnLV1RhXirp4eaVjclfom2NRAc48vU5xdXv0Thtw9E0DP6ZEdXAI2xf+ptuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341345; c=relaxed/simple;
	bh=TOo7AQXQrHPpBBc7jATvGFKdQIms7xUVUjisG+rwHKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDbe8p4Hrm65GIT1ZIStTYZRR19DJjWyG1Ysa6Xpb7QgpoO8+lArqwNxa3mIiAF3MeMwhbG4WX4GrglMD50smb+nsuPF9SgZWfIFOUqgxaWVDiuGJ/LKywiNSSs2fSZ36s3FV7eVoGF5hP3o9zlnKDSIRtPbyYnJpC2d+TJCiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjptmjPs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjptmjPs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669A51F00898;
	Fri, 25 Sep 2026 13:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790341343;
	bh=Nrvcb5k/fSmMlLH7+4k+1YnJOu1ZD9csl9cvsYCyWSY=;
	h=From:To:Cc:Subject:Date;
	b=GjptmjPsmEjy7D/GEKRCs9XF3kSnhQMAmOBkj3yTDjPs9dTAeMuje5T2q7/AaeI6L
	 A2YFjXPMVN6D8+mh7s3Kl1HMa+mwrDVe2vQw0DevGXBYf2u/PCCpA6mA8RoxCoNqUu
	 wlRUx3DZcQvfsRwLePXz+pzXpbe3X58VqCFQ21IEB+61Am2rDQMXBhyZqzN9hVef/1
	 dauhOB2ZKIdq3yKuGsqxBu9XtpSPo0mvvfvIEtxK1i8T/ngYUCHqD5LRM/1y0W60da
	 /mQXY/b3c5tBYFE2pwNvFV6VTYpayOJ+oAayxGbBz4lrSN4WSONV61B8Pvj63vb8p6
	 c9GM/AbwbVXmg==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Kees Cook <kees@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86/purgatory: Compile purgatory with -D__DISABLE_EXPORTS
Date: Fri, 25 Sep 2026 15:01:49 +0200
Message-ID: <20260925130217.3912329-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A previous patch fixed compile-time issues by setting __NO_FORTIFY
for all of the purgatory code, but this is insufficient and still
leaves build failures that appeared recently in linux-next:

ld.lld: error: undefined symbol: __memset
>>> referenced by string.c
>>>               arch/x86/purgatory/purgatory.ro:(__UNIQUE_ID_addressable___memset_2)

ld.lld: error: undefined symbol: __memmove
>>> referenced by string.c
>>>               arch/x86/purgatory/purgatory.ro:(__UNIQUE_ID_addressable___memmove_3)

Set __DISABLE_EXPORTS as well, to avoid pulling in a reference to the
wrong string functions.

Fixes: 65cbe410d312 ("x86/purgatory: Compile purgatory with -D__NO_FORTIFY")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/purgatory/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index cde8463b4d84..df7dbb5b3387 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -11,8 +11,6 @@ $(obj)/string.o: $(srctree)/arch/x86/boot/compressed/string.c FORCE
 $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 	$(call if_changed_rule,cc_o_c)
 
-CFLAGS_sha256.o := -D__DISABLE_EXPORTS
-
 # When profile-guided optimization is enabled, llvm emits two different
 # overlapping text sections, which is not supported by kexec. Remove profile
 # optimization flags.
@@ -37,7 +35,7 @@ PURGATORY_CFLAGS := -mcmodel=small -ffreestanding -fno-zero-initialized-in-bss -
 PURGATORY_CFLAGS += -fpic -fvisibility=hidden
 PURGATORY_CFLAGS += $(DISABLE_KSTACK_ERASE) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
-PURGATORY_CFLAGS += -D__NO_FORTIFY
+PURGATORY_CFLAGS += -D__NO_FORTIFY -D__DISABLE_EXPORTS
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-- 
2.53.0

