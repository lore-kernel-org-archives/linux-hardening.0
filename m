Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C1F42E480;
	Thu,  8 Jan 2026 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864505; cv=none; b=j9A26RkZ1QUUWMS8eSG9RD/N95Iai5rnxRon9pjdl2vLPF3tVRnQa3xf4cZcB7Om2OF8fG73nDEQ6ZhKGSYowxd67QhjlM192JyI6oh8DcCTtifDi5Zd4ZOxCKkyTCm28ksd4dQHYEiZAiENqiio9I/xG1LUWsfH8G1p5tUJMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864505; c=relaxed/simple;
	bh=UKYzBsVEAFiPjZdHt7axt6UwaeRnASbJ8MN6S8KXN78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNhJVkv7s0p+aPTYXTO2yZZvlCmPWZGUb37QibSCPzG4QM5GsEY/lcIQZlf7tcO2FBmeFco45gaFsWvZQxVI5Mco4RHHLK85VmdqH4LJ8N7VImX5m8KidqlsCH+/0i3zt4KZiea3+vxdlALIMZwMRl0u1OEXj5m1JdFqwb/4MYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ+CVu0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ+CVu0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5905AC19422;
	Thu,  8 Jan 2026 09:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864503;
	bh=UKYzBsVEAFiPjZdHt7axt6UwaeRnASbJ8MN6S8KXN78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AZ+CVu0ygqa1AHc2ET8QtSCzK8gs9r0Aphn7ggnsq5mJV9eoXKh8ekupo0Mc8LmzS
	 bagiVEoa1mxpkDw/jhh8oXOIPjNebnUff4Dv/2s4mkTwOvPrSQCjQAqI5scj3dwX9z
	 wlvMX1Qv25BXey1kYO1p/G+vFtKid5HHwdXOjS4S6J2vGBgDM+amJSL+jL3e/kAG7Y
	 +9AMMOPyA9WJ36gQKd7ul0f5zDyEutAbUn+nN007mA0syBvVdPlKl4uOqsntuaUPS/
	 DiXVmjrwxfJ0y9cWO8DnUVJdCaKky8yFFpVEKqfwHAkcINaWNkDBqxL37C1+VOIE21
	 mO+mS8sOssPlw==
From: Ard Biesheuvel <ardb@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Uros Bizjak <ubizjak@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: [RFC/RFT PATCH 10/19] x86/kvm: Use RIP-relative addressing
Date: Thu,  8 Jan 2026 09:25:37 +0000
Message-ID: <20260108092526.28586-31-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=ardb@kernel.org; h=from:subject; bh=UKYzBsVEAFiPjZdHt7axt6UwaeRnASbJ8MN6S8KXN78=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+QqQ6plyr7mmy9qeqitP/WC0m8k3kMGJmaN64/fcf3 sBw98MdpSwMYlwMsmKKLAKz/77beXqiVK3zLFmYOaxMIEMYuDgFYCIfLzEyzOlqf/2o0zF80ZRb Zn/nJiywfCd76oD5pY3quZ4lh/tS8xn+Sl2ovvTY123bU5lzYdukLt2t453mH7jaYtoasX8rXqT 9YgAA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Replace absolute references in inline asm with RIP-relative ones, to
avoid the need for relocation fixups at boot time. This is a
prerequisite for PIE linking, which only permits 64-bit wide
loader-visible absolute references.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/kvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index df78ddee0abb..1a0335f328e1 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -807,8 +807,9 @@ extern bool __raw_callee_save___kvm_vcpu_is_preempted(long);
  * restoring to/from the stack.
  */
 #define PV_VCPU_PREEMPTED_ASM						     \
- "movq   __per_cpu_offset(,%rdi,8), %rax\n\t"				     \
- "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time(%rax)\n\t" \
+ "0:leaq 0b(%rip), %rax\n\t"						     \
+ "addq   __per_cpu_offset - 0b(%rax,%rdi,8), %rax\n\t"			     \
+ "cmpb   $0, " __stringify(KVM_STEAL_TIME_preempted) "+steal_time-0b(%rax)\n\t" \
  "setne  %al\n\t"
 
 DEFINE_ASM_FUNC(__raw_callee_save___kvm_vcpu_is_preempted,
-- 
2.47.3

