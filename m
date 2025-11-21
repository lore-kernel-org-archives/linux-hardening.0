Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6452E7F20
	for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754913; cv=none; b=ZDK6ZOXbW+4un2UMtNB+5Wyd8/0e7tKb4MNUI77BfZGPugiI8zjSn0u7uXrtcETXrzgL4JoayG14aRMgjgxr69cO+deR0gxfmcWjDnlAyeEiHOpPTUfH8o31GyJhG6G0DFf+/HyIXqrnbHPnyzMPk1nRIXBBvxWFJYJm1A9gAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754913; c=relaxed/simple;
	bh=FeBc3mz9++WhInS5DCc3/yvwNzCoBHeGSj4Nx5UNqAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o3jmOEIQjomjxXNItj8aaawnFwKnj9X6ydWnJHI8+E7MfGkhCYUiPjoVGWaFLkSz0HJp1/RAnORxmS3cGh11ikoDWKweAahW/3od72X1T+ia7621nTmGaRtPEkEVzXq2Gd4NKHO3i/jcLOIaV8lc1xyaUrLXPwt1+AyOTOvYB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HEqL0X+5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--morbo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HEqL0X+5"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so2036882b3a.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Nov 2025 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763754911; x=1764359711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OsLQEMyKEn/UE/LwUY0j1tuqWL3xiSmMEKB7wO01+Co=;
        b=HEqL0X+50/jzNxD6HyVOiGtq2K/Jq967Ugm6tzyDjeO/EPz8HDLqelm1FaueL3euUM
         QdmYUm3mJsXXTT/lxrBHO5V5MznUkKyoxFdSY6igxKLkuOJsOKZq2z4bwteGywm7xY5w
         /ZmArkpFg3Yu8WlkEdMg2XW5bNpIts0dNzdVtDbu233coq7xGYP8JY2WpaKBTl5TL8Av
         T8a5qbMgab6uwV7z1/mksYRVTGSffPRBY8UV7fV9gFgRTQuJJiOs1fdd1U+LSkIknmk/
         b2LVmvsBgTOTDP3sfCTxxbxLU3XDWyzEyBZeWegGDVJqssl+o3qBsjod2pG9U46OkEAG
         w1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763754911; x=1764359711;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OsLQEMyKEn/UE/LwUY0j1tuqWL3xiSmMEKB7wO01+Co=;
        b=dkQL1xry3Lp0tYR6uoSaAfelG3G+CVDrWsRWiW3xMi8B04AXws6NZVP13+yuAzEier
         5jyggUCby3AuCSeOl6bNhR0uwDzkL6fXTRIWTdHoySalJgmXiKI8fp+Q5fCxgSAuIC2W
         Hx/0rNwElrg8UqbeZL1WidV/VQ71sE4bjC7xcBkhSqcnuXFTCBU1G+9OA/94g3pm92dF
         6+GShKsKxI7ln3HoYO0Lp4S+oAWEWAmkh/a5JSlOfqBddfMMSt3608xnSmtMDxJeat/r
         tpgLTDAm6VIphJvMpUYo+cQLktl8SiIhajqhgZg57vGsLUjexprlwE7jMyp6+4B6hhMQ
         2Oiw==
X-Forwarded-Encrypted: i=1; AJvYcCUeLriKE7kC/+J5pE3QEGwGaOTp74zmIMspMdS5lTc4AHYCPOoyjB87rh6FLgts1MXp5N85QdWlaqYHfvVTE9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpzGytFlcKxI/jgOeegc8HZzsRVqtffIseSlXWg4pFOEp2BDT
	dwDg8nHrWPoNst4jGvBpa70lbGCaPbtEDW1Raj01TfSSwzHcyI9+maH9mXUtvfAz2Sy7js1tbIV
	k
X-Google-Smtp-Source: AGHT+IGxGbZXuYRUV+1DBM1iC3d8Dgs2MaafPC2v4F8uQUYDIrUiNXJIpBlI3Tv92mLuGvfDyHJ2cMMikw==
X-Received: from pgn1.prod.google.com ([2002:a63:d41:0:b0:b6c:b8e0:6988])
 (user=morbo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9184:b0:34e:cc0a:40b2
 with SMTP id adf61e73a8af0-3614eddf63fmr4914029637.30.1763754911092; Fri, 21
 Nov 2025 11:55:11 -0800 (PST)
Date: Fri, 21 Nov 2025 19:54:33 +0000
In-Reply-To: <20251121193957.1655580-2-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251121193957.1655580-2-morbo@google.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
Message-ID: <20251121195504.1661783-1-morbo@google.com>
Subject: [PATCH v2 1/2] Compiler Attributes: Add __counted_by_ptr macro
From: Bill Wendling <morbo@google.com>
To: linux-kernel@vger.kernel.org
Cc: Bill Wendling <morbo@google.com>, Kees Cook <kees@kernel.org>, Qing Zhao <qing.zhao@oracle.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Justin Stitt <justinstitt@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>, 
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, John Stultz <jstultz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Brian Gerst <brgerst@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	Jan Hendrik Farr <kernel@jfarr.cc>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Clang and GCC are expanding the '__counted_by' attribute to support
pointers in structs. Clang has support for it since version 21. This
requires defining a separate macro, '__counted_by_ptr', because, while
the attribute has the same name for both a pointer and a flexible array
member, minimal compiler versions need to catch up.

The effect of this feature is the same as for __counted_by on flexible
array members. It provides hardening the ability to perform run-time
bounds checking on otherwise unknown-size pointers.

Cc: Kees Cook <kees@kernel.org>
Cc: Qing Zhao <qing.zhao@oracle.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Marc Herbert <Marc.Herbert@linux.intel.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-hardening@vger.kernel.org
Cc: llvm@lists.linux.dev
Signed-off-by: Bill Wendling <morbo@google.com>
---
v2 - Add support for GCC.
---
 include/linux/compiler_types.h | 11 +++++++++++
 init/Kconfig                   |  7 +++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.=
h
index 0a1b9598940d..2b0251bb951c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -351,6 +351,17 @@ struct ftrace_likely_data {
 # define __assume(expr)
 #endif
=20
+/*
+ * Optional: only supported since clang >=3D 21
+ *
+ * clang: https://github.com/llvm/llvm-project/pull/137250
+ */
+#ifdef CONFIG_CC_HAS_COUNTED_BY_FOR_POINTER
+#define __counted_by_ptr(member)	__attribute__((__counted_by__(member)))
+#else
+#define __counted_by_ptr(member)
+#endif
+
 /*
  * Optional: only supported since gcc >=3D 15
  * Optional: only supported since clang >=3D 18
diff --git a/init/Kconfig b/init/Kconfig
index cab3ad28ca49..f947f242bca8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -139,6 +139,13 @@ config CC_HAS_COUNTED_BY
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D108896
 	default y if CC_IS_GCC && GCC_VERSION >=3D 150100
=20
+config CC_HAS_COUNTED_BY_ON_POINTERS
+	bool
+	# supported since clang 21.1.0
+	default y if CC_IS_CLANG && CLANG_VERSION >=3D 210100
+	# supported since gcc 16.0.0
+	default y if CC_IS_GCC && GCC_VERSION >=3D 160000
+
 config CC_HAS_MULTIDIMENSIONAL_NONSTRING
 	def_bool $(success,echo 'char tag[][4] __attribute__((__nonstring__)) =3D=
 { };' | $(CC) $(CLANG_FLAGS) -x c - -c -o /dev/null -Werror)
=20
--=20
2.52.0.rc2.455.g230fcf2819-goog

