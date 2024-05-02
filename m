Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484AF57C9B
	for <linux-hardening@vger.kernel.org>; Thu,  2 May 2024 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689226; cv=none; b=i8JTN4Oeh5AMuKO70S+p3F9IbvJepHzS/vmEELh9qEAu6UVQOFFivI0XAxWyIrcoGKX5T0gGEd0WZboqe0oz7PF7/08Fe953Y/Fk9b78SzQl4YTaj3n8EWFtt0XuPMh26+nb4HTJXL2AC60kWIG8FJVqNvRAMV/jw+GdHd//uV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689226; c=relaxed/simple;
	bh=zh3jTYlv3gAfsJ0fJDEOOWbgXfu84QDhZ5jAngTPr/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r4+G2y/xKedle2TNrlFUo25eehGmkOUps0xDnw1IZ+JPjtV/I5KrqK560z658/YUx5oMXiHjz6NY06aoLfX/06bQ6+ZbWGf4PfES10p1SmNd9GlPWpn9K9W5CUtSh+IK8dxc3zi62QRU+n//LKzUFBZrO0MnaDO7PaOJRaRWlx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KV0UXu5f; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KV0UXu5f"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ecd9dab183so12081085ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 02 May 2024 15:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689223; x=1715294023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Alkyi5JqXUdcGMCJmPn2xNXTUHn7MjYy9EVPcBLGUQQ=;
        b=KV0UXu5fQphPwu/En8bFdZb2papNHd9PJxLZ2WTsEqQNz8tuinfCD2icHLLIK4jv3X
         epozpPCTWjKYEgy7RvzWsKC8cKABBzmDCIF3jWCtxn/BwsdRAln4s6YwOAPx3lvmE81A
         zY0yGcqQ8nkuoD1xGakPTTyykaawUVOwTUwcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689223; x=1715294023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Alkyi5JqXUdcGMCJmPn2xNXTUHn7MjYy9EVPcBLGUQQ=;
        b=fyGMTzcPXeBWRfWbayinxpkUpwYRE9TaBP224Qk7fJtSWfHCJDzjeKtPipAIQsxrKj
         ExOFQD1cPCkV/kgPoIyH/vvvcwsGqE/C/eQC53333at+JwqNtcHqNz3XbLRlgcm4PRJ7
         DUnTnHz584JYVIZvE0XRC0nA7utau2lZyhaLmzQ4vygvgC2Wjp9gx2HWMzSKw59y4F0/
         sJBazby5rc6Ag9js8bhiVYcD9cD132MRqx+bsblcm9CDotdiDB2SdpMKcWv2t39mf5L0
         VMze13EZsaM5FJUIe1TyQSEhaMppF6fhlfe8fMXJqtK6zlu26Re7eo6r/bXzGHt9XkPL
         p0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWps4fcd1cfivcbXfA3Pxws0hmlUUhQJktL2seKwiffsxpVdizZffSKhKCIbjdsdwMhLTCk7aH+B42N2oWztqXceENNJdSuqY6zrIczbJky
X-Gm-Message-State: AOJu0YxI+Is5Omxy8aoCaw5GJnRgOECiDbIY0DlwJPeU2DFu2F8i+ddt
	kpNlbCQXnqyflrEt1j/f+JzCMjkJS6cEp+PVR3u0ROOL9CRPu5vIiEg3NCHqMA==
X-Google-Smtp-Source: AGHT+IGAayZiLEBsyLgIJp727/HOhIW8jcf68JHnImgIz5MoqiH36x7xVdhDcqAQUHQ4AOs7ALD8tQ==
X-Received: by 2002:a17:902:ce81:b0:1e2:7734:63dd with SMTP id f1-20020a170902ce8100b001e2773463ddmr5911220plg.30.1714689223609;
        Thu, 02 May 2024 15:33:43 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001ec852124f6sm1859006plh.309.2024.05.02.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>,
	Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/5] fs: Do not allow get_file() to resurrect 0 f_count
Date: Thu,  2 May 2024 15:33:35 -0700
Message-Id: <20240502222252.work.690-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=keescook@chromium.org;
 h=from:subject:message-id; bh=zh3jTYlv3gAfsJ0fJDEOOWbgXfu84QDhZ5jAngTPr/A=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNBTDFUoY6TVoqmQxs375eqvdFBj89/ctuDLOW
 2+X99yJ49+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjQUwwAKCRCJcvTf3G3A
 JspPEACtGBTA/04xGkfNe0POOY6UGlh9ESMNyH/8oZZ8d3UQPt4M6jepl1PWlD4m3cEnHJK7W59
 Ew1O/o3JMO6xpM/DaYhVWnWU6vmyOuXC2BLL3sC0H78DoDCS1YeGvgwcsLvoJQkPR6yocxZc1Lp
 ArPQeS2n1GN6Natd2CKQpRU1hHaVx8V4k47jJ1C1ooXgDt7NaA3v3Mxp2k1nkVABc40Xt0iPZHe
 N135yJYCUnJcpYLB0ibjarI10wI4Q38s3kkHaSPBUFFlyZzwaqs8cVJtVafb+WFIadgKLSgplR6
 Gvo818ypPYTYB7jNIlptvHB2MpN4nJBL6DYjM9W9EA22HbIDDGJexmcFxNXqlQl/qXZpFt7XmnP
 Q6IX+BvQ65e6Zl3n+AYDDb+8lD/3uddFxKLY+yN8uImNTJaomfLEsLEdpWNQISX4Sd0iZoqRgNU
 wW8OcE471z7VJafbM8my64tY9J+xrj7sh3jZrbv695WaOXZVOZhvKl4yHNKdmuB7SwoTxzGJp8c
 6H/kFSBF+jTC0H5n89DfR0Uuy/y1HoONrXrvE252vDox1DwVh8Gfz62Vr1+HtbNlBpcN9K4w/k7
 /tznwjyRyIqPUxNhJJzdX9hpAs9d/CHvDyY8049XOPocPYOnqRtriVf3abZjlh68t5HB+axTGF/
 GHusxWn D0shXk1Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Failure with f_count reference counting are better contained by
an actual reference counting type, like refcount_t. The first step
is for get_file() to use inc_not_zero to avoid resurrection. I also
found a couple open-coded modifications of f_count that should be using
get_file(). Since long ago, f_count was switched to atomic_long_t, so to
get proper reference count checking, I've added a refcount_long_t API,
and then converted f_count to refcount_long_t.

Now if there are underflows (or somehow an overflow), we'll see them
reported.

-Kees

Kees Cook (5):
  fs: Do not allow get_file() to resurrect 0 f_count
  drm/vmwgfx: Do not directly manipulate file->f_count
  drm/i915: Do not directly manipulate file->f_count
  refcount: Introduce refcount_long_t and APIs
  fs: Convert struct file::f_count to refcount_long_t

 MAINTAINERS                           |   2 +-
 Makefile                              |  11 +-
 drivers/gpu/drm/i915/gt/shmem_utils.c |   5 +-
 drivers/gpu/drm/vmwgfx/ttm_object.c   |   2 +-
 fs/file.c                             |   4 +-
 fs/file_table.c                       |   6 +-
 include/linux/fs.h                    |   7 +-
 include/linux/refcount-impl.h         | 344 ++++++++++++++++++++++++++
 include/linux/refcount.h              | 341 +------------------------
 include/linux/refcount_types.h        |  12 +
 lib/refcount.c                        |  17 +-
 11 files changed, 398 insertions(+), 353 deletions(-)
 create mode 100644 include/linux/refcount-impl.h

-- 
2.34.1

