Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A02E23A9
	for <linux-hardening@vger.kernel.org>; Fri, 30 May 2025 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748563614; cv=none; b=s6Xpwi/0nGPeRL+BtNnqIs6kx5NBDy2CvtHIqGRfva5tHQi/yYrorxPFm3h0tHvQbYrdX4gEpGVWjLb4e7D/yG9zOsRouVPq2LB22bNaE/ZWH8IxdWRsuTLc34xPVd6CNcMLMN3B15h/G4NB8z703BuZaORQyj/abdGXpY+AKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748563614; c=relaxed/simple;
	bh=Qs3fKJz8kaIyTjSI+VH+mg1a+38N08rlUGlC+WiuByA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMjWBv1XPHbm3dj7QMUGqjFqIaMua1Jz2gUixT0HKVpzJ390sdQFkOGMmaKD1EqVfI7pLZoiKl7Ghk1XB7qHCgOJbbQzmR/x0A4ZNeCOalJLiXxS845XuTWL2AKhHYWWfQampJ1JfcbTF6bi3xAp/+lCMuKM02b/dM6ylVmxshc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEjykQEV; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEjykQEV"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1249680b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 29 May 2025 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748563609; x=1749168409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JaOyXlzy8Vkp255k6mJVMg/BC/f2o1qDq99ujzTjjD8=;
        b=mEjykQEV90aXFWctAZRHDq6f9YM6RJkzBAfK4xWDLKUMC3sG9TqBKj+1sgmNL6RRP+
         L42s71MdFMIBnRarH8C3zJCvAkBE0OhyhSonHJTTd2N5IcO1FpqcmmKMTdb8bcqM5n23
         2nq0ywTfIDUIj+hWOnX71J3O2V3/99rM83LTuMhTBW8qt1YV/8lv8CBngSvi8aR6wYso
         vY8+s/5faXWeFBwTaHtVUY0Q4cTr9yLy6MYt63yfft7OfDRJMHdGNgE0EbmjmaE5/UKI
         08m2aJWnSGnYZ0cdcukucAECA17zEbmPuN+d6tQTUWb4EBF+7VZWMJZmd279ct7l9sV6
         LqPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748563609; x=1749168409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JaOyXlzy8Vkp255k6mJVMg/BC/f2o1qDq99ujzTjjD8=;
        b=t95iEGrbTN1XsV+uaQEqVBfNuzjEx+XJv7e4SQ5DRSdPvZGRMCMipnFn5ZCKEnwbV+
         WOnH3yYVFDLf3T8u9pkUE78xPAUTjhbOJ4F29cHCqgfadLkjcnSkD+B9SiMvEtmGPKI2
         vO+SM6SoSPpSEWs+SrKKOzjRrL6v2mF42Ycwr+PRyZ7Se4JrZzm4BIGEokuoWtpTHfGh
         ibqg9eHa+Sbhat1buiGG4Fg2QI6ZSTTadIeCql7uXFNSNH4sASA9kC+qjZuRDJLicC35
         JW0Jv0sdbg3vlUESdSqcfwS+IB1qb+LVkmxzuyHOhE3Fd+OPfguQ343vUppaLVOXQ2aI
         boBw==
X-Forwarded-Encrypted: i=1; AJvYcCWczadZFObhOikEtY4qO/B0Dc7/OvAcXn/mCiL2LnPyoiw2J8eVvh32TKl8v0ryP8lkxRiFZUIBsEOb/ISleoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikKYOVQYCEd9uadaQxmZMPCxzZVgIieBrVyMTFZebpg3BLSf5
	19mz0SnTAjxmK2g+owQYZLErVvcB5ee8PGAeY1kw7bQzmgMuQBBu02CunlRjv2etVsA=
X-Gm-Gg: ASbGncse/OnWwkBPx+aplnMUn5hRuPM0Ci/VLZcxdVAxANF67UoZnAiuO/7x5GSAWc/
	TBLlkdqUJsXsgbqFNoskmb53CGpPUQZQAgdzaGkKWsRIV+T3KqR3Q7wD2DE8j77I9uQ9BfFk4Yk
	Ub1u4//Fphqp06ww9nZIzJFE/wi79QS8DpYu3A8k/juvPdZXiY9LW58sWldsM7CO3iyNhODwIXw
	CSB1uKvj+YNFqfS9q6TR/hzTq5dKPvE5eP6iPsq5WWG8qn2ki9F5RLLqurLCrn6XRKXu/WjoZC5
	5MxuF6PRyWmI7eNPUu+b4IUaegyCzrfqaGFXJmlSxPeRrFpThNCn+NIYheecQl18rKggIQ==
X-Google-Smtp-Source: AGHT+IHYOsFk2zcF1gLH1VRU+irYg1/F2TFp50LC35CUJj4OwIZqUaVrXo0NvOsbYcPu1XpBkFVZUg==
X-Received: by 2002:a05:6a00:189b:b0:736:8c0f:7758 with SMTP id d2e1a72fcca58-747c1a7f839mr253775b3a.10.1748563609262;
        Thu, 29 May 2025 17:06:49 -0700 (PDT)
Received: from localhost ([2804:14d:7e39:88d6:4b9a:64e:e01:2c33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afe967easm1894641b3a.21.2025.05.29.17.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 17:06:48 -0700 (PDT)
From: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
To: kees@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	broonie@kernel.org,
	davidgow@google.com,
	diego.daniel.professional@gmail.com,
	gnoack@google.com,
	gustavoars@kernel.org,
	jmorris@namei.org,
	justinstitt@google.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux@treblig.org,
	llvm@lists.linux.dev,
	mcgrof@kernel.org,
	mic@digikod.net,
	morbo@google.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	paul@paul-moore.com,
	pmladek@suse.com,
	rmoar@google.com,
	serge@hallyn.com,
	tamird@gmail.com,
	wangyuli@uniontech.com
Subject: Re: [PATCH 3/3] Revert "hardening: Disable GCC randstruct for COMPILE_TEST"
Date: Thu, 29 May 2025 21:06:46 -0300
Message-ID: <20250530000646.104457-1-thiago.bauermann@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250427013836.877214-3-kees@kernel.org>
References: <20250427013836.877214-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This commit was reported by our CI as breaking the allmodconfig build for
the arm and arm64 architectures when using GCC 15. This is due to
https://github.com/KSPP/linux/issues/367 :

-00:05:08 *** WARNING *** there are active plugins, do not report this as a bug unless you can reproduce it without enabling any plugins.
00:05:08 Event                            | Plugins
00:05:08 PLUGIN_FINISH_TYPE               | randomize_layout_plugin
00:05:08 PLUGIN_FINISH_DECL               | randomize_layout_plugin
00:05:08 PLUGIN_ATTRIBUTES                | latent_entropy_plugin randomize_layout_plugin
00:05:08 PLUGIN_START_UNIT                | latent_entropy_plugin stackleak_plugin
00:05:08 PLUGIN_ALL_IPA_PASSES_START      | randomize_layout_plugin
00:05:08 arch/arm64/kernel/kexec_image.c:132:14: internal compiler error: in comptypes_check_enum_int, at c/c-typeck.cc:1519
00:05:08   132 | const struct kexec_file_ops kexec_image_ops = {
00:05:08       |              ^~~~~~~~~~~~~~
00:05:08 0x225bdff internal_error(char const*, ...)
00:05:08 	../../../../../../gcc/gcc/diagnostic-global-context.cc:517
00:05:08 0x7cb197 fancy_abort(char const*, int, char const*)
00:05:08 	../../../../../../gcc/gcc/diagnostic.cc:1803
00:05:08 0x81f0e7 comptypes_check_enum_int(tree_node*, tree_node*, bool*)
00:05:08 	../../../../../../gcc/gcc/c/c-typeck.cc:1519
00:05:08 0x81f0e7 comptypes_check_enum_int(tree_node*, tree_node*, bool*)
00:05:08 	../../../../../../gcc/gcc/c/c-typeck.cc:1513
00:05:08 0x7e3b83 diagnose_mismatched_decls
00:05:08 	../../../../../../gcc/gcc/c/c-decl.cc:2170
00:05:08 0x7e64f3 duplicate_decls
00:05:08 	../../../../../../gcc/gcc/c/c-decl.cc:3169
00:05:08 0x7ea1eb pushdecl(tree_node*)
00:05:08 	../../../../../../gcc/gcc/c/c-decl.cc:3376
00:05:08 0x803c03 start_decl(c_declarator*, c_declspecs*, bool, tree_node*, bool, unsigned long*)
00:05:08 	../../../../../../gcc/gcc/c/c-decl.cc:5755
00:05:08 0x864c67 c_parser_declaration_or_fndef
00:05:08 	../../../../../../gcc/gcc/c/c-parser.cc:2851
00:05:08 0x8a7b33 c_parser_external_declaration
00:05:08 	../../../../../../gcc/gcc/c/c-parser.cc:2110
00:05:08 0x8a8ba3 c_parser_translation_unit
00:05:08 	../../../../../../gcc/gcc/c/c-parser.cc:1964
00:05:08 0x8a8ba3 c_parse_file()
00:05:08 	../../../../../../gcc/gcc/c/c-parser.cc:29839
00:05:08 0x931eff c_common_parse_file()
00:05:08 	../../../../../../gcc/gcc/c-family/c-opts.cc:1385
00:05:08 Please submit a full bug report, with preprocessed source (by using -freport-bug).
00:05:08 Please include the complete backtrace with any bug report.
00:05:08 See <https://gcc.gnu.org/bugs/> for instructions.
00:05:08 make[4]: *** [scripts/Makefile.build:203: arch/arm64/kernel/kexec_image.o] Error 1

The same error repeats for several other source files.
