Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ED3444822;
	Thu,  8 Jan 2026 09:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864527; cv=none; b=Avjw0UHUQmmiRvcaCYPpDFrNXOf1ojFeOEB1eeq8sg2VjZEbcB50KsTu2Pnv0thrCKIvdoa7j8SgSWluUEYXXFIZsLvYTetl0XoVK2yovniNSoMlqyEw3ZxSIHvaXYbTjFl7F7RY/wb0ZV4yLGucV/uEWKAC+On1DDXcWyEKSO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864527; c=relaxed/simple;
	bh=P1lJeWjCS3Z/ecUvYNiclBWHLgcgxigfGGdI48tiRW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMRygra1XNjGu/TBCy3sDaN2kIGNPTr27p1q/BoyEDgG4/CUOmrU/tOb+950JCH+gGxr3a3TygIvFwXod7mfM+9ZtYzTeyhOqlMfh2T6X/hHBq0oxm65GSFTlrCLu5GMWfUNY9/MJqNXYqCiyDZYMCLuGEbt/d0YRpOdF86oBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u0UNqmCZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u0UNqmCZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DB3C16AAE;
	Thu,  8 Jan 2026 09:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767864526;
	bh=P1lJeWjCS3Z/ecUvYNiclBWHLgcgxigfGGdI48tiRW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u0UNqmCZ+DFoIsCdMmJJKGAn44VXz4xiIoe26PDpbFJUg7WCOfLVipErMD++H3VW3
	 QXFWKBIxdB5laWUic9JuYSfdJvIpzwe69v0gfdf37hFKPaw4FDhrocpbGj1TpD40jm
	 ycvMhQX27uh/h2VkHjdpq4sq7VQHNVIFK1Mvfx8N5RF2IVo0gEK13yY0qQF947YzIH
	 S/h/uD5SinqOgmpHnElBo9BQalaLAh77I6EDUzbMs+pr5W03Ftwlxw032p1FZoI3w7
	 18Q60yhzUS+u3Yj5IfHx6mud13AKH71hEZXvyzaQJw2iBJOSiaNae6D7Oz7b5sk0pV
	 UIaYPgCgTf0MQ==
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
Subject: [RFC/RFT PATCH 18/19] x86/boot: Implement support for RELA/RELR/REL runtime relocations
Date: Thu,  8 Jan 2026 09:25:45 +0000
Message-ID: <20260108092526.28586-39-ardb@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
References: <20260108092526.28586-21-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4132; i=ardb@kernel.org; h=from:subject; bh=P1lJeWjCS3Z/ecUvYNiclBWHLgcgxigfGGdI48tiRW8=; b=owGbwMvMwCVmkMcZplerG8N4Wi2JITO+Qt7gw6xPobaxR/5ek+LUbV402XbPNuc97fX9rHO8J vrI96p0lLIwiHExyIopsgjM/vtu5+mJUrXOs2Rh5rAygQxh4OIUgIlMbWX4H39takRyofbbi0zX f6s98DqhzvrgoDDrLNG3c3K1eTuFbjL8Uw1f8mnyqbMMTDIR+67eEuLTDJu5hedKYN6p+7/6HnX 8ZgEA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit

Given that the decompressor already incorporates an ELF loader that
parses the program headers of the decompressed ELF image, support for
dealing with the PT_DYNAMIC program header can be added quite easily,
which describes the location of the RELA and RELR relocation tables in
the image.

This is a more efficient, and more idiomatic format, which allows the
handling of boot-time randomization (KASLR) in a generic manner, rather
than based on a bespoke x86-specific relocation format. This is a
prerequisite for enabling further hardening measures that are
implemented in the ELF domain, i.e., fgkaslr.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/misc.c | 73 +++++++++++++++++++-
 include/uapi/linux/elf.h        |  3 +
 2 files changed, 74 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 1ea419cf88fe..bc5677e697ca 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -278,7 +278,68 @@ static inline void handle_relocations(void *output, unsigned long output_len,
 { }
 #endif
 
-static size_t parse_elf(void *output)
+#define ELF(type) __PASTE(__PASTE(Elf, __LONG_WIDTH__), __PASTE(_, type))
+
+static void handle_dynamic(const ELF(Dyn) *dyn, unsigned long p2v_offset,
+			   unsigned long va_shift)
+{
+	const ELF(Rela) *rela = NULL;
+	const ELF(Rel) *rel = NULL;
+	unsigned long *relr = NULL;
+	unsigned long *place;
+	int relasize = 0;
+	int relrsize = 0;
+	int relsize = 0;
+
+	for (auto d = dyn; d->d_tag != DT_NULL; d++) {
+		switch (d->d_tag) {
+		case DT_RELA:
+			rela = (void *)(d->d_un.d_ptr + p2v_offset);
+			break;
+		case DT_RELASZ:
+			relasize = d->d_un.d_val;
+			break;
+		case DT_RELR:
+			relr = (void *)(d->d_un.d_ptr + p2v_offset);
+			break;
+		case DT_RELRSZ:
+			relrsize = d->d_un.d_val;
+			break;
+		case DT_REL:
+			rel = (void *)(d->d_un.d_ptr + p2v_offset);
+			break;
+		case DT_RELSZ:
+			relsize = d->d_un.d_val;
+			break;
+		}
+	}
+
+	for (int i = 0; i < relasize / sizeof(*rela); i++) {
+		place = (unsigned long *)(rela[i].r_offset + p2v_offset);
+		*place += va_shift;
+	}
+
+	for (int i = 0; i < relrsize / sizeof(*relr); i++) {
+		if ((relr[i] & 1) == 0) {
+			place = (unsigned long *)(relr[i] + p2v_offset);
+			*place++ += va_shift;
+			continue;
+		}
+
+		for (unsigned long *p = place, r = relr[i] >> 1; r; p++, r >>= 1)
+			if (r & 1)
+				*p += va_shift;
+		place += 8 * sizeof(*relr) - 1;
+	}
+
+	for (int i = 0; i < relsize / sizeof(*rel); i++) {
+		place = (unsigned long *)(rel[i].r_offset + p2v_offset);
+		*place += va_shift;
+	}
+
+}
+
+static size_t parse_elf(void *output, u64 va_shift)
 {
 #ifdef CONFIG_X86_64
 	Elf64_Ehdr ehdr;
@@ -320,6 +381,12 @@ static size_t parse_elf(void *output)
 				dest += (unsigned long)output - LOAD_PHYSICAL_ADDR;
 			memmove(dest, output + phdr->p_offset, phdr->p_filesz);
 			break;
+		case PT_DYNAMIC:
+			if (!va_shift)
+				break;
+			dest = (void *)(output + phdr->p_paddr - LOAD_PHYSICAL_ADDR);
+			handle_dynamic(dest, (unsigned long)dest - phdr->p_vaddr, va_shift);
+			break;
 		default: /* Ignore other PT_* */ break;
 		}
 	}
@@ -351,7 +418,9 @@ unsigned long decompress_kernel(unsigned char *outbuf, unsigned long virt_addr,
 			 NULL, error) < 0)
 		return ULONG_MAX;
 
-	entry = parse_elf(outbuf);
+	if (IS_ENABLED(CONFIG_X86_32))
+		virt_addr = (unsigned long)outbuf;
+	entry = parse_elf(outbuf, virt_addr - LOAD_PHYSICAL_ADDR);
 	handle_relocations(outbuf, output_len, virt_addr);
 
 	return entry;
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 819ded2d39de..868cd67f0ea7 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -103,6 +103,9 @@ typedef __u16	Elf64_Versym;
 #define DT_TEXTREL	22
 #define DT_JMPREL	23
 #define DT_ENCODING	32
+#define DT_RELRSZ	35
+#define DT_RELR		36
+#define DT_RELRENT	37
 #define OLD_DT_LOOS	0x60000000
 #define DT_LOOS		0x6000000d
 #define DT_HIOS		0x6ffff000
-- 
2.47.3

