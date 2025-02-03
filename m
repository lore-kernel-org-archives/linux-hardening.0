Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B250201267;
	Mon,  3 Feb 2025 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578517; cv=none; b=cmt2MkCXNVuGsjMO0hpB1W9zZR+WUNxg9zuDj5LBqp5X8MNQs1OW/kj2pcLskxgNL+M81LQ4kgZHa8OAvb9m7A/5BR2hsxv17t4RsMkOQQeGeZ9gdQjxaGGws9BDgEe9vrvsHkKs6pZJtrWGRb8Y5lO3BN7/Csb/oKIdy6Ke4FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578517; c=relaxed/simple;
	bh=DnaBm0hMuXXLGPOYsY0jmePHuwE2wiR7Tegd00Oy9OY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz36UklO6GGBUO5QWVmYlh/CoUUxLQvYWlyfZLQl6zH4QKzxDJC5hY9yxSlV5ILYXmC9wjmP/oLA4A0qEFl83hfrAVSg56dsIebBtm4fOlUsQH+jToiwRAgcPzFx9DGQGDtbVJAYRk/Tu5Td6NhMoqsSPxljBtpMo5mG5z9M4m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF761682;
	Mon,  3 Feb 2025 02:28:59 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8CF223F63F;
	Mon,  3 Feb 2025 02:28:31 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Howells <dhowells@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Kees Cook <kees@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Lutomirski <luto@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	Quentin Perret <qperret@google.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Will Deacon <will@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [RFC PATCH 2/8] mm: kpkeys: Introduce unrestricted level
Date: Mon,  3 Feb 2025 10:28:03 +0000
Message-ID: <20250203102809.1223255-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250203102809.1223255-1-kevin.brodsky@arm.com>
References: <20250203102809.1223255-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Highly privileged components, such as allocators, may require write
access to arbitrary data. To that end, introduce a kpkeys level that
grants write access to all kpkeys.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/include/asm/kpkeys.h | 4 +++-
 include/linux/kpkeys.h          | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kpkeys.h b/arch/arm64/include/asm/kpkeys.h
index 3f16584d495a..ab2305ca24b7 100644
--- a/arch/arm64/include/asm/kpkeys.h
+++ b/arch/arm64/include/asm/kpkeys.h
@@ -19,7 +19,9 @@ static inline u64 por_set_kpkeys_level(u64 por, int level)
 {
 	por = por_set_pkey_perms(por, KPKEYS_PKEY_DEFAULT, POE_RXW);
 	por = por_set_pkey_perms(por, KPKEYS_PKEY_PGTABLES,
-				 level == KPKEYS_LVL_PGTABLES ? POE_RW : POE_R);
+				 level == KPKEYS_LVL_PGTABLES ||
+				 level == KPKEYS_LVL_UNRESTRICTED
+				 ? POE_RW : POE_R);
 
 	return por;
 }
diff --git a/include/linux/kpkeys.h b/include/linux/kpkeys.h
index 645eaf00096c..9d9feec83ccf 100644
--- a/include/linux/kpkeys.h
+++ b/include/linux/kpkeys.h
@@ -10,9 +10,10 @@ struct folio;
 
 #define KPKEYS_LVL_DEFAULT	0
 #define KPKEYS_LVL_PGTABLES	1
+#define KPKEYS_LVL_UNRESTRICTED	2
 
 #define KPKEYS_LVL_MIN		KPKEYS_LVL_DEFAULT
-#define KPKEYS_LVL_MAX		KPKEYS_LVL_PGTABLES
+#define KPKEYS_LVL_MAX		KPKEYS_LVL_UNRESTRICTED
 
 #define __KPKEYS_GUARD(name, set_level, restore_pkey_reg, set_arg, ...)	\
 	__DEFINE_CLASS_IS_CONDITIONAL(name, false);			\
-- 
2.47.0

