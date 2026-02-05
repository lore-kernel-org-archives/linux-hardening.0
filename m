Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86103A1D07;
	Thu,  5 Feb 2026 10:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770285931; cv=none; b=SqDHMAxP5hlUMYf4HrvqpYxAgKHWywgH6boeld4SD5IK3+2Z3KR7FqACUHEoI9BCjxORu4unkzAMaAv2+Mxv4BDBGhw45taVJhW04U0Yzl+D3V/IvZFNwtQiCsZifLjld+AyPyY6ZrBUisJlLrPaG7mYujwK2RplmBcy8PhpMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770285931; c=relaxed/simple;
	bh=AA0j+ccHQ9UwXxjRo6PyJU3aL0AF31nGrSbMSHAgwFM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f05RxiqLb1uCr7zmAe/b2BvG7L/6UJoadXk0piqX3JjY6AubrjQx0wXOYSYHrxWofuAMS5OsC+LNpdK9zr0EoQ8OLxXpM+LqEfibLiiJ3pF1xXOw0bf9TtfqfIGJbnLFDPDCDvU+LMPpAzgBqOsA2GWvJ+CwDopMSJHgafBivA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Un6ikFWD; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Un6ikFWD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sPoqZUGwj+5Bi5z4vx96eEq6JXWaEqv8vZqoNKhRA4Y=;
	b=Un6ikFWDy+OL/X35GfoynaKqozTukzBUEGGr1KyzRsUxy14hDXbZGeUF05qp7Wr+4OrPCN5j/
	sk+4SupjtDViXV7t5JI6/60h2z8tGzIRgXGflSdph/KS4ecWy0VbK2nPc/S06OXqrNSFhLQDIeu
	Q3Uv1YOzxYPzfQ+vyM4T6BU=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4f6CQs5s8Hz1K9Yq;
	Thu,  5 Feb 2026 18:00:53 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 33E4440565;
	Thu,  5 Feb 2026 18:05:26 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.109.17) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 5 Feb 2026 18:05:25 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <maddy@linux.ibm.com>, <mpe@ellerman.id.au>, <npiggin@gmail.com>,
	<chleroy@kernel.org>, <kees@kernel.org>, <andy@kernel.org>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <lilinjie8@huawei.com>,
	<liaohua4@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [PATCH 2/2] powerpc/text-patching: Fix possible stringop-overread compilation error
Date: Thu, 5 Feb 2026 18:05:17 +0800
Message-ID: <20260205100517.292858-2-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260205100517.292858-1-xieyuanbin1@huawei.com>
References: <20260205100517.292858-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

For strnlen(), if the compiler detects that the maxlen argument exceeds
the valid memory size of the input string object, a compilation error may
occur.

For lastest linux-next source, changing ppc_kallsyms_lookup_name() to
__always_inline, using default ppc64_defconfig, and setting
CONFIG_EXPERT=y, CONFIG_PPC64_BIG_ENDIAN_ELF_ABI_V2=n,
CONFIG_CC_OPTIMIZE_FOR_SIZE=y. Then, when using gcc-15 for compilation,
the following error will be triggered:
```log
  CC      arch/powerpc/kernel/optprobes.o
In file included from ./arch/powerpc/include/asm/kprobes.h:24,
                 from ./include/linux/kprobes.h:31,
                 from arch/powerpc/kernel/optprobes.c:8:
In function ‘ppc_kallsyms_lookup_name’,
    inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:209:21:
./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 19 [-Werror=stringop-overread]
  232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function ‘ppc_kallsyms_lookup_name’,
    inlined from ‘arch_prepare_optimized_kprobe’ at arch/powerpc/kernel/optprobes.c:210:22:
./arch/powerpc/include/asm/text-patching.h:232:13: error: ‘strnlen’ specified bound 512 exceeds source size 13 [-Werror=stringop-overread]
  232 |         if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
```

Refer to the implementation of fortify's strnlen(). If the string length
is a compile-time constant, do not call the strnlen() function.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 arch/powerpc/include/asm/text-patching.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/text-patching.h b/arch/powerpc/include/asm/text-patching.h
index e7f14720f630..ce1b2131980a 100644
--- a/arch/powerpc/include/asm/text-patching.h
+++ b/arch/powerpc/include/asm/text-patching.h
@@ -228,8 +228,13 @@ static inline unsigned long ppc_kallsyms_lookup_name(const char *name)
 	/* check for dot variant */
 	char dot_name[1 + KSYM_NAME_LEN];
 	bool dot_appended = false;
+	size_t n_len = __compiletime_strlen(name);
+	const size_t n_size = __member_size(name);
 
-	if (strnlen(name, KSYM_NAME_LEN) >= KSYM_NAME_LEN)
+	if (n_len == SIZE_MAX || KSYM_NAME_LEN < n_size)
+		n_len = strnlen(name, KSYM_NAME_LEN);
+	
+	if (n_len >= KSYM_NAME_LEN)
 		return 0;
 
 	if (name[0] != '.') {
-- 
2.51.0

