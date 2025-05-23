Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7CA2DCBEE;
	Fri, 23 May 2025 04:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747974406; cv=none; b=uvT+e695WmSCsLHNiJ1Ph1IBzJUU65O38QT1F4J1QXvCIGRcoxhpJvFkcbNm3rRdABZyobY0SDmDBryMQjzsNgjaS+JpqsDgn6eS0n69z3VHioWzy778GilPQL4dtaTTUHDzXUpdN3qd46Su9wGPV3ZkysgReLijcFzVhm6VzF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747974406; c=relaxed/simple;
	bh=EiExo/O1G1E1SOUp1zjWSOI7ZyzWY/boZSXRjtlQQKU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OIpTEWGjYAh/smfzzabvGRue/J6DHz7f8sNbkrxOxaTQB/IA28CvFOh8i7wY+N5i3iUYpFChGdQXTWR8owAZ1ovrgV4Rp0dzjEsYTRwtvbDxPOSGmXh2n+shyYjOih8KK0bQf8+SCkQz1OP/ZqBhCqUbpnp12VVmSfXv401x/Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd0cPxQ0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd0cPxQ0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2819CC4CEE9;
	Fri, 23 May 2025 04:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747974406;
	bh=EiExo/O1G1E1SOUp1zjWSOI7ZyzWY/boZSXRjtlQQKU=;
	h=From:To:Cc:Subject:Date:From;
	b=gd0cPxQ0zoquo9jIgV+uoBAHduYSKgrAdT0roCiDt9NE4yqILo1P9983Vp6MFLPxz
	 KP8H6jFX9tizAmoAbtIAFDe8zauGFb/FZic9N7z5rNQ6QGOo1xe2p2saEEbUhh09Cp
	 5rY/hFw/47tM15sFF4g7Nq2eueH8XmfjCRAtsWec0eoV9IEZM7YpsdBgXryjV2wjRV
	 fpThYZb3TUkVoAM8dKrPb9FHxMoG7Fhg7lOwY7PJA7Qf++V922+Z7hWeDQ/FypdKWi
	 WseVHaD/YWiKMqvDxWvt1JQUrP3LP4/vJTEwlrkuh2Vs+JXdhxNdK605va6zeBVgqZ
	 weR8av0wI9BQg==
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] x86: string_32.h: Provide basic sanity checks for fallback memcpy()
Date: Thu, 22 May 2025 21:26:40 -0700
Message-Id: <20250523042635.work.579-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=kees@kernel.org; h=from:subject:message-id; bh=EiExo/O1G1E1SOUp1zjWSOI7ZyzWY/boZSXRjtlQQKU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6P/4LaVfbv6sK5RDKfeB1aV+eQpL12qdCf5LfLbjeG 7hrnePjjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIlYfGL4n/RZf/rOoKiqvSu4 ju2y8k3w1xFe3b7GY1ly0aZ90kUb2xn+mdgJ39awud3Mxne/2rB2/vX56xZPXXAkN5z50gq7IFZ nBgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add basic sanity checking for pathological "size" arguments to
memcpy(). Besides the run-time checking benefit, this avoids
GCC trying to be very smart about value range tracking[1] when
CONFIG_PROFILE_ALL_BRANCHES=y but FORTIFY_SOURCE=n.

Link: https://lore.kernel.org/all/202505191117.C094A90F88@keescook/ [1]
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Closes: https://lore.kernel.org/all/e3754f69-1dea-4542-8de0-a567a14fb95b@infradead.org/
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: isolate this specifically to 32-bit x86 -- doing this generally is much more work
 v1: https://lore.kernel.org/lkml/20250520163320.work.924-kees@kernel.org/
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 arch/x86/include/asm/string_32.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 32c0d981a82a..6e8d100d1301 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -147,7 +147,14 @@ extern void *memcpy(void *, const void *, size_t);
 
 #ifndef CONFIG_FORTIFY_SOURCE
 
-#define memcpy(t, f, n) __builtin_memcpy(t, f, n)
+#define memcpy(t, f, n)					\
+	({						\
+		typeof(n) __n = (n);			\
+		/* Skip impossible sizes. */		\
+		if (!(__n < 0 || __n == SIZE_MAX))	\
+			__builtin_memcpy(t, f, __n);	\
+		(t);					\
+	})
 
 #endif /* !CONFIG_FORTIFY_SOURCE */
 
-- 
2.34.1

