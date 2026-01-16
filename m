Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7FD3570B3
	for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556064; cv=none; b=U5H9zZFzrvdWSlFuA9fAOLJAyrO+iaHnaTxhdn38sZcjKKon9rFBQwtLvYlfmIf4nTztgKvymoPIlk6PQXACv7IKiR7Z2PVwPQIxwEWYpuwT5qCuHGcL1bsAZieId1cuEejOgt8RfrXK9lde85awf9Paqz9sNX8jY6l9BC/Ny74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556064; c=relaxed/simple;
	bh=Y/JLcurrP7hYPL4AV5l4OWDyDh1zMqiBUjyu5CelejU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lFKh+uhh1zDBhKuEfIB6FFr1q1n8lAcH1wkbRGo/yUkNiUK5mh+AkT+znkNxElP4fKVkpO79yq6TGlDKXk+QcDzJLLLTFSScupFhEwCeiiOLpFaM5FtmrJozWCpXI3Tq23ha3O6RHpL4Rndsaup/K3jC4EjsO99Lk9qdlcGrsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cwbF2N2n; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cwbF2N2n"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-47ee71f0244so15117385e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 16 Jan 2026 01:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768556061; x=1769160861; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dobnQlzcQXndjhDiBs5Er5oWRxsPFXQMWQBLT95H/Xg=;
        b=cwbF2N2nDY8tR+eEvbhvqkJuzQjXY83InFdk9YN8fBeltVuhZAE/fqemHhsvFKcMXY
         eHWV0F7BadYCh3VZkmP86mWHiTesWY6igyAPHYqgK2AF2hYLJ0hu7dPw9jFTU15/i5T4
         xPlVNP3MD9DAOPMQqut5hnT7AwQ4aP3b2HpFLtHOQISZ0IIYA5e7ty9pOQCVvf7cCFdi
         1Wm9cOR8ddBWzkNFPfB/GW4krT3INKieFtZvsRGsWMsWQnIEDYJKw4YVN5NXYyAsZXRi
         NpXt1GIJOs8A9PulUT0c8bC08SOm2m5roNAtWTs7XmvoYm9gQdJz/AdDERvKczlzC7qn
         3HYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768556061; x=1769160861;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dobnQlzcQXndjhDiBs5Er5oWRxsPFXQMWQBLT95H/Xg=;
        b=DEzr3ylfv8zZcUnOJNoQW90mZ/qOnPHbJ9403uvD+VuLLohsm4Tgdu1roj4keA9UwK
         2pdWqrtavVBWS84GH+aETgQItr3/iVZkR0nNqHFP7EDurIbkPZ64GIEm/e4MHJWcKoCl
         26PwrcMVxwAp2ZCsza0v2as3WFRPYWVVj35+R95ZelPWeqCuAt+H5G5MECObWZ/I8eEI
         fKaUXRcD3axVQqt8j9qHlOuJOYZXUTm/xH/4BYq4e9A55ZYiYUz0COCvgipZp0/dSge9
         kEnNCNEyAQNfQGboki4R8hDYXMTDzuDsrsAFAf/59Iy8gck6/DJ8RuN519c2J9B/+UYc
         tsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnQtZo5Dxfr3Xprh/8F99Ixm21WLokNx2o3PXsiVDUe6rxQOT1eUZtyTNR37khHpxw6KL1l58k7W0nKWrDrQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGMTF/B1sfszir77IV5LnEnkjDNtOWs3+JvqkNliwCXZSexyYN
	qf+fiRkk5BT6aafVc+50dJjvErUOmYe0xuRXWdVV9FAT9vbeIn45CaojphXjSBHssQhGTx0/8Q=
	=
X-Received: from wmco13.prod.google.com ([2002:a05:600c:a30d:b0:475:decb:4c4d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5248:b0:477:b642:9dc9
 with SMTP id 5b1f17b1804b1-4801e3459d3mr25659335e9.28.1768556060718; Fri, 16
 Jan 2026 01:34:20 -0800 (PST)
Date: Fri, 16 Jan 2026 10:34:01 +0100
In-Reply-To: <20260116093359.2442297-4-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260116093359.2442297-4-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1741; i=ardb@kernel.org;
 h=from:subject; bh=DUkB/GIoROOowZ3yMGbRxpDeWaywIuqMepfO7ycB2TA=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JITOLjeO/9crlrv6HHGMT1oTLXg3eZzZ7nocCV6f7nuPX/
 H9kFH/pKGVhEONikBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZvJThn2Lwjg8vrmw/smH9
 xV9lbhIhKZINZ+5MZ7adumSKbY3FIyeG/3WHvRslAtJvO5p8KszUeGCoFxvEUeDP7nDx6+0uS5W J3AA=
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260116093359.2442297-5-ardb+git@google.com>
Subject: [PATCH v2 1/2] mips: Add support for PC32 relocations in vmlinux
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Kees Cook <kees@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

MIPS supports PC32 relocations like most other architectures, which will
be used by kallsyms to make its symbol references visible to the linker.

Given that these are place-relative, they can be ignored by the 'relocs'
tool, just like other PC type relocations.

Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/mips/boot/tools/relocs.c | 2 ++
 arch/mips/include/asm/elf.h   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/mips/boot/tools/relocs.c b/arch/mips/boot/tools/relocs.c
index 9863e1d5c62e..30809f47415a 100644
--- a/arch/mips/boot/tools/relocs.c
+++ b/arch/mips/boot/tools/relocs.c
@@ -79,6 +79,7 @@ static const char *rel_type(unsigned type)
 		REL_TYPE(R_MIPS_HIGHEST),
 		REL_TYPE(R_MIPS_PC21_S2),
 		REL_TYPE(R_MIPS_PC26_S2),
+		REL_TYPE(R_MIPS_PC32),
 #undef REL_TYPE
 	};
 	const char *name = "unknown type rel type name";
@@ -522,6 +523,7 @@ static int do_reloc(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
 	case R_MIPS_PC16:
 	case R_MIPS_PC21_S2:
 	case R_MIPS_PC26_S2:
+	case R_MIPS_PC32:
 		/*
 		 * NONE can be ignored and PC relative relocations don't
 		 * need to be adjusted.
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index dc8d2863752c..aaef0eaa68d5 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -123,6 +123,8 @@
 #define R_MIPS_LOVENDOR		100
 #define R_MIPS_HIVENDOR		127
 
+#define R_MIPS_PC32		248
+
 #define SHN_MIPS_ACCOMON	0xff00		/* Allocated common symbols */
 #define SHN_MIPS_TEXT		0xff01		/* Allocated test symbols.  */
 #define SHN_MIPS_DATA		0xff02		/* Allocated data symbols.  */
-- 
2.52.0.457.g6b5491de43-goog

